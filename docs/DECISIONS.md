# Jobs System — Decision Log

**Status:** Normative. This is the single source of truth for the project's architectural decisions.
**Relationship to other docs:** `ARCHITECTURE.md` describes the design these decisions shape and cross-references each record by id (e.g. `(ADR-005)`). `GLOSSARY.md` is normative for terminology. On any conflict between this log and `ARCHITECTURE.md` prose, **this log wins** (as `GLOSSARY.md` wins on terms).
**Format:** each record follows MADR 4.0 (Context → Decision Drivers → Considered Options → Decision Outcome → Pros/Cons → Confirmation → Refs).

---

## How We Decide

A short, repeatable procedure. Keep it lightweight; the point is an honest, durable trail — not ceremony.

### When to write an ADR

Write a record for any choice that is **hard to reverse**, **changes a port or contract** (§4 of `ARCHITECTURE.md`), or **selects one pattern over a viable alternative**. Do *not* write one for naming, formatting, or anything `GLOSSARY.md` already governs — those are settled elsewhere.

### Status lifecycle

```
Proposed ──▶ Accepted ──▶ Superseded
   │
   └──▶ Rejected                 Accepted ──▶ Deprecated
```

- **Proposed** — drafted, under review, not yet binding.
- **Accepted** — binding. Conforming implementations must honor it.
- **Superseded** — replaced by a newer decision; kept for history, links to its replacement.
- **Rejected** — evaluated and declined; kept so the option is not re-litigated.
- **Deprecated** — an accepted decision aged out with no direct replacement.

### Numbering & superseding

- Ids are monotonic, zero-padded `ADR-NNN`, **never reused**.
- To reverse or replace a decision, write a **new** record with a new id. Link both ways: the new record carries `Supersedes: ADR-XXX`; the old record's status becomes `Superseded` with `Superseded by: ADR-YYY`.
- **Never delete** a record. History is the point.

### Authoring loop

```
research → draft a Proposed ADR → review → mark Accepted → update the (ADR-NNN) tag in ARCHITECTURE.md
```

One decision per record. Keep `Confirmation` concrete: state the observable invariant a contract test (§13) would assert, so "are we honoring this?" has a checkable answer.

---

## Index

| ID | Title | Status | Date | Supersedes | Superseded by |
|---|---|---|---|---|---|
| ADR-001 | Two layered tiers (queue substrate + durable orchestration) | Accepted | 2026-06-16 | — | — |
| ADR-002 | Hexagonal ports & adapters as the structure | Accepted | 2026-06-16 | — | — |
| ADR-003 | CloudEvents as the wire envelope | Accepted | 2026-06-16 | — | — |
| ADR-004 | Effectively-once via at-least-once + idempotent consumers | Accepted | 2026-06-16 | — | — |
| ADR-005 | Orchestration sagas over choreography | Accepted | 2026-06-16 | — | — |
| ADR-006 | Distributed cron fires once cluster-wide | Accepted | 2026-06-16 | — | — |
| ADR-007 | Local backend is first-class, not a stub | Accepted | 2026-06-16 | — | — |
| ADR-008 | Workflow-definition format hidden behind the `DurableEngine` port | Accepted | 2026-06-16 | — | — |
| ADR-009 | Contracts stay language-neutral | Accepted | 2026-06-16 | — | — |
| ADR-010 | Payload-level (end-to-end) encryption is supported | Accepted | 2026-06-16 | — | — |
| ADR-011 | Tiered mid-Job resumability: fan-out default, Chunk-commit checkpoint escape | Accepted | 2026-06-16 | — | — |
| ADR-012 | `Queue` port targets work-queue brokers; log brokers are a separate adapter class | Proposed | 2026-06-17 | — | — |
| ADR-013 | Durable-execution model is adapter-specific (replay vs journaling vs managed-state) | Proposed | 2026-06-17 | — | — |
| ADR-014 | Declared system-of-record store classes + per-class data models | Proposed | 2026-06-17 | — | — |
| ADR-015 | Scheduler fire-once via adapter occurrence-dedupe; add pause/resume | Proposed | 2026-06-17 | — | — |
| ADR-016 | Port contracts specify guarantees, not mechanisms | Proposed | 2026-06-17 | — | — |
| ADR-017 | Workflow/code versioning is in scope | Proposed | 2026-06-17 | — | — |
| ADR-018 | Global rate-limiting / concurrency-limit is a first-class mechanism | Proposed | 2026-06-17 | — | — |
| ADR-019 | Unique-jobs (enqueue-time dedup), distinct from idempotency | Proposed | 2026-06-17 | — | — |
| ADR-020 | Conformance proven by a shared per-port test kit (TCK) | Proposed | 2026-06-17 | — | — |

> **ADR-012…020 are Proposed** — derived from `PROCESS-GAP-AUDIT.md` (2026-06-17). They await review before acceptance; the `ARCHITECTURE.md` edits each implies are deferred until the record is Accepted.

---

## Records

## ADR-001: Two layered tiers (queue substrate + durable orchestration)

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
A job system must serve both a "fire one job" request and a "provision → bill → notify → on failure roll back" flow. These have opposite cost/safety profiles: the first wants cheap, low-overhead dispatch; the second wants crash-safe, multi-step coordination with compensation. What execution model serves both without penalizing either?

### Decision Drivers
- Cheap single-shot dispatch for trivial jobs (no overhead tax).
- Crash-safety for multi-step, long-running workflows.
- Portability across backends, some of which lack a durable engine.

