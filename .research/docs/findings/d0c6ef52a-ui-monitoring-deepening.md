---
id: d0c6ef52a
topic: ui-monitoring
title: 'Operator UIs in depth: engine dashboards, cloud consoles, and container monitoring'
status: draft
shape: survey
---

# Operator UIs in depth: engine dashboards, cloud consoles, and container monitoring

**Scope.** This is a deepening sibling to the existing operator-UI finding
(`d8c5f2828`, which synthesized only Airflow UI, JobRunr, Sidekiq web, Grafana, and
CloudWatch). It expands coverage across three families of operator surface drawn from
the catalog's currently-uncited ui-monitoring sources: (1) **engine-native run/execution
dashboards** bundled with workflow and queue engines; (2) **cloud consoles and managed
observability** surfaces; and (3) **general container/Kubernetes operator tooling** that
job systems inherit when they run as containers. The focus is *what an operator actually
sees and does* on each surface — the lists, run-detail panes, graphs, logs, and metrics.
Not covered: alerting/on-call routing internals, the engine-native UIs already synthesized
in `d8c5f2828`, and Google Cloud Tasks/Cloud Workflows console specifics — the corpus
pages for those returned 404/nav-only shells with no citable body, as did the Flower
screenshots page.

## Engine-native run and execution dashboards

The dominant pattern is a **two-level drill-down: a filterable list of runs, then a
per-run detail view** showing timing, state, inputs/outputs, and logs.

- **Temporal Web UI.** The main Workflows page displays a table of all Workflow
  Executions within the retention period, listable by Status, Workflow ID, Workflow Type,
  start time, end time, and search attributes [ca4c5cb75]. Selecting an execution opens
  its History, Workers, Relationships, pending Activities, Queries, and Metadata, and the
  entire Event History can be downloaded in JSON format [ca4c5cb75]. Namespaces are listed
  in the left section and switchable from the Workflows view [ca4c5cb75].
- **Dagster UI** (served by the Dagster webserver) lets you inspect Dagster objects such
  as assets, jobs, and schedules, launch runs, and view launched runs and the assets they
  produced [c56937ff8]. The Runs page lists all job runs, filterable by job name, run ID,
  execution status, or tag; a Run details page shows timing information, errors, and logs,
  with a Gantt chart in the upper-left pane and a filterable events/logs pane below
  [c56937ff8]. A job's detail view exposes Overview, Launchpad (a configuration editor to
  experiment and launch runs), Runs, and Partitions tabs [c56937ff8].
- **Prefect UI** is described as a modern UI for real-time flow run monitoring, logging,
  and state tracking, automatically rendering dependency graphs and DAGs [cba04d3ef].
- **Inngest** exposes a "Runs" page in the left navigation listing function runs across all
  apps in the selected environment, filterable by Status, Queued/Started-at, and
  Application, with an advanced CEL-expression search over event and output fields
  [c74eb273d]. The run-details view supports performing actions on a run [c74eb273d].
- **Trigger.dev** centers on "runs": a run moves through initial, execution, and final
  lifecycle states, and the dashboard supports replaying and bulk actions [ca5210dec]. The
  same filter model is exposed programmatically — `runs.list()` filters by status, created
  time, task identifier, version, tags, batch, and schedule [ca5210dec].
- **Bull Board** is a dashboard UI for Bull and BullMQ job queues that you mount into your
  own server to see your queues [c5285d005].
- **AWS Step Functions Workflow Studio** is a graphical builder whose Design mode shows a
  states browser (Actions, Flow, and Patterns tabs of drag-and-drop building blocks), a
  workflow canvas/graph, an inspector, and contextual help; states are dragged onto the
  canvas and the graph can be zoomed for large workflows [c103bc45b].
- **Argo Workflows** ships an Argo Server that exposes an API and UI for workflows, runnable
  in hosted or local mode and serving the UI on port 2746; by default the UI service is not
  exposed with an external IP [ccefae857].

## Cloud consoles and managed observability

Managed platforms fold the operator surface into the provider console, pairing a service
console with a metrics/logs/traces backend.

- **AWS Batch** organizes work into job queues and jobs, and is accessible to operators
  through the AWS Batch console (among CLI/SDK paths) [c11067bf2].
- **Amazon CloudWatch** gives system-wide observability via metrics tracked at user-defined
  intervals, alarms that watch metrics against thresholds and can trigger automated actions,
  and dashboards offering a unified view of metrics and logs in one location — including
  curated automatic dashboards for many AWS services so operators don't have to build them,
  plus log collection/query and cross-account central monitoring [c14919b16].
