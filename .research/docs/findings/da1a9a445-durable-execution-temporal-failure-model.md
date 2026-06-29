---
id: da1a9a445
topic: durable-execution
title: "Temporal's durable-execution failure model: timeouts, activity retries, and replay-forced versioning"
status: draft
shape: single-entity
---

# Temporal's durable-execution failure model

Temporal provides Durable Execution, which guarantees an application runs to completion despite infrastructure issues, network problems, and Worker crashes — but not all failures are handled automatically, so the platform separates platform-level from application-level failures [c1bd468eb]. The model rests on a division of labor: a Workflow is deterministic orchestration code, while an Activity is a normal function executing a single well-defined action (calling a service, transcoding a file, sending email) whose code may be non-deterministic and which Temporal recommends be idempotent [c207dad27].

## Workflow-level failures

Workflow timeouts each bound a different aspect of an execution. The Workflow Execution Timeout caps total time in Open status including retries and Continue-As-New; the Workflow Run Timeout bounds a single run and therefore excludes retries and Continue-As-New; the Workflow Task Timeout caps how long a Worker may execute a Workflow Task after pulling it, defaulting to 10 seconds (extendable to 120, not recommended), and exists mainly to recognize that a Worker has gone down so the execution can recover on another Worker [c2e8d1622]. Temporal generally discourages setting Workflow Timeouts because Workflows are meant to be long-running, recommending a Timer instead [c2e8d1622]. Notably, a failed Workflow Task does not fail the Workflow; if the failure is unhandled the Workflow keeps running but never completes, detectable via the `TemporalReportedProblems` Search Attribute or the Web UI Task Failures View [c2e8d1622]. Operators can also count Workflows by `ExecutionStatus` through Visibility [c3c530383].

## Activity timeout taxonomy

A Workflow detects Activity failures through four timeouts [ce1e072b0]:

- **Schedule-To-Start** — limit on how long an Activity Task can sit enqueued before a Worker picks it up; default is infinity, and crucially it triggers no retries because a retry would re-enqueue to the same Task Queue [ce1e072b0].
- **Start-To-Close** — maximum for a single Activity Task Execution; strongly recommended because the Server cannot detect a Worker that crashes mid-execution and relies on this timeout to force retries. On expiry it writes an `ActivityTaskTimedOut` Event, increments the attempt count, and resets the timer [ce1e072b0].
- **Schedule-To-Close** — maximum for the overall Activity Execution across the chain of Activity Tasks; default infinity, used to bound total duration without altering the Retry Policy's Maximum Attempts [ce1e072b0]. An Activity must set either Start-To-Close or Schedule-To-Close [ce1e072b0].
- **Heartbeat Timeout** — maximum time between Activity Heartbeats, pings from the Worker telling the Service the Activity is progressing and the Worker has not crashed; on expiry the Activity Task fails and retries per the Retry Policy. Heartbeats can carry a progress payload that the next retry can read [ce1e072b0].

## Why replay forces versioning

Because Workflow Executions can run for months or years, code often must change mid-execution, yet the platform requires Workflow code to be deterministic; a change that would behave non-deterministically on Replay requires a Versioning method [c98eed491]. Common causes are adding, removing, or reordering `await` calls on Command-producing APIs such as Activities and timers, since each `await` is a yield point affecting the Command sequence seen during Replay [c98eed491]. Temporal offers Worker Versioning and Patching; `patched` inserts a marker into Event History, and during Replay a Worker that encounters that marker fails the Workflow Task if the code does not reproduce the same patch marker [c98eed491]. This versioning burden is a direct consequence of deterministic replay — a cost that queue libraries, which do not replay, do not incur.
