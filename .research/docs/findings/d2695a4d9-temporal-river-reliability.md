---
id: d2695a4d9
topic: reliability
title: 'Reliability and delivery guarantees: Temporal, River, and the delivery-guarantee divide'
status: draft
shape: comparison
---

**Scope.** This finding covers the reliability story of two engines that abstained from the
prior reliability finding — **Temporal** (durable execution) and **River** (Postgres-backed
transactional enqueue) — plus the cross-engine **at-least-once vs exactly-once** delivery-guarantee
divide that frames how every job/message system reasons about failure. It complements, and does not
restate, the existing BullMQ/Sidekiq/Celery reliability finding; those three engines are out of
scope here. Two deliberate limits: (1) the delivery-guarantee section draws heavily on **Kafka/stream-processing**
sources (Confluent, Streamkap, et al.), because that is where the vocabulary is defined most precisely —
the *concepts* transfer to job queues but the Kafka-specific config knobs do not; (2) several Temporal
sources are personal engineering blogs rather than temporal.io docs, and are attributed as such below.
Gap: none of the supplied sources give Temporal's or River's own formal SLA/durability numbers, so this
finding does not quote uptime or durability figures.

## Temporal: durable execution and "exactly-once workflow semantics"

Temporal's reliability pitch is **durable execution**, which temporal.io defines bluntly as
"_crash-proof execution_" — code written so that the developer can "imagine how much simpler your
application would be if it just couldn't fail" [c80bc2a20]. The promise is that the framework guarantees
your code "would run to completion, automatically resume after crashes, and retry failures — all while
maintaining exactly-once semantics" [c64285464].

The mechanism behind that promise is **deterministic replay over an event history** (event sourcing).
Temporal records an event history per workflow — a log of events such as `ActivityTaskScheduled`,
`ActivityTaskCompleted`, `ActivityTaskTimeOut`, `ActivityTaskScheduled → retry` — and when a worker
resumes a workflow it "replays the history to rebuild the in-memory state," so the function "picks up
after the last completed step" [c30e424ce]. A personal engineering blog describes the same design as
"deterministic replay with event sourcing": on restart "the workflow replays the event log to
reconstruct state" [c4397ad66].

This is why the central constraint is **determinism**: "workflow code must be deterministic" — no
`datetime.now()`, no `random.random()`, no I/O — instead using Temporal-provided primitives
(`workflow.now()`, `workflow.uuid4()`, `workflow.execute_activity()`) that "produce the same result on
replay" [c30e424ce]. The replay "must produce the same sequence of activities as the original
execution," so random numbers, timestamps, and external state "must be obtained through the framework,
not from system calls" [c4397ad66].

**Be precise about what "exactly-once" means here.** The "exactly-once semantics" Temporal advertises is
*exactly-once execution of the workflow function* via the replay/history mechanism — not exactly-once
external side effects. I/O lives in **activities**, which temporal.io describes as "functions that retry
automatically and recover seamlessly" [cfca4102b] — i.e. an at-least-once execution model for the side
effect itself. In Temporal's own default, an activity call has "default = no retry" until a retry policy
is set [c30e424ce], and the durable-execution literature is explicit that this does not abolish the
need for idempotency: the same author who explains Temporal's replay also frames end-to-end
exactly-once as an "Exactly-Once Illusion" that idempotency keys and the outbox pattern exist to manage,
noting "Temporal automates 80% of the boilerplate" rather than eliminating the problem [c30e424ce]. A
second blog lists when durable execution is *overkill* — "jobs complete in seconds and occasional
duplicates are acceptable" or "idempotency is naturally handled by your domain" — and reserves it for
when "partial failure is catastrophic" or you need "precise exactly-once semantics across unreliable
external services" [c64285464]. Net: Temporal moves the exactly-once boundary to the workflow level and
automates the retry/replay scaffolding, but activities remain retried (at-least-once) and idempotent
activity design is still the user's responsibility.

*Provenance note:* the durable-execution *definition* and the *activity-retry* claims rest on official
temporal.io pages [c80bc2a20, cfca4102b] (the homepage [cfca4102b] is marketing copy, used only for the
uncontroversial product claim that activities retry automatically); the *replay/event-history/determinism*
mechanics rest on two independent personal engineering blogs [c30e424ce, c4397ad66] that corroborate each
other.

## River: transactional enqueue as the reliability primitive

River's reliability story is narrower and concrete: the job is **enqueued in the same Postgres
transaction as the business data it depends on**. The River docs motivate this with the classic
dual-write failure: a signup flow inserts the user row in a Postgres transaction that commits, then
"attempts to enqueue a job in Redis to send a welcome email" — and "_the server just lost power_," so
"that user will never receive a signup confirmation email" [cc64e3fc3]. Enqueuing *before* the Postgres
commit has the symmetric flaw (the job can run against data that never commits) [cc64e3fc3].

**Transactional enqueueing** removes the second system entirely: "when you enqueue a job in River, you
can do so in a transaction with any other changes you're making such as inserting a user record," which
means "when a worker picks up a job, it can rely on the fact that any data it depends on was already
committed along with the job itself" — and it does so "without needing to operate an additional service
outside the primary Postgres database" [cc64e3fc3]. River's docs call this "the default model for
building reliable systems, appropriate for all but the very largest applications" [cc64e3fc3]. In the
API this is the `InsertTx` method, which a tutorial notes "is preferred because it ensures jobs are
enqueued within a transaction, reducing the risk of partial writes" [c8a3755a2].

