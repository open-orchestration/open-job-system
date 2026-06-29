# Synthesis — Job & Queue System Selection (grounded)

What the **verified evidence** supports about choosing and operating job/queue systems.
Every claim here links to a *promoted* finding — one that passed citation, faithfulness,
and independent-reviewer gates. Claims the catalog gestures at but that no promoted
finding yet backs are quarantined under [Not yet grounded](#not-yet-grounded) rather
than stated as fact.

Grounding status: **29 promoted findings** across 20 topics. The seed comparison
(BullMQ, Sidekiq, Celery, Temporal, River × reliability, throughput, operational
complexity) is **fully scored** — all three dimensions are sourced for all five entities
in [`comparison-report.md`](docs/comparison-report.md). The survey then extends across
brokers, durable execution, workflow orchestration, the three clouds, compute substrate,
specs, observability, and patterns. Certainty is **moderate** except where a finding
notes otherwise (the BullMQ/Sidekiq/Celery reliability finding is **low**).

## What the evidence supports

### Reliability is a configuration exercise, not a default — and the backing store sets the floor
The backing store bounds delivery guarantees: Celery on a Redis broker needs
`visibility_timeout` tuning to avoid duplicate or lost tasks, whereas RabbitMQ supplies
durable queues and acknowledgements out of the box; the same Redis-vs-ack contrast frames
BullMQ against RabbitMQ. Sidekiq's default client does no push error-handling (Pro adds a
bounded "reliable push" buffer), and Celery offers exponential-backoff retries plus
soft/hard task timeouts — but across all three, out-of-the-box behavior is not
production-grade
([Reliability across BullMQ, Sidekiq, Celery](docs/findings/d8564cbd0-reliability-delivery-guarantees.md)).
What a broker must supply to make any of this safe is itself documented: RabbitMQ's
symmetric model — publisher confirms plus consumer acks, durable/quorum queues, and
dead-letter exchanges — yields at-least-once delivery, and *without* acks only at-most-once
([RabbitMQ delivery guarantees](docs/findings/d6a62b548-brokers-rabbitmq-delivery-guarantees.md)).

### Temporal and River are the structural ends of the reliability axis
Temporal's durable execution gives exactly-once *workflow-execution* semantics via
event-history replay, but activities are at-least-once and demand idempotency; River
collapses the dual-write problem by enqueuing inside the same Postgres transaction as the
business write
([Temporal/River reliability](docs/findings/d2695a4d9-temporal-river-reliability.md)).
Temporal's failure handling is concrete: a four-timeout activity taxonomy
(schedule-to-start, start-to-close, schedule-to-close, heartbeat), retry policies, and a
versioning tax that deterministic replay forces on long-running workflows — a cost queue
libraries never pay
([Temporal failure model](docs/findings/da1a9a445-durable-execution-temporal-failure-model.md)).
Durable execution as a model — persist each step, resume after crash — subsumes the
retry/timeout/state-recovery that queues bolt on
([Durable execution model](docs/findings/dd681af26-durable-execution-model.md)).

### Throughput is architecture, not a headline number
No engine publishes a trustworthy unconditioned jobs/sec figure; throughput is a
capacity-planning exercise driven by the concurrency model, prefetch/batch behavior, and
the backing store
([Throughput: Sidekiq/Celery/Temporal/River](docs/findings/d7c5d5a95-throughput.md)).
The one hard number — BullMQ at ~54K jobs/s `add` and ~30K/s processing on Node.js v24 —
is the maintainer's own synthetic, single-machine benchmark, reported as an
order-of-magnitude and not a neutral production ceiling
([BullMQ throughput](docs/findings/d71fe93d4-throughput-bullmq.md)).

### Operational complexity tracks the number of moving parts
A clear gradient: River (Postgres only) → Sidekiq/BullMQ (one Redis + a dashboard) →
Celery (broker + optional result backend + Flower) → Temporal (a cluster of server
processes + persistence DB + visibility store + UI server)
([Operational complexity](docs/findings/dd3344178-operational-complexity.md)).

### Workflow orchestration is a distinct category from job queues
Orchestrators schedule DAGs on interval-driven timetables rather than dispatching loose
jobs. Airflow's execution model — DAGs as the unit of scheduling, a scheduler that triggers
task instances through a pluggable executor, DAG runs carrying data intervals — is the
canonical example
([Airflow execution model](docs/findings/d478f3ee5-workflow-orchestration-airflow-execution-model.md)),
sitting alongside the broader authoring-model × unit-of-abstraction survey
([Workflow orchestration engines](docs/findings/d86b66b28-workflow-orchestration-engines.md)).

### The field rests on a small set of reusable primitives
Across brokers (queue vs log/stream), the three clouds' mirrored primitives, compute
substrates (K8s/HPC/language-native), vendor-neutral specs (CloudEvents/OpenAPI/Serverless
Workflow), and observability (OTel → Prometheus → Grafana), the tools are *instantiations*
of canonical patterns — Guaranteed Delivery, Competing Consumers, Transactional Outbox,
Saga, Write-Ahead Log, Raft — not inventions
([Canonical patterns](docs/findings/d5797c35a-canonical-patterns.md),
[Core patterns](docs/findings/da9c1d5da-core-patterns.md)). At-least-once is the default
delivery contract, so idempotent consumers are mandatory; exactly-once is a per-primitive
opt-in with real costs.

The full topic-by-topic index of all 29 promoted findings is the narrative
[`report.md`](docs/report.md) and the auto-generated
[findings index](docs/findings/SYNTHESIS.md).

## Not yet grounded

These remain open after the current runs:

- **BullMQ *neutral* throughput** — the only hard number is the maintainer's own synthetic
  benchmark; no independent third-party BullMQ jobs/sec measurement is in the corpus.
- **BullMQ quantitative reliability** (retry-recovery rate, Redis Cluster failover) — still
  architectural-only; the one benchmark found was promotional and was excluded by the gate.
- **Per-engine numeric throughput headlines** — intentionally not asserted; the corpus has
  architecture and class-level data points, not conditioned production jobs/sec figures.

## How this was produced

This synthesis is the published view of the Open Research System runs captured under
`.research/` (state, run log, corpus). Findings enter canon only after the three gates;
rejected drafts are retained under `docs/findings/_drafts/` for the audit trail.