- **Azure Application Insights** is an APM feature of Azure Monitor whose "Investigate"
  experiences include an at-a-glance Application dashboard, an Application map of
  architecture and component interactions, a real-time Live metrics analytics dashboard, and
  Search/Failures/Performance views; the "Monitoring" experiences add Alerts, Metrics, Logs,
  and Workbooks [cd4f034b7].
- **Azure Durable Functions** diagnostics route through Application Insights: operators run
  Kusto queries in Application Insights Analytics to inspect orchestration instances — an
  "instance summary" query returns the list of instance IDs and their current runtime status
  over a time range — and the Durable Functions Monitor is offered as an additional tool
  [c2b47b6c6].

## General-purpose visualization

- **Grafana** dashboards are built from panels, where each panel is the basic building block
  composed of a query plus a visualization (a graphical representation of query results),
  drawn from a growing suite ranging from time-series graphs to heatmaps [ccd377138]. This
  is the "wire up the metrics, get one cross-system pane" model that complements the
  domain-aware engine dashboards above.

## Container and Kubernetes operator surfaces

When a job system runs as containers, operators frequently watch it through generic
container/Kubernetes tooling rather than the engine's own UI.

- **Kubernetes Dashboard** (web UI) has a Workloads view listing applications by workload
  kind (Deployments, ReplicaSets, StatefulSets) and summarizing actionable data such as the
  number of ready pods or current memory usage; an Admin overview where the Node list
  aggregates CPU and memory metrics across nodes; a built-in logs viewer; and a deploy wizard
  for launching containerized apps [c2be088ad].
- **k9s** is a terminal-based UI that continually watches Kubernetes for changes to navigate,
  observe, and manage deployed applications; it tracks real-time metrics for pods, containers,
  and nodes, offers standard commands (logs, scaling, port-forwards, restarts), an Error Zoom
  to drill into what's wrong, and Pulses/XRay multi-resource views [c083ff4c0].
- **Lens** is a Kubernetes IDE for working with Kubernetes clusters [cbdb3129c].
- **Portainer** hides the complexity of managing containers behind an easy-to-use UI —
  removing the need for the CLI, YAML, or manifests — and manages containers across Docker,
  Docker Swarm, Kubernetes, and Azure ACI [c6da40640].
- **kubectl** remains the baseline operator surface: `kubectl get pods` (with `-o wide` for
  detail), `kubectl describe pods`, and `kubectl logs` — including `-f` to stream stdout and
  `--previous` to read a crashed container's prior instantiation — plus `kubectl top pod` for
  per-pod/container metrics [c75fccaf6].
- **Docker logs.** `docker logs --follow` continues streaming new output from a container's
  STDOUT and STDERR, with `--tail` to bound the number of lines, `--timestamps` to prefix
  times, and `--since`/`--until` to window by time [c1e484888].
- **`docker compose ps`** lists the containers for a Compose project with their current
  status and exposed ports, defaulting to running containers and accepting `--all` and a
  `--status`/`--filter status=<status>` filter [cc2bc1b9f].
- **Docker Desktop** presents a Dashboard as the central management surface, with a
  Quick Search spanning containers and images and an integrated terminal [cea2cea43].

## What recurs across surfaces

Three conventions hold across all three families. **A filterable run/instance list keyed by
status** appears in engine dashboards (Temporal, Dagster, Inngest, Trigger.dev) [ca4c5cb75]
[c56937ff8] [c74eb273d] [ca5210dec], in managed status queries (Durable Functions instance
summary) [c2b47b6c6], and in container listings (`docker compose ps`, `kubectl get pods`)
[cc2bc1b9f] [c75fccaf6]. **A per-run detail view binding timing, state, inputs/outputs, and
logs** is explicit in Dagster's Run details (Gantt + events/logs panes) [c56937ff8] and
Temporal's execution History [ca4c5cb75]. **Logs as a first-class panel** is universal —
engine run views, the Kubernetes Dashboard logs viewer [c2be088ad], k9s [c083ff4c0],
`docker logs` streaming [c1e484888], and CloudWatch/App Insights log stores [c14919b16]
[cd4f034b7] all surface them. The split the prior finding noted — domain-aware engine UIs
vs. metric-agnostic general dashboards (Grafana [ccd377138], CloudWatch [c14919b16]) — extends
to a third axis here: **container/orchestrator tooling** (k9s, Lens, Portainer, kubectl,
Docker) that sees pods and containers but not the engine's jobs, useful precisely when the
engine UI is unavailable or the failure is below the engine.