The design rationale, from River's creator, is that "transactions are really _just a really good idea_…
maybe _the best_ idea in robust service design," a service "modeled entirely around transactions and
strong data constraints" where "data inconsistencies… functionally don't exist" [cc6fc3ea0]. The
Postgres enabler is `SKIP LOCKED` (Postgres 9.5), "which lets transactions find rows to lock with less
effort by skipping rows that are already locked" — the feature "most important for a queue" [cc6fc3ea0].

*Provenance note:* the transactional-enqueue model and the dual-write failure example are from the
official riverqueue.com docs [cc64e3fc3]; `InsertTx` semantics are corroborated by a dev.to tutorial
[c8a3755a2]; the robustness rationale and `SKIP LOCKED` detail are from brandur.org [cc6fc3ea0], a
personal blog that is authoritative here because its author is River's creator. River's transactional
enqueue is effectively the **transactional-outbox guarantee built into the queue** — the job and the
data commit atomically, so a committed job never references uncommitted data and a committed write never
loses its job.

## The delivery-guarantee divide: at-least-once vs exactly-once

Underneath both engines is the same taxonomy the streaming world has standardized. The three semantics
trade off data loss, duplication, and complexity [c4cd6492f]:

- **At-most-once** ("fire and forget"): "every message is delivered zero or one time. No duplicates,
  but drops are possible under failure" [ca2130003]. It is "the fastest option because it requires zero
  coordination," but "accepts data loss as a normal failure mode" [c4cd6492f]. Confluent: implement it
  "by disabling retries on the producer and committing offsets in the consumer before processing"
  [cd3da7a01].
- **At-least-once**: the system processes the event, then commits the offset; if it crashes after
  processing but before committing, "the event will be replayed on recovery. The data is never lost,
  but it may be processed more than once" [c4cd6492f]. Put plainly: "No data loss but Duplicates
  possible" [cd107853c]. This is **the default**: "by default Kafka guarantees at-least-once delivery"
  [cd3da7a01], and at-least-once "is the default behavior in most Kafka consumer configurations"
  [c4cd6492f].
- **Exactly-once**: "even when failures occur, the end-to-end effect on the output is as if each event
  was processed one time and one time only. No data loss, no duplicates in the output" [c4cd6492f].

The load-bearing, cross-engine insight is that **exactly-once is not free and is not magic**. Achieving
it "requires tight coordination between the source, the processor, and the sink," with "real costs in
terms of latency, throughput, and operational complexity" [c4cd6492f]. Kafka only supports exactly-once
"in Kafka Streams" using "transactional producers and consumers… when transferring and processing data
between Kafka topics" [cd3da7a01] — i.e. when the side effect is *another write to the same broker*.
Stated mechanically, exactly-once "in practice… is delivered as at least once delivery plus deduplication
plus transactional writes to sinks, often orchestrated by a framework" [ca2130003].

For job/queue systems with **external side effects** (a database, an API, an email), the practitioner
guidance is to use **at-least-once with idempotent consumers** as the default: the consumer performs its
side effect and acks, and "if a duplicate arrives, the consumer detects it (via a deduplication store…)
and acks without re-processing" [c5e9d5baa]. The blunt version: "Exactly-once with external side effects
is a lie — what you actually have is at-least-once with broker-side dedup plus whatever idempotency you
built in the consumer" [c5e9d5baa]. Reserve broker-level exactly-once for the case where "the consumer's
side effect is _another publish to the same broker_" (e.g. Kafka Streams' `processing.guarantee=exactly_once_v2`)
[c5e9d5baa]. One operational caveat worth carrying: dedup windows must be sized to exceed the worst-case
redelivery interval — Kafka's `transactional.id.expiration.ms` defaults to 7 days and NATS JetStream's
`--dupe-window` defaults to 2 minutes, and "the window must exceed your worst-case producer retry
interval or dedup silently fails" [c5e9d5baa].

*Provenance note:* the authoritative definitional anchors are docs.confluent.io [cd3da7a01]; Streamkap
[c4cd6492f] and Stackharbor [c5e9d5baa] are vendor knowledge-base articles, used for their explicit and
internally consistent technical claims and attributed as vendor sources; the Medium [cd107853c] and
DesignGurus [ca2130003] pieces are corroborating blog/SEO material, used only where they agree with the
stronger sources (no claim rests on them alone).

## How this lands on the two engines

- **Temporal** raises the guarantee to the *workflow* layer: the workflow function executes effectively
  exactly-once via deterministic replay of its event history [c30e424ce, c4397ad66], while the individual
  activities are retried (at-least-once) and recover automatically [cfca4102b] — so idempotent activity
  design remains the user's job [c64285464, c30e424ce]. It is positioned for long-running, multi-step,
  partial-failure-catastrophic workflows, and called overkill for short jobs where occasional duplicates
  are fine [c64285464].
- **River** raises reliability at the *enqueue* layer: by committing the job in the same Postgres
  transaction as the business data [cc64e3fc3], it removes the dual-write window that otherwise loses
  jobs or runs them against uncommitted data — the transactional-outbox guarantee, native to the queue,
  with `SKIP LOCKED` as the dequeue primitive [cc6fc3ea0]. River does not itself claim exactly-once
  *processing*; transactional enqueue guarantees the job is durably recorded with its data, after which
  worker execution still follows the at-least-once-plus-idempotency discipline above.
