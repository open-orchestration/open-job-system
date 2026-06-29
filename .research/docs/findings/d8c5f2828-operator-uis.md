---
id: d8c5f2828
topic: ui-monitoring
title: "Operator UIs: engine-native dashboards vs general observability"
status: draft
shape: survey
---

# Operator UIs: engine-native dashboards vs general observability

**Scope.** The operator surface for watching a job system, from the catalog's
ui-monitoring sources. Covers engine-native dashboards (Airflow UI, JobRunr, Sidekiq web)
and general-purpose dashboards (Grafana, CloudWatch); the corpus holds ~30 more
(Prefect UI, Temporal Web, App Insights, Lens, Portainer, …) not synthesized here.

## Key claims (cited)

- **Airflow UI.** Provides a powerful way to **monitor, manage, and troubleshoot** your data
  pipelines and data assets [c72ace91e].
- **JobRunr dashboard.** Gives **helpful insights into your background jobs** [ca72fd994].
- **Sidekiq web.** Sidekiq ships a **web application that can display the current state of a
  Sidekiq installation** (mounted into the host app) [c4bb94cc2].
- **Grafana (general).** A dashboard is a **set of one or more panels** that provide an
  **at-a-glance view of related information**, built from components that query and transform
  data [cc85b94f6].
- **CloudWatch (general).** Includes **automatic pre-built dashboards** and lets you **create
  your own** [ccb08675c].

## Convergent vs contested

- **Convergent:** Every job system exposes an operator surface to see queue/worker/job state —
  observability is treated as a first-class part of the system, not an afterthought.
- **Contested / two kinds:** **Engine-native** UIs (Airflow UI, JobRunr, Sidekiq web) are
  bundled with the engine and understand its domain directly — jobs, workers, runs — but are
  per-tool. **General** dashboards (Grafana, CloudWatch) visualize metrics from *any* source
  via panels, giving one cross-system pane but requiring the metrics to be wired up. Depth +
  domain-awareness vs breadth + uniformity.

## Implications for the system

- The generic job system should ship a **native operator UI** (job lifecycle, queue depth,
  failures/DLQ, worker health) *and* **export metrics** so the same state appears in
  Grafana/CloudWatch — pairing engine-native depth with general-dashboard breadth.
- This mirrors the observability finding (OpenTelemetry → Prometheus → Grafana): the native UI
  is the fast path; the metrics export is the portable, cross-system path.

## Gaps found → re-scan
- Temporal Web UI, Prefect UI, Bull Board, Flower, App Insights — not synthesized.
- Kubernetes operator surfaces (Lens, Portainer, kubectl) for container-batch workloads.
- What the *minimum* operator UI for a job system must show (the required panels/views).
