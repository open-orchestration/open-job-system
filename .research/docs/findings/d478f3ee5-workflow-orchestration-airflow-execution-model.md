---
id: d478f3ee5
topic: workflow-orchestration
title: 'Airflow''s execution model: DAGs, scheduler, executor, and DAG runs'
status: draft
shape: single-entity
---

# Airflow's execution model

Apache Airflow orchestrates workflows rather than dispatching loose jobs: its
unit of scheduling is the DAG, "a model that encapsulates everything needed to
execute a workflow," whose attributes include a schedule, its tasks, and the
task dependencies that fix the order and conditions under which tasks execute
[c1be14e09]. The DAG "doesn't care about _what_ is happening inside the tasks;
it is merely concerned with _how_ to execute them — the order to run them in,
how many times to retry them, if they have timeouts, and so on" [c1be14e09].
The name derives from the mathematical "directed acyclic graph" [c1be14e09].

A Task is "the basic unit of execution in Airflow," arranged into DAGs with
upstream and downstream dependencies expressing run order [c3b02633d]. There
are two authoring styles for the work itself. An Operator is "a template for a
predefined" Task — for example `BashOperator` executes a bash command and
`PythonOperator` calls an arbitrary Python function [ccc1d94ae]. Alternatively
the TaskFlow API (added in version 2.0) wraps a plain Python function as a task
via the `@task` decorator, moving inputs and outputs between tasks using XComs
and automatically calculating dependencies [c7eff2026]. Internally both reduce
to subclasses of `BaseOperator` [c3b02633d].

Execution is split across two components. The scheduler "monitors all tasks and
Dags, then triggers the task instances once their dependencies are complete";
once per minute by default it collects DAG parsing results and checks whether
any active tasks can be triggered, and it "uses the configured Executor to run
tasks that are ready" [cf5123b41]. Executors are "the mechanism by which task
instances get run" — a common, pluggable API set by the `executor` option in
the `[core]` config [c18fa1028]. Airflow defaults to the `LocalExecutor`, which
runs tasks locally inside the scheduler process; remote executors instead run
tasks via a pool of workers for multi-machine installations [c18fa1028].

Each execution materializes as a DAG Run, "an object representing an
instantiation of the Dag in time," whose status depends on its tasks' states
and which can run in parallel for the same DAG [cf76f81df]. DAGs run either when
triggered manually or via the API, or on a defined schedule [c1be14e09]. The
first DAG Run is created from the minimum `start_date`; subsequent runs are
created according to the DAG's timetable [cf5123b41]. Each run carries a data
interval, and its "logical date" denotes the start of that interval, not when
the run actually executes — a run is usually scheduled after its data interval
has ended [cf76f81df]. A timetable's scheduling logic computes the next run from
the `last_automated_data_interval` of the prior non-manually-triggered run and a
`restriction` carrying `earliest`, `latest`, and `catchup` [cd3f8af81]. This
interval-driven, dependency-aware scheduling is what distinguishes Airflow as a
workflow orchestrator from a simple job queue.
