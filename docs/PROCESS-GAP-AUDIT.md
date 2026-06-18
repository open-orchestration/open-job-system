# Process Gap Audit — Backend Feasibility & Competitive Parity

**Date:** 2026-06-17
**Status:** Findings — validates process gaps G2 (port × backend feasibility), G3 (data-model across store classes), G6 (competitive parity).
**Method:** Multi-agent probe (5 parallel audits). The web-verification step stalled on tooling; findings below rest on training knowledge (cutoff Jan 2026). **Confidence:** High for well-known backend semantics; items needing live-doc confirmation are tagged `⟨verify⟩`.
**Legend:** ✅ clean map · ⚠️ maps with documented constraint · 🔧 requires emulation/build · ❌ infeasible / wrong model.

---

## Headline

The architecture's abstractions are **mostly sound but carry three paradigm biases** that break agnosticism for whole backend classes:

1. **`Queue` port is a work-queue model** — it does **not** fit log brokers (Kafka). Per-message lease/ack/nack/visibility has no clean Kafka mapping.
2. **`DurableEngine` port bakes in Temporal's replay paradigm** — §7.2's determinism invariant is false for journaling engines (Restate/DBOS) and meaningless for managed-state engines (Step Functions), yet those conform to the orchestration *contract*.
3. **`Store` + data model are relational-biased** — outbox atomicity and the FK data model don't map onto wide-column (Cassandra) without per-class denormalization; "single-document satisfies atomicity" survives Mongo but is conditional on Cassandra and durability-conditional on Redis.

Plus: most managed **schedulers are at-least-once** (ADR-006 "fire-once" is an adapter responsibility, not a backend guarantee), and the feature set misses **workflow versioning, global rate-limiting, unique-jobs, and schedule pause** — table-stakes in leading systems.

---

## G2a — `Queue` port × message brokers

| Contract element | SQS (std/FIFO) | Kafka | RabbitMQ | Redis Streams | Pub/Sub | Service Bus |
|---|---|---|---|---|---|---|
| enqueue delay (per-msg) | ✅ ≤15min cap | ❌ delay-topics | ⚠️ plugin/TTL+DLX | 🔧 zset+mover | ❌ (use Cloud Tasks) | ✅ ScheduledEnqueue |
| priority hint | ❌ | ❌ | ✅ priority queues | ❌ | ❌ | ⚠️ via sessions/queues |
| dedupKey | ⚠️ FIFO 5-min | ⚠️ producer-only | ❌ plugin | ⚠️ manual by id | ⚠️ exactly-once window | ✅ dup-detect window |
| lease / visibility | ✅ vis-timeout | ❌ offset model | ⚠️ unacked, no timer | ✅ PEL | ✅ ack deadline | ✅ peek-lock |
| heartbeat / extend | ✅ ChangeVisibility | ⚠️ liveness only | ⚠️ conn-level | ⚠️ idle/XCLAIM | ✅ modifyAckDeadline | ✅ RenewLock |
| ack (per-message) | ✅ Delete | ❌ positional commit | ✅ basic.ack | ✅ XACK | ✅ | ✅ Complete |
| nack (retryAfter) | ⚠️ set vis=0 | ❌ seek only | ✅ nack/reject | ⚠️ leave→XCLAIM | ✅ | ✅ Abandon |
| deadLetter | ✅ native redrive | 🔧 build | ✅ DLX | 🔧 build | ✅ DL topic | ✅ DLQ subqueue |
| depth{ready,inflight,delayed,dead} | ⚠️ approx, split | ⚠️ lag only | ⚠️ ready/unacked | ⚠️ XLEN/XPENDING | ⚠️ metric only | ✅ active/sched/DL |
| single-active-lease | ✅ | ⚠️ per-partition | ✅ | ✅ PEL | ✅ | ✅ |
| at-least-once | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

