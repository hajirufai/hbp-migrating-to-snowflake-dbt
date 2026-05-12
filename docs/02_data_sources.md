# Data Sources

## Chosen Sources

For this fast interview project, the best sources are business-relevant CSV extracts that represent real systems Harvard Business Publishing could use.

## Source 1: CRM and Subscription Data

Files:

- `seeds/accounts.csv`
- `seeds/subscriptions.csv`

Purpose:

- Identify customers.
- Track segment, region, industry, and account owner.
- Track subscription product, seat count, annual contract value, and renewal date.

Why this matters:

Customer success and revenue teams need renewal context to decide where to focus.

## Source 2: Product Engagement Data

File:

- `seeds/content_engagement.csv`

Purpose:

- Track learning events by account and learner.
- Measure content usage, time spent, and completion.

Why this matters:

Low activation or low completion can signal that a customer is not receiving value from the product.

## Source 3: Support Ticket Data

File:

- `seeds/support_tickets.csv`

Purpose:

- Track account-level customer issues.
- Measure open tickets, high-priority tickets, and CSAT.

Why this matters:

High-priority unresolved issues can create renewal risk, especially near contract end dates.

## Why Not Use a Complicated External API?

The interview goal is to show good data engineering thinking quickly:

- source-to-staging-to-mart modeling
- SQL transformations
- Snowflake/dbt usage
- data quality tests
- business-oriented reporting

Using CSV seeds avoids spending interview preparation time on API authentication, rate limits, and data cleaning that does not improve the story.
