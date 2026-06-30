---
id: d40a062f5
topic: cloud-gcp-firebase
title: "Cloud Tasks and Cloud Run: Operational Limits and Quotas"
status: draft
shape: synthesis
---

# Cloud Tasks and Cloud Run: Operational Limits and Quotas

Synthesis of concrete operational limits for Google Cloud Tasks (quotas, system limits, retry/retention semantics, `max_burst_size` derivation) and Cloud Run (maximum concurrent requests per instance). Closes two prior open questions — the exact task-retention limit and the `max_burst_size` derivation — and adds Cloud Run concurrency.

## Cloud Tasks quotas & system limits

Cloud Tasks splits its limits into adjustable *quotas* and fixed *system limits*; system limits can't be changed [c8a5cbf60].

System limits (fixed) [c8a5cbf60]:

- Queue dispatch rate: `500 tasks per second per queue` — the maximum rate at which tasks can be dispatched from a queue; to dispatch at higher rates, use multiple queues [c8a5cbf60].
- Maximum task size: `1 MiB` — the maximum size of a task that can be added to a queue [c8a5cbf60].
- Task deduplication window: `Up to 24 hours` — the period during which adding a task with the same name as a recently deleted task is rejected with an error [c8a5cbf60].
- Inactive queues: `Inactive after 30 days` — a queue is `INACTIVE` if it receives no API method calls and has no task dispatches for this period [c8a5cbf60].
- Maximum task retention: `31 days` — the time between when a task is added to a queue and when it is automatically deleted [c8a5cbf60].
- Maximum schedule time for a task: `30 days from current date and time` — the maximum amount of time in the future a task can be scheduled [c8a5cbf60].
- Queue re-creation: `7 days` — the time you must wait after deleting a queue before re-creating one with the same name [c8a5cbf60].

Quotas (adjustable, applied per project per region) [c8a5cbf60]:

- Maximum number of queues: `1,000 per region` (console name "Number of queues per region"), covering both HTTP and App Engine targets including the default queue; queues created via `queue.yaml` instead use the older Task Queues method with an initial quota of `100` [c8a5cbf60].
- API requests: `6,000,000 per minute` per region [c8a5cbf60].
- Force run task requests: `60 per minute` per region — intended for manual debugging and unrelated to normal task execution [c8a5cbf60].
- List requests: `600 per minute` per region — total of `list tasks`, `list queues`, and `list locations` requests [c8a5cbf60].

Quotas generally apply at the Google Cloud project level, and within a project are shared across all applications and IP addresses [c8a5cbf60].

## Cloud Tasks retry / retention behavior

Retry behavior is governed by the queue's `RetryConfig` [c4144b6cf]. `MaxAttempts` is the number of attempts per task including the first attempt, must be `>= -1` (where `-1` indicates unlimited attempts), and Cloud Tasks stops retrying only when both `max_attempts` and `max_retry_duration` are satisfied, or when the task succeeds [c4144b6cf]. `MaxRetryDuration` specifies the time limit for retrying a failed task measured from first attempt; a value of `0` indicates an unlimited duration, up to the maximum task retention limit [c4144b6cf]. When `max_attempts` is `-1` and `max_retry_duration` is `0`, the task is retried until the maximum task retention limit is reached [c4144b6cf] — i.e. the `31 days` retention ceiling [c8a5cbf60].

Backoff is bounded by `MinBackoff` and `MaxBackoff`: a task is scheduled for retry between `min_backoff` and `max_backoff` after a failure, each given as a seconds string suffixed with `s` and truncated to the nearest second [c4144b6cf]. `MaxDoublings` controls the curve: the retry interval starts at `min_backoff`, doubles `max_doublings` times, then increases linearly, and finally retries at intervals of `max_backoff` up to `max_attempts` times [c4144b6cf]. The documented example — `min_backoff` `10s`, `max_backoff` `300s`, `max_doublings` `3` — yields retry intervals of `10s, 20s, 40s, 80s, 160s, 240s, 300s, 300s, ...` [c4144b6cf]. Unspecified retry fields take a Cloud Tasks default at queue creation [c4144b6cf].

## max_burst_size derivation

Cloud Tasks controls dispatch rate with a token-bucket algorithm: each queue holds tokens up to a maximum of `max_burst_size`, a token is removed per dispatch, tasks dispatch until the bucket empties, and the bucket refills continuously based on `max_dispatches_per_second` [c7be2fd23]. On the default: "The default value of `max_burst_size` is picked by Cloud Tasks based on the value of `max_dispatches_per_second`" [c7be2fd23]. "The maximum value of `max_burst_size` is 500" [c7be2fd23]. For App Engine queues created or updated via `queue.yaml/xml`, `max_burst_size` equals `bucket_size` [c7be2fd23]. Calling `UpdateQueue` without explicitly setting `max_burst_size` re-derives it whenever the update changes `max_dispatches_per_second` [c7be2fd23]. (The body states the default is *derived from* `max_dispatches_per_second` but does not give an explicit numeric formula — see Open questions.)

## Cloud Run concurrency

The maximum concurrent requests per instance is configurable and can be increased to a maximum of `1000` [c4db5a67c]. By default, instances deployed via Google Cloud CLI or Terraform have a maximum concurrency of `80 times the number of vCPUs`, applied only at new-service creation (not to subsequent revision deployments); instances deployed via the Google Cloud console default to a concurrency of `80` [c4db5a67c]. The specified value is a maximum limit — if the instance CPU is already highly utilized Cloud Run may send fewer requests and instead scale up the instance count [c4db5a67c]. Concurrency can be limited to `1` (one request at a time per instance) when each request uses most of the available CPU/memory or the container relies on unshareable global state, but a concurrency of `1` is likely to negatively affect scaling performance because many instances must start to absorb a spike [c4db5a67c].

Cost/scaling implication: when more instances process requests, Cloud Run allocates more CPU and memory at higher cost; a higher concurrency setting lets fewer instances handle the same request volume and can reduce cost — provided the application code handles parallel requests efficiently [c4db5a67c]. For single-threaded (CPU-bound) workloads on multi-vCPU instances, "vCPU hotspots" can keep average CPU utilization deceptively low and defeat CPU-based autoscaling, so lowering maximum concurrency forces scaling on request throughput instead [c4db5a67c].

## Open questions the sources could not answer

- c7be2fd23 states the default `max_burst_size` is "picked by Cloud Tasks based on the value of `max_dispatches_per_second`" but gives no explicit numeric formula for the derivation (only the `500` maximum) — the exact computation remains unstated.

## Dropped sources

None — all four sources (c8a5cbf60, c4144b6cf, c7be2fd23, c4db5a67c) were anchored to body content and cited.