**Leaks & tensions**
- **Kafka is the wrong shape.** Offset-commit ≠ per-message ack; you cannot ack msg 5 while msg 3 is in flight. No per-message lease, no native DLQ, no per-message delay. The `Queue` port is a *work-queue* abstraction; Kafka is a *log*. Forcing it requires a side-store of per-message state (KMQ-style) — heavy emulation that defeats "adapter is a config choice."
- **`priority` hint** is unsupported by 4 of 6 — already deferred (§1 YAGNI), but the port shouldn't imply portability it lacks.
- **Time-based visibility timeout is an SQS-shaped assumption.** RabbitMQ redelivers on consumer/channel death, not on a timer; Redis on idle-claim. Same outcome, different trigger — the contract should specify the *guarantee* (redelivery after worker loss) not the *mechanism* (timeout).
- **`depth()` full breakdown is rarely native** — mostly approximate or partial.

**Recommended actions**
- **New ADR** — "`Queue` port targets work-queue brokers; log-oriented brokers (Kafka) are a distinct adapter class requiring per-message-state emulation, or out of scope." Narrow the portability claim.
- **Document constraint** — `enqueue.delay` cap and availability vary; `priority` is best-effort/optional; `depth()` fields are best-effort estimates.
- **Reword §4.1** — specify redelivery *guarantee* (after lease loss / worker death), not "visibility timeout" mechanism.
- **Contract-test** — redelivery-after-worker-death (mechanism-agnostic), per-message-ack isolation (will fail Kafka → proves the boundary).

**Verdict:** Agnostic-with-documented-constraints across true queue brokers (Service Bus is the cleanest fit; SQS/Rabbit/Redis/PubSub ⚠️). **Broken for log brokers** — needs an explicit class boundary.

---

## G2b — `DurableEngine` port × execution engines

| Contract element | Temporal/Cadence | Step Functions | Azure Durable Fns | Restate / DBOS | Emulate on queue+store |
|---|---|---|---|---|---|
| startWorkflow + idempotencyKey | ✅ | ✅ name-idempotent | ✅ | ✅ idempotency native | 🔧 |
| executeActivity (retry/timeout) | ✅ | ✅ Task states | ✅ | ✅ durable steps | 🔧 |
| startTimer | ✅ | ✅ Wait | ✅ | ✅ | 🔧 |
| awaitSignal | ✅ | ⚠️ task-token callback | ✅ external events | ✅ awakeables | 🔧 |
| query (side-effect-free) | ✅ | ⚠️ Describe only | ✅ status | ⚠️ | ❌ |
| startChild | ✅ | ✅ nested SM | ✅ sub-orch | ✅ | 🔧 |
| cancel → children+activities | ✅ | ⚠️ Stop, manual prop | ✅ | ✅ | 🔧 |
| **determinism/replay invariant (§7.2)** | ✅ required | ❌ N/A (no user replay) | ✅ required | ❌ **not required (journaling)** | n/a |
| Continue-As-New (§14.4) | ✅ native term | ⚠️ restart pattern | ✅ native term | ❌ not a concept | n/a |

**Leaks & tensions**
- **The port is modeled on Temporal.** §7.2 ("workflow code must be deterministic — no wall-clock/random/IO in the body") is a *replay-engine* requirement. It is **false for Restate/DBOS** (they journal results, so non-deterministic code is fine) and **meaningless for Step Functions** (no user code body is replayed). Stating it as a *port invariant* mislabels an adapter-specific constraint as universal.
- **Continue-As-New is Temporal/Azure vocabulary** leaking into the neutral spec (§14.4). Restate/DBOS bound history differently; Step Functions restarts.
- **PROVIDER-REFERENCE never mentions Restate/DBOS** (confirmed by probe) — the entire journaling-engine class is unrepresented, so the abstraction was never tested against it.
- **"Emulate on bare queue+store"** is honest only for *single-step* (ADR-001 lower tier). Emulating multi-step durable orchestration = building a durable engine — should be declared **out of scope**; the upper tier is *optional and absent*, not emulated.

