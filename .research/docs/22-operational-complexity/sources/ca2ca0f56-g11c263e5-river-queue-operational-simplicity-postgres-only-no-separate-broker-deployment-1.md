[Skip to content](https://riverqueue.com/docs#_top)
[ River Docs  ](https://riverqueue.com/)
Search ` `⌘``K` `
Cancel 
Clear
[ ](https://github.com/riverqueue/river)
Theme
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
Theme
On this page Overview 
  * [ Overview ](https://riverqueue.com/docs#_top)
  * [ Prerequisites ](https://riverqueue.com/docs#prerequisites)
  * [ Installation ](https://riverqueue.com/docs#installation)
  * [ Running migrations ](https://riverqueue.com/docs#running-migrations)
  * [ Job args and workers ](https://riverqueue.com/docs#job-args-and-workers)
  * [ Registering workers ](https://riverqueue.com/docs#registering-workers)
  * [ Starting a client ](https://riverqueue.com/docs#starting-a-client)
    * [ Stopping ](https://riverqueue.com/docs#stopping)
  * [ Inserting jobs ](https://riverqueue.com/docs#inserting-jobs)


## On this page
  * [ Overview ](https://riverqueue.com/docs#_top)
  * [ Prerequisites ](https://riverqueue.com/docs#prerequisites)
  * [ Installation ](https://riverqueue.com/docs#installation)
  * [ Running migrations ](https://riverqueue.com/docs#running-migrations)
  * [ Job args and workers ](https://riverqueue.com/docs#job-args-and-workers)
  * [ Registering workers ](https://riverqueue.com/docs#registering-workers)
  * [ Starting a client ](https://riverqueue.com/docs#starting-a-client)
    * [ Stopping ](https://riverqueue.com/docs#stopping)
  * [ Inserting jobs ](https://riverqueue.com/docs#inserting-jobs)


# Getting started
Learn how to install River packages for Go, run migrations to get River's database schema in place, and create an initial worker and client to start inserting and working jobs.
[ ![River Go package docs](https://riverqueue.com/images/badges/go-reference.svg) ](https://pkg.go.dev/github.com/riverqueue/river)
* * *
##  Prerequisites [ ](https://riverqueue.com/docs#prerequisites)
River requires an existing PostgreSQL database, and is most commonly used with [pgx](https://pkg.go.dev/github.com/jackc/pgx/v5). River is tested using the three most recent major versions of PostgreSQL.
##  Installation [ ](https://riverqueue.com/docs#installation)
To install River, run the following in the directory of a Go project (where a `go.mod` file is present):
Terminal window
```


go get github.com/riverqueue/river




go get github.com/riverqueue/river/riverdriver/riverpgxv5


```

Alternatively, the `riverdatabasesql` driver can be used instead of `riverpgxv5` for compatibility with Go's built-in `database/sql`. See [inserting jobs with Bun](https://riverqueue.com/docs/bun) or [GORM](https://riverqueue.com/docs/gorm).
##  Running migrations [ ](https://riverqueue.com/docs#running-migrations)
River persists jobs to a Postgres database, and needs a small set of tables created to insert jobs and carry out [leader election](https://riverqueue.com/docs/leader-election). It's bundled with a command line tool which executes migrations, and which future-proofs River in case other migration steps need to be run in future versions.
From the same directory as above, install the River CLI:
Terminal window
```


go install github.com/riverqueue/river/cmd/river@latest


```

With the `DATABASE_URL` of a target database (looks like `postgres://host:5432/db`), migrate up:
Terminal window
```


river migrate-up --database-url "$DATABASE_URL"


```

See also [migrations](https://riverqueue.com/docs/migrations).
##  Job args and workers [ ](https://riverqueue.com/docs#job-args-and-workers)
Each kind of job in River requires two types: a [`JobArgs`](https://pkg.go.dev/github.com/riverqueue/river#JobArgs) struct and a [`Worker[T JobArgs]`](https://pkg.go.dev/github.com/riverqueue/river#Worker). The `JobArgs` struct has two purposes:
  1. It defines the structured arguments for your worker. These arguments are serialized to JSON before the job is stored in the database.
  2. It defines a `Kind() string` method that will be used to uniquely identify the kind of job in the database.


Here is a simple `Worker` and `JobArgs` setup for a `SortWorker` which will sort and print a list of strings provided in its arguments:

```


type SortArgs struct {




    // Strings is a slice of strings to sort.




    Strings []string `json:"strings"`



}







func (SortArgs) Kind() string { return "sort" }


```


```


type SortWorker struct {




    // An embedded WorkerDefaults sets up default methods to fulfill the rest of




    // the Worker interface:




    river.WorkerDefaults[SortArgs]



}







func (w *SortWorker) Work(ctx context.Context, job *river.Job[SortArgs]) error {




    sort.Strings(job.Args.Strings)




    fmt.Printf("Sorted strings: %+v\n", job.Args.Strings)




    return nil



}

```

Generics 
River utilizes Go generics to simplify your Worker definitions. This means that your worker only needs to deal with fully structured and typed set of arguments. As in the example above, a `Worker` has a 1:1 relationship with the `JobArgs` type it handles.
##  Registering workers [ ](https://riverqueue.com/docs#registering-workers)
Jobs are uniquely identified by their "kind" string. Workers are registered on start up so that River knows how to assign jobs to workers:

```


workers := river.NewWorkers()



// AddWorker panics if the worker is already registered or invalid:



river.AddWorker(workers, &SortWorker{})


```

`AddWorker` panics in case of invalid configuration. Given its succinct syntax and that bad configuration should prevent a worker process from booting, panicking is probably a reasonable compromise for most applications. However, for those who find it distastely, `AddWorkerSafely` is also provided:

```


workers := river.NewWorkers()




if err := river.AddWorkerSafely(workers, &SortWorker{}); err != nil {




    panic("handle this error")



}

```

##  Starting a client [ ](https://riverqueue.com/docs#starting-a-client)
A River [`Client`](https://pkg.go.dev/github.com/riverqueue/river#Client) provides an interface for job insertion and manages job processing and [maintenance services](https://riverqueue.com/docs/maintenance-services). A client is created with a database pool, [driver](https://riverqueue.com/docs/database-drivers), and config struct containing a `Workers` bundle and other settings. Here's a client `Client` working one queue (`"default"`) with up to 100 worker goroutines at a time:

```


dbPool, err := pgxpool.New(ctx, os.Getenv("DATABASE_URL"))




if err != nil {




    // handle error



}







riverClient, err := river.NewClient(riverpgxv5.New(dbPool), &river.Config{




    Queues: map[string]river.QueueConfig{




        river.QueueDefault: {MaxWorkers: 100},




    },




    Workers: workers,



})



if err != nil {




    // handle error



}






// Run the client inline. All executed jobs will inherit from ctx:



if err := riverClient.Start(ctx); err != nil {




    // handle error



}

```

###  Stopping [ ](https://riverqueue.com/docs#stopping)
The client should also be stopped on program shutdown:

```

// Stop fetching new work and wait for active jobs to finish.



if err := riverClient.Stop(ctx); err != nil {




    // handle error



}

```

There are some complexities around ensuring clients stop cleanly, but also in a timely manner. Read [Graceful shutdown](https://riverqueue.com/docs/graceful-shutdown) for more details on River's stop modes.
[Insert-only clients](https://riverqueue.com/docs/insert-only-clients) will insert jobs, but not work them, and don't need to be started or stopped.
##  Inserting jobs [ ](https://riverqueue.com/docs#inserting-jobs)
[`Client.InsertTx`](https://pkg.go.dev/github.com/riverqueue/river#Client.InsertTx) is used in conjunction with an instance of job args to insert a job to work on a transaction:

```


_, err = riverClient.InsertTx(ctx, tx, SortArgs{




    Strings: []string{




        "whale", "tiger", "bear",




    },




}, nil)




if err != nil {




    // handle error



}

```

See the [`InsertAndWork` example](https://pkg.go.dev/github.com/riverqueue/river#example-package-InsertAndWork) for complete code.
[`Client.Insert`](https://pkg.go.dev/github.com/riverqueue/river#Client.Insert) that doesn't take a transaction is also available, although as described in [Transactional enqueuing](https://riverqueue.com/docs/transactional-enqueueing), inserting jobs in transactions is usually more appropriate to avoid bugs.

```


_, err = riverClient.Insert(ctx, SortArgs{




    Strings: []string{




        "whale", "tiger", "bear",




    },




}, nil)




if err != nil {




    // handle error



}

```

See also [Batch job insertion](https://riverqueue.com/docs/batch-job-insertion). Next 
     [ Migrations ](https://riverqueue.com/docs/migrations)

