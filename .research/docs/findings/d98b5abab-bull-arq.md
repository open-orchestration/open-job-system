---
id: d98b5abab
topic: task-queues
title: "Redis-backed job queues: Bull and arq"
status: draft
shape: comparison
---

# Redis-backed job queues: Bull and arq

Bull and arq are both Redis-backed job queues, but target different runtimes:
Bull is a Node.js library whose `Queue` constructor "creates a new Queue that is
persisted in Redis" [ce5f329e8], while arq provides "Job queues and RPC in python
with asyncio and redis" [c5ebfb6d8].

## Bull (Node.js)

**What it is / backend.** A Bull `Queue` is persisted in Redis, and "Everytime
the same queue is instantiated it tries to process all the old jobs that may
exist from a previous unfinished session" [ce5f329e8]. The optional `url`
argument "allows to specify a redis connection string" such as
`redis://mypassword@myredis.server.com:1234`, and `RedisOpts` are passed directly
to the ioredis constructor [ce5f329e8].

**Job/queue model.** `Queue#add` "Creates a new job and adds it to the queue. If
the queue is empty the job will be executed directly, otherwise it will be placed
in the queue and executed as soon as possible" [ce5f329e8]. An optional `name`
(also called job type) can be added so that "only process functions defined for
that name will process the job" [ce5f329e8]. A processing function is defined with
`Queue#process`, and "The callback is called everytime a job is placed in the
queue" [ce5f329e8].

**Delayed/scheduled jobs.** The `delay` job option is "An amount of miliseconds
to wait until this job can be processed" [ce5f329e8]. The advanced setting
`guardInterval` (default `5000`) is the "Poll interval for delayed jobs and added
jobs," described as the interval "on which the delayed job watchdog will run"
[ce5f329e8]. When running multiple concurrent workers with delayed tasks, "the
default value of `guardInterval` will cause spikes on network bandwidth, cpu usage
and memory usage" because "Each concurrent worker will run the delayed job
watchdog," and the docs advise raising it, e.g. `guardInterval =
numberOfWorkers*5000` [ce5f329e8]. A delayed job can be moved forward manually:
`Job#promote` "Promotes a job that is currently 'delayed' to the 'waiting' state
and executed as soon as possible" [ce5f329e8]. Recurring jobs use the `repeat`
option, which repeats a job "according to a cron specification" [ce5f329e8].

**Retries and concurrency.** The `attempts` option is "The total number of
attempts to try the job until it completes," and `backoff` is the "Backoff setting
for automatic retries if the job fails," whose type "can be either `fixed` or
`exponential`" [ce5f329e8]. Concurrency is set on the processor: "You can specify
a `concurrency` argument. Bull will then call your handler in parallel respecting
this maximum value," and "Concurrency defaults to 1 if not specified" [ce5f329e8].
For named processors in one queue, "concurrency stacks up" [ce5f329e8].

**Uniqueness.** The `jobId` option can "Override the job ID," and "If you use this
option, it is up to you to ensure the jobId is unique. If you attempt to add a job
with an id that already exists, it will not be added" [ce5f329e8].

**Result handling.** With the `done`-callback signature, "results, as a second
argument to the 'completed' event"; otherwise "a promise must be returned to
signal job completion" and its resolved value "will be the 'completed' event's
second argument" [ce5f329e8]. `Job#finished` "Returns a promise that resolves or
rejects when the job completes or fails" [ce5f329e8]. The `removeOnComplete`
option, "If true, removes the job when it successfully completes," otherwise the
"Default behavior is to keep the job in the completed set" [ce5f329e8].

## arq (Python asyncio)

**What it is / backend.** arq is "Job queues and RPC in python with asyncio and
redis," "conceived as a simple, modern and performant successor to rq"
[c5ebfb6d8]. It is "built using python 3's asyncio allowing non-blocking job
enqueuing and execution," and "Multiple jobs (potentially hundreds) can be run
simultaneously using a pool of asyncio `Tasks`" [c5ebfb6d8]. The Redis connection
is configured via `RedisSettings`, whose default "is to connect to localhost:6379,
no password" [c5ebfb6d8].

**Job/queue model.** arq enqueues "jobs by name rather than 'just calling a
function'," which "means your frontend (calling the worker) doesn't need access to
the worker code, meaning better code separation" [c5ebfb6d8]. Jobs are enqueued
with `enqueue_job`, whose `function` parameter is the "Name of the function to
call" [c5ebfb6d8]. arq uses "pessimistic execution": "jobs aren't removed from the
queue until they've either succeeded or failed. If the worker shuts down, the job
will be cancelled immediately and will remain in the queue to be run again when the
worker starts up again (or run by another worker which is still running)"
[c5ebfb6d8]. Consequently "Jobs may be called more than once!" and arq "favours
multiple times over zero times" [c5ebfb6d8].

