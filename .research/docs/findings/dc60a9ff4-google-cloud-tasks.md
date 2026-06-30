---
id: dc60a9ff4
topic: cloud-gcp-firebase
title: "Google Cloud Tasks: Managed Queue Model"
status: draft
shape: synthesis
---

# Google Cloud Tasks: Managed Queue Model

Cloud Tasks is a managed task-queue system. This synthesis asks: how do queues dispatch and get configured (method), what delivery guarantees and limits are documented (evidence), where reliability caveats bite (contradiction), and what the HTTP-target worker pattern looks like (application).

## Queues & reliable dispatch (method)

A queue is the dispatch unit: when tasks are added to a queue, the queue dispatches them and makes sure they are reliably processed by a service, also known as a worker [ca057179c]. A queue name consists of three parts: a project ID, a location, and a queue ID [ca057179c]. Queues can be created in the Google Cloud console, by using the gcloud CLI in a terminal or Cloud Shell, or by sending a direct request to the Cloud Tasks API [ca057179c]. The gcloud creation command is `gcloud tasks queues create QUEUE_ID --location=LOCATION` [ca057179c]; the REST equivalent is the `projects.locations.queues.create` method [ca057179c]. Other flags for the gcloud CLI command let you configure rate limits, retry options, queue types, and more [ca057179c]. A newly created queue returns a `Queue` resource whose documented defaults are `maxDispatchesPerSecond` 500, `maxBurstSize` 100, `maxConcurrentDispatches` 1000, and a `retryConfig` of `maxAttempts` 100, `minBackoff` "0.100s", `maxBackoff` "3600s", `maxDoublings` 16, with `state` RUNNING [ca057179c]. It can take a few minutes for a newly created queue to be available [ca057179c].

## Queue configuration (method)

A queue can be configured when created or anytime afterwards, and the configuration is applied to all tasks in that queue [c8bbf2e4d]. There are three basic aspects to configuring queues: routing, rate limits, and retry parameters [c8bbf2e4d].

Configuring routing at the queue level overrides routing set at the task level, which is useful to use Cloud Tasks as a buffer in front of a target service [c8bbf2e4d]. For HTTP tasks, queue-level routing is set via the queue's `uriOverride` parameter [c8bbf2e4d]. Updating queue-level routing on an existing queue requires pausing the queue, applying the change, waiting one minute, then resuming it, because it can take up to one minute for the new configuration to take effect [c8bbf2e4d]. Pause and resume use `gcloud tasks queues pause QUEUE_ID` and `gcloud tasks queues resume QUEUE_ID` [c8bbf2e4d]. A documented incompatibility: queue-level routing is not compatible with Cloud Key Management Service (Cloud KMS) customer-managed encryption keys (CMEK) — if CMEK is enabled, you can't create tasks on a queue that has queue-level routing or apply queue-level routing [c8bbf2e4d].

The rate limit determines the maximum rate at which tasks can be dispatched by a queue, regardless of whether the dispatch is a first task attempt or a retry [c8bbf2e4d]. The queue uses the token bucket algorithm to control the rate of task execution, and each named queue has a bucket that holds its tokens [c8bbf2e4d]. Through the Cloud Tasks API two fields define the dispatch rate, `max_dispatches_per_second` and `max_concurrent_dispatches`; a third field, `max_burst_size`, is calculated by the system based on the value set for `max_dispatches_per_second` [c8bbf2e4d].

For retries: if a task doesn't complete successfully, Cloud Tasks will retry the task with an exponential backoff according to the parameters you have set, and once a task is successfully executed it is removed from the queue [c8bbf2e4d]. Retry flags are `--max-attempts`, `--max-retry-duration`, `--min-backoff`, `--max-backoff`, and `--max-doublings` [c8bbf2e4d]. `MAX_ATTEMPTS` is the maximum number of attempts including the first, and unlimited retries are allowed by setting it to `-1` [c8bbf2e4d]. In all cases the maximum task retention limit also applies [c8bbf2e4d].

## HTTP target tasks (application)

