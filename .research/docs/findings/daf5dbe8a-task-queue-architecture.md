---
id: daf5dbe8a
topic: task-queues
title: Task queue architecture across ecosystems
status: draft
shape: survey
---

# Task queue architecture across ecosystems

**Scope.** The shared worker+broker model and where ecosystems diverge, from the catalog's
task-queue sources. Drawn from a representative spread (Celery, BullMQ, JobRunr, River,
Dramatiq); the corpus holds ~40 task-queue sources, so engines not cited here (Sidekiq, RQ,
Asynq, Huey, pg-boss, …) remain to be synthesized.

## Key claims (cited)

- The canonical model is a **task queue distributing units of work across threads or
  machines**: the input is a "task," dedicated worker processes continuously monitor queues
  for new work, and the system communicates via messages using a **broker** that mediates
  between clients and workers — multiple workers and brokers give high availability and
  horizontal scaling (Celery) [c7710d098]. Celery is written in Python but the protocol can
  be implemented in any language, with clients for Node, Go, Rust, and PHP [c7710d098].
- Retrying failing jobs is a first-class concern: BullMQ provides **built-in backoff
  strategies** plus **custom back-off strategies** for jobs that fail during processing
  [cefe4d862].
- The host-language idiom varies. JobRunr expresses background jobs as **Java 8 lambdas**,
  enqueued three ways (a lambda, a `JobRequest`, or a `JobBuilder`) [c536273f7]. Dramatiq
  defines background work as **actors** — an ordinary function decorated with
  `@dramatiq.actor` — running against a RabbitMQ broker [cc23533ba].
- The backing store splits the field. River is Postgres-backed and centers its core concepts
  on **job retries, writing reliable workers, and transactional enqueueing**, and supports
  cross-language enqueueing from Python, Ruby, SQL, and TypeScript [c250479ba].

## Convergent vs contested

- **Convergent:** Every engine implements the same abstraction — client enqueues a task → a
  broker/store holds it → dedicated workers pull and execute — and treats retry/backoff as a
  built-in. The differences are surface idiom (decorator vs lambda vs builder) over a shared core.
- **Contested / differentiating:** The **broker/store choice** is the real axis — Redis
  (BullMQ), RabbitMQ (Dramatiq; Celery is broker-agnostic), and Postgres (River, which gets
  transactional enqueueing for free). Delivery guarantees and throughput per engine are not
  quantified in these sources.

## Implications for the system

- Model the core as the broker-agnostic **client → broker/store → worker** triple, with
  retry/backoff as a first-class policy, since every engine converges on it.
- Treat the store as a pluggable adapter (Redis / RabbitMQ / Postgres): Postgres buys
  transactional enqueueing, Redis buys latency, RabbitMQ buys routing — the choice is the
  main differentiator, not the task API.

## Gaps found → re-scan
- Per-engine delivery guarantees (at-least-once / exactly-once) and throughput benchmarks.
- Synthesize the uncited corpus engines (Sidekiq, RQ, Asynq, Huey, pg-boss, Graphile Worker, Resque, Machinery, Spring Batch, Quartz).
- Transactional-enqueue (outbox) semantics for Postgres-backed queues vs Redis/RabbitMQ.
