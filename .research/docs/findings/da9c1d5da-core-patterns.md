---
id: da9c1d5da
topic: patterns
title: Core transactional and resilience patterns for distributed jobs
status: draft
shape: survey
---

# Core transactional and resilience patterns for distributed jobs

**Scope.** The canonical design patterns a generic job system must implement, from
microservices.io (Chris Richardson) and the AWS Builder Library. Two families:
transactional-messaging patterns (cross-service consistency) and resilience patterns
(failure handling).

## Key claims (cited)

### Transactional messaging
- **Saga.** Implement a business transaction spanning multiple services as **a sequence of
  local transactions**, where each local transaction updates the database and **publishes a
  message or event to trigger the next** local transaction in the saga [cb07c0c51].
- **Transactional Outbox.** To update business entities *and* send messages atomically, **store
  the message in the database as part of the same transaction**, and a **separate process then
  sends the messages** to the broker — solving the dual-write problem [c3242780f].
- **Event Sourcing.** **Persist the state of a business entity as a sequence of
  state-changing events**; whenever state changes, a new event is appended [c6b9ea514].
- **CQRS.** Support queries with a **read-only view ('replica') database** kept up to date by
  **subscribing to domain events** published by the owning service [c9c48a59f].

### Resilience
- **Timeouts, retries, backoff + jitter.** **Timeouts keep systems from hanging** unreasonably
  long, retries mask transient failures, and you **add jitter** (where it doesn't hurt UX) to
  spread retry load [c2d3133e6].
- **Queue-backlog avoidance.** Queue-based systems must be designed to avoid **insurmountable
  queue backlogs** — backlog is a first-class failure mode to measure and manage [c519b593f].

## Convergent vs contested

- **Convergent:** These patterns are the **building blocks the rest of the catalog implements**.
  Event Sourcing is the same append-only model as the Write-Ahead Log (education finding) and
  durable-execution event history; Saga is the orchestration story behind Step Functions /
  Temporal; Outbox + at-least-once is how a job is enqueued atomically with a state change;
  backoff+jitter and backlog management are the reliability/observability disciplines made
  concrete.
- **Contested / tradeoffs:** Saga (orchestration vs choreography) and CQRS/Event Sourcing add
  real complexity (eventual consistency, event versioning) — they pay off for cross-service
  consistency but are not free; the Outbox is the lower-cost default for atomic enqueue.

## Implications for the system

- Make the **Transactional Outbox the default enqueue mechanism** (atomic "update state +
  enqueue job"), since every broker/scheduler is at-least-once and dual-writes otherwise lose
  messages.
- Offer **Saga** for multi-step cross-service jobs, **Event Sourcing** for the durable job
  lifecycle log, and bake **timeouts + capped retries with jitter** and **backlog metrics**
  into the core, not into each caller.

## Gaps found → re-scan
- API Composition, messaging, and the AWS "avoiding fallback" / "workflow state machines" patterns — in-corpus, not synthesized here.
- Idempotency-key + dedup-store implementation to pair with at-least-once delivery.
- Saga orchestration-vs-choreography decision criteria and event-versioning strategy.
