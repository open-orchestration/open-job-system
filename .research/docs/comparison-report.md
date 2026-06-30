# Compare BullMQ, Sidekiq, Celery, Temporal, and River on reliability, throughput, and operational complexity

> Regenerated after the corpus grew to 61 promoted findings. All three planned dimensions are
> sourced for all five entities; each cell cites the corpus id(s) that bear it out. The Temporal
> cells are now enriched with the architecture, programming-model, and production-hardening
> findings added since the first scoring pass; the Celery operational cell folds in the
> monitoring/management finding. The BullMQ throughput cell remains the maintainer's own
> synthetic benchmark — a vendor measurement, attributed as such and not laundered into a
> neutral production ceiling — and Bull facts are kept distinct from BullMQ facts.
>
> Backing findings (all promoted, certainty: high unless noted):
> - reliability, BullMQ/Sidekiq/Celery — `findings/d8564cbd0-reliability-delivery-guarantees.md` (certainty: low)
> - reliability, Temporal/River + delivery-guarantee divide — `findings/d2695a4d9-temporal-river-reliability.md`
> - Temporal failure model — `findings/da1a9a445-durable-execution-temporal-failure-model.md`
> - Temporal architecture — `findings/d5c5a0bde-temporal-architecture.md`
> - Temporal programming model — `findings/d8e9f8182-temporal-programming-model.md`
> - Temporal production hardening — `findings/d7114325c-temporal-production-hardening.md`
> - throughput, Sidekiq/Celery/Temporal/River — `findings/d7c5d5a95-throughput.md`
> - throughput, BullMQ — `findings/d71fe93d4-throughput-bullmq.md` (maintainer benchmark, scope-bounded)
> - operational complexity — `findings/dd3344178-operational-complexity.md`
> - Celery monitoring & management — `findings/d93d3272e-celery-monitoring.md`
> - Bull (BullMQ's predecessor) — `findings/d98b5abab-bull-arq.md`

## Matrix — entities × dimensions

| Entity | reliability | throughput | operational complexity |
| --- | --- | --- | --- |
| **BullMQ** | Redis-backed Node.js successor to Bull; reliability rests on Redis persistence semantics vs RabbitMQ's AMQP acks/durable queues [c9d6b59a6]. Its predecessor Bull re-attempts unfinished jobs only when the same queue is re-instantiated and leaves `jobId` uniqueness to the caller [ce5f329e8] — predecessor behavior, not asserted as BullMQ's | Maintainer benchmark (BullMQ author, synthetic, local Redis-on-Docker, M2 Pro, best-of-5): on Node.js v24 ~54,113 jobs/s individual `add` and ~30,102 jobs/s processing (concurrency 100) at 50K-job scale; `add` drops to ~36,765/s at 100K (attributed to V8 GC) while processing holds. Vendor/synthetic — order-of-magnitude, not a neutral production ceiling [c6dd75a7d] | Redis as the in-memory job-state store; durability via Redis AOF (`appendonly`/`appendfsync everysec`); monitored with Bull Board [ce7433bff]. One Redis store + a dashboard |
| **Sidekiq** | Default client does no push error-handling; Pro "reliable push" buffers locally but bounded (per-process, in-memory, last 1,000, lost on restart) [c7b4003f6] | Thread-per-process Redis model; concurrency = threads/process (default 5); maintainer claims "thousands of jobs per second… millions per day" (qualitative); scale by adding processes/servers [c7d59cf55][cf1e5048d] | Redis (7.0+/Valkey/Dragonfly) via `REDIS_URL`; 1+ processes per app server all sharing one Redis; built-in web UI + `sidekiqmon` [c8e155433][c33cbcb8c][c983a4b42] |
| **Celery** | Auto-retry w/ `autoretry_for` + `retry_backoff`, capped attempts [c9397f0cc]; Redis broker needs `visibility_timeout` tuning to avoid duplicate/lost tasks [ca14577a1]; soft/hard timeouts [c9397f0cc] | Pluggable pools: prefork (CPU-bound), eventlet/gevent (IO-bound) [cadab39c9]; `worker_prefetch_multiplier` (default 4) trades latency vs throughput [c3cc70cd6][cab7b5230]; throughput is capacity-planning, not one headline number [c162af10e] | Broker (transport) + optional result backend + Flower for monitoring; Redis can be both broker and backend; backend not required unless results needed [c1d9724f7][cf04262ad][cd7ebc288]. Flower is the recommended real-time web monitor (remote control, HTTP API, OpenID), with `inspect`/`control` CLI and broker/backend introspection as the rest of the management surface [c5276a516] |
| **Temporal** | Durable execution = "crash-proof" workflows via event-history replay; **exactly-once workflow-execution semantics** (replay/dedup), but activities are at-least-once and need idempotency [c80bc2a20][c64285464][c30e424ce]. Failure handling is concrete: four-timeout activity taxonomy + retry policies + replay-forced versioning [c1bd468eb]. Message passing distinguishes Signals (async write), Queries (read-only, no Event-History entry) and Updates (sync, writes history) for safe interaction with running workflows [c3c7c6653]; mTLS (internode + frontend) secures the wire in production [caa7de4d5] | Vendor metric is "State Transitions per second" (jobs/sec called "not a very useful metric"); persistence DB is the bottleneck, scaled via shards (4 dev → 512 → ~4,096) [ccee53635]; single Postgres ~100 RPS before failures in one independent test [c3436cdfc] | Heaviest: a Temporal Service = Temporal Server + a Persistence store + a Visibility store [ca75d348d], plus Workers running your code and a separate UI server [c57c8b28f][c8ebc897b]; lighter single-binary CLI dev server for non-prod [c4a87ede8]. Production adds mTLS config, an authorizer/claim-mapper, and (for encrypted payloads) a Codec Server to deploy and operate [caa7de4d5][c89d6b902]; Workers are written via language SDKs (Go/Java/Python/TS/.NET/Ruby/PHP) [cdd95b319] |
| **River** | Postgres-backed transactional enqueue: job inserted in the same DB transaction as business data (`InsertTx`), eliminating dual-write loss; "default model… for all but the very largest applications" [cc64e3fc3][c8a3755a2][cc6fc3ea0] | `InsertManyFast` wraps Postgres `COPY`; polling via `FetchCooldown`/`FetchPollInterval`; independent harnesses publish setup, not a headline River jobs/sec [cca599229][c72a3f924]. Postgres-queue-class ceilings (e.g. DBOS's own benchmark: 12.1K queued workflows/s on 96-vCPU hardware) illustrate the class, **not** River's measured throughput [ce4944f95] | Lightest: Postgres only — no separate broker/Redis; job + leader-election tables via `river migrate-up`; built-in Web UI [ca2ca0f56][cc6ce16fe][c685ed0ec] |

## reliability

The backing store sets the delivery-guarantee floor. Celery on a Redis broker depends on a
`visibility_timeout` (too short → duplicate execution, too long → delayed redelivery);
RabbitMQ avoids the tuning with durable queues + acks [ca14577a1]. The same Redis-vs-ack
contrast frames BullMQ against RabbitMQ's AMQP model [c9d6b59a6]. BullMQ's predecessor Bull
re-attempts unfinished jobs only when the same queue is re-instantiated and leaves `jobId`
uniqueness to the caller [ce5f329e8] — a useful read on the lineage's posture, kept distinct
from BullMQ's own guarantees. Sidekiq's default client assumes the Redis push succeeds; Pro's
"reliable push" adds only a bounded in-memory buffer [c7b4003f6].

Temporal and River sit at the two structural ends. Temporal's durable execution makes
workflows "crash-proof" by replaying event history to rebuild state, giving exactly-once
*workflow-execution* semantics — but activities (the side-effecting steps) default to no
retry and are at-least-once, so idempotency is the caller's job; "exactly-once with external
side effects is a lie" is the cross-engine consensus [c80bc2a20][c30e424ce][c5e9d5baa]. The
reliability is mechanical, not magical: a four-timeout activity taxonomy
(schedule-to-start, start-to-close, schedule-to-close, heartbeat), retry policies, and a
deterministic-replay constraint that forces explicit workflow versioning are the price of the
guarantee [c1bd468eb]. The same determinism shapes how running workflows accept input —
Queries are read-only and add no Event-History entry, Signals are fire-and-forget async
writes, and Updates are synchronous writes that *do* record history — so operators reason
precisely about what a message does to durable state [c3c7c6653]. River collapses the
dual-write problem by enqueuing the job inside the same Postgres transaction as the business
write (`InsertTx`), so a committed signup and its follow-up job are atomic [cc64e3fc3][cc6fc3ea0].
Across the broker world the default is at-least-once with idempotent consumers; true
exactly-once needs coordination with "real costs in latency, throughput, and operational
complexity" [c4cd6492f][cd3da7a01].

Full findings: `findings/d8564cbd0-reliability-delivery-guarantees.md`,
`findings/d2695a4d9-temporal-river-reliability.md`,
`findings/da1a9a445-durable-execution-temporal-failure-model.md`,
`findings/d8e9f8182-temporal-programming-model.md`.

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
the *class*, not a River measurement [cca599229][ce4944f95]. **BullMQ** is the one engine with
a hard jobs/sec source, but it is the maintainer's own synthetic benchmark: on Node.js v24,
best-of-5 on a local Redis-on-Docker setup, ~54K jobs/s for individual `add` and ~30K jobs/s
for processing at 50K jobs, with `add` falling to ~37K/s at 100K (V8 garbage collection) while
processing stays I/O-bound on Redis round-trips [c6dd75a7d]. It is reported as a vendor,
single-machine order-of-magnitude — useful for sizing, not a guaranteed production ceiling.

Full findings: `findings/d7c5d5a95-throughput.md`, `findings/d71fe93d4-throughput-bullmq.md`.

## operational complexity

Operational burden tracks the number of moving parts, and the five line up on a clear
gradient:

1. **River** — Postgres only, no separate broker; tables created by `river migrate-up`;
   built-in Web UI [ca2ca0f56][cc6ce16fe][c685ed0ec].
2. **Sidekiq / BullMQ** — one Redis store plus a dashboard; Sidekiq adds a web UI +
   `sidekiqmon`, BullMQ uses Bull Board [c8e155433][c33cbcb8c][ce7433bff].
3. **Celery** — broker + optional result backend + Flower; more parts to wire and monitor.
   Flower is the recommended real-time web monitor (remote control, HTTP API, OpenID auth),
   with `inspect`/`control` CLI and broker/backend introspection rounding out the management
   surface [c1d9724f7][cf04262ad][cd7ebc288][c5276a516].
4. **Temporal** — the heaviest: a Temporal Service (Temporal Server + persistence store +
   visibility store, typically Elasticsearch) [ca75d348d], a fleet of Workers running your
   code through language SDKs [cdd95b319], and a separate UI server [c57c8b28f][c8ebc897b].
   Production hardening adds still more surface to deploy and operate: mTLS configuration with
   separate internode/frontend certs, an authorizer/claim-mapper for AuthZ, and a Codec Server
   when payloads are encrypted at rest [caa7de4d5][c89d6b902]. Materially more to deploy,
   monitor, and upgrade [c266bb52e].

Full findings: `findings/dd3344178-operational-complexity.md`,
`findings/d5c5a0bde-temporal-architecture.md`,
`findings/d7114325c-temporal-production-hardening.md`,
`findings/d93d3272e-celery-monitoring.md`.

## Open gaps

- BullMQ throughput: filled, but the only hard source is the maintainer's own synthetic
  benchmark (vendor, single local machine, Redis on Docker). No neutral third-party BullMQ
  throughput measurement is in the corpus; the figures are an order-of-magnitude, not a
  production guarantee.
- BullMQ quantitative reliability still rests on architectural facts only (its reliability
  benchmark source was promotional; see the reliability finding's scope note). The Bull
  finding describes the predecessor library's behavior, not BullMQ's measured guarantees.
- Per-engine numeric throughput headlines are intentionally not asserted — the corpus does
  not contain trustworthy, conditioned jobs/sec figures for these engines, only architecture
  and class-level data points.
- River reliability/operational facts beyond the transactional-enqueue model and the
  Postgres-only deployment remain thin; no River production hardening or failure-mode finding
  exists in the corpus to parallel Temporal's.
