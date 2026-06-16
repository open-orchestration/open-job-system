# Monitoring UI Synthesis — Core Screens Across 32 Platform Docs

Derived from the 32 markdown files in `docs/15-ui-monitoring/` (27 distinct platforms; AWS = Step Functions + CloudWatch + SQS + Batch; Docker = Desktop + compose + CLI + Portainer; K8s = Dashboard + kubectl + k9s + Lens). Counts below are *platform presence* — how many of the 27 platforms exhibit a pattern, measured by scanning the doc bodies. Goal: a minimal, framework-agnostic wireframe set for our own jobs-platform monitoring UI.

> Note: `flower/screenshots.md` resolved to a 404 page; Flower (Celery) is treated from its known feature set (workers list, task list/detail, broker/queue monitor, real-time graphs) plus the prompt description.

---

## 1. Per-platform view inventory

| Platform | Primary monitoring views / screens |
| --- | --- |
| Temporal Web/Cloud UI | Workflow list (saved-view queries), workflow/run detail, **event history** timeline, pending-activities, task-failures view, workers, schedules, namespaces |
| Kubernetes Dashboard | Cluster/namespace overview, workloads list, resource detail, **logs viewer**, events, metrics; create/deploy view |
| kubectl (quick-ref) | `get` list views (custom-columns/sorting), `describe` detail, events-by-time, logs, top (metrics) — CLI analogues of the same screens |
| k9s | Resource list tables (pods/jobs/cronjobs), detail/describe, logs, events, metrics, namespace switcher |
| Lens | Cluster overview, workloads list, pod/resource detail, logs, metrics charts, namespaces |
| AWS Step Functions console | State-machine list, **execution detail with workflow graph**, execution event history/table, map-run view, redrive/retry |
| AWS CloudWatch | Metrics dashboards (panels/charts), **Logs Insights** log viewer, alarms, service map (X-Ray traces) |
| AWS SQS console | Queue list, queue detail (messages available / in-flight / DLQ), CloudWatch metrics, send/poll/purge |
| AWS Batch console | Job-queue dashboard, job list by status, job detail, logs, compute-environment health, alarms |
| Docker Desktop | Containers list, container detail, logs, stats (metrics), quick search |
| docker compose ps | Service/container list filtered by status; logs (`logs -f`) |
| docker CLI logs | Streaming log view (follow, tail, timestamps) |
| Portainer | Container/stack list, container detail, logs, resource stats |
| Airflow UI | DAG list (home), **Grid view**, **Graph view**, Gantt, DAG-run detail, task-instance detail, logs, events, code, calendar, trigger window, backfill |
| Flower (Celery) | Workers list, task list, task detail, broker/queue monitor, real-time rate graphs |
| Bull Board | Queue list with counts, job list per state tab (waiting/active/completed/failed/delayed), job detail, retry/clean actions |
| Sidekiq Web | Dashboard (realtime graph), **Queues** view, **Busy/workers** view, **Retries** view, **Scheduled** view, **Dead (morgue)** view, metrics |
| JobRunr dashboard | Overview, job list by state, job detail, recurring jobs (schedules), servers, queue/metrics |
| Dagster UI | Overview/runs list, **run detail with Gantt timeline**, asset graph, schedules/sensors, backfills, deployment health |
| Argo Workflows UI | Workflow list, **workflow DAG graph + node detail**, logs, events, retry/resubmit, cron-workflows |
| Prefect UI | Dashboard, flow-runs list, flow-run detail, **DAG/graph**, logs, schedules/deployments, retries |
| Azure Durable Functions | Orchestration status query, **Durable Functions Monitor (Gantt/sequence)**, App Insights logs/metrics, storage state |
| Azure App Insights | Dashboards, **end-to-end transaction trace**, logs (KQL), metrics, failures, alerts |
| GCP Cloud Workflows | Execution list, execution detail + results, execution history/steps |
| GCP Cloud Tasks | Queue list, queue detail, task list, Cloud Monitoring metrics |
| Inngest | Function-runs list (searchable), **run detail timeline/trace**, per-step view, retry/cancel/replay actions |
| Trigger.dev | Runs dashboard list (status filters), run detail with lifecycle states, queues, retries, replay/cancel, alerts |
| Grafana | Dashboards of panels (time-series/stat/table), log panels, trace panels, alerting |

