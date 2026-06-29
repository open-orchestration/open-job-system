---
id: d77e4ce35
topic: task-queues
title: 'Task queue engines in depth: configuration, retries, scheduling, and per-engine design'
status: draft
shape: survey
---

# Task queue engines in depth: configuration, retries, scheduling, and per-engine design

**Scope.** This is a deepening sibling to the existing task-queue architecture finding
(`daf5dbe8a`), which synthesized the shared worker+broker model from five sources. Here we
expand source coverage into the *mechanism* layer — concrete configuration keys, retry and
error-handling knobs, acknowledgement/delivery semantics, scheduling and periodic tasks,
rate-limiting, and flow/canvas primitives — and across the broader engine landscape (arq,
asynq, bee-queue, db-scheduler, graphile-worker, huey, resque, agenda) the sibling left
unsynthesized. It draws only on primary engine docs/wikis not cited by `daf5dbe8a`. **Not
covered:** quantified throughput benchmarks, the managed-cloud primitives, workflow-orchestration
engines (Airflow/Temporal), and pg-boss (its corpus capture is navigation chrome only, with no
load-bearing body text, so it is abstained on here).

## Job definition and enqueue idioms

The host-language surface differs sharply even though the core enqueue→store→worker triple is
shared. **Sidekiq** jobs are Ruby classes that `include Sidekiq::Job`, runnable under Rails or
plain Ruby [c5fa7504c]. **RQ** needs no special decorator at all — "any Python function call can
be put on an RQ queue" via `q.enqueue(count_words_at_url, 'http://nvie.com')`, and queues are
typically named after priorities (`high`, `medium`, `low`) [c827016e6]. **Celery** exposes a
uniform "Calling API": `apply_async(args, kwargs)` sends a task message, `delay(*args, **kwargs)`
is its shortcut, and execution options include `countdown` (seconds into the future), `eta` (a
`datetime`), and `expires` [cb1edef8d]. **BullMQ** controls a queue with the `Queue` class
(`new Queue('Cars')`), where "a Queue is nothing more than a list of jobs waiting to be
processed" that can double as a message broker [ceac7ded8]; a `Worker` is the receiver, its
*process function* is asynchronous, and a job moves to `completed` on success or `failed` if the
process throws [c6259762b]. **Resque** marks a class's queue with a `@queue` instance variable
and enqueues via `Resque.enqueue(Archive, ...)` against Redis [c2d724def]. **huey** turns
functions into tasks with `@huey.task()` and `@huey.periodic_task(...)` decorators executed by a
consumer [c3f216354].

## Retry and error-handling knobs

Retry policy is where per-engine configuration is richest. **Sidekiq** controls retries through
`sidekiq_options`: the default is 25 retries, `retry: 5` caps the count, `retry: false` discards a
failed job immediately, `retry: 0` sends it straight to the Dead set, and (as of 7.1.3)
`retry_for: 48.hours` retries for a time window [c5af79a4a]. The delay itself is customizable by
defining `sidekiq_retry_in`, whose block may return an integer delay, `:kill` (send to the
DeadSet), or `:discard` (throw the job away); after exhaustion the `sidekiq_retries_exhausted`
hook fires before the job moves to the **Dead set**, a holding pen limited by default to 10,000
jobs or 6 months [c5af79a4a]. **Celery** raises retries from inside the task with
`self.retry(exc=exc)`, bounded by `max_retries` and spaced by `default_retry_delay`; automatic
retry is declared with `autoretry_for=(SomeError,)` and exponential spacing with `retry_backoff`,
and the task must be `bind=True` to access `self` [c730b6ae6]. **huey** declares retries at the
decorator: `@huey.task(retries=2, retry_delay=60)` retries twice with 60s between attempts
[c3f216354]. **RQ**'s CLI exposes `--retry-max` and `--retry-interval` alongside TTL controls
(`--result-ttl`, `--ttl`, `--failure-ttl`) and `--depends-on` [c827016e6]. **BullMQ** workers
auto-retry failed jobs, the failed/completed transition being driven by whether the process
function throws [c6259762b]. **asynq** lists retries of failed tasks and automatic recovery of
tasks on worker crash as first-class features [c484ea7d7]; **bee-queue** offers "job timeouts,
retries, and retry strategies" [ccc8a1c53].

