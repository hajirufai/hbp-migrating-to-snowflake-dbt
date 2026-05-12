# dbt Cloud and Snowflake Setup

## Snowflake

In Snowflake, open a SQL worksheet and run `snowflake_setup.sql`.

Use an `XSMALL` warehouse and `AUTO_SUSPEND = 60` to protect the free trial credits.

## dbt Cloud Free Account

Create a free dbt Cloud account, then:

1. Create a new project.
2. Name it `Customer Health Analytics`.
3. Choose Snowflake as the data warehouse.
4. Enter your Snowflake account information.
5. Use:
   - Warehouse: `HBP_DEMO_WH`
   - Database: `HBP_DEMO`
   - Schema: `RAW`
   - Role: your available Snowflake role, probably `ACCOUNTADMIN` for the trial
6. Connect the project repository from GitHub.
7. Open dbt Cloud IDE.

## Commands to Run

```bash
dbt deps
dbt seed
dbt run
dbt test
```

## Where Tables Will Land

With the current `dbt_project.yml`:

- Seeds load to a raw schema.
- Staging models build as views.
- Mart models build as tables.

In dbt Cloud, your target schema may be prefixed depending on your environment. That is normal.

## Demo Checklist

- Show raw seeds.
- Run `dbt seed`.
- Run `dbt run`.
- Run `dbt test`.
- Open `fct_account_health`.
- Open `fct_content_performance`.
- Explain the business decisions these tables support.
