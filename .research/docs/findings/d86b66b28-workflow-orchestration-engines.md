---
id: d86b66b28
topic: workflow-orchestration
title: Workflow orchestration engines: authoring models and execution
status: draft
shape: survey
---

# Workflow orchestration engines: authoring models and execution

**Scope.** How DAG/pipeline orchestrators differ in authoring model and unit of
abstraction, from the catalog's workflow-orchestration sources. Drawn from Airflow,
Prefect, Dagster, Argo Workflows, and Flyte; the corpus also holds Luigi, Kubeflow,
Metaflow, Mage, Kestra, Windmill, and n8n/Node-RED (not yet synthesized).

## Key claims (cited)

- Apache Airflow is an open-source platform for **developing, scheduling, and monitoring
  batch-oriented workflows**, via an extensible Python framework that connects with
  virtually any technology [cd32d3fbd].
- Prefect is an open-source orchestration engine that **turns Python functions into
  production-grade data pipelines** — workflows authored in pure Python with no DSLs or
  config files, runnable anywhere Python runs — handling state tracking, failure handling,
  and real-time monitoring out of the box [cda20993b].
- Dagster is **asset-oriented**: its core abstractions are Assets with asset dependencies and
  asset checks, alongside ops and jobs, automated by schedules and sensors [cda19b1d5].
- Argo Workflows is **the workflow engine for Kubernetes**, expressing workflows as DAGs and
  steps of containers through custom resources (Workflows, Cron Workflows) with retrying of
  failed/errored steps, timeouts, exit handlers, and loops/conditionals [c22e3f6f3].
- Flyte is **task-oriented**, organized around a TaskEnvironment and Tasks, with caching,
  retries and timeouts, and fanout/parallel-execution control as first-class capabilities
  [c3867c7c7].

## Convergent vs contested

- **Convergent:** All five share the orchestrator loop — author a graph of steps → a
  scheduler runs them → state and failures are tracked and monitored — and all treat
  retries/timeouts as built-in.
- **Contested / differentiating:** Two axes split the field. (1) *Authoring model* —
  Python-native frameworks (Airflow, Prefect, Dagster, Flyte) vs Kubernetes-CRD/YAML
  (Argo). (2) *Unit of abstraction* — task/operator graphs (Airflow), data **assets**
  (Dagster), typed **tasks** (Flyte), or plain Python **flows** (Prefect). These reflect
  different mental models (pipeline-of-tasks vs graph-of-data-assets), not mere syntax.

## Implications for the system

- If the core is durable-execution + queue, an orchestrator sits *above* it for multi-step
  DAGs; pick the authoring model to match the team (Python-native for app teams, Argo for
  Kubernetes-native shops).
- The asset-vs-task distinction matters for data workloads: choose asset-oriented (Dagster)
  when lineage/freshness is the goal, task-oriented (Airflow/Flyte/Prefect) when the unit is
  a step of work.

## Gaps found → re-scan
- Scheduler/executor internals (Airflow scheduler/executor split, Prefect work pools) — not synthesized.
- Uncited engines: Luigi, Kubeflow Pipelines, Metaflow, Mage, Kestra, Windmill, n8n/Node-RED.
- How orchestrators compose with a durable-execution tier (Temporal/Step Functions) vs replace it.
