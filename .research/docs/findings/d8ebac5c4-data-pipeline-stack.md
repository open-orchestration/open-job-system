---
id: d8ebac5c4
topic: data-pipeline
title: "Data pipeline stack: capture, process, transform"
status: draft
shape: survey
---

# Data pipeline stack: capture, process, transform

**Scope.** How data-pipeline tools divide the work, from the catalog's sources. Covers
Debezium, Apache Flink, Apache Beam, and dbt; the corpus also holds Apache Spark and NiFi
(not synthesized here).

## Key claims (cited)

- **Capture — Debezium (CDC).** Debezium is a set of distributed services to **capture
  changes in your databases** so applications can react to them; it records all row-level
  changes in a **change event stream** consumed in the order they occurred [c17f16782].
- **Process (streaming) — Flink.** Flink's APIs are built on **stateful and timely stream
  processing**, introduced in the context of data pipelines & ETL [c9885a6d8].
- **Process (portable model) — Beam.** Beam provides **SDKs to create data processing
  pipelines** — a programming model for authoring pipelines independent of the runner
  [c0394b138].
- **Transform — dbt.** dbt **transforms raw warehouse data into trusted data products**: you
  write simple **SQL select statements** and dbt builds modular, maintainable data models
  [c15e78c4b].

## Convergent vs contested

- **Convergent:** A data pipeline is a chain of stages — **capture → process → transform** —
  and these tools each own one stage rather than competing head-on: Debezium feeds change
  data in, a processing engine (Flink/Beam) computes over it, and dbt shapes the result in the
  warehouse.
- **Contested / differentiating:** The processing layer splits by model. **Flink** is a
  stateful streaming engine (events as they arrive, with state and time semantics). **Beam**
  is a portable *programming model* that runs on multiple engines. **dbt** is not a processing
  engine at all — it pushes **SQL transformation down into the warehouse** (ELT), a different
  paradigm from stream/batch compute.

## Implications for the system

- Data pipelines are **adjacent to** the job system, not the same thing: a job/queue moves
  discrete work items; a data pipeline moves and transforms datasets. Integrate via events
  (CDC/Debezium → broker) rather than absorbing pipeline semantics into the job core.
- Where the job system triggers data work, treat the pipeline engine as an external target
  (run a Flink/Beam job, trigger a dbt run) behind the same provider-adapter boundary.

## Gaps found → re-scan
- Apache Spark (batch/stream engine, SparkContext scheduling) and NiFi (dataflow) — not synthesized.
- Beam's batch+stream unification ("Beam model": watermarks, windowing) — named, not detailed.
- Exactly-once/checkpointing in Flink and delivery semantics from CDC → broker.
