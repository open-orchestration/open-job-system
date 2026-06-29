---
id: d7c5d5a95
topic: throughput
title: 'Throughput characteristics across Sidekiq, Celery, Temporal, and River'
status: draft
shape: comparison
---

# Throughput characteristics across Sidekiq, Celery, Temporal, and River

**Scope.** This finding covers sustained throughput — jobs/tasks/workflows processed
per second — and, more importantly, the architectural factors that drive it: the
concurrency model, prefetch/batch behaviour, and the backing store. Entities with
usable sources are **Sidekiq**, **Celery**, **Temporal**, and **River**. **BullMQ is
abstained**: no primary throughput source survived filtering (the only results were
vendor/promotional), so no BullMQ throughput figure is stated here — fabricating one
would be worse than the gap. Throughout, headline numbers are treated as secondary to
the qualitative architecture, because most of the available numbers come with heavy
measurement caveats (and one of the most-cited River-relevant numbers is a vendor's
benchmark of its own product, not of River).

## Sidekiq — thread-per-process over Redis

Sidekiq's throughput model is threads inside a Ruby process pulling jobs from queues
that live in Redis. The maintainer's own scaling guide states the architecture "makes
it easy to scale up to thousands of jobs per second and millions of jobs per day," and
that scaling "can simply be a matter of 'adding more servers'" [c7d59cf55]. The core
lever is **concurrency** — "the number of threads available to a single Sidekiq
process" — and jobs are stored in Redis queues processed oldest-first (FIFO)
[c7d59cf55]. Each process also holds a database connection pool and a Redis connection
pool shared across its threads [c7d59cf55]. The recommended starting point is **five
threads per process, which is the Sidekiq default**; the guide warns that many teams
get "too ambitious" with concurrency and saturate CPU, slowing all jobs, and advises
finding the sweet spot where CPU is "high but not 100%" [c7d59cf55].

A hard ceiling on per-process throughput is the GIL: GitLab's operations docs note that
Sidekiq "starts one worker process and only uses a single core," that its threads "run
inside a single Ruby process, and each process can only use a single CPU core," so the
way to use more cores is to run multiple processes — at most equal to the number of CPU
cores dedicated to Sidekiq [cf1e5048d]. GitLab's default is "a number of threads that
equals the number of queues, plus one spare thread, up to a maximum of 50," and it
recommends typical concurrency from "5 for highly CPU-bound tasks to 15 or higher for
mixed low-priority work," with 15–25 a reasonable non-specialized range [cf1e5048d].
Threading only helps when work waits on external dependencies like database queries or
HTTP requests [cf1e5048d]. No conditioned per-second benchmark number is stated here:
the only quantified Sidekiq figures found came from a personal blog whose provenance is
too weak to carry a load-bearing throughput number, so they are deliberately omitted.

## Celery — prefork concurrency with broker prefetch

Celery's throughput is governed by two knobs: the concurrency pool and the prefetch
multiplier. The default pool is **prefork**, described in the official docs as "ideal
for CPU-bound tasks and most use cases"; `eventlet` and `gevent` use greenlets for
"high concurrency" on IO-bound work, `solo` runs tasks sequentially in the main thread,
and a `threads` pool is also available [cadab39c9]. Pool size is the `worker_concurrency`
setting (the `-c` option) [c3cc70cd6].

Prefetch is the throughput-critical second knob. The official optimizing guide defines
the prefetch limit as "a limit for the number of tasks (messages) a worker can reserve
for itself," and states the worker's default prefetch count is the
`worker_prefetch_multiplier` **multiplied by the number of concurrency slots**
[c3cc70cd6]. The trade-off is explicit: for many long-duration tasks the multiplier
should be **one** (reserve one task per process at a time), but "if you have many
short-running tasks, and throughput/round trip latency is important to you, this number
should be large," because "the worker is able to process more tasks per second if the
messages have already been prefetched, and is available in memory" [c3cc70cd6]. A
community Q&A corroborates that the multiplier's default is 4 and that setting it to 0
means "no specific limit" (unlimited) rather than disabling prefetch, with prefetching
improving performance by avoiding a broker round-trip per message [cab7b5230]. Celery's
own guidance also frames throughput as a capacity-planning problem rather than a single
number: "there's a limit to how much data a system can process in a timely manner," and
if a task takes 10 minutes while 10 new tasks arrive per minute, "the queue will never
be empty" [c162af10e]; transient (non-durable) queues are offered as a way to "improve
performance" by skipping the broker's disk writes [c162af10e]. No raw tasks/sec figure
is asserted — the sources give the levers, not a measured rate.

## Temporal — task-queue polling, throughput measured as state transitions

Temporal deliberately does **not** use workflows-per-second as its throughput metric.
Its engineering blog explains that "Workflows in Temporal can vary enormously between
different use cases, so this turns out to not be a very useful metric," and instead
adopts **State Transitions per second** as the throughput measure [ccee53635]. A
Temporal cluster is split into Frontend, History, Matching, and Worker services, with
the Matching service routing tasks to workers and the History service managing workflow
execution history [c3436cdfc][ccee53635]. Scale comes from **shards (partitions)** that
divide a namespace's workflow histories across History pods: the development default is
4 shards, Temporal "recommends that small production clusters use 512 shards," and "it
is rare for even large Temporal clusters to go beyond 4,096 shards" [ccee53635].