**Recommended actions**
- **New ADR** — "Durable-execution *model* is adapter-specific: replay (Temporal/Cadence/Azure Durable Fns), journaling (Restate/DBOS), or managed-state (Step Functions). The port specifies *capability*, not *mechanism*."
- **Reclassify §7.2 determinism** as an adapter-specific constraint (a property of replay adapters), not a port invariant.
- **Generalize §14.4** "Continue-As-New" → "history/journal bounding (engine-specific mechanism)."
- **Add Restate/DBOS** to PROVIDER-REFERENCE; re-validate the port against the journaling model.
- **State explicitly** the upper tier is optional; bare backends offer lower-tier jobs only.
- **Contract-test** — orchestration capability (start/activity/timer/signal/child/cancel/idempotent-start) *without* asserting replay-determinism, so a journaling engine can pass.

**Verdict:** Capability contract is sound; **mechanism assumptions (determinism, Continue-As-New) are Temporal-biased** and must be reclassified for genuine engine-agnosticism.

---

## G3 — `Store` + data model × store classes

| Element | PostgreSQL (relational) | MongoDB (document) | Cassandra (wide-column) | Redis / Dynamo (KV) |
|---|---|---|---|---|
| optimistic concurrency (expectedVersion) | ✅ row version | ✅ version-filter update | ⚠️ LWT, per-partition, costly | ⚠️ WATCH/MULTI · ✅ Dynamo cond-write |
| recordIdempotent (atomic 1st-writer) | ✅ unique index | ✅ unique idx/upsert | ⚠️ LWT IF NOT EXISTS | ✅ SET NX · ✅ Dynamo cond-put |
| outbox atomicity (same tx as state) | ✅ tx | ✅ single-doc / multi-doc tx | ❌/🔧 same-partition only | ⚠️ MULTI not durable-by-default · ⚠️ Dynamo TransactWrite (limits) |
| readOutbox / relay | ✅ | ✅ change streams/poll | ⚠️ scan/query-table | 🔧 list/stream |
| skip-locked claiming (§3.2) | ✅ SKIP LOCKED | 🔧 findAndModify flag | ❌ no lock model | 🔧 zset claim/Redlock |
| relational data model (Job/Attempt/Batch/Item/Chunk + FK) | ✅ joins | ⚠️ embed/denormalize | ❌ denormalize per query | ❌ manual index |
| secondary-index query (by state/tenant) | ✅ | ✅ | ❌ anti-pattern; query tables | 🔧 maintain indexes |

**Leaks & tensions**
- **"Single-document or conditional write satisfies outbox atomicity" (§4.2) is conditional.** It holds on Mongo. On **Cassandra** only if state+outbox share a partition (BATCH is atomic only within a partition, not isolated) — forces data-model contortion. On **Redis** MULTI/EXEC is atomic but **not durable by default** — atomicity ≠ durability for an outbox.
- **The data model is relational.** Job/Attempt/Batch/Item/Chunk/Checkpoint with FKs needs joins; wide-column/KV require a **denormalized, query-first model per access pattern** that DATA-STRATEGY treats as one undifferentiated "NoSQL" bucket (G3 confirmed).
- **Secondary-index querying** (list jobs by state/tenant — needed for the §11.4 operator UI) is a Cassandra/Dynamo anti-pattern; needs materialized query tables or GSIs, designed up front.
- **Redis as system-of-record is questionable** — excellent for queue/lease/idempotency-cache, weak for durable Store.

**Recommended actions**
- **New ADR** — "Declare valid store classes for *system-of-record*: relational ✅ and document ✅ first-class; wide-column ✅ *with* mandated denormalized query-tables; KV ⚠️ auxiliary (lease/idempotency/cache), not durable Store-of-record unless durably configured."
- **Per-class data models** — DATA-STRATEGY must give a denormalized schema + access-pattern table per class, not SQL+NoSQL.
- **Document outbox-atomicity strategy per class** — co-partition (Cassandra), durability-config requirement (Redis), TransactWriteItems limits (Dynamo).
- **Conformance-test** — outbox atomic-publish under crash, per store class (will expose the Redis-durability and Cassandra-partition constraints).

**Verdict:** Genuinely DB-agnostic for relational + document; **relational-biased** for wide-column and KV — needs per-class models and an explicit system-of-record class list.

---

## G2c — `Scheduler`/`Clock` × schedulers