**Delayed/scheduled jobs.** "By default, when a job is enqueued it will run as soon
as possible," but jobs can be scheduled to run in the future "either by a given
duration (`_defer_by`) or at a particular time `_defer_until`" [c5ebfb6d8]. The
`_defer_until` parameter is a "datetime at which to run the job" and `_defer_by` is
a "duration to wait before running the job" [c5ebfb6d8]. The `JobStatus.deferred`
state means the "job is in the queue, time it should be run not yet reached"
[c5ebfb6d8]. Periodic scheduling uses cron jobs: "Functions can be scheduled to be
run periodically at specific times," and "Workers will enqueue this job at or just
after the set times" [c5ebfb6d8].

**Retries and concurrency.** Jobs can be retried "by raising the `Retry` exception
from within a job, optionally with a duration to defer rerunning the jobs by,"
and "after max_tries (default 5) the job will permanently fail" [c5ebfb6d8]. The
worker's `max_tries` is the "default maximum number of times to retry a job"
[c5ebfb6d8]. A job can also be aborted via `Job.abort()`, which "will abort a job
if it's already running or prevent it being run if it's currently in the queue,"
though this requires setting `allow_abort_jobs` to `True` on the worker
[c5ebfb6d8]. Concurrency is bounded by the worker's `max_jobs`, the "maximum number
of jobs to run at a time," which defaults to 10 [c5ebfb6d8].

**Uniqueness.** arq "supports this via custom job ids," and "It guarantees that a
job with a particular ID cannot be enqueued again until its execution has finished
and its result has cleared" [c5ebfb6d8]. When a custom `_job_id` is reused while
still active, "the job will not be enqueued and enqueue_job will return None"
[c5ebfb6d8]. The "check of `job_id` uniqueness in the queue is performed using a
redis transaction so you can be certain jobs with the same id won't be enqueued
twice (or overwritten) even if they're enqueued at exactly the same time"
[c5ebfb6d8]. To "control when a finished job's result clears, you can use the
keep_result setting on your worker" [c5ebfb6d8].

**Result handling.** Job information, status, and results are accessed "using the
`arq.jobs.Job` instance returned from `enqueue_job`" [c5ebfb6d8]. `Job.result`
will "Get the result of the job or, if the job raised an exception, reraise it,"
and "waits for the result if it's not yet available and the job is present in the
queue" [c5ebfb6d8]. How long results persist is governed by `keep_result`, the
"default duration to keep job results for," plus `keep_result_forever`, "whether
to keep results forever" [c5ebfb6d8].

## Contrast

Both libraries persist jobs in Redis, but their execution philosophy differs at
shutdown: arq's "pessimistic execution" deliberately keeps a job in the queue to
be "run again when the worker starts up again," accepting that "Jobs may be called
more than once" [c5ebfb6d8], whereas Bull re-attempts old jobs only when "the same
queue is instantiated" and it "tries to process all the old jobs that may exist
from a previous unfinished session" [ce5f329e8].

For delayed jobs, Bull relies on a polling "delayed job watchdog" governed by
`guardInterval`, where "Each concurrent worker will run the delayed job watchdog"
[ce5f329e8]; arq instead times deferral per job via `_defer_by` / `_defer_until`
and tracks a `deferred` status until "the time it should be run" is reached
[c5ebfb6d8].

Uniqueness is opt-in in both, but with different guarantees. In Bull "it is up to
you to ensure the jobId is unique," and a colliding id means the job "will not be
added" [ce5f329e8]. In arq, a custom job ID "cannot be enqueued again until its
execution has finished and its result has cleared," enforced "using a redis
transaction," with a duplicate enqueue returning `None` [c5ebfb6d8].

Concurrency defaults also differ: Bull's per-processor concurrency "defaults to 1
if not specified" [ce5f329e8], while arq runs up to `max_jobs` (default 10)
simultaneously across "a pool of asyncio `Tasks`" [c5ebfb6d8]. Both retry on
failure with a configurable cap, Bull via the `attempts` option with `fixed` or
`exponential` `backoff` [ce5f329e8], and arq via the `Retry` exception bounded by
`max_tries` (default 5) [c5ebfb6d8].