### Considered Options
1. **Two layered tiers** — a queue/worker substrate (at-least-once) beneath a durable-orchestration tier (effectively-once via replay); each job sits at the lowest tier that satisfies it.
2. **Durable-only** — every job runs as an event-sourced workflow.
3. **Queue-only** — everything is a queued message; no durable orchestration tier.

### Decision Outcome
Chosen: **Option 1 (two layered tiers)**, because most real systems need both modes, and a layered model lets each job pay only for the guarantees it needs while the upper tier *uses* the lower tier to dispatch each step.

### Pros and Cons of the Options
- **Two layered tiers** — *Pros:* trivial jobs stay cheap; complex flows get crash-safety; backends without a durable engine still serve the lower tier. *Cons:* two execution models to specify and learn.
- **Durable-only** — *Pros:* one model. *Cons:* event-sourcing overhead on trivial jobs; forces emulation of a durable engine on backends that lack one — a leaky abstraction.
- **Queue-only** — *Pros:* simplest substrate. *Cons:* punts the core problem — surviving a crash mid-workflow with correct compensation.

### Confirmation
A single-step job completes using only `Queue` + `Store` (no `DurableEngine` dependency); a multi-step workflow survives a mid-flow crash and resumes via replay (§8.3 flow, §13.2 replay tests).

### Refs
`ARCHITECTURE.md` §2.

---

## ADR-002: Hexagonal ports & adapters as the structure

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
A goal is one core model that maps onto any queue, store, scheduler, or durable engine without rewriting orchestration logic. How should the codebase be structured so backend specifics never leak into the core?

### Decision Drivers
- Generic across backends without forking the core.
- Adapter swappable without touching core orchestration.
- Provider mappings should be a configuration choice, not a code fork.

### Considered Options
1. **Hexagonal (ports & adapters)** — the core depends only on narrow port interfaces; each backend supplies an adapter.
2. **Per-backend codebases** — a separate implementation per backend.
3. **Thick common runtime** — one fat runtime that re-implements each backend's engine internally.

### Decision Outcome
Chosen: **Option 1 (hexagonal)**, because it is the only structure that stays generic across backends without forking the core; no core file references a backend SDK, so `PROVIDER-REFERENCE.md` mappings become configuration.

### Pros and Cons of the Options
- **Hexagonal** — *Pros:* clean swap boundary; shared contract tests across adapters (§13.1); core stays small and reasoned-about. *Cons:* port abstractions must be designed carefully or they leak.
- **Per-backend codebases** — *Pros:* each can exploit its backend fully. *Cons:* N forks to maintain; orchestration logic duplicated and divergent.
- **Thick common runtime** — *Pros:* uniform behavior. *Cons:* re-implements engines that backends already provide; enormous surface; high maintenance.

### Confirmation
No core source file imports a backend SDK; every port (§4) has a shared contract-test suite that all adapters pass (§13.1).

### Refs
`ARCHITECTURE.md` §3.

---

## ADR-003: CloudEvents as the wire envelope

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
Portability lives in the wire format, not shared code: a producer in one language and a worker in another must interoperate. This is the one place a concrete interop format is unavoidable. What envelope carries a job message?

### Decision Drivers
- Vendor-neutral; bindings for any common transport.
- Cross-language interoperability through a shared schema.
- An ecosystem of existing tooling/bindings (no bespoke maintenance).

### Considered Options
1. **CloudEvents** — a vendor-neutral specification with transport bindings; job-specific fields (`idempotencykey`, `traceparent`, `tenantid`) ride as extension attributes.
2. **Per-library native payloads** — each language/transport's own message type.
3. **Bespoke envelope** — a project-defined format.

### Decision Outcome
Chosen: **Option 1 (CloudEvents)**, because it makes the *contract* (not code) the portability boundary and brings transport bindings and ecosystem for free.

### Pros and Cons of the Options
- **CloudEvents** — *Pros:* vendor-neutral; bindings exist for common transports; extension attributes fit the custom fields. *Cons:* a standard to learn; some attributes unused for simple jobs.
- **Native payloads** — *Pros:* zero translation in a single-language deployment. *Cons:* locks the message to a language/transport; no cross-language interop.
- **Bespoke envelope** — *Pros:* exactly the fields we want. *Cons:* no ecosystem, no bindings, all tooling self-built and self-maintained.

### Confirmation
A message produced by one language's adapter is consumed and validated by another's against the shared JSON Schema (§5.2); the four custom fields are present as CloudEvents extension attributes (§5.1).

### Refs
`ARCHITECTURE.md` §5.

---

## ADR-004: Effectively-once via at-least-once + idempotent consumers

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
Duplicate delivery is inevitable under at-least-once transport, yet jobs must not double-charge, double-create, or double-send. What delivery/consistency model does the system guarantee end-to-end?

### Decision Drivers
- Correctness across external, non-idempotent side effects.
- No reliance on a transport-specific exactly-once claim.
- A single universal primitive adapters can all honor.

### Considered Options
1. **At-least-once delivery + idempotent consumers ⇒ effectively-once effects** — every job carries an `idempotencykey`; consumers record processed keys (`Store.recordIdempotent`) and return the prior result on a duplicate.
2. **Assume exactly-once delivery** — trust a transport's exactly-once guarantee end-to-end.
3. **At-most-once as default** — deliver once, accept drops.

### Decision Outcome
Chosen: **Option 1 (effectively-once via idempotency)**, because no transport guarantees end-to-end exactly-once across external side effects — even a log-based transport's exactly-once stops at its own boundary — so idempotency is the universal primitive. At-most-once remains an explicit opt-in for telemetry-grade work only.