## Acknowledgement and delivery semantics

Delivery guarantees turn on *when* the message is acknowledged/removed. **Sidekiq** is explicit
that it executes a job **at least once, not exactly once** — "Sidekiq makes no exactly-once
guarantee at all" because Redis can fail between job completion and acknowledgement — so jobs must
be made idempotent and transactional [c09a53b6b]. Its default fetch uses Redis `BRPOP`, which
*removes* the job from Redis, so a crash mid-job loses it; Sidekiq Pro's `super_fetch` instead
uses the Redis `LMOVE` command to keep the job in Redis until complete, with fetch algorithms for
strict ordering or weighted random, enabled together with `reliable_push!` and `reliable_scheduler!`
[c9f5b5376]. **Celery** mirrors this knob with `task_acks_late`: late ack means the message is
acknowledged *after* execution rather than before [c5da9b16b], and because "the task message is
only deleted from the queue after the task is acknowledged," a worker crash lets the message be
redelivered — so reserving one task at a time (a prefetch multiplier of one) trades throughput for
this safety [cdad54cb3]. **Sidekiq** also offers transactional enqueue via
`Sidekiq.transactional_push!`, which only enqueues jobs when the surrounding Active Record
transaction commits (and deliberately doesn't support `push_bulk`) [c85240a45]. **graphile-worker**
gets the same property from Postgres directly: jobs "will not get lost (thanks to Postgres'
transactional guarantees)," each job executes at least once and "most jobs will execute exactly
once" [cb93af587]. **asynq** advertises a guaranteed *at-least-once* execution [c484ea7d7].

## Scheduling and periodic tasks

Recurring work is modeled differently per engine. **Celery** runs periodic tasks through a `beat`
scheduler reading `beat_schedule`, supporting `crontab` schedules and `solar` schedules keyed to
sun events via `solar(event, latitude, longitude)` [ccda30e93]. **BullMQ** replaced "repeatable
jobs" (v5.16.0+) with **Job Schedulers**: `queue.upsertJobScheduler('id', { every: 1000 })` or a
cron `pattern`, acting as a factory that always keeps one job in the `Delayed` status and uses
*upsert* to avoid duplicate recurring definitions [ce0b23aa3]. **arq** defers jobs by duration
(`_defer_by`) or to an absolute time (`_defer_until`) on `enqueue_job` [c5ebfb6d8]. **huey**
schedules with `crontab(...)` via `@huey.periodic_task` and one-off delays via `.schedule(...,
delay=10)` [c3f216354]. **RQ**'s CLI schedules with `--schedule-in` (e.g. `10s`, `5m`, `2d`) and
`--schedule-at` (ISO-8601) [c827016e6]. **db-scheduler** is a Java task-scheduler built as a
clustered `java.util.concurrent.ScheduledExecutorService` "simpler than Quartz," with static and
dynamic recurring tasks; the dynamic variant persists its `Schedule` in `task_data` and is created
with `Tasks.recurringWithPersistentSchedule(..)` [cc2531b1e]. **agenda** schedules via cron or
human-readable syntax with configurable priority, concurrency, repetition and result persistence
[ceb3f1786]. **graphile-worker** offers crontab-like recurring scheduling with optional backfill
[cb93af587].

## Rate limiting, concurrency, and routing

**BullMQ** rate-limits at the worker via a `limiter: { max, duration }` option; the limiter is
**global** across all workers on a queue, and rate-limited jobs "stay in the waiting state." For
dynamic limits (e.g. an upstream API returning `429 Too Many Requests`) the worker calls
`worker.rateLimit(duration)` and throws `Worker.RateLimitError()` [cc2a17911]. **Celery** routes
tasks with `task_routes`, a list of routers consulted in order mapping task names to queues, with
`task_queues` defining `Queue` instances carrying `routing_key`, `exchange`, and
`exchange_type` (e.g. `topic`) [c41c51928] [c5da9b16b]. Celery worker concurrency uses a pool
(prefork or eventlet) and supports remote control commands such as `revoke` and
`revoke_by_stamped_headers` [c7fc72595]. **Sidekiq 7.0** introduced **Capsules** for
single-threaded or serial execution of a queue: `config.capsule("unsafe") { |cap| cap.concurrency
= 1; cap.queues = %w[queue_a queue_b] }`, where queue lists express strict priority (or weighted
with a `,N` suffix) [c85240a45]. **asynq** offers both weighted and strict priority queues
[c484ea7d7]. **BullMQ**'s feature set advertises a polling-free design, LIFO and FIFO jobs,
priorities, delayed jobs, a concurrency setting per worker, threaded (sandboxed) processing
functions, and automatic recovery from process crashes [ca4ee7698].

