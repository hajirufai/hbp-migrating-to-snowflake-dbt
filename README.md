# Customer Health Analytics with dbt and Snowflake

This is a portfolio analytics engineering project for a customer success and renewal-risk use case.

I used Snowflake for the warehouse layer and dbt for seeds, staging models, marts, and tests. The final outputs show account health, revenue at risk, and content performance.

## Business Problem

Learning and subscription businesses need to know whether customers are getting value before renewal conversations. In this case, the useful questions are:

- Which customer accounts are healthy, at risk, or need attention before renewal?
- Are licensed seats actually being used?
- Which learning content is driving engagement and completion?
- Are support issues connected to renewal risk?

## Stakeholders

- Customer Success: prioritize accounts that need outreach.
- Revenue: understand annual contract value attached to risky accounts.
- Product and Content: see which learning materials drive engagement and completion.
- Data: maintain tested models instead of rebuilding reports manually.

## Data Sources

The demo uses four CSV seed files:

- `accounts.csv`: CRM account/customer data.
- `subscriptions.csv`: CRM or billing subscription and renewal data.
- `content_engagement.csv`: learning platform event data.
- `support_tickets.csv`: helpdesk support ticket data.

In a production stack, these files would usually come from tools such as Salesforce, a billing platform, a learning platform database, Zendesk, S3/Snowpipe, Fivetran, Airbyte, or source APIs. I used seeds here so the project can be reviewed and rerun quickly.

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

## Snowflake Evidence

I included Snowflake worksheet scripts in [`snowflake_worksheets/`](snowflake_worksheets/) so reviewers can see the raw sources, staging views, transformation SQL, and final outputs.

This demo does not require a Snowflake UI Project. The work is shown through SQL worksheets, database objects, dbt models, and screenshots.

Completed Snowflake screenshots are stored in [`evidence_screenshots/`](evidence_screenshots/). These images are screenshots from the Snowflake UI showing the worksheet SQL and result grids.

Use this worksheet context at the top of every Snowflake script:

```sql
use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;
```

The main Snowflake objects are:

- Raw sources: `HBP_DEMO.RAW_RAW`
- dbt staging views: `HBP_DEMO.RAW_STAGING`
- dbt final marts: `HBP_DEMO.RAW_MARTS`

Worksheet scripts:

| Order | SQL file | What it proves | Suggested screenshot name |
| --- | --- | --- | --- |
| Optional fix | [`00_rebuild_staging_views_if_needed.sql`](snowflake_worksheets/00_rebuild_staging_views_if_needed.sql) | Repairs staging views if old views fail on blank dates | `00_rebuild_staging_views_if_needed.png` |
| 1 | [`01_environment_and_schemas.sql`](snowflake_worksheets/01_environment_and_schemas.sql) | Snowflake role, warehouse, database, and schemas are available | `01_environment_and_schemas.png` |
| 2 | [`02_raw_sources_preview.sql`](snowflake_worksheets/02_raw_sources_preview.sql) | Raw CSV seed data is loaded into Snowflake source tables | `02_raw_sources_preview.png` |
| 3 | [`03_source_row_counts.sql`](snowflake_worksheets/03_source_row_counts.sql) | Every raw source table has records | `03_source_row_counts.png` |
| 4 | [`04_staging_views_preview.sql`](snowflake_worksheets/04_staging_views_preview.sql) | dbt created staging views for cleaned source data | `04_staging_views_preview.png` |
| 5 | [`05_view_transformation_sql.sql`](snowflake_worksheets/05_view_transformation_sql.sql) | Snowflake can show the SQL behind the dbt-created views | `05_view_transformation_sql.png` |
| 6 | [`06_final_outputs_preview.sql`](snowflake_worksheets/06_final_outputs_preview.sql) | dbt created final mart tables for analysis | `06_final_outputs_preview.png` |
| 7 | [`07_account_health_dashboard.sql`](snowflake_worksheets/07_account_health_dashboard.sql) | Final customer health output for Customer Success | `07_account_health_dashboard.png` |
| 8 | [`08_revenue_at_risk.sql`](snowflake_worksheets/08_revenue_at_risk.sql) | Revenue-at-risk summary by account health status | `08_revenue_at_risk.png` |
| 9 | [`09_content_performance_dashboard.sql`](snowflake_worksheets/09_content_performance_dashboard.sql) | Learning content performance output | `09_content_performance_dashboard.png` |
| 10 | [`10_source_to_output_audit.sql`](snowflake_worksheets/10_source_to_output_audit.sql) | End-to-end row count check from source to output | `10_source_to_output_audit.png` |

Snowflake worksheet name used for the screenshots:

```text
hbp_customer_health_demo.sql
```

Screenshot flow:

1. Open one Snowflake worksheet named `hbp_customer_health_demo.sql`.
2. Paste and run one script at a time from the `snowflake_worksheets/` folder.
3. Take a screenshot of the SQL and result grid.
4. Save each screenshot in [`evidence_screenshots/`](evidence_screenshots/) using the suggested screenshot name in the table.

## Demo Data Note

This is a portfolio demo. It does not use Harvard Business Publishing internal systems, confidential data, proprietary business logic, or private customer information.

The project uses synthetic CSV seed data and a Harvard Business Publishing-style business scenario to show:

- Snowflake warehouse setup
- dbt seed loading
- dbt staging views
- dbt mart transformations
- data quality tests
- dashboard-ready SQL analysis

The purpose is to show the core workflow for a junior data engineer role: load source data, model it with dbt, test it, and produce analysis-ready tables.

## Suggested Demo Flow

1. Explain the business problem and stakeholders.
2. Show the raw source files as simulated extracts from different systems.
3. Show staging models that clean and standardize the raw data.
4. Show mart models that combine engagement, subscription, and support data.
5. Run `dbt test` to show data quality checks.
6. Open the report queries in `analyses/` and explain the insights.

## Short Summary

I built an ELT pipeline in Snowflake and dbt using CRM-style account data, subscription data, learning engagement data, and support ticket data. The project turns those sources into tested mart tables for account health, renewal risk, and content performance analysis.