### Pros and Cons of the Options
- **Effectively-once via idempotency** — *Pros:* correct across any transport and any external system; one primitive every adapter implements. *Cons:* requires a durable idempotency record and disciplined key usage by callers.
- **Assume exactly-once delivery** — *Pros:* no consumer-side dedup code. *Cons:* false guarantee at the external-effects boundary; correctness bugs that surface only under failure.
- **At-most-once default** — *Pros:* cheapest, simplest. *Cons:* silent data loss; unacceptable for anything but disposable telemetry.

### Confirmation
A redelivered message's second `recordIdempotent(key)` returns `AlreadyExists` and the worker applies no second effect (§8.1, §8.2); contract tests assert idempotent-consume across duplicate delivery (§13.1).

### Refs
`ARCHITECTURE.md` §6.1, §7.1.

---

## ADR-005: Orchestration sagas over choreography

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
Multi-step workflows spanning resources need consistency without distributed transactions. The saga pattern provides this via per-step compensations — but sagas can be coordinated two ways. Which coordination style?

### Decision Drivers
- Auditability — failure/compensation logic in one inspectable place.
- Reasoning and testability of the failure path.
- Crash-safe resume of an in-flight multi-step flow.

### Considered Options
1. **Orchestration saga** — a central `DurableEngine` workflow drives steps and runs compensations on failure; each forward step declares its compensating action up front.
2. **Choreography saga** — services react to each other's events; compensation is emergent across services.

### Decision Outcome
Chosen: **Option 1 (orchestration)**, because it keeps failure and compensation logic in one auditable place, which is easier to reason about, test (replay), and recover (resume via history) than logic smeared across services.

### Pros and Cons of the Options
- **Orchestration** — *Pros:* single auditable locus of failure logic; compensations declared explicitly; crash resumes via replay (§7.2). *Cons:* the orchestrator is a component to run and scale; central definition of the flow.
- **Choreography** — *Pros:* no central coordinator; loose coupling. *Cons:* compensation logic scattered across services; hard to audit, hard to test, emergent failure behavior.

### Confirmation
A saga whose Nth step fails runs declared compensations in reverse for steps 1..N-1, and a crash between steps resumes via replay rather than restart (§8.3, §13.2).

### Refs
`ARCHITECTURE.md` §6.3.

---

## ADR-006: Distributed cron fires once cluster-wide

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
The `Scheduler` runs with many replicas for availability. A cron occurrence must dispatch the job — but duplicate fires cause duplicate work. How many times does one occurrence fire across the cluster?

### Decision Drivers
- Exactly one dispatch per cron occurrence, cluster-wide.
- A missed tick must be detectable, never silently dropped.
- Tolerant of multiple scheduler replicas.

### Considered Options
1. **Leader-elected / deduped fire** — one occurrence dispatches once cluster-wide via leader election or occurrence dedupe.
2. **Per-replica timers** — each replica runs its own timer and fires independently.

### Decision Outcome
Chosen: **Option 1 (fire-once)**, because duplicate scheduled fires cause duplicate work; leader election / dedupe makes each occurrence effectively exactly-once at the scheduler.

### Pros and Cons of the Options
- **Leader-elected / deduped** — *Pros:* one fire per occurrence regardless of replica count; missed ticks detectable. *Cons:* requires a coordination mechanism (leader election or a dedupe record).
- **Per-replica timers** — *Pros:* trivially simple, no coordination. *Cons:* N replicas → N fires per occurrence; duplicate downstream work.

### Confirmation
With M scheduler replicas, a single cron occurrence produces exactly one dispatch; `Scheduler.onDue` fires once per occurrence (§4.3).

### Refs
`ARCHITECTURE.md` §4.3.

---

## ADR-007: Local backend is first-class, not a stub

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
Developers and CI need to run end-to-end flows without provisioning hosted infrastructure. What fidelity does the local backend target?

### Decision Drivers
- Zero-cost iteration and CI.
- Honest integration tests that exercise real failure modes.
- A credible starting point before any hosted backend (§15).

### Considered Options
1. **Full-fidelity local backend** — a complete local stack that honors the same port contracts and failure modes as hosted backends.
2. **In-memory-only local mode** — a simplified stub for happy-path development.

### Decision Outcome
Chosen: **Option 1 (first-class local)**, because full local parity enables zero-cost iteration and honest end-to-end tests; a stub hides exactly the failure modes the system exists to handle.

### Pros and Cons of the Options
- **Full-fidelity local** — *Pros:* real crash/lease/redelivery behavior testable for free; recommended first backend. *Cons:* more effort than a stub to build and keep faithful.
- **In-memory-only stub** — *Pros:* fast, trivial. *Cons:* hides real failure modes; green local tests give false confidence.

### Confirmation
The full §8 flows and the port contract-test suite (§13.1) pass against the local backend with no hosted infrastructure (§13.4).

### Refs
`ARCHITECTURE.md` §13.4.

---

## ADR-008: Workflow-definition format hidden behind the `DurableEngine` port

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
Durable engines define workflows in irreconcilable ways — declarative DSLs (e.g. Serverless Workflow, BPMN) versus code-based definitions. The system must support conforming engines of either kind. Should one workflow-definition format be mandated?

### Decision Drivers
- Support both declarative-DSL and code-based engines.
- Don't exclude an otherwise-conforming engine over its definition format.
- Keep the portability boundary at the port, not the format.