The dominant throughput bottleneck is persistence. Temporal "is designed to be
horizontally scalable, so it is almost always the case that it can be scaled to the
point that the persistence" database is the limit, and the blog's stated goal is to
keep the persistence DB "at or below 80% CPU" [ccee53635] — its load-test rig used a
MySQL instance with 4 CPU cores and 32 GB RAM, with two pods per Temporal service
[ccee53635]. An independent engineering write-up reinforces this: testing with k6 at
100 virtual users, a single PostgreSQL instance serving both persistence and visibility
"quickly proved inadequate" — "even with small event bursts of around 100 RPS, the load
on the PostgreSQL instance spiked beyond 120, leading to failures," after which the team
separated concerns onto Cassandra (persistence) and Elasticsearch (visibility) for "the
best throughput and scalability," and found scaling "depends heavily on the number of
shards and configured concurrency limits" [c3436cdfc]. Both Temporal sources are
attributed engineering content (one vendor, one independent); neither publishes a clean
unconditioned state-transitions/sec headline, so none is restated here.

## River — Postgres-backed batch enqueue and polled fetch

River's throughput architecture is its use of Postgres as the queue. An independent
audit of a River benchmark harness documents that River exposes a bulk-insert API,
`client.InsertManyFast()`, which "is the documented bulk-insert API for River (wraps
Postgres COPY)" — i.e. producers batch enqueues through Postgres's COPY path rather than
single-row inserts [cca599229]. Workers fetch by polling: River's configuration exposes
`FetchCooldown` and `FetchPollInterval`, whose documented defaults the audit notes are
"much longer" than the 50 ms the benchmark used [cca599229]. The audit also flags that a
`PRODUCER_BATCH_MAX` default of 1 (single-row inserts) "is intentionally conservative
and will under-measure bulk-insert throughput vs. batched production at higher rates"
[cca599229] — a useful caution that River's headline throughput depends entirely on
whether the bulk/COPY path is exercised.

For a measured per-second figure, **River is effectively abstained**. An independent
PostgreSQL-queue benchmark (postgres-ai) does place River side-by-side with PgQue, PgQ,
PGMQ, Que, and pg-boss "under identical hardware and workload conditions" on a Hetzner
CAX31 box, but the source is a 3-hour **validation run** description that states the
goal without publishing River's throughput result [c72a3f924] — so no River number is
taken from it. The most-quoted number in this architecture class comes from a **vendor
benchmark** by DBOS of its own Postgres-backed durable execution, not of River, and must
be read as promotional and conditioned accordingly: on an AWS RDS `db.m7i.24xlarge`
(96 vCPUs, 384 GB RAM, 120K provisioned IOPS on an io2 volume), DBOS reports a single
Postgres server sustaining "up to 144K writes per second," "up to 43K workflows per
second" for direct durable workflows (two writes each), and "up to 12.1K queued
workflows per second" once the queue path adds four Postgres writes per workflow
[ce4944f95]. DBOS attributes the queue-path bottleneck not to the WAL but to "lock
contention in the workflow_status table," because all clients enqueue to or dequeue from
"the same few rows at the head of the queue" despite `SKIP LOCKED`, and reports that
distributing work across multiple queues or partitions raises maximum throughput with
diminishing returns [ce4944f95]. This is a credible illustration of how a Postgres-
backed queue like River scales and where it stalls (head-of-queue row contention, mitigated
by batching and partitioning) — but the absolute numbers are DBOS's product benchmark on
high-end hardware, **not a River measurement**, and should not be quoted as River's
throughput.

## Cross-engine summary

The defensible comparison is architectural, not numeric. Sidekiq scales by adding
threads (default 5/process) and processes (one core each) against Redis, with the GIL
capping per-process CPU use [c7d59cf55][cf1e5048d]. Celery scales by pool choice
(prefork default) and a prefetch multiplier that trades latency for per-second
throughput on short tasks [cadab39c9][c3cc70cd6]. Temporal scales horizontally until the
persistence database becomes the bottleneck, measuring throughput as state transitions/
sec and tuning shard count to relieve contention [ccee53635][c3436cdfc]. River scales by
batching enqueues through Postgres COPY and polling for fetch, inheriting Postgres's
write-throughput ceiling and head-of-queue lock contention [cca599229][ce4944f95]. The
only clean per-second numbers in the corpus are DBOS's vendor benchmark of its own
Postgres queue (12.1K queued workflows/sec on a 96-vCPU RDS box) [ce4944f95] and
Sidekiq's maintainer's qualitative "thousands of jobs per second" [c7d59cf55]; every
other engine's number is either absent, conditioned away, or sourced too weakly to
carry — and BullMQ has no primary source at all.
