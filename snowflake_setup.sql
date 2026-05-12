use role accountadmin;

create warehouse if not exists HBP_DEMO_WH
  warehouse_size = xsmall
  auto_suspend = 60
  auto_resume = true
  initially_suspended = true;

create database if not exists HBP_DEMO;

create schema if not exists HBP_DEMO.RAW;
create schema if not exists HBP_DEMO.STAGING;
create schema if not exists HBP_DEMO.MARTS;

-- Optional: create a least-privilege dbt role and user later.
-- For the fastest interview demo, you can connect dbt Cloud with your trial account user,
-- then tighten permissions after the project works.