## Flows, canvas, and workflow primitives

For multi-job composition, **Celery**'s Canvas defines `signature`s combined by primitives:
`group` (run a list of tasks in parallel), `chain` (link signatures so one runs after another),
`chord` (a group with a callback body that runs after the header completes), plus `map`,
`starmap`, and `chunks` (split a long argument list into parts) [c8b1b67f4]. **BullMQ** models
parent-child dependencies as **Flows**: a parent enters the `waiting-children` state until its
children complete, `job.getChildrenValues()` collects child outputs, a `parentKey` links upward,
and removing a parent removes all its children [cdd9c9723]; parent-child dependencies are a
headline BullMQ feature [ca4ee7698]. **asynq** supports aggregating a group of tasks to batch
successive operations [c484ea7d7].

## The broader engine landscape

The catalog's long tail clusters by backing store and design intent. **Redis-backed:** **arq** is
an async Redis queue [c5ebfb6d8]; **asynq** is a Go Redis queue adding de-duplication via a unique
option, per-task timeout/deadline, periodic tasks, and Redis Sentinel high availability
[c484ea7d7]; **bee-queue** is a deliberately small (~1000 LOC) Node/Redis queue built for short,
real-time jobs, contrasting itself with Celery, Resque, Kue, and Bull, which target longer
background jobs and features like prioritization and repeatable jobs that "Bee-Queue currently
does not" [ccc8a1c53]; **resque** is a Redis-backed Ruby library whose workers fork a child
process per job that exits after processing, making them "resilient to memory leaks / bloat"
[c2d724def]; **huey** is a lightweight queue supporting redis/valkey, sqlite, file-system, or
in-memory storage with task locking, rate-limits, and timeouts [c3f216354]. **Postgres-backed:**
**graphile-worker** is Postgres-centric, using `LISTEN`/`NOTIFY` for low latency (typically under
3ms from schedule to execution) and `SKIP LOCKED` to claim jobs, with a customizable retry count
defaulting to 25 attempts over ~3 days [cb93af587]; **db-scheduler** persists tasks in the
database for clustered scheduling [cc2531b1e]. **MongoDB-backed:** **agenda** is a Node job
scheduler defaulting to MongoDB but with a pluggable backend (mongo, postgres, or redis), fork
mode for sandboxed job execution, and real-time notifications via Redis, PostgreSQL `LISTEN/NOTIFY`,
or MongoDB Change Streams [ceb3f1786].

## Convergent vs contested

- **Convergent:** retry-with-backoff, idempotency as the user's responsibility, and a late-ack /
  keep-in-store reliability mode appear almost everywhere — Sidekiq (`super_fetch`), Celery
  (`task_acks_late`), and graphile-worker (Postgres transactions) all implement the same
  at-least-once-with-recovery idea through different substrates [c9f5b5376] [cdad54cb3] [cb93af587].
- **Contested / differentiating:** delivery strength is *not* uniform — Sidekiq explicitly
  disclaims exactly-once [c09a53b6b] while graphile-worker claims "most jobs will execute exactly
  once" off Postgres [cb93af587]. Workflow composition is a real fork: Celery Canvas and BullMQ
  Flows offer rich DAG primitives [c8b1b67f4] [cdd9c9723], whereas minimalist engines like
  bee-queue deliberately omit even job prioritization [ccc8a1c53].

## Gaps found → re-scan
- pg-boss body text was not captured (nav-only) — re-fetch a clean source before citing its
  SKIP-LOCKED / archive design.
- Quartz, Spring Batch, Faktory, Machinery, Dramatiq, and Quartz-style enterprise schedulers in
  the corpus remain unsynthesized at the mechanism level.
- Quantified throughput / latency comparisons across these engines are still absent from the
  cited primary docs (only graphile-worker's "<3ms" self-claim appears).
