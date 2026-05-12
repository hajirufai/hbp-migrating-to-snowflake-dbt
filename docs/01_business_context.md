# Who Wants the Analytics and Why?

## Primary Audience

The main audience is the customer success and revenue team supporting a subscription-based learning or digital content product.

They need a trusted view of customer engagement before renewal conversations happen. Without a modeled dataset, they may have to check CRM records, usage exports, support tickets, and spreadsheets separately.

## What This Helps Them Do

- Identify accounts that are approaching renewal with low product usage.
- See whether customers are actively using licensed learning seats.
- Understand whether support pain is creating renewal risk.
- Prioritize outreach based on evidence, not guesswork.
- Show product and content teams which learning materials are resonating.

## Why Build a Pipeline?

The source data lives in different systems:

- CRM or billing has accounts, subscriptions, seat counts, and renewal dates.
- The learning platform has product usage and completion events.
- The support system has ticket volume, ticket severity, and satisfaction signals.

A dbt and Snowflake pipeline makes this usable by:

- Loading the raw data into a warehouse.
- Cleaning each source in staging models.
- Joining sources into business-ready mart tables.
- Adding tests so the team can trust the outputs.
- Making dashboard queries repeatable instead of manually rebuilt.

## Analytics Dashboard Goal

The dashboard should answer:

- Which accounts are high risk?
- Which accounts should Customer Success contact first?
- Which content types have strong engagement?
- Which customers have open or high-priority support issues?
- How much annual contract value is tied to risky accounts?
