# Compare BullMQ, Sidekiq, Celery, Temporal, and River on reliability, throughput, and operational complexity

> Regenerated over run `r88403b06` after the comparison was completed. All three planned
> dimensions are now sourced. Each cell cites the corpus id(s) that bear it out; the one
> remaining unfilled cell (BullMQ throughput) is marked honestly — no primary throughput
> source exists for BullMQ (only promotional benchmarks, which were filtered out).
>
> Backing findings (all promoted, certainty: high unless noted):
> - reliability, BullMQ/Sidekiq/Celery — `findings/d8564cbd0-reliability-delivery-guarantees.md` (certainty: low)
> - reliability, Temporal/River + delivery-guarantee divide — `findings/d2695a4d9-temporal-river-reliability.md`
> - throughput — `findings/d7c5d5a95-throughput.md`
> - operational complexity — `findings/dd3344178-operational-complexity.md`

## Matrix — entities × dimensions

| Entity | reliability | throughput | operational complexity |
| --- | --- | --- | --- |
| **BullMQ** | Redis-backed Node.js successor to Bull; reliability rests on Redis persistence semantics vs RabbitMQ's AMQP acks/durable queues [c9d6b59a6] | **abstained** — no primary throughput source (only promotional benchmarks, filtered) | Redis as the in-memory job-state store; durability via Redis AOF (`appendonly`/`appendfsync everysec`); monitored with Bull Board [ce7433bff]. One Redis store + a dashboard |
| **Sidekiq** | Default client does no push error-handling; Pro "reliable push" buffers locally but bounded (per-process, in-memory, last 1,000, lost on restart) [c7b4003f6] | Thread-per-process Redis model; concurrency = threads/process (default 5); maintainer claims "thousands of jobs per second… millions per day" (qualitative); scale by adding processes/servers [c7d59cf55][cf1e5048d] | Redis (7.0+/Valkey/Dragonfly) via `REDIS_URL`; 1+ processes per app server all sharing one Redis; built-in web UI + `sidekiqmon` [c8e155433][c33cbcb8c][c983a4b42] |
| **Celery** | Auto-retry w/ `autoretry_for` + `retry_backoff`, capped attempts [c9397f0cc]; Redis broker needs `visibility_timeout` tuning to avoid duplicate/lost tasks [ca14577a1]; soft/hard timeouts [c9397f0cc] | Pluggable pools: prefork (CPU-bound), eventlet/gevent (IO-bound) [cadab39c9]; `worker_prefetch_multiplier` (default 4) trades latency vs throughput [c3cc70cd6][cab7b5230]; throughput is capacity-planning, not one headline number [c162af10e] | Broker (transport) + optional result backend + Flower for monitoring; Redis can be both broker and backend; backend not required unless results needed [c1d9724f7][cf04262ad][cd7ebc288] |
| **Temporal** | Durable execution = "crash-proof" workflows via event-history replay; **exactly-once workflow-execution semantics** (replay/dedup), but activities are at-least-once and need idempotency [c80bc2a20][c64285464][c30e424ce] | Vendor metric is "State Transitions per second" (jobs/sec called "not a very useful metric"); persistence DB is the bottleneck, scaled via shards (4 dev → 512 → ~4,096) [ccee53635]; single Postgres ~100 RPS before failures in one independent test [c3436cdfc] | Heaviest: a cluster of multiple server processes + a persistence DB + (typically) an Elasticsearch visibility store + a separate UI server [c57c8b28f][c8ebc897b]; lighter single-binary CLI dev server for non-prod [c4a87ede8] |
| **River** | Postgres-backed transactional enqueue: job inserted in the same DB transaction as business data (`InsertTx`), eliminating dual-write loss; "default model… for all but the very largest applications" [cc64e3fc3][c8a3755a2][cc6fc3ea0] | `InsertManyFast` wraps Postgres `COPY`; polling via `FetchCooldown`/`FetchPollInterval`; independent harnesses publish setup, not a headline River jobs/sec [cca599229][c72a3f924]. Postgres-queue-class ceilings (e.g. DBOS's own benchmark: 12.1K queued workflows/s on 96-vCPU hardware) illustrate the class, **not** River's measured throughput [ce4944f95] | Lightest: Postgres only — no separate broker/Redis; job + leader-election tables via `river migrate-up`; built-in Web UI [ca2ca0f56][cc6ce16fe][c685ed0ec] |

## reliability

The backing store sets the delivery-guarantee floor. Celery on a Redis broker depends on a
`visibility_timeout` (too short → duplicate execution, too long → delayed redelivery);
RabbitMQ avoids the tuning with durable queues + acks [ca14577a1]. The same Redis-vs-ack
contrast frames BullMQ against RabbitMQ's AMQP model [c9d6b59a6]. Sidekiq's default client
assumes the Redis push succeeds; Pro's "reliable push" adds only a bounded in-memory buffer
[c7b4003f6].

Temporal and River sit at the two structural ends. Temporal's durable execution makes
workflows "crash-proof" by replaying event history to rebuild state, giving exactly-once
*workflow-execution* semantics — but activities (the side-effecting steps) default to no
retry and are at-least-once, so idempotency is the caller's job; "exactly-once with external
side effects is a lie" is the cross-engine consensus [c80bc2a20][c30e424ce][c5e9d5baa].
River collapses the dual-write problem by enqueuing the job inside the same Postgres
transaction as the business write (`InsertTx`), so a committed signup and its follow-up job
are atomic [cc64e3fc3][cc6fc3ea0]. Across the broker world the default is at-least-once with
idempotent consumers; true exactly-once needs coordination with "real costs in latency,
throughput, and operational complexity" [c4cd6492f][cd3da7a01].

Full findings: `findings/d8564cbd0-reliability-delivery-guarantees.md`,
`findings/d2695a4d9-temporal-river-reliability.md`.

## throughput

No engine publishes a trustworthy unconditioned jobs/sec headline, and the finding refuses
to invent one. Sidekiq's throughput is a thread-per-process Redis story: concurrency is the
thread count (default 5), one process saturates roughly one core, and you scale horizontally
[c7d59cf55][cf1e5048d]. Celery exposes the knobs directly — pool type (prefork vs
eventlet/gevent) and `worker_prefetch_multiplier` — so throughput is a tuning/capacity
exercise, not a constant [cadab39c9][c3cc70cd6][c162af10e]. Temporal deliberately reports
"State Transitions per second" rather than jobs/sec, with the persistence database as the
scaling bottleneck addressed by shard count [ccee53635]; an independent test saw a single
Postgres back-end fail past ~120 RPS of spiked load [c3436cdfc]. River's throughput is
Postgres-queue-class — bulk `COPY` inserts and `SKIP LOCKED` fetch — and the only large
numbers in the corpus are DBOS's own product benchmark, explicitly fenced as illustrative of
the *class*, not a River measurement [cca599229][ce4944f95]. **BullMQ is abstained** — the
only throughput figures found were promotional and were excluded.

Full finding: `findings/d7c5d5a95-throughput.md`.

## operational complexity

Operational burden tracks the number of moving parts, and the five line up on a clear
gradient:

1. **River** — Postgres only, no separate broker; tables created by `river migrate-up`;
   built-in Web UI [ca2ca0f56][cc6ce16fe][c685ed0ec].
2. **Sidekiq / BullMQ** — one Redis store plus a dashboard; Sidekiq adds a web UI +
   `sidekiqmon`, BullMQ uses Bull Board [c8e155433][c33cbcb8c][ce7433bff].
3. **Celery** — broker + optional result backend + Flower; more parts to wire and monitor
   [c1d9724f7][cf04262ad][cd7ebc288].
4. **Temporal** — a cluster of multiple server processes, a persistence database, a
   visibility store (typically Elasticsearch), and a separate UI server — materially more to
   deploy, monitor, and upgrade [c57c8b28f][c8ebc897b][c266bb52e].

Full finding: `findings/dd3344178-operational-complexity.md`.

## Open gaps

- BullMQ throughput: no primary/independent source (the only benchmark found was
  promotional, excluded). Honest blank in the matrix.
- BullMQ quantitative reliability still rests on architectural facts only (its reliability
  benchmark source was promotional; see the reliability finding's scope note).
- Per-engine numeric throughput headlines are intentionally not asserted — the corpus does
  not contain trustworthy, conditioned jobs/sec figures for these engines, only architecture
  and class-level data points.
