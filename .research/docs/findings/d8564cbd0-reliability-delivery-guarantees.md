---
id: d8564cbd0
topic: reliability
title: Reliability and delivery guarantees across BullMQ, Sidekiq, and Celery
status: draft
shape: comparison
---

# Reliability and delivery guarantees across BullMQ, Sidekiq, and Celery

**Scope.** Reliability dimension only. Covered: Sidekiq (official wiki) and Celery
(attributed engineering posts), plus BullMQ at the *architectural* level. Temporal and
River are **abstained** — no on-target source. BullMQ's quantitative reliability
benchmark was dropped: the only such source was promotional, so BullMQ here is limited to
attributed architectural facts (see gaps).

## Retry mechanism and backoff

Celery provides automatic retries via the `@task` decorator: `autoretry_for` selects the
exception types to retry, `retry_backoff` enables exponential backoff, and `retry_kwargs`
caps the attempt count (e.g. 3) [c9397f0cc]. Each retry attempt is a fresh task execution
that should be traced as one logical operation; absent explicit observability the retry
path is effectively a black box [cf6b75357].

## Delivery guarantees and the broker

The broker sets the delivery-guarantee floor. With Redis as the Celery broker a
`visibility_timeout` governs how long the broker waits for a worker ack before
redelivering [ca14577a1]. If a task runs longer than `visibility_timeout`, another worker
can pick up and re-execute the same task, so a too-short timeout risks duplicate
execution while a too-long one delays redelivery of tasks lost to a crash [ca14577a1].
RabbitMQ sidesteps this tuning because it supplies delivery guarantees through durable
queues and message acknowledgements out of the box [ca14577a1]. The same Redis-vs-ack
contrast frames BullMQ: BullMQ is a Redis-backed Node.js library and successor to Bull,
while RabbitMQ is an AMQP broker whose reliability rests on message acknowledgement and
durable queues [c9d6b59a6].

## Failure isolation and durability

Sidekiq's default client assumes the Redis push succeeds and does no error handling, so a
network failure surfaces as an application exception [c7b4003f6]. Sidekiq Pro's
reliability client adds "reliable push," locally enqueuing jobs until the connection is
re-established [c7b4003f6]. That buffer is deliberately bounded: it is per-process and
in-memory (lost on restart), retains only the last 1,000 pushes by default, does not
cover Batches, and drains only on the next push — so an idle process delays delivery
[c7b4003f6]. Celery bounds runaway tasks with two timeouts: `soft_time_limit` raises
`SoftTimeLimitExceeded` for graceful cleanup, while `time_limit` forcibly terminates the
task [c9397f0cc].

## Cross-cutting

Default configurations are not production-grade: Celery on Redis is "easy until it isn't,"
and reliability requires deliberate configuration, queue design, and observability rather
than defaults [ca14577a1].

## Open questions (gaps)

- BullMQ quantitative reliability (retry-recovery rate, Redis Cluster failover) from a
  **primary** source (official docs) — the only benchmark found was promotional and was
  excluded.
- Temporal durable-execution guarantees — no on-target source yet.
- River (Postgres-backed) transactional enqueue reliability — not fetched.
- Per-engine delivery-guarantee class: at-least-once vs exactly-once.