| Element | K8s CronJob | EventBridge Sched | Cloud Scheduler | Temporal Schedules | DB-backed poll | Quartz (clustered) |
|---|---|---|---|---|---|---|
| fire-once cluster-wide (ADR-006) | ⚠️ best-effort, can dup | ⚠️ at-least-once | ⚠️ at-least-once | ✅ server-guaranteed | 🔧 row-claim/leader | ✅ DB-lock |
| missed-tick detectable | ⚠️ skips >100, logs | ⚠️ | ⚠️ | ✅ catchup policy | 🔧 build | ⚠️ misfire policy |
| canonical cron grammar + tz | ⚠️ dialect | ⚠️ | ⚠️ | ✅ | 🔧 | ⚠️ Quartz dialect |
| schedule/cancel | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

**Leaks & tensions** — **Most managed schedulers are at-least-once.** EventBridge and Cloud Scheduler explicitly "may run more than once" `⟨verify exact wording⟩`; K8s CronJob is best-effort (skips on >100 missed starts; `concurrencyPolicy=Forbid` prevents overlap, not duplicates). So **ADR-006's "fires exactly once cluster-wide" is an adapter responsibility** — the adapter layers occurrence-dedupe (an idempotency key per occurrence, ADR-004) over an at-least-once scheduler. Only Temporal/Quartz provide it natively. Also no native **schedule pause/resume**, and the "one canonical cron grammar" glosses over dialect/tz differences.

**Recommended actions** — **New ADR / amend ADR-006**: "fire-once is achieved by occurrence-level dedupe in the adapter (reusing ADR-004), since most schedulers guarantee only at-least-once." Add `pauseSchedule`/`resumeSchedule` to §4.3. Document cron-dialect translation as an adapter duty. Contract-test: duplicate-occurrence suppression.

**Verdict:** Agnostic-with-constraints — fire-once is a layered guarantee, not a backend one. Make that explicit.

---

## G2d — `EventSink` × observability backends

| Element | OpenTelemetry | Prometheus | Logging | Cloud-native |
|---|---|---|---|---|
| emitLifecycle | ✅ | ⚠️ | ✅ | ✅ |
| startSpan/endSpan | ✅ | ❌ (not tracing) | ⚠️ | ✅ |
| recordMetric (push) | ✅ | ⚠️ **pull model** | ✅ | ✅ push |
| non-blocking invariant | ✅ BatchProcessor | ⚠️ | ✅ | ✅ |
| trace continuity across hops | ✅ (envelope carries traceparent) | n/a | ⚠️ | ✅ |

**Leaks & tensions** — Prometheus is **pull-based**; the `recordMetric` push contract needs a Pushgateway (last-write-wins gauge semantics break counters) or a local exporter Prometheus scrapes. Non-blocking holds only with async/batch exporters (SimpleSpanProcessor blocks). Trace continuity is well-designed (envelope already carries W3C `traceparent`) but brokers may strip headers.

**Recommended actions** — Document the **push-vs-pull metrics bridge** as an adapter concern; require async/batch export for the non-blocking invariant. Contract-test: emission-failure does not fail job execution.

**Verdict:** Agnostic; pull-based metrics (Prometheus) is the one bridge to document.

---

## G6 — Competitive parity

Coverage vs Temporal/Cadence, Step Functions, Airflow, Dagster, River, Faktory, Celery, Sidekiq(+Pro/Ent), Hatchet/Inngest/Trigger.dev.