### Considered Options
1. **Abstract the format behind the `DurableEngine` port** — the port defines the orchestration capability; the definition format is an adapter detail.
2. **Mandate one workflow DSL** — pick a single definition language all engines must speak.

### Decision Outcome
Chosen: **Option 1 (abstract behind the port)**, because declarative and code-based definitions cannot be unified into a single surface, and mandating one would exclude engines that don't speak it. Serverless Workflow and BPMN are *recognized* but not required.

### Pros and Cons of the Options
- **Abstract behind the port** — *Pros:* any engine conforms regardless of format; portability boundary stays at the port. *Cons:* no single portable workflow definition across engines.
- **Mandate one DSL** — *Pros:* one portable definition; tooling around it. *Cons:* excludes non-conforming engines; forces emulation; bets on one format's longevity.

### Confirmation
A code-based engine adapter and a declarative-engine adapter both satisfy the same `DurableEngine` contract (§4.4) and pass its contract tests, with no shared definition format required.

### Refs
`ARCHITECTURE.md` §5.3.

---

## ADR-009: Contracts stay language-neutral

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
Portability across languages is a core goal: the contract, not the code, is the portability boundary. How are the port interfaces (§4) specified?

### Decision Drivers
- Cross-language portability of the contracts.
- The contract is the interop boundary, not any one implementation.
- Adapters in any language satisfy the same semantics with their own idioms.

### Considered Options
1. **Language-neutral pseudotype contracts** — ports specified as `Name(args) -> result` with pre/post-conditions and invariants, not in any language's type system.
2. **Specify ports in one language's types** — define the canonical contract in a chosen language.

### Decision Outcome
Chosen: **Option 1 (language-neutral)**, because pinning a language in the contract defeats the cross-language portability goal; the lead language is deliberately deferred to an implementation hook (§15).

### Pros and Cons of the Options
- **Language-neutral** — *Pros:* any-language adapters; contract outlives implementation choices. *Cons:* pseudotypes aren't machine-checked; each language re-expresses them.
- **One language's types** — *Pros:* compiler-checked, immediately usable in that language. *Cons:* biases the model toward one language's idioms; other languages translate from a foreign contract.

### Confirmation
The §4 contracts contain no language-specific types; an adapter in a second language can be written purely from the contract text and pass the shared contract tests (§13.1).

### Refs
`ARCHITECTURE.md` §4, §15.

---

## ADR-010: Payload-level (end-to-end) encryption is supported

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
Transport (TLS) and at-rest encryption protect data from outside observers and at the storage layer, but not from the platform operator (broker, orchestration engine). Some payloads and compliance regimes require that the platform itself cannot read the data. Is operator-opaque protection in scope?

### Decision Drivers
- Protect sensitive payloads even from the platform operator.
- Meet compliance regimes that demand end-to-end confidentiality.
- Keep it optional and pluggable (not every workload needs it).

### Considered Options
1. **Support payload-level (end-to-end) encryption** — a pluggable payload codec at the message boundary lets the producer encrypt `data` so only authorized workers decrypt; the broker and engine see ciphertext.
2. **Rely solely on transport + at-rest encryption** — TLS on every hop plus encrypted storage, no payload-level option.

### Decision Outcome
Chosen: **Option 1 (support payload-level)**, because transport/at-rest leaves the payload readable by the platform operator, which some sensitive data and compliance regimes forbid. It is supported and pluggable, not mandatory.

### Pros and Cons of the Options
- **Payload-level encryption** — *Pros:* payloads opaque to broker/engine/operator; satisfies strict compliance; pairs with claim-check for large bodies (§9.2). *Cons:* key management and an encryption boundary to operate; payloads not server-inspectable.
- **Transport + at-rest only** — *Pros:* simpler; no payload key management. *Cons:* operator can read payloads; insufficient for some compliance regimes.

### Confirmation
With the payload codec enabled, a message's `data` is unreadable at the broker and the durable engine and decrypts only at an authorized worker (§9.2).

### Refs
`ARCHITECTURE.md` §9.2.

---

## ADR-011: Tiered mid-Job resumability — fan-out by default, Chunk-commit checkpoint as escape hatch

**Status:** Accepted | **Date:** 2026-06-16

### Context and Problem Statement
A redelivered `Job` re-runs its body from the start; idempotency prevents double *effects*, but a `Job` processing many `Item`s would reprocess from the first `Item`. How does a long, multi-`Item` job resume mid-way without redundant rework?

### Decision Drivers
- Reuse primitives already owned; avoid net-new machinery where possible.
- Maximize parallelism for independent item-sets.
- Correct resume points only (durably committed, not a reporting value).
- Don't tax the common case with heavyweight machinery.

### Considered Options
1. **Tiered: fan-out by default, Chunk-commit `Checkpoint` as escape hatch** — independent items become a `Batch` of one-`Job`-per-`Item` (resumability falls out of job-tier redelivery); unitary streaming jobs persist a `Checkpoint` (last committed `Chunk` cursor) to the `Store`, carried on the lease heartbeat, and resume from it.
2. **Periodic global snapshots** — workers snapshot full in-progress state on an interval.
3. **Single uniform mechanism** — one checkpoint mechanism for every multi-item job.

### Decision Outcome
Chosen: **Option 1 (tiered)**, because independent item-sets resume for free via job-tier redelivery when fanned out (no new primitive, maximal parallelism), while the rarer unitary streaming job gets a durable cursor reusing the lease heartbeat we already own. Progress *reporting* is explicitly **not** a checkpoint — a resume point must be durably committed and read back by the next `Attempt`.