---

## 2. Common CORE screens (recur across MOST platforms)

### A. Jobs / Runs List  — *the universal landing screen*
- **Purpose:** Browse and triage all job/run instances; the operator's home base.
- **Platforms (≈all 27):** Temporal, Airflow, Dagster, Prefect, Argo, Inngest, Trigger.dev, Sidekiq, Bull Board, JobRunr, Step Functions, Batch, SQS, Cloud Workflows, K8s/k9s/Lens lists, Docker `ps`, etc.
- **Essential components:** sortable table (id, name/type, status, started, duration, attempts); status-colored rows/badges; status filter + free-text search (search present in 18/27, filter-in-general in 23/27); time-range filter; pagination/infinite scroll; status count summary / facet chips; row click → detail; bulk-select for batch actions.

### B. Run / Execution Detail  — *the universal drill-down*
- **Purpose:** Everything about one run: status, timing, inputs/outputs, steps, errors.
- **Platforms (≈all 27):** "detail/run detail/execution detail" appears in ~24/27 docs.
- **Essential components:** header (id, status badge, type, started/ended, duration, attempt #); metadata/params + result/output payload; **step/task breakdown** (sub-list or inline graph); error/stack panel on failure; per-run **action bar** (retry, cancel, replay, rerun); links to logs and trace; tabs (Overview / Logs / Events / Graph).

### C. Logs / Event History  — *near-universal*
- **Purpose:** Read execution output and the ordered lifecycle events of a run.
- **Platforms (21/27 logs; event-history specifically in Temporal, Airflow, Step Functions, GCP, Dagster, Argo).**
- **Essential components:** chronological event/log stream; follow/tail toggle; timestamps; level/severity coloring; search-in-logs; download/export; per-event expand (Temporal/Step Functions event payloads).

### D. Workflow / DAG Graph view
- **Purpose:** Visualize step dependencies and per-node status of a workflow.
- **Platforms (16/27 graph-ish; strongest in Airflow, Argo, Step Functions, Prefect, Dagster, Durable Functions, App Insights trace map, CloudWatch service map).**
- **Essential components:** node-edge canvas; node color = status; click node → step detail/logs; zoom/pan; legend; (often paired with the run-detail screen).

### E. Timeline / Gantt
- **Purpose:** See when each step ran and how long, to spot slow/serial bottlenecks.
- **Platforms (6/27 explicit: Airflow Gantt, Dagster Gantt, Temporal, Inngest trace timeline, Durable Functions Monitor, Grafana).**
- **Essential components:** horizontal bars per step on a time axis; duration labels; overlap/parallelism visible; hover → step detail.

### F. Queue / Worker Health
- **Purpose:** Operational health of the processing fabric — backlog and capacity.
- **Platforms:** worker/executor health discussed in 22/27; explicit queue-depth/backlog in SQS, Sidekiq, JobRunr, CloudWatch, Bull Board, Cloud Tasks, Batch, Flower.
- **Essential components:** queue table (name, depth/backlog, in-flight, DLQ count, latency/oldest-message); worker/server table (id, status, current job, heartbeat, concurrency, CPU/mem); purge/drain/scale actions.

### G. Metrics Dashboard
- **Purpose:** Aggregate throughput/success/failure/latency over time.
- **Platforms (21/27):** Grafana, CloudWatch, App Insights, Sidekiq, JobRunr, Dagster, Inngest, Trigger.dev, k9s/Lens, Batch, SQS, etc.
- **Essential components:** time-series charts (throughput, success vs failure, latency p50/p95); stat tiles (running / queued / failed counts); time-range picker; per-queue/per-type breakdown.

### H. Schedules / Recurring jobs
- **Purpose:** View and manage cron/recurring triggers.
- **Platforms (18/27):** Airflow, Temporal, Dagster, Prefect, Argo cron-workflows, JobRunr, Sidekiq scheduled, Trigger.dev, Cloud tasks, EventBridge/CloudWatch.
- **Essential components:** schedule list (name, cron expr, next run, last run, enabled toggle); pause/resume; trigger-now; link to runs produced.

### I. Retry / DLQ / Failed view (secondary but distinct)
- **Purpose:** A dedicated place for failed/dead work to redrive or discard.
- **Platforms:** explicit in Sidekiq (Retries + Dead/morgue), SQS (DLQ + redrive), Step Functions (redrive), Bull Board (failed tab); failed-status filtering everywhere.
- **Essential components:** failed-job table; error preview; retry/redrive (single + bulk), delete/discard, requeue.

### J. Alerts (lighter weight)
- **Purpose:** Define/observe alert conditions on failures or backlog.
- **Platforms (11/27):** CloudWatch alarms, Grafana alerting, App Insights, Dagster, Sidekiq, Batch, SQS, Bull Board, Docker Desktop.

---

## 3. Common columns & filters (list views)

**Recurring columns** (with presence count):
- **Status / state** — 22/27 (the single most universal column; always color-coded)
- **Started / start time** — 24/27
- **Name / type** — 21/27
- **ID** (run/job/execution/workflow/message id) — 15/27
- **Duration / elapsed / latency** — 17/27
- **Worker / node / executor / pod** — 21/27
- **Created / enqueued timestamp** — 13/27
- **Attempts / retries** — 10/27
- **Queue** — 10/27
- **Priority** — 5/27 (minority)

**Recurring filters / controls:**
- **Free-text search** — 18/27 (search by id/name; Inngest & Temporal expose searchable property sets)
- **General filter/facet/query/sort** — 23/27
- **Status filter** — explicit in Inngest, Trigger.dev, Airflow, docker `ps --status`; implied wherever status is a column
- **Namespace / tag / label** — 15/27 (multi-tenant scoping)
- **Time range / date range** — CloudWatch, Airflow, Durable Functions, plus every metrics screen
- **Queue filter** — queue-centric platforms (SQS, Sidekiq, Bull Board, Inngest)

---

## 4. Common actions (operator)

| Action | Presence | Platforms (sample) |
| --- | --- | --- |
| **View logs / drill into trace** | 20/27 | nearly all; trace specifically in Temporal, CloudWatch, App Insights, Docker, K8s, Grafana, Inngest |
| **Replay / rerun / restart / backfill** | 15/27 | Inngest, Trigger.dev, Argo, Dagster, Airflow, Durable Functions, k9s, K8s, Docker |
| **Cancel / terminate / stop / kill** | 14/27 | Temporal, Argo, Step Functions, Inngest, Trigger.dev, SQS, Bull Board, Docker |
| **Trigger / submit / enqueue (run now)** | 15/27 | Airflow, Temporal, Argo, Prefect, JobRunr, Sidekiq, Inngest, Bull Board |
| **Delete / purge / drain / remove** | 13/27 | SQS purge, Sidekiq, Bull Board clean, Temporal, K8s, Docker |
| **Retry (single + bulk)** | 11/27 | Sidekiq, Bull Board, Step Functions redrive, Argo, Airflow, Inngest, App Insights |
| **Pause / resume / suspend** | 9/27 | Argo, Prefect, Step Functions, Airflow schedules, K8s, Docker, Trigger.dev |

Pattern: actions live (a) inline per row in the **list**, (b) in an **action bar on the run detail**, and (c) on **schedule** rows (pause/resume/trigger).

---

## 5. Status taxonomy (union across platforms)

Mapped to a normalized set our UI should support (with which platform families use each):

| Normalized status | Aliases seen | Presence |
| --- | --- | --- |
| **Queued / Pending / Scheduled** | queued, pending, waiting, enqueued, scheduled, delayed | 11/27 (+ implicit everywhere) |
| **Running / Active** | running, active, in-progress, executing | 19/27 |
| **Succeeded** | succeeded, success, completed, done | 14/27 |
| **Failed** | failed, failure, errored, faulted | 19/27 |
| **Retrying** | retrying, retry-pending | 10/27 |
| **Cancelled / Terminated** | cancelled, terminated, aborted | 9/27 |
| **Paused / Suspended** | paused, suspended | low (schedules/services) |
| **Timed out** | timed out, timeout | 5/27 (Temporal, Sidekiq, JobRunr, Trigger.dev, SQS) |
| **Dead / DLQ** | dead, DLQ, dead-letter, morgue, dead-set | 3/27 (Sidekiq, SQS, compose) — distinct terminal bucket |

**Recommended canonical state machine:**
`Scheduled → Queued → Running → (Succeeded | Failed | Cancelled | TimedOut)`, with `Failed → Retrying → Queued` loop and `Failed/exhausted → Dead/DLQ`. `Paused` applies to schedules, not individual runs.

---

## 6. Recommended VERY BASIC wireframe set (ranked)

A framework-agnostic minimum that covers the core. Aim: 6 screens.

1. **Runs List** *(P0 — the landing screen)*
   Table: id · name/type · status badge · queue · started · duration · attempts. Top bar: status-filter chips + search + time-range. Row actions: retry / cancel / view. — *Rationale: present in ~all 27 platforms; it is where every operator starts.*

2. **Run Detail** *(P0)*
   Header (id, status, type, timing, attempt) + tabs **Overview / Steps / Logs / Events**. Action bar: Retry · Replay · Cancel. Params + output + error panel. — *Rationale: the universal drill-down (~24/27); folds in logs, events, and per-step status so we don't need separate top-level screens for those first.*

3. **Queues & Workers Health** *(P1)*
   Two tables: Queues (name · depth · in-flight · DLQ · oldest-age) and Workers (id · status · current job · heartbeat · concurrency). Purge / drain / scale actions. — *Rationale: operational health is the second thing operators check; worker health in 22/27, queue depth in the queue-centric platforms.*

4. **Metrics Dashboard** *(P1)*
   Stat tiles (running / queued / failed) + time-series (throughput, success vs failure, latency p95) + time-range picker. — *Rationale: 21/27 platforms ship an aggregate dashboard; needed for trend/at-a-glance health.*

5. **Schedules** *(P2)*
   List: name · cron · next run · last run · enabled toggle. Actions: pause/resume · trigger-now · view runs. — *Rationale: 18/27; the management surface for recurring work, distinct from ad-hoc runs.*

6. **Failed / DLQ** *(P2)*
   Failed/dead-letter table with error preview and bulk **redrive/retry** + **discard**. — *Rationale: failure triage is the highest-value operator workflow; SQS/Sidekiq/Step Functions/Bull Board all give it a dedicated screen.*

**Deferred (not in the basic set, add later):**
- **Workflow/DAG Graph** + **Gantt timeline** — high value only once jobs are multi-step DAGs (16/27 and 6/27 respectively); collapse into a tab inside Run Detail when introduced.
- **Distributed trace view** — overlaps with Run Detail steps; defer.
- **Alerts configuration** — start by surfacing alerts; build authoring later (11/27).

**Cross-cutting UI primitives to standardize first:** the **status badge** (one color map for the canonical taxonomy in §5), the **relative-time / duration** formatter, and a shared **list+filter** component reused by screens 1, 3, 5, 6.