| Capability | Coverage | Table-stakes in | Note |
|---|---|---|---|
| Lifecycle states / retries+backoff+jitter / DLQ+redrive | ✅ | all | strong |
| Idempotency / effectively-once | ✅ | Temporal, Inngest, River | strong |
| Saga / compensation / signals / child wf / cancel / 3-scope timeouts | ✅ | Temporal, Step Fns | strong |
| Scheduled/cron / delayed | ✅ | all | strong (but fire-once caveat above) |
| Fan-out / map / batch | ✅ | Step Fns map, Sidekiq batches | §14.3 |
| Heartbeat / long-running / claim-check payloads | ✅ | Temporal, SQS | strong |
| Multi-tenancy / tracing / visibility query | ✅ | Temporal, Inngest | strong |
| **Workflow / code versioning & migration** | ❌ §15 hook only | Temporal, Step Fns (versions/aliases) | **must-have** for long-running |
| **Global rate-limiting / concurrency limits** | ⚠️ §6.7 named, no mechanism | Inngest, Sidekiq Ent, River, Hatchet | should-have |
| **Unique jobs / active-work dedup** | ⚠️ ≠ idempotency | Sidekiq, River, Faktory | should-have (prevents *enqueue*, not just effect) |
| **Schedule pause / resume** | ❌ | Temporal Schedules | should-have |
| **Human-in-the-loop / approval (task token)** | ⚠️ via awaitSignal, not called out | Step Fns, Temporal | should-have callout |
| **Batch completion callbacks** | ⚠️ counters, no callback | Sidekiq Pro batches | should-have |
| Replay / time-travel debugging UI | ⚠️ §11.4 DAG view, not replay | Temporal Web, Dagster | should-have |
| Sensors / event triggers / backfills | ⚠️ partial | Airflow, Dagster | likely non-goal (not a data-pipeline engine, §1) |

**Missing for world-class (ranked)**
1. **Workflow versioning & migration** — must-have; currently only a §15 hook. Long-running workflows break without it.
2. **Global / distributed rate-limiting & concurrency caps** — should-have; §6.7 names but doesn't specify a port/mechanism.
3. **Unique jobs** (dedup at enqueue, distinct from idempotency-at-effect) — should-have.
4. **Schedule pause/resume** — should-have; add to `Scheduler` (§4.3).
5. **Batch completion callbacks / fan-in hooks** — should-have.
6. **Human-in-the-loop / external-task-token** — should-have explicit callout (achievable via `awaitSignal`).
7. **Replay/time-travel debugging** — should-have for the operator UI.
8. **Sensors/backfills** — explicit-non-goal candidate (keeps scope vs Airflow/Dagster).

**Recommended actions** — add 1–6 to a **REQUIREMENTS/NFR baseline** (gap G4) and write ADRs for the ones that touch a port (rate-limit mechanism, unique-jobs, schedule pause). Declare 8 an explicit non-goal.

**Verdict:** **Strong core** (matches Temporal-class on durability/saga/idempotency/observability); **material operational gaps** in versioning, rate-limiting, unique-jobs, schedule pause — all table-stakes in leading systems.

---

## Consolidated action list (feeds the decision log)

| # | Action | Type | Addresses |
|---|---|---|---|
| 1 | `Queue` port targets work-queue brokers; log brokers a separate class | new ADR | G2a |
| 2 | Durable-execution model is adapter-specific; reclassify §7.2 determinism | new ADR + edit | G2b |
| 3 | Generalize Continue-As-New → engine-specific history bounding | edit §14.4 | G2b |
| 4 | Add Restate/DBOS (journaling engines) to PROVIDER-REFERENCE | edit | G2b |
| 5 | Declare system-of-record store classes; per-class denormalized models | new ADR + DATA-STRATEGY | G3 |
| 6 | Outbox atomicity strategy documented per store class | edit §4.2 | G3 |
| 7 | Fire-once = adapter-layered occurrence-dedupe over at-least-once schedulers | amend ADR-006 | G2c |
| 8 | Add `pauseSchedule`/`resumeSchedule` to `Scheduler` | edit §4.3 | G2c, G6 |
| 9 | Document push-vs-pull metrics bridge; require async export | edit §4.5/§11 | G2d |
| 10 | Add workflow versioning to scope/requirements | new ADR | G6 |
| 11 | Specify global rate-limiting / concurrency-limit mechanism | new ADR | G6 |
| 12 | Add unique-jobs (enqueue-dedup) capability | new ADR | G6 |
| 13 | Reword contracts to specify guarantees, not mechanisms (redelivery, not "visibility timeout") | edit §4.1 | G2a |
| 14 | Author the per-port conformance test suite (TCK) — the through-line of every "contract-test" above | process (G1) | G1/G2 |

**Confidence note:** backend semantics above are from training knowledge (Jan 2026). Items tagged `⟨verify⟩` and any version-specific guarantee should be confirmed against current vendor docs before an ADR cites them as fact.