### Pros and Cons of the Options
- **Tiered** — *Pros:* common case needs no new machinery; max parallelism via fan-out; escape hatch reuses existing lease/heartbeat and `Store`; checkpoint granularity tunable by chunk size. *Cons:* two strategies to understand; chunk-size is a tradeoff to set.
- **Periodic global snapshots** — *Pros:* uniform, engine-style. *Cons:* heavyweight, stream-engine-oriented — overkill for discrete jobs; snapshot cost regardless of need.
- **Single uniform mechanism** — *Pros:* one concept. *Cons:* forces checkpoint machinery onto the common independent-item case that doesn't need it.

### Confirmation
A fanned-out batch redelivers only incomplete Item-Jobs (tracked by `Batch` counters); a checkpointed streaming job resumes from the last committed `Chunk` cursor read from the `Store`, never from a progress-reporting value (§14.3, §14.5).

### Refs
`ARCHITECTURE.md` §14.

---

## ADR-012: `Queue` port targets work-queue brokers; log brokers are a separate adapter class

**Status:** Proposed | **Date:** 2026-06-17

### Context and Problem Statement
The `Queue` port (§4.1) specifies per-message lease, ack, nack, visibility timeout, and DLQ — a *work-queue* model. The feasibility audit (`PROCESS-GAP-AUDIT.md` §G2a) found this maps cleanly onto SQS, Service Bus, RabbitMQ, Redis Streams, and Pub/Sub, but **not onto log brokers (Kafka)**: Kafka's offset-commit model has no per-message ack (committing offset 5 acks 1–5), no per-message lease/visibility, no per-message delay, and no native DLQ. Forcing Kafka behind the port requires a side-store of per-message state — heavy emulation that contradicts "an adapter is a configuration choice." Is the `Queue` port claimed to cover log brokers?

### Decision Drivers
- Honesty of the agnosticism claim — don't imply portability the port lacks.
- Keep adapters thin (config choice, not a re-implementation).
- Avoid contorting the core to fit a fundamentally different transport model.

### Considered Options
1. **Scope the `Queue` port to work-queue brokers; treat log brokers as a distinct adapter class** (its own contract or explicitly out of scope).
2. **Widen the `Queue` port to also cover log brokers** by mandating per-message-state emulation in every log adapter.
3. **Lowest-common-denominator port** — drop lease/ack/visibility so Kafka fits.

### Decision Outcome
Chosen: **Option 1**. The `Queue` port remains a work-queue abstraction; log-oriented brokers are a separate adapter class requiring per-message-state emulation, or are out of scope for this port. The portability claim is narrowed accordingly.

### Pros and Cons of the Options
- **Option 1** — *Pros:* honest boundary; thin adapters for the brokers that fit; core stays a work-queue model. *Cons:* Kafka users need a distinct adapter strategy or another transport.
- **Option 2** — *Pros:* one nominal port covers everything. *Cons:* every log adapter re-implements queue semantics in a side store; fat, fragile, defeats the abstraction.
- **Option 3** — *Pros:* Kafka fits trivially. *Cons:* guts the guarantees (lease/ack/visibility) every real job system needs; worst of both.

### Confirmation
The per-message-ack-isolation contract test (ack msg N while msg M in-flight) passes on work-queue adapters and is documented as the boundary a log broker cannot satisfy without emulation.

### Refs
`PROCESS-GAP-AUDIT.md` §G2a; `ARCHITECTURE.md` §4.1. Related: [[ADR-016]].

---

## ADR-013: Durable-execution model is adapter-specific (replay vs journaling vs managed-state)

**Status:** Proposed | **Date:** 2026-06-17

### Context and Problem Statement
`ARCHITECTURE.md` §7.2 states a port-level invariant: workflow code must be deterministic — no wall-clock, randomness, or I/O in the body — because the engine recovers by **replaying** history. The audit (§G2b) found this is a *replay-engine* assumption: it is **not required** by journaling engines (Restate, DBOS — they journal results, so non-deterministic code is safe) and is **meaningless** for managed-state engines (Step Functions — no user-code body is replayed). Both conform to the orchestration *capability contract* yet violate the §7.2 *invariant*. "Continue-As-New" (§14.4) is likewise Temporal/Azure-specific vocabulary. Is determinism a property of the port or of a class of adapters?

### Decision Drivers
- Genuine engine-agnosticism (the core goal of the durable tier).
- Don't impose one engine's recovery tax on engines that don't need it.
- Separate *capability* (what the port offers) from *mechanism* (how an adapter delivers it).

### Considered Options
1. **Reclassify determinism/replay as an adapter-specific constraint; the port specifies capability, not mechanism.** Generalize "Continue-As-New" to "engine-specific history/journal bounding." Add journaling engines to the reference.
2. **Keep determinism as a port invariant** (all conforming engines must be replay-based).
3. **Define separate ports** per execution model.

### Decision Outcome
Chosen: **Option 1**. The `DurableEngine` port specifies orchestration *capability* (start, activity, timer, signal, child, cancel, idempotent-start, compensation). The recovery *mechanism* — replay (Temporal/Cadence/Azure Durable Functions), journaling (Restate/DBOS), or managed-state (Step Functions) — is an adapter property. The §7.2 determinism rule is documented as a constraint of replay adapters, not a universal invariant.

