# Customer Health Analytics

## Opening Statement

Customer Health Analytics is a Snowflake and dbt analytics project built to help a subscription-based learning business understand customer engagement, renewal risk, and content performance.

The project is framed around a Harvard Business Publishing-style use case: organizations subscribe to learning products, employees or students engage with digital content, and Customer Success teams need to know whether each account is receiving enough value before renewal conversations begin.

This is not presented as an official Harvard Business Publishing internal system. It is a practical demo data product showing how customer, subscription, engagement, and support data can be modeled into a trusted analytics layer for business decision-making.

## Problem Statement

Customer Success and Revenue teams often need to make renewal decisions using information spread across multiple systems. Account details may live in a CRM, subscription details may live in billing data, product usage may live in a learning platform, and customer pain may appear in support tickets.

When these data sources are disconnected, teams may struggle to answer a simple but important question:

```text
Which customers are healthy, which customers are at risk, and what should we do next?
```

This project solves that problem by creating a repeatable Snowflake and dbt pipeline that combines those signals into account health, renewal risk, and content performance reporting.

## Business Questions

The project is designed to answer:

- Which accounts are high renewal risk?
- Are customers using the seats they purchased?
- Which accounts should Customer Success contact first?
- Are support issues or low engagement connected to renewal risk?
- Which content is driving strong learning engagement?
- How much annual contract value is tied to risky accounts?

## Business Value

Customer Success teams can use the account health report to prioritize outreach before renewals.

Revenue leaders can see how much contract value is attached to risky accounts.

Product and Content teams can understand which learning materials are driving engagement and completion.

The Data team can provide a reusable, tested analytics layer instead of rebuilding spreadsheet reports manually.

## Data Used

The demo uses four CSV seed files to represent common business system extracts:

- [accounts.csv](seeds/accounts.csv): CRM-like account and customer data.
- [subscriptions.csv](seeds/subscriptions.csv): subscription, seat count, annual contract value, and renewal data.
- [content_engagement.csv](seeds/content_engagement.csv): learning platform usage events.
- [support_tickets.csv](seeds/support_tickets.csv): support/helpdesk tickets and CSAT data.

In production, these would usually come from tools such as Salesforce, a billing platform, a learning platform database, Zendesk, S3/Snowpipe, Fivetran, Airbyte, or source application APIs.

## Solution Overview

The project follows a simple ELT pattern:

```text
Extract: CRM, subscription, engagement, and support data
Load: raw tables in Snowflake
Transform: dbt staging and mart models
Report: account health, content performance, and revenue-at-risk queries
```

dbt is used to clean raw extracts, cast data types, join sources, calculate KPIs, and run data quality tests.

## Core Analytics Outputs

The main output is an account health table:

- [fct_account_health.sql](models/marts/fct_account_health.sql)

This table combines account, subscription, learning engagement, and support data to calculate:

- active learners
- licensed seats
- seat activation rate
- total learning events
- completion rate
- open support tickets
- high-priority support tickets
- average CSAT score
- days until renewal
- annual contract value
- account health status

The second major output is a content performance table:

- [fct_content_performance.sql](models/marts/fct_content_performance.sql)

This table shows which content items are being used and completed across customer accounts.

## Account Health Logic

The account health status is intentionally simple and explainable:

- `High risk`: renewal is within 90 days and either seat activation is very low or the account has at least one high-priority ticket.
- `Watch`: completion rate is below 50 percent or the account has at least one open ticket.
- `Healthy`: all other accounts.

In a production environment, these thresholds would be refined with Customer Success and Revenue leaders using historical renewal outcomes.

## Report Links

Dashboard-style SQL reports are stored in the `analyses/` folder:

- [account_health_dashboard.sql](analyses/account_health_dashboard.sql): prioritizes accounts by health status, renewal timing, and contract value.
- [content_performance_dashboard.sql](analyses/content_performance_dashboard.sql): ranks content by engagement and completion.
- [revenue_at_risk.sql](analyses/revenue_at_risk.sql): summarizes annual contract value by account health status.

Supporting project documentation:

- [README.md](README.md): project overview and demo flow.
- [01_business_context.md](docs/01_business_context.md): business audience and purpose.
- [02_data_sources.md](docs/02_data_sources.md): source data explanation.
- [03_report_questions.md](docs/03_report_questions.md): report questions and KPIs.
- [04_dbt_cloud_snowflake_setup.md](docs/04_dbt_cloud_snowflake_setup.md): setup guide.

## Where To View the Finished Output

Snowflake login:

<https://mkskywk-qy23935.snowflakecomputing.com>

In Snowflake, go to:

```text
Data > Databases > HBP_DEMO > RAW_MARTS
```

Main report tables:

```text
HBP_DEMO.RAW_MARTS.FCT_ACCOUNT_HEALTH
HBP_DEMO.RAW_MARTS.FCT_CONTENT_PERFORMANCE
```

The project has been built and verified in Snowflake:

```text
FCT_ACCOUNT_HEALTH rows: 6
FCT_CONTENT_PERFORMANCE rows: 7
dbt tests passed: 17 / 17
```

Current account health split:

```text
Healthy: 3
High risk: 2
Watch: 1
```

## Board Presentation Talk Track

This project demonstrates how a data team can turn disconnected operational data into a decision-ready customer health view.

The business problem is renewal risk. Customer Success needs to know where to focus before contracts expire, but the signals are split across account records, subscriptions, usage data, and support tickets. I used Snowflake as the warehouse and dbt as the transformation layer to combine those sources into a reliable analytics model.

The output is a practical account health dashboard. It highlights which accounts are healthy, which accounts need monitoring, and which accounts are high risk. It also shows why an account is risky by surfacing engagement, seat activation, support issues, CSAT, renewal timing, and annual contract value.

This gives the business a clear way to prioritize outreach, protect revenue, and understand whether customers are receiving value from the learning product.

## Snowflake Report Queries

Account health dashboard:

```sql
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
from HBP_DEMO.RAW_MARTS.FCT_ACCOUNT_HEALTH
order by
    case account_health_status
        when 'High risk' then 1
        when 'Watch' then 2
        else 3
    end,
    days_until_renewal,
    annual_contract_value desc;
```

Content performance dashboard:

```sql
select
    content_type,
    content_id,
    learning_events,
    accounts_reached,
    active_learners,
    total_minutes_spent,
    avg_minutes_per_event,
    completion_rate
from HBP_DEMO.RAW_MARTS.FCT_CONTENT_PERFORMANCE
order by
    completion_rate desc,
    learning_events desc;
```

Revenue at risk:

```sql
select
    account_health_status,
    count(*) as account_count,
    sum(annual_contract_value) as annual_contract_value,
    avg(seat_activation_rate) as avg_seat_activation_rate,
    sum(open_tickets) as open_tickets,
    sum(high_priority_tickets) as high_priority_tickets
from HBP_DEMO.RAW_MARTS.FCT_ACCOUNT_HEALTH
group by 1
order by
    case account_health_status
        when 'High risk' then 1
        when 'Watch' then 2
        else 3
    end;
```

## Final Summary

Customer Health Analytics shows the full analytics engineering workflow: raw data, Snowflake setup, dbt transformations, tested staging and mart models, and dashboard-ready SQL reports.

The project is small enough to explain clearly in an interview, but realistic enough to show how data engineering supports customer success, renewal planning, product insight, and revenue protection.