Cloud Tasks handlers can be run on any HTTP endpoint with an external IP address such as GKE, Compute Engine, or even an on-premises web server, and tasks can be executed on any of these services in a reliable, configurable fashion [c15acad57]. For tasks with HTTP targets there are two creation methods: the `CreateTask` method, where you explicitly create a task object and specify routing at the task level (and cannot use queue-level routing), and the `BufferTask` method, used when the queue is set up to buffer tasks in front of a service and must have queue-level routing [c15acad57]. The `BufferTask` method is not supported in client libraries and is not supported in the RPC API, and does not support task-level routing, so it requires queue-level routing [c15acad57].

To authenticate between Cloud Tasks and an HTTP target handler, Cloud Tasks creates a header token based on the credentials in the `Cloud Tasks Enqueuer` service account, and the request with the header token is sent from the queue to the handler by HTTPS [c15acad57]. The handler can be authenticated with either an ID token or an access token, and authentication can be configured at the queue level or the task level, with queue-level configuration overriding the task level [c15acad57]. For handlers, the default timeout is 10 minutes, with a maximum of 30 minutes [c15acad57]. An HTTP target request carries headers set by the queue that provide task-specific information for information only and should not be used as sources of identity [c15acad57]; these always include `X-CloudTasks-QueueName`, `X-CloudTasks-TaskName`, `X-CloudTasks-TaskRetryCount`, `X-CloudTasks-TaskExecutionCount`, and `X-CloudTasks-TaskETA` [c15acad57]. If a task is given a name, Cloud Tasks can use that name to ensure task deduplication, although the processing necessary for this can add increased latency [c15acad57]; scheduling a task at a future time is supported for `CreateTask` only and not supported for `BufferTask` [c15acad57].

## Retry & delivery semantics / limitations (evidence + contradiction)

The reliability guarantees are bounded. On ordering: "With the exception of tasks scheduled to run in the future, task queues are completely platform-independent about execution order. There are no guarantees or best effort attempts made to execute tasks in any particular order." [c37dae40d] Specifically, there are no guarantees that old tasks will execute unless a queue is completely emptied [c37dae40d]. On duplicates: "Cloud Tasks aims for a strict "execute exactly once" semantic." [c37dae40d] However, where a trade-off must be made between guaranteed execution and duplicate execution, the service errs on the side of guaranteed execution, so a non-zero number of duplicate executions do occur — in production, more than 99.999% of tasks are executed only once [c37dae40d]. Executions might also experience minor delays, usually lasting a few minutes, due to internal system restarts; tasks are delayed, but no tasks are lost [c37dae40d].

The dominant reliability caveat is resource exhaustion on the worker: the most common source of backlogs in immediate processing queues is exhausting resources on the target instances, which can generally be resolved by increasing the number of instances processing requests [c37dae40d]. Overloaded servers can return backoff errors — HTTP `503` for App Engine targets, or HTTP `429` or `5xx` for external targets — and Cloud Tasks reacts by slowing down execution until errors stop [c37dae40d]. To smooth traffic, dispatches ramp up slowly when the queue is newly created or idle, and ramp-up is based in part on the number of successful previously dispatched tasks, so long-running task handlers (on the order of minutes) can lag the queue ramp-up rate [c37dae40d]. Increasing `max_concurrent_dispatches` can help when latency spikes leave queues unable to execute at the expected rate, but increasing it is unlikely to relieve any underlying resource pressure [c37dae40d]. Two operational limits: if you have more than 5,000 tasks, some are not visible in the console (use the gcloud CLI to view all) [c37dae40d]; and after deleting a queue you must wait 3 days before recreating it with the same name [c37dae40d].

## Cross-source synthesis

The four sources cohere into one model: a queue is the reliable-dispatch unit [ca057179c], configured for routing/rate/retry that apply to all its tasks [c8bbf2e4d], delivering authenticated HTTPS requests to an arbitrary worker endpoint [c15acad57] — under explicitly bounded ordering and at-least-once-leaning duplicate semantics whose practical failure mode is worker resource exhaustion [c37dae40d].

## Open questions (research gaps)

- Exact value/formula the system uses to compute `max_burst_size` from `max_dispatches_per_second` is referenced but not stated in these bodies [c8bbf2e4d]; the numeric maximum task retention limit is linked but not given [c8bbf2e4d][c37dae40d].

## Dropped sources

None — all four sources (ca057179c, c8bbf2e4d, c15acad57, c37dae40d) were cited from body prose.