### Pros and Cons of the Options
- **Option 1** — *Pros:* fits all three engine classes; capability/mechanism split keeps the port honest. *Cons:* §7.2 and §14.4 must be reworded; per-adapter constraints to document.
- **Option 2** — *Pros:* simplest single rule. *Cons:* excludes journaling and managed-state engines — false agnosticism.
- **Option 3** — *Pros:* each port is precise. *Cons:* fragments the upper tier; defeats one orchestration abstraction.

### Confirmation
The orchestration contract test (start/activity/timer/signal/child/cancel/idempotent-start) passes on a journaling-model engine **without** asserting replay-determinism; PROVIDER-REFERENCE maps at least one replay, one journaling, and one managed-state engine.

### Refs
`PROCESS-GAP-AUDIT.md` §G2b; `ARCHITECTURE.md` §4.4, §5.3, §7.2, §14.4. Related: [[ADR-008]], [[ADR-016]].

---

## ADR-014: Declared system-of-record store classes + per-class data models

**Status:** Proposed | **Date:** 2026-06-17

### Context and Problem Statement
The audit (§G3) found the `Store` contract and the `DATA-STRATEGY.md` model are relational-biased. The §4.2 claim "stores lacking multi-row transactions satisfy outbox atomicity via single-document or conditional write" holds on MongoDB, is **same-partition-only** on Cassandra (a BATCH is atomic only within a partition and not isolated), and is **durability-conditional** on Redis (MULTI/EXEC is atomic but not durable by default). The Job/Attempt/Batch/Item/Chunk/Checkpoint model uses joins and secondary-index queries (list-by-state/tenant for the §11.4 UI) that are anti-patterns on wide-column/KV. "NoSQL" is treated as one undifferentiated bucket. Which store classes are valid as system-of-record, and what model does each use?

### Decision Drivers
- Real DB-agnosticism, decomposed by store *class* not SQL-vs-NoSQL.
- Outbox atomicity and idempotency must hold (or be honestly excluded) per class.
- Operator-UI query patterns must be serviceable on each class.

### Considered Options
1. **Declare system-of-record store classes and give a denormalized data model per class.** Relational and document first-class; wide-column first-class *with mandated query-tables*; KV auxiliary (lease/idempotency/cache), not durable Store-of-record unless durably configured.
2. **Keep a single model; require every store to emulate relational semantics.**
3. **Relational-only system-of-record; other stores auxiliary.**

### Decision Outcome
Chosen: **Option 1**. `DATA-STRATEGY.md` provides a denormalized schema + access-pattern table per store class; §4.2 documents the outbox-atomicity strategy per class (co-partition on Cassandra; durability-config requirement on Redis; TransactWriteItems limits on Dynamo). Valid system-of-record classes are declared explicitly.

### Pros and Cons of the Options
- **Option 1** — *Pros:* honest per-class guarantees; UI queries serviceable; KV used where it's strong. *Cons:* more modeling work; several schemas to maintain.
- **Option 2** — *Pros:* one model. *Cons:* forces relational emulation onto stores that can't (Cassandra cross-partition atomicity); leaky and slow.
- **Option 3** — *Pros:* simplest, safest. *Cons:* abandons the DB-agnostic goal.

### Confirmation
An outbox-atomic-publish-under-crash conformance test passes per declared system-of-record class; each class has a documented denormalized model satisfying the list-by-state/tenant query.

### Refs
`PROCESS-GAP-AUDIT.md` §G3; `ARCHITECTURE.md` §4.2; `DATA-STRATEGY.md`. Related: [[ADR-004]].

---

## ADR-015: Scheduler fire-once via adapter occurrence-dedupe; add pause/resume

**Status:** Proposed | **Date:** 2026-06-17
**Refines:** ADR-006

### Context and Problem Statement
ADR-006 states a cron occurrence "fires exactly once cluster-wide." The audit (§G2c) found **most managed schedulers guarantee only at-least-once**: AWS EventBridge Scheduler and GCP Cloud Scheduler may invoke more than once; Kubernetes CronJob is best-effort (skips after >100 missed starts; `concurrencyPolicy=Forbid` prevents overlap, not duplicates). Only Temporal Schedules and clustered Quartz provide native fire-once. So fire-once cannot be assumed from the backend. Also, `Scheduler` (§4.3) offers schedule/cancel but no pause/resume, which leading systems treat as table-stakes.

### Decision Drivers
- Preserve the fire-once *effect* (no duplicate scheduled work) despite at-least-once backends.
- Reuse the idempotency primitive already mandated (ADR-004).
- Operability parity (pause a schedule without deleting it).

### Considered Options
1. **Fire-once is an adapter responsibility: dedupe per occurrence (occurrence id → idempotency key, ADR-004) layered over an at-least-once scheduler; add `pauseSchedule`/`resumeSchedule`.**
2. **Require backends that natively guarantee fire-once** (Temporal/Quartz only).
3. **Accept at-least-once scheduling** and rely solely on downstream job idempotency.

### Decision Outcome
Chosen: **Option 1**. The `Scheduler` adapter converts an at-least-once trigger into an effectively-once dispatch via per-occurrence dedupe, reusing ADR-004. `pauseSchedule`/`resumeSchedule` are added to §4.3. ADR-006's intent (no duplicate scheduled work) is preserved; its claim of a *native* cluster-wide single fire is corrected to an adapter-layered guarantee.

