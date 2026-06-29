[Skip to content](https://riverqueue.com/docs/transactional-enqueueing#_top)
[ River Docs  ](https://riverqueue.com/)
Search ` `⌘``K` `
Cancel 
Clear
[ ](https://github.com/riverqueue/river)
  * Introduction
    * [ Getting started ](https://riverqueue.com/docs)
    * [ Migrations ](https://riverqueue.com/docs/migrations)
  * Core Concepts
    * [ Job retries ](https://riverqueue.com/docs/job-retries)
    * [ Writing reliable workers ](https://riverqueue.com/docs/reliable-workers)
    * [ Transactional enqueueing ](https://riverqueue.com/docs/transactional-enqueueing)
  * Guides
    * [ Inserting and working jobs ](https://riverqueue.com/docs/inserting-and-working-jobs)
    * [ Inserting many jobs at once ](https://riverqueue.com/docs/inserting-many-jobs)
    * [ Running the River web UI ](https://riverqueue.com/docs/river-ui)
    * [ Updating River ](https://riverqueue.com/docs/updating-river)
    * [ Using with Bun ](https://riverqueue.com/docs/bun)
    * [ Using with GORM ](https://riverqueue.com/docs/gorm)
    * [ Using with SQLite ](https://riverqueue.com/docs/sqlite)
    * [ Using an alternate schema ](https://riverqueue.com/docs/alternate-schema)
  * Features
    * [ Batching Pro ](https://riverqueue.com/docs/pro/batching)
    * [ Cancelling jobs ](https://riverqueue.com/docs/cancelling-jobs)
    * [ Concurrency limits Pro ](https://riverqueue.com/docs/pro/concurrency-limits)
    * [ Getting the client within workers ](https://riverqueue.com/docs/context-client)
    * [ Dead letter queue Pro ](https://riverqueue.com/docs/pro/dead-letter-queue)
    * [ Durable periodic jobs Pro ](https://riverqueue.com/docs/pro/durable-periodic-jobs)
    * [ Encrypted jobs Pro ](https://riverqueue.com/docs/pro/encrypted-jobs)
    * [ Ephemeral jobs Pro ](https://riverqueue.com/docs/pro/ephemeral-jobs)
    * [ Error and panic handling ](https://riverqueue.com/docs/error-handling)
    * [ Job-persisted logging ](https://riverqueue.com/docs/job-logging)
    * [ Multiple queues ](https://riverqueue.com/docs/multiple-queues)
    * [ Pausing queues ](https://riverqueue.com/docs/pausing-queues)
    * [ Per-queue job retention Pro ](https://riverqueue.com/docs/pro/per-queue-job-retention)
    * [ Periodic and cron jobs ](https://riverqueue.com/docs/periodic-jobs)
    * [ Recorded output ](https://riverqueue.com/docs/recorded-output)
    * [ Resumable jobs ](https://riverqueue.com/docs/resumable-jobs)
    * [ Scheduled jobs ](https://riverqueue.com/docs/scheduled-jobs)
    * [ Sequences Pro ](https://riverqueue.com/docs/pro/sequences)
    * [ Snoozing jobs ](https://riverqueue.com/docs/snoozing-jobs)
    * [ Subscriptions ](https://riverqueue.com/docs/subscriptions)
    * [ Test helpers ](https://riverqueue.com/docs/testing)
    * [ Transactional job completion ](https://riverqueue.com/docs/transactional-job-completion)
    * [ Unique jobs ](https://riverqueue.com/docs/unique-jobs)
    * [ Work functions ](https://riverqueue.com/docs/work-functions)
    * [ Workflows Pro ](https://riverqueue.com/docs/pro/workflows)
  * River Pro
    * [ About River Pro ](https://riverqueue.com/docs/pro)
    * [ Getting started ](https://riverqueue.com/docs/pro/getting-started)
    * [ Go package docs ](https://riverqueue.com/pkg/riverpro)
    * [ Changelog ](https://riverqueue.com/docs/pro/changelog)
    * [ Installing private Go modules ](https://riverqueue.com/docs/pro/go-proxy)
    * [ Pro migrations ](https://riverqueue.com/docs/pro/migrations)
    * [ Dependency updates ](https://riverqueue.com/docs/pro/dependency-updates)
  * Cross-language enqueueing
    * [ Inserting jobs from Python ](https://riverqueue.com/docs/python)
    * [ Inserting jobs from Ruby ](https://riverqueue.com/docs/ruby)
    * [ Inserting jobs from SQL ](https://riverqueue.com/docs/sql)
    * [ Inserting jobs from TypeScript ](https://riverqueue.com/docs/typescript)
  * Advanced
    * [ Benchmarks ](https://riverqueue.com/docs/benchmarks)
    * [ Changing job args safely ](https://riverqueue.com/docs/changing-job-args)
    * [ Database drivers ](https://riverqueue.com/docs/database-drivers)
    * [ Graceful shutdown ](https://riverqueue.com/docs/graceful-shutdown)
    * [ Hooks ](https://riverqueue.com/docs/hooks)
    * [ In-memory queue ](https://riverqueue.com/docs/in-memory-queue)
    * [ Insert-only clients ](https://riverqueue.com/docs/insert-only-clients)
    * [ Leader election ](https://riverqueue.com/docs/leader-election)
    * [ Middleware ](https://riverqueue.com/docs/middleware)
    * [ Maintenance services ](https://riverqueue.com/docs/maintenance-services)
    * [ OpenTelemetry ](https://riverqueue.com/docs/open-telemetry)
    * [ PgBouncer ](https://riverqueue.com/docs/pgbouncer)
    * [ Renaming jobs ](https://riverqueue.com/docs/renaming-jobs)


[GitHub](https://github.com/riverqueue/river)
On this page Overview 
  * [ Overview ](https://riverqueue.com/docs/transactional-enqueueing#_top)
  * [ Failures with two primary stores ](https://riverqueue.com/docs/transactional-enqueueing#failures-with-two-primary-stores)
    * [ Enqueue after transaction ](https://riverqueue.com/docs/transactional-enqueueing#enqueue-after-transaction)
    * [ Enqueue before transaction completes? ](https://riverqueue.com/docs/transactional-enqueueing#enqueue-before-transaction-completes)
  * [ A simpler model ](https://riverqueue.com/docs/transactional-enqueueing#a-simpler-model)


## On this page
  * [ Overview ](https://riverqueue.com/docs/transactional-enqueueing#_top)
  * [ Failures with two primary stores ](https://riverqueue.com/docs/transactional-enqueueing#failures-with-two-primary-stores)
    * [ Enqueue after transaction ](https://riverqueue.com/docs/transactional-enqueueing#enqueue-after-transaction)
    * [ Enqueue before transaction completes? ](https://riverqueue.com/docs/transactional-enqueueing#enqueue-before-transaction-completes)
  * [ A simpler model ](https://riverqueue.com/docs/transactional-enqueueing#a-simpler-model)


# Transactional enqueueing
Transactional enqueueing is a key benefit of River. This model avoids several common failure modes of background jobs in a distributed application. It reduces the time spent investigating or engineering around distributed systems edge cases, and results in a simpler architecture.
* * *
##  Failures with two primary stores [ ](https://riverqueue.com/docs/transactional-enqueueing#failures-with-two-primary-stores)
The alternative to River's approach of putting a job queue in your main database is the traditional model of having two data stores — a primary database and a secondary store like Redis where jobs are enqueued. While largely functional, the two store approach can lead to data loss on the edges that's nearly impossible to fully reconcile.
###  Enqueue after transaction [ ](https://riverqueue.com/docs/transactional-enqueueing#enqueue-after-transaction)
Imagine building a user signup flow. The frontend submits an email and password to the backend application's `POST /users` route. This request opens a database transaction to insert the user record into Postgres, which completes successfully. Then the backend application attempts to enqueue a job in Redis to send a welcome email to the user. ️⚡️ _**Zap!—the server just lost power.**_ ⚡ ️ That user will never receive a signup confirmation email.
This chain of events might sound familiar to any seasoned backend developer. If it's not a power loss, it could be a program panic, a network interruption, or any number of other failure modes that are possible when coordinating between two independent data stores (Postgres and Redis).
While such events may sound unlikely, in practice they turn out to be a regular frustration, especially at nontrivial scale.
###  Enqueue before transaction completes? [ ](https://riverqueue.com/docs/transactional-enqueueing#enqueue-before-transaction-completes)
In previous example, the developer tried to enqueue the job _after_ the primary database transaction completed. This ensured that the database changes were committed _atomically_ (all at once or none at all), but it left open the possibility of the subsequent jobs being enqueued. What if the developer tried the opposite approach, and enqueued the job in Redis before the Postgres transaction commits?
Naturally, this developer also built their Redis job worker in Go. Because their worker is so fast, so it managed to pick up the new job in only a couple a milliseconds. As the worker queries the database to load the user record from the database by its ID, they hit an error — it seems the user does not exist in the database yet.
The diligent developer notices an error in their exception tracker and immediately digs in. They are puzzled to see that the `POST /users` request was successful, yet somehow their worker could not find the user record in the database. How could that be?
The answer is that the job was fetched from the Redis queue _before_ the Postgres database transaction committed the new user record, and thanks to rules around transaction visibility, the worker could not yet see that row when it queried for it. Or maybe the API encountered a subsequent error which caused the transaction to rollback and the user record was never actually committed. Or maybe the server encountered another power failure before it could commit.
##  A simpler model [ ](https://riverqueue.com/docs/transactional-enqueueing#a-simpler-model)
Transactional enqueueing solves all of the above problems, and it does so without needing to operate an additional service outside the primary Postgres database. When you enqueue a job in River, you can do so in a transaction with any other changes you're making such as inserting a user record or adding a corresponding profile record. This means that when a worker picks up a job, it can rely on the fact that any data it depends on was already committed along with the job itself.
When you build your system around transactional enqueueing, you spend less time tracking down and patching around distributed systems edge cases and more time focusing on building what matters. In the past this model was held back by poor implementations or Postgres limitations, but this is no longer the case: a modern Postgres job queue can easily scale to tens of thousands of jobs per second.
We believe this should be the default model for building reliable systems, appropriate for all but the very largest applications. Previous 
     [ Writing reliable workers ](https://riverqueue.com/docs/reliable-workers) Next 
     [ Inserting and working jobs ](https://riverqueue.com/docs/inserting-and-working-jobs)

