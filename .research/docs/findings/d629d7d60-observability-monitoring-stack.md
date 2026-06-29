---
id: d629d7d60
topic: observability
title: Observability and monitoring stack for job systems
status: draft
shape: survey
---

# Observability and monitoring stack for job systems

**Scope.** What the catalog's observability sources (official docs) establish about the
metrics/visualization/instrumentation layer for job and queue systems. Sources: Prometheus,
Grafana, Flower, OpenTelemetry.

## Key claims (cited)

- Prometheus is an open-source systems monitoring and alerting toolkit, built at SoundCloud
  in 2012 and a Cloud Native Computing Foundation project since 2016 (the second hosted
  project after Kubernetes) [c2792f5cd]. It stores metrics as time series — values with a
  timestamp plus optional key/value **labels** — under a multi-dimensional data model
  queried with **PromQL**, collects via a **pull model over HTTP** (with push supported
  through an intermediary gateway), and discovers targets via service discovery or static
  configuration [c2792f5cd].
- Grafana is open-source software to query, visualize, alert on, and explore **metrics,
  logs, and traces** wherever they are stored, turning time-series database (TSDB) data into
  graphs and visualizations [c2f4d8110].
- Flower is an open-source web application for monitoring and managing **Celery** clusters,
  giving real-time information on worker and task status, with Prometheus metric scraping and
  Grafana dashboard integration [c6fe3f972].
- OpenTelemetry frames telemetry as **signals** — traces, metrics, and logs — emitted through
  code-based or zero-code instrumentation, exported over the **OTLP exporter**, with context
  propagation across service hops and tail sampling for trace volume control [c76a8ccf7].

## Convergent vs contested

- **Convergent:** The metrics backbone is Prometheus (pull-based, label-dimensional) feeding
  Grafana for visualization across metrics/logs/traces; OpenTelemetry supplies the
  vendor-neutral instrumentation layer (traces/metrics/logs), and per-engine UIs such as
  Flower layer queue/worker state on top of that same Prometheus + Grafana stack.
- **Contested / thin:** The sources cover the *metrics* path well but say little here about
  log aggregation, distributed-trace correlation across job hops, or concrete SLO/alerting
  thresholds for async work — the OpenTelemetry source is navigation-level rather than
  prescriptive.

## Implications for the system

- Default the observability contract to **OpenTelemetry instrumentation → Prometheus metrics
  → Grafana dashboards**, with engine-specific UIs (Flower-style) as an optional operator
  view, since every source converges on that stack.
- Model job telemetry as OTel signals (traces spanning the job lifecycle, metrics for queue
  depth/latency/throughput, logs with correlation IDs) so the contract is broker-agnostic.

## Gaps found → re-scan
- SLO/SLI definitions and alerting thresholds for async/queue work (backlog, DLQ growth, stuck jobs).
- Distributed tracing correlation across enqueue → worker → downstream hops (OTel context propagation in practice).
- Log aggregation/retention strategy for job history and replay.
- Per-engine dashboards beyond Flower (Bull Board, JobRunr, Temporal Web, Sidekiq web).