### Pros and Cons of the Options
- **Option 1** — *Pros:* works on every scheduler; reuses idempotency; adds needed operability. *Cons:* adapter carries a dedupe record per occurrence.
- **Option 2** — *Pros:* no adapter dedupe. *Cons:* excludes the common cloud schedulers — fails agnosticism.
- **Option 3** — *Pros:* simplest. *Cons:* duplicate dispatches reach workers; relies on every consumer being idempotent for *scheduling* correctness — fragile.

### Confirmation
A duplicate-occurrence suppression test: two trigger deliveries for the same occurrence produce exactly one dispatch. `pauseSchedule` halts firing without losing the schedule; `resumeSchedule` restores it.

### Refs
`PROCESS-GAP-AUDIT.md` §G2c; `ARCHITECTURE.md` §4.3. Refines [[ADR-006]]; reuses [[ADR-004]].

---

## ADR-016: Port contracts specify guarantees, not mechanisms

**Status:** Proposed | **Date:** 2026-06-17

### Context and Problem Statement
Several port contracts name a *mechanism* rather than the *guarantee* it provides, which silently encodes one backend's model. The audit found §4.1 specifies a "visibility timeout" (an SQS mechanism) where the real requirement is "a message is redelivered after a worker loses its lease or dies" — RabbitMQ achieves this on channel/consumer death, Redis on idle-claim, with no timer. Mechanism-named contracts make conforming backends look non-conforming. How should contracts be phrased?

### Decision Drivers
- Maximize the set of backends that can conform.
- Make conformance about observable behavior, not implementation.
- Stop one vendor's vocabulary from leaking into the neutral spec.

### Considered Options
1. **State every port contract as an observable guarantee; mention mechanisms only as adapter examples.**
2. **Keep mechanism-named contracts** (visibility timeout, etc.).

### Decision Outcome
Chosen: **Option 1**. Contracts state guarantees (e.g., "redelivery after lease loss/worker death," "atomic first-writer-wins dedup," "effectively-once dispatch"); specific mechanisms (visibility timeout, SKIP LOCKED, peek-lock) appear only as illustrative adapter realizations. This is a cross-cutting editorial rule applied across §4.

### Pros and Cons of the Options
- **Option 1** — *Pros:* broadest conformance; contracts and contract-tests align on behavior. *Cons:* one-time rewording pass across the contracts.
- **Option 2** — *Pros:* concrete and familiar. *Cons:* encodes SQS/Postgres assumptions; mislabels conforming backends.

### Confirmation
Contract tests assert behaviors (redelivery-after-worker-death, dedup-atomicity), not mechanisms; no §4 contract clause names a single-vendor mechanism as a requirement.

### Refs
`PROCESS-GAP-AUDIT.md` §G2a; `ARCHITECTURE.md` §4. Related: [[ADR-012]], [[ADR-020]].

---

## ADR-017: Workflow/code versioning is in scope

**Status:** Proposed | **Date:** 2026-06-17

### Context and Problem Statement
The parity audit (§G6) flagged workflow/code versioning as the biggest missing capability: it is currently only a §15 implementation hook. Long-running workflows outlive code deploys; changing a definition while runs are in flight breaks replay-based engines and risks inconsistent behavior on managed-state engines. Temporal (versioning API) and Step Functions (versions/aliases) treat this as table-stakes. Is versioning in scope for the reference?

### Decision Drivers
- Correctness of in-flight long-running workflows across deploys.
- Parity with world-class engines.
- The durable tier's value proposition (multi-day/eternal workflows) depends on it.

### Considered Options
1. **Make workflow/code versioning a first-class concern** — the `DurableEngine` port and message contract carry a definition version; the architecture specifies compatibility/migration expectations.
2. **Leave versioning to implementations** (status quo: §15 hook only).

### Decision Outcome
Chosen: **Option 1**. Versioning is in scope: workflow definitions are versioned, runs pin their version, and the architecture states the compatibility rule (in-flight runs complete on their pinned version; new runs use the new version) with migration as an engine-specific mechanism.

### Pros and Cons of the Options
- **Option 1** — *Pros:* correct long-running workflows; parity; closes the largest gap. *Cons:* adds a versioning concept to the spec.
- **Option 2** — *Pros:* less spec surface now. *Cons:* the durable tier is not credibly world-class without it; every implementer reinvents it.

### Confirmation
A definition change with a run in flight: the in-flight run completes on its pinned version while a new run uses the new version, with no replay/non-determinism failure.

### Refs
`PROCESS-GAP-AUDIT.md` §G6; `ARCHITECTURE.md` §4.4, §15. Related: [[ADR-013]].

---

## ADR-018: Global rate-limiting / concurrency-limit is a first-class mechanism

**Status:** Proposed | **Date:** 2026-06-17

### Context and Problem Statement
`ARCHITECTURE.md` §6.7 names rate limiting and bulkheads but specifies no port or mechanism. The audit (§G6) found distributed rate-limiting and global concurrency caps are table-stakes in Inngest, Sidekiq Enterprise, River, and Hatchet — needed to protect shared downstreams and enforce per-tenant fairness across many workers. Per-worker limits (token buckets in one process) do not bound *aggregate* throughput. How is a cluster-wide limit expressed?

### Decision Drivers
- Protect shared downstreams from aggregate overload.
- Per-tenant fairness (ties to §9.4 noisy-neighbor).
- A limit that holds across all workers, not per process.

### Considered Options
1. **Specify a global rate-limit / concurrency-limit mechanism** — a distributed limiter (keyed by job type / tenant / downstream) backed by the `Store` or `Queue`, enforced before lease/dispatch.
2. **Per-worker limits only** (status quo implication).
3. **Out of scope** — defer entirely to backends.

