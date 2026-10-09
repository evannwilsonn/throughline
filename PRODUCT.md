# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Hiring managers first, arriving from Evan Wilson's resume or LinkedIn and giving the page about a minute; they need to see an executive KPI dashboard that says what happened and why, on real marketplace data, with governed definitions. Analytics engineers second, who check definitions, targets, the cohort logic and data notes. Desktop and phone viewing are about equal. (Confirmed for the whole portfolio on 2026-10-09.)

## Product Purpose

Throughline is an executive KPI dashboard for an e-commerce marketplace, built on about 100,000 real orders from the Olist Brazilian E-Commerce Public Dataset (Jan 2017 to Aug 2018). Eleven KPIs across growth, customers, operations, experience, unit economics and marketplace are defined once in a governed catalog, computed once in dbt, and checked against targets. It answers "how did the marketplace do this month against plan, and what drives it": GMV vs plan, on/off-track KPIs, and the drivers the data supports (late deliveries crush review scores; growth is almost entirely new customers).

## Positioning

The throughline from a KPI to its cause: each number links to the driver behind it, with definitions and data notes so nobody has to ask how it was calculated.

## Operating Context

Static page with inline data (dashboard/data.json), built from DuckDB or Snowflake; also published as a Claude artifact and as a product view inside Switchyard.

## Capabilities and Constraints

- Data: KPI catalog (11 KPIs, definitions, units, direction, target type and value), monthly values with prior month, prior year, target and status, categories and states by month, delivery-timing buckets with review outcomes, monthly cohort retention, data-quality notes.
- 20 months (2017-01 to 2018-08); year-over-year from 2018-01. Currency is Brazilian reais (R$).
- Every number comes from data.json.

## Brand Commitments

Each portfolio project has its own visual world and its own new colour palette, distinct from Reprise (cool white, ink, blue ramp, amber), Cloverfield (control-room black, Caltrans orange, green/amber/red), Cloverleaf (concrete grey, plum, lime), Switchyard (cream, rust, umber), Curbside (newsprint, ink, taxi yellow), Clip Curator (graphite, film black, hot pink). Throughline is also an executive KPI dashboard, so it must not read as Curbside's broadsheet.

## Evidence on Hand

dashboard/data.json; README findings. No users or testimonials.

## Product Principles

1. Lead with what happened and why, in a sentence.
2. Every KPI shows its definition, target and trend on demand.
3. Show the driver behind the number, not just the number.
4. Every mark maps to real data.

## Accessibility & Inclusion

WCAG AA contrast in light and dark; status never carried by colour alone; works at phone width.