### Decision Outcome
Chosen: **Option 1**. The reference specifies a cluster-wide limiter keyed by configurable dimensions (job type, tenant, downstream), enforced at dispatch, as a named mechanism bound to `Store`/`Queue`. Algorithm (token bucket / leaky bucket / concurrency semaphore) is an adapter choice.

### Pros and Cons of the Options
- **Option 1** — *Pros:* real aggregate protection; per-tenant fairness; parity. *Cons:* a distributed-limiter component to specify and operate.
- **Option 2** — *Pros:* trivial. *Cons:* cannot bound cluster-wide load; downstreams still overrun.
- **Option 3** — *Pros:* less spec. *Cons:* leaves a table-stakes capability unaddressed.

### Confirmation
Under N workers, aggregate dispatch for a limited key does not exceed the configured cluster-wide rate/concurrency; a saturating tenant does not starve others (§9.4).

### Refs
`PROCESS-GAP-AUDIT.md` §G6; `ARCHITECTURE.md` §6.7, §9.4, §10.2.

---

## ADR-019: Unique-jobs (enqueue-time dedup), distinct from idempotency

**Status:** Proposed | **Date:** 2026-06-17

### Context and Problem Statement
Idempotency (ADR-004) makes a *duplicate execution* harmless — it acts at the *effect* boundary. The audit (§G6) noted leading systems (Sidekiq, River, Faktory) also offer **unique jobs**: preventing a second job with the same key from being *enqueued/active* at all. These are distinct: idempotency still admits the job and runs the dedup check; unique-jobs rejects the enqueue (or coalesces) so the work never queues twice. Is enqueue-time uniqueness in scope?

### Decision Drivers
- Avoid wasteful duplicate *queuing* (not just duplicate effects).
- Match a common operator expectation ("only one active reindex per tenant").
- Keep it distinct from, and complementary to, idempotency.

### Considered Options
1. **Add a unique-jobs capability** — an optional uniqueness key on `enqueue` with a scope (e.g., while-queued, while-running, for-a-window) that rejects or coalesces duplicates at admission.
2. **Rely on idempotency alone** (status quo).

### Decision Outcome
Chosen: **Option 1**. `enqueue` accepts an optional uniqueness key + scope; the `Queue`/`Store` adapter rejects or coalesces a second job with a live key. This complements ADR-004: uniqueness prevents duplicate *queuing*; idempotency prevents duplicate *effects*.

### Pros and Cons of the Options
- **Option 1** — *Pros:* prevents wasteful duplicate work; meets a common expectation; clear separation from idempotency. *Cons:* a uniqueness record + scope semantics to specify.
- **Option 2** — *Pros:* nothing new. *Cons:* duplicates still queue and consume capacity even if effects are deduped.

### Confirmation
Two enqueues with the same uniqueness key and overlapping scope result in exactly one queued/active job; after the scope clears, a new job with the same key is admitted.

### Refs
`PROCESS-GAP-AUDIT.md` §G6; `ARCHITECTURE.md` §4.1, §6.1. Complements [[ADR-004]].

---

## ADR-020: Conformance proven by a shared per-port test kit (TCK)

**Status:** Proposed | **Date:** 2026-06-17

### Context and Problem Statement
"Backend-agnostic" is only credible if an adapter can be *objectively shown* to conform. `ARCHITECTURE.md` §13.1 names a "shared contract-test suite," and every ADR has a `Confirmation` field, but there is no defined, runnable kit — so agnosticism is asserted, not proven. The audit's recommended actions repeatedly converge on "add a contract-test." Process gap **G1** identified this as the highest-leverage missing piece. How is conformance established?

### Decision Drivers
- Make agnosticism objective and repeatable, not a claim.
- A single suite, many adapters (the §3 swap-safety promise).
- Encode each port's guarantees (and the ADR `Confirmation` clauses) as executable checks.

### Considered Options
1. **Define a Technology Compatibility Kit (TCK): one shared, runnable conformance suite per port; "an adapter is done" = it passes the TCK.** Each ADR `Confirmation` clause becomes a TCK case.
2. **Per-adapter ad hoc tests** authored independently.
3. **Manual review** of each adapter against the contracts.

### Decision Outcome
Chosen: **Option 1**. The project maintains a per-port TCK asserting the documented guarantees (redelivery-after-worker-death, ack-isolation, dedup-atomicity, outbox-atomicity-under-crash, orchestration-capability-without-replay-assumption, duplicate-occurrence-suppression, …). An adapter's definition of done is a green TCK run. New ADR `Confirmation` clauses are added as TCK cases.

### Pros and Cons of the Options
- **Option 1** — *Pros:* objective conformance; swap-safety proven; ties decisions to checks; onboarding a backend has a finish line. *Cons:* the kit is real engineering to build and maintain.
- **Option 2** — *Pros:* quick per adapter. *Cons:* divergent coverage; no shared guarantee; agnosticism unproven.
- **Option 3** — *Pros:* no test infrastructure. *Cons:* not repeatable; regressions invisible; subjective.

### Confirmation
Every port has a TCK; at least one adapter per supported backend class passes it in CI; each accepted ADR's `Confirmation` clause maps to a TCK case.

### Refs
`PROCESS-GAP-AUDIT.md` §G1 and consolidated action 14; `ARCHITECTURE.md` §13.1. Underpins [[ADR-002]], [[ADR-012]], [[ADR-013]], [[ADR-014]], [[ADR-016]].
