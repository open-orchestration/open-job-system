[Skip to content](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#main-content)
Navigation menu [ ![DEV Community](https://media2.dev.to/dynamic/image/quality=100/https://dev-to-uploads.s3.amazonaws.com/uploads/logos/resized_logo_UQww2soKuUsjaOGNB38o.png) ](https://dev.to/)
Search [ Powered by Algolia Search ](https://www.algolia.com/developers/?utm_source=devto&utm_medium=referral)
[ Log in ](https://dev.to/enter?signup_subforem=1) [ Create account ](https://dev.to/enter?signup_subforem=1&state=new-user)
## DEV Community
Close
![](https://assets.dev.to/assets/heart-plus-active-9ea3b22f2bc311281db911d416166c5f430636e76b15cd5df6b3b841d830eefa.svg) 10 Add reaction 
![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg) 2 Like  ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg) 2 Unicorn  ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg) 2 Exploding Head  ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg) 2 Raised Hands  ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg) 2 Fire 
0 Jump to Comments  6 Save  Boost 
More...
Copy link Copy link
Copied to Clipboard
[ Share to X ](https://twitter.com/intent/tweet?text=%22Power%20Up%20Your%20Go%20Apps%3A%20Using%20PostgreSQL%20as%20a%20Job%20Queue%20with%20River%22%20by%20%40shrsv23%20%23DEVCommunity%20https%3A%2F%2Fdev.to%2Fshrsv%2Fpower-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g) [ Share to LinkedIn ](https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fdev.to%2Fshrsv%2Fpower-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g&title=Power%20Up%20Your%20Go%20Apps%3A%20Using%20PostgreSQL%20as%20a%20Job%20Queue%20with%20River&summary=Hi%20there%21%20I%27m%20Shrijith%20Venkatrama%2C%20founder%20of%20Hexmos.%20Right%20now%2C%20I%E2%80%99m%20building%20LiveAPI%2C%20a%20first%20of%20its...&source=DEV%20Community) [ Share to Facebook ](https://www.facebook.com/sharer.php?u=https%3A%2F%2Fdev.to%2Fshrsv%2Fpower-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g) [ Share to Mastodon ](https://s2f.kytta.dev/?text=https%3A%2F%2Fdev.to%2Fshrsv%2Fpower-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g)
[Share Post via...](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g) [Share Post via...](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g) [Report Abuse](https://dev.to/report-abuse)
[![Shrijith Venkatramana](https://media2.dev.to/dynamic/image/width=50,height=50,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.us-east-2.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F1001514%2F17b7d334-44b1-417a-9268-346e6a34988a.jpg)](https://dev.to/shrsv)
[Shrijith Venkatramana](https://dev.to/shrsv)
Posted on Jul 29, 2025 • Edited on Mar 7
![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg) 2 ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg) 2 ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg) 2 ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg) 2 ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg) 2
#  Power Up Your Go Apps: Using PostgreSQL as a Job Queue with River 
[#beginners](https://dev.to/t/beginners) [#programming](https://dev.to/t/programming) [#productivity](https://dev.to/t/productivity) [#go](https://dev.to/t/go)
_Hello, I'm Shrijith. I'm building git-lrc, an AI code reviewer that runs on every commit. It is free, unlimited, and source-available on Github.[Star Us](https://github.com/HexmosTech/git-lrc) to help devs discover the project. Do give it a try and share your feedback for improving the product._
Job queues are a game-changer for handling background tasks in Go applications. 
Let's dive into why and how you can leverage them effectively in your Go projects.ions. If you're building a web app and need to process tasks like sending emails, generating reports, or syncing data without slowing down your API, a job queue is your friend. Enter **River** , a Go library that turns your PostgreSQL database into a robust job queue. No need for Redis or RabbitMQ—your existing Postgres can handle it all.
In this post, we'll walk through setting up **River** with PostgreSQL, creating workers, inserting jobs, and managing them effectively. We'll keep it hands-on with complete, runnable code examples and practical tips to get you started. Let's dive into using River to make your Go apps more scalable and responsive.
##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#why-use-postgresql-as-a-job-queue) Why Use PostgreSQL as a Job Queue? 
PostgreSQL is already a battle-tested database for many Go developers. Using it as a job queue with River has some clear advantages:
  * **No extra infrastructure** : Reuse your existing Postgres database, avoiding the need for additional services like Redis.
  * **Transactional safety** : River leverages Postgres transactions to ensure jobs are enqueued reliably.
  * **Simplicity** : River's Go-native design and use of generics make it intuitive for Go developers.
  * **Scalability** : Handle thousands of jobs with configurable workers and queues.


River is particularly great for apps that already rely on Postgres and want to keep their stack lean. It’s not a one-size-fits-all solution, but if you’re looking to avoid managing another system, it’s worth a look. Check out [River’s documentation](https://riverqueue.com/docs) for more context.
##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#setting-up-river-in-your-go-project) Setting Up River in Your Go Project 
To get started, you need a Go project and a PostgreSQL database. River works seamlessly with the **pgx** driver, but it also supports Go’s `database/sql` for flexibility. Here’s how to set it up.
###  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#step-1-install-river-packages) Step 1: Install River Packages 
Run these commands in your Go project directory (where `go.mod` exists):  


```
go get github.com/riverqueue/river
go get github.com/riverqueue/river/riverdriver/riverpgxv5

```

Enter fullscreen mode Exit fullscreen mode
This pulls in the core River package and the `pgx/v5` driver. If you prefer `database/sql`, you can use `riverdatabasesql` instead, but we’ll stick with `pgx` for this guide.
###  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#step-2-install-the-river-cli) Step 2: Install the River CLI 
River requires a few database tables for job storage and leader election. The River CLI handles migrations for you:  


```
go install github.com/riverqueue/river/cmd/river@latest

```

Enter fullscreen mode Exit fullscreen mode
###  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#step-3-run-migrations) Step 3: Run Migrations 
With your `DATABASE_URL` (e.g., `postgres://user:password@localhost:5432/mydb`), run:  


```
river migrate-up --database-url "$DATABASE_URL"

```

Enter fullscreen mode Exit fullscreen mode
This creates the necessary tables. You can verify by checking your database for tables like `river_job`. If you need to roll back, `river migrate-down` is available, but use it cautiously.
##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#defining-jobs-and-workers) Defining Jobs and Workers 
Every job in River needs two things: a **JobArgs** struct to hold the job’s data and a **Worker** to process it. The `JobArgs` struct defines the job’s arguments and a unique `Kind` identifier, while the `Worker` contains the logic to execute the job.
Here’s an example of a job that sorts a list of strings and prints them:  


```
package main

import (
    "context"
    "fmt"
    "sort"

    "github.com/riverqueue/river"
)

// SortArgs defines the arguments for the sort job.
type SortArgs struct {
    Strings []string `json:"strings"`
}

// Kind returns the unique identifier for this job type.
func (SortArgs) Kind() string { return "sort" }

// SortWorker processes the sort job.
type SortWorker struct {
    river.WorkerDefaults[SortArgs]
}

// Work executes the job, sorting the strings and printing them.
func (w *SortWorker) Work(ctx context.Context, job *river.Job[SortArgs]) error {
    sort.Strings(job.Args.Strings)
    fmt.Printf("Sorted strings: %v\n", job.Args.Strings)
    return nil
}

// Output when running with input ["zebra", "apple", "monkey"]:
// Sorted strings: [apple monkey zebra]

```

Enter fullscreen mode Exit fullscreen mode

```
package main

import (
    "context"
    "fmt"
    "sort"

    "github.com/riverqueue/river"
)

// SortArgs defines the arguments for the sort job.
type SortArgs struct {
    Strings []string `json:"strings"`
}

// Kind returns the unique identifier for this job type.
func (SortArgs) Kind() string { return "sort" }

// SortWorker processes the sort job.
type SortWorker struct {
    river.WorkerDefaults[SortArgs]
}

// Work executes the job, sorting the strings and printing them.
func (w *SortWorker) Work(ctx context.Context, job *river.Job[SortArgs]) error {
    sort.Strings(job.Args.Strings)
    fmt.Printf("Sorted strings: %v\n", job.Args.Strings)
    return nil
}

// Output when running with input ["zebra", "apple", "monkey"]:
// Sorted strings: [apple monkey zebra]

```

Enter fullscreen mode Exit fullscreen mode

```
package main

import (
    "context"
    "fmt"
    "sort"

    "github.com/riverqueue/river"
)

// SortArgs defines the arguments for the sort job.
type SortArgs struct {
    Strings []string `json:"strings"`
}

// Kind returns the unique identifier for this job type.
func (SortArgs) Kind() string { return "sort" }

// SortWorker processes the sort job.
type SortWorker struct {
    river.WorkerDefaults[SortArgs]
}

// Work executes the job, sorting the strings and printing them.
func (w *SortWorker) Work(ctx context.Context, job *river.Job[SortArgs]) error {
    sort.Strings(job.Args.Strings)
    fmt.Printf("Sorted strings: %v\n", job.Args.Strings)
    return nil
}

// Output when running with input ["zebra", "apple", "monkey"]:
// Sorted strings: [apple monkey zebra]

```

Enter fullscreen mode Exit fullscreen mode
**Key points** :
  * The `SortArgs` struct uses JSON tags for serialization.
  * The `Kind` method uniquely identifies the job in the database.
  * The `WorkerDefaults` embed simplifies implementing the `Worker` interface.
  * The `Work` method contains the job’s logic and must return `nil` on success or an error on failure.


##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#registering-workers-with-river) Registering Workers with River 
Before River can process jobs, you need to register your workers. This tells River which workers handle which job kinds. Here’s how to register the `SortWorker`:  


```
package main

import (
    "github.com/riverqueue/river"
)

func registerWorkers() *river.Workers {
    workers := river.NewWorkers()
    river.AddWorker(workers, &SortWorker{})
    return workers
}

```

Enter fullscreen mode Exit fullscreen mode
**Key points** :
  * `AddWorker` panics on invalid configuration, so use it during startup.
  * If you prefer error handling, use `AddWorkerSafely` instead.
  * Register all workers before starting the River client.


##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#starting-a-river-client) Starting a River Client 
The **River Client** manages job insertion and processing. It needs a database connection pool, a driver, and a configuration with queues and workers. Here’s a complete example that sets up a client to process jobs from a “default” queue with up to 100 workers:  


```
package main

import (
    "context"
    "log"
    "os"

    "github.com/jackc/pgx/v5/pgxpool"
    "github.com/riverqueue/river"
    "github.com/riverqueue/river/riverdriver/riverpgxv5"
)

func startRiverClient(ctx context.Context, workers *river.Workers) (*river.Client[riverpgxv5.Driver], error) {
    dbPool, err := pgxpool.New(ctx, os.Getenv("DATABASE_URL"))
    if err != nil {
        return nil, err
    }

    riverClient, err := river.NewClient(riverpgxv5.New(dbPool), &river.Config{
        Queues: map[string]river.QueueConfig{
            river.QueueDefault: {MaxWorkers: 100},
        },
        Workers: workers,
    })
    if err != nil {
        return nil, err
    }

    if err := riverClient.Start(ctx); err != nil {
        return nil, err
    }

    return riverClient, nil
}

func main() {
    ctx := context.Background()
    workers := registerWorkers()
    client, err := startRiverClient(ctx, workers)
    if err != nil {
        log.Fatalf("Failed to start client: %v", err)
    }
    defer client.Stop(ctx)
}

```

Enter fullscreen mode Exit fullscreen mode
**Key points** :
  * Use `pgxpool.New` to create a connection pool.
  * Configure queues with `MaxWorkers` to control concurrency.
  * Call `Start` to begin processing jobs.
  * Always defer `Stop` to ensure graceful shutdown.


For more on shutdown strategies, see River’s [graceful shutdown guide](https://riverqueue.com/docs/graceful-shutdown).
##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#inserting-jobs-into-the-queue) Inserting Jobs into the Queue 
To add jobs to the queue, use the **River Client** ’s `Insert` or `InsertTx` methods. `InsertTx` is preferred because it ensures jobs are enqueued within a transaction, reducing the risk of partial writes. Here’s an example of inserting a sort job:  


```
package main

import (
    "context"
    "log"

    "github.com/jackc/pgx/v5"
    "github.com/riverqueue/river"
    "github.com/riverqueue/river/riverdriver/riverpgxv5"
)

func insertSortJob(ctx context.Context, client *river.Client[riverpgxv5.Driver]) error {
    tx, err := client.DBPool.Begin(ctx)
    if err != nil {
        return err
    }
    defer tx.Rollback(ctx)

    _, err = client.InsertTx(ctx, tx, SortArgs{
        Strings: []string{"zebra", "apple", "monkey"},
    }, nil)
    if err != nil {
        return err
    }

    return tx.Commit(ctx)
}

func main() {
    ctx := context.Background()
    workers := registerWorkers()
    client, err := startRiverClient(ctx, workers)
    if err != nil {
        log.Fatalf("Failed to start client: %v", err)
    }
    defer client.Stop(ctx)

    if err := insertSortJob(ctx, client); err != nil {
        log.Fatalf("Failed to insert job: %v", err)
    }

    // Wait briefly to allow the job to process
    // In a real app, you'd use a more robust synchronization mechanism
    select {
    case <-ctx.Done():
    case <-time.After(2 * time.Second):
    }

    // Output in console:
    // Sorted strings: [apple monkey zebra]
}

```

Enter fullscreen mode Exit fullscreen mode
**Key points** :
  * Use `InsertTx` for transactional safety.
  * Pass `nil` as the last argument unless you need advanced options like priority or queue name.
  * The job is picked up by a worker and processed asynchronously.


##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#managing-queues-and-concurrency) Managing Queues and Concurrency 
River lets you configure multiple queues with different priorities and worker counts. This is useful for separating high-priority tasks (e.g., user notifications) from low-priority ones (e.g., data cleanup). Here’s a table summarizing queue configuration options:  
| Option  | Description  | Example Value  |  
| --- | --- | --- |  
| MaxWorkers  | Max concurrent workers per queue  | 100  |  
| Priority  | Job priority (1 = highest, 4 = lowest)  | 1  |  
| QueueName  | Custom queue name  | "high_priority"  |  
To configure multiple queues, update the client’s config:  


```
package main

import (
    "context"
    "github.com/riverqueue/river"
)

func configureMultiQueue(workers *river.Workers) *river.Config {
    return &river.Config{
        Queues: map[string]river.QueueConfig{
            "high_priority": {MaxWorkers: 50, Priority: 1},
            "low_priority":  {MaxWorkers: 20, Priority: 4},
        },
        Workers: workers,
    }
}

```

Enter fullscreen mode Exit fullscreen mode
**Key points** :
  * Assign jobs to specific queues using the `InsertOpts` struct.
  * Higher `MaxWorkers` values increase throughput but consume more resources.
  * Use priorities to ensure critical tasks are processed first.


##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#handling-errors-and-retries) Handling Errors and Retries 
River automatically retries failed jobs with an exponential backoff. You can customize retry behavior in the `Insert` or `InsertTx` call using `InsertOpts`. Here’s an example of a job that might fail and how to handle retries:  


```
package main

import (
    "context"
    "errors"
    "github.com/riverqueue/river"
)

type RetryArgs struct {
    Attempt int `json:"attempt"`
}

func (RetryArgs) Kind() string { return "retry" }

type RetryWorker struct {
    river.WorkerDefaults[RetryArgs]
}

func (w *RetryWorker) Work(ctx context.Context, job *river.Job[RetryArgs]) error {
    if job.Args.Attempt < 3 {
        return errors.New("simulated failure")
    }
    fmt.Printf("Job succeeded on attempt %d\n", job.Args.Attempt)
    return nil
}

func insertRetryJob(ctx context.Context, client *river.Client[riverpgxv5.Driver]) error {
    _, err := client.Insert(ctx, RetryArgs{Attempt: 1}, &river.InsertOpts{
        MaxAttempts: 5,
    })
    return err
}

// Output after retries:
// Job succeeded on attempt 3

```

Enter fullscreen mode Exit fullscreen mode
**Key points** :
  * Set `MaxAttempts` in `InsertOpts` to control retry limits.
  * River’s default backoff strategy delays retries progressively.
  * Check the `river_job` table in Postgres to monitor job status.


##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#scaling-and-best-practices) Scaling and Best Practices 
To make the most of River in production, consider these tips:
  * **Separate Insert and Worker Processes** : Use insert-only clients in your frontend (e.g., API servers) and dedicated worker processes for job execution. This isolates resource usage.
  * **Monitor Job States** : Query the `river_job` table to track job status (e.g., `completed`, `failed`, `retryable`).
  * **Use Transactions** : Always prefer `InsertTx` over `Insert` to ensure data consistency.
  * **Tune Worker Counts** : Adjust `MaxWorkers` based on your server’s capacity and workload.
  * **Handle Shutdown Gracefully** : Use `client.Stop` to ensure active jobs complete before shutting down.


For advanced use cases, explore River’s [batch insertion](https://riverqueue.com/docs/batch-insert) for enqueuing multiple jobs efficiently.
##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#next-steps-for-your-job-queue-journey) Next Steps for Your Job Queue Journey 
River makes it easy to integrate a job queue into your Go application using PostgreSQL. By leveraging your existing database, you can keep your stack simple while handling background tasksreliably. Start by experimenting with the examples above, then explore advanced features like custom queues, job priorities, and batch inserts.
To go deeper, check out the [River documentation](https://riverqueue.com/docs) for topics like periodic jobs, job timeouts, and observability. If you’re curious about real-world use cases, try implementing River in a small project—like a notification system or a data import pipeline—and see how it fits your needs. With River, you’ve got a powerful tool to make your Go apps more scalable and responsive without the overhead of managing another system.
[![git-lrc](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fyzvpkxm9mga1pweneahx.png)](https://github.com/HexmosTech/git-lrc)   
*AI agents write code fast. They also silently remove logic, change behavior, and introduce bugs -- without telling you. You often find out in production. 
git-lrc fixes this. It hooks into git commit and reviews every diff before it lands. 60-second setup. Completely free.* 
Any feedback or contributors are welcome! It's online, source-available, and ready for anyone to use. 
⭐ Star it on GitHub:   

##  ![GitHub logo](https://assets.dev.to/assets/github-logo-5a155e1f9a670af7944dd5e12375bc76ed542ea80224905ecaf878b9157cdefc.svg) [ HexmosTech ](https://github.com/HexmosTech) / [ git-lrc ](https://github.com/HexmosTech/git-lrc)
###  Free, Unlimited AI Code Reviews That Run on Commit 
| [🇩🇰 Dansk](https://github.com/HexmosTech/git-lrc/readme/README.da.md) | [🇪🇸 Español](https://github.com/HexmosTech/git-lrc/readme/README.es.md) | [🇮🇷 Farsi](https://github.com/HexmosTech/git-lrc/readme/README.fa.md) | [🇫🇮 Suomi](https://github.com/HexmosTech/git-lrc/readme/README.fi.md) | [🇯🇵 日本語](https://github.com/HexmosTech/git-lrc/readme/README.ja.md) | [🇳🇴 Norsk](https://github.com/HexmosTech/git-lrc/readme/README.nn.md) | [🇵🇹 Português](https://github.com/HexmosTech/git-lrc/readme/README.pt.md) | [🇷🇺 Русский](https://github.com/HexmosTech/git-lrc/readme/README.ru.md) | [🇦🇱 Shqip](https://github.com/HexmosTech/git-lrc/readme/README.sq.md) | [🇨🇳 中文](https://github.com/HexmosTech/git-lrc/readme/README.zh.md) |
  
  
[![git-lrc logo](https://camo.githubusercontent.com/948c8f2d5cf41b48985cd364d48c3a2dc9bfbfd42eab3e0a9a1b3e61f5f17ce3/68747470733a2f2f6865786d6f732e636f6d2f66726565646576746f6f6c732f7075626c69632f6c725f6c6f676f2e737667)](https://camo.githubusercontent.com/948c8f2d5cf41b48985cd364d48c3a2dc9bfbfd42eab3e0a9a1b3e61f5f17ce3/68747470733a2f2f6865786d6f732e636f6d2f66726565646576746f6f6c732f7075626c69632f6c725f6c6f676f2e737667)   

# git-lrc
## Free, Unlimited AI Code Reviews That Run on Commit
[![git-lrc - Free, unlimited AI code reviews that run on commit | Product Hunt](https://camo.githubusercontent.com/87bf2d4283c1e0aa99e254bd17fefb1c67c0c0d39300043a243a4aa633b6cecc/68747470733a2f2f6170692e70726f6475637468756e742e636f6d2f776964676574732f656d6265642d696d6167652f76312f746f702d706f73742d62616467652e7376673f706f73745f69643d31303739323632267468656d653d6c6967687426706572696f643d6461696c7926743d31373731373439313730383638)](https://www.producthunt.com/products/git-lrc?embed=true&utm_source=badge-top-post-badge&utm_medium=badge&utm_campaign=badge-git-lrc)
  
[![Go Report Card](https://camo.githubusercontent.com/e74c0651c3ee9165a2ed01cb0f6842c494029960df30eb9c24cf622d3d21bf46/68747470733a2f2f676f7265706f7274636172642e636f6d2f62616467652f6769746875622e636f6d2f4865786d6f73546563682f6769742d6c7263)](https://goreportcard.com/report/github.com/HexmosTech/git-lrc) [![gitleaks.yml](https://github.com/HexmosTech/git-lrc/actions/workflows/gitleaks.yml/badge.svg)](https://github.com/HexmosTech/git-lrc/actions/workflows/gitleaks.yml) [![osv-scanner.yml](https://github.com/HexmosTech/git-lrc/actions/workflows/osv-scanner.yml/badge.svg)](https://github.com/HexmosTech/git-lrc/actions/workflows/osv-scanner.yml) [![govulncheck.yml](https://github.com/HexmosTech/git-lrc/actions/workflows/govulncheck.yml/badge.svg)](https://github.com/HexmosTech/git-lrc/actions/workflows/govulncheck.yml) [![semgrep.yml](https://github.com/HexmosTech/git-lrc/actions/workflows/semgrep.yml/badge.svg)](https://github.com/HexmosTech/git-lrc/actions/workflows/semgrep.yml) [![dependabot-enabled](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fgithub.com%2FHexmosTech%2Fgit-lrc%2F.%2Fgfx%2Fdependabot-enabled.svg)](https://github.com/HexmosTech/git-lrc/./gfx/dependabot-enabled.svg)
  
  

* * *
AI agents write code fast. They also _silently remove logic_ , change behavior, and introduce bugs -- without telling you. You often find out in production.
**`git-lrc`fixes this.** It hooks into `git commit` and reviews every diff _before_ it lands. 60-second setup. Completely free.
## See It In Action
> See git-lrc catch serious security issues such as leaked credentials, expensive cloud operations, and sensitive material in log statements
git-lrc-intro-60s.mp4
## Why
  * 🤖 **AI agents silently break things.** Code removed. Logic changed. Edge cases gone. You won't notice until production.
  * 🔍 **Catch it before it ships.** AI-powered inline comments show you _exactly_ what changed and what looks wrong.
  * 🔁 **Build a** …


[View on GitHub](https://github.com/HexmosTech/git-lrc)
DEV Community
Dropdown menu
  * [ What's a billboard? ](https://dev.to/billboards)
  * [ Manage preferences ](https://dev.to/settings/customization#sponsors)
* * *
  * [ Report billboard ](https://dev.to/report-abuse?billboard=238781)


[![Google AI Education track image](https://media2.dev.to/dynamic/image/width=775%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fu09y9fffqrb2one15j3g.png)](https://dev.to/deved/build-apps-with-google-ai-studio?bb=238781)
##  [ ](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g#build-apps-with-google-ai-studio) [Build Apps with Google AI Studio 🧱](https://dev.to/deved/build-apps-with-google-ai-studio?bb=238781)
This track will guide you through Google AI Studio's new "Build apps with Gemini" feature, where you can turn a simple text prompt into a fully functional, deployed web application in minutes.
[Read more →](https://dev.to/deved/build-apps-with-google-ai-studio?bb=238781)
Read More 
##  Top comments (0)
Subscribe
![pic](https://media2.dev.to/dynamic/image/width=256,height=,fit=scale-down,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F8j7kvp660rqzt99zui8e.png)
Personal Trusted User [ Create template ](https://dev.to/settings/response-templates)
Templates let you quickly answer FAQs or store snippets for re-use.
Submit Preview [Dismiss](https://dev.to/404.html)
[Code of Conduct](https://dev.to/code-of-conduct) • [Report abuse](https://dev.to/report-abuse)
Are you sure you want to hide this comment? It will become hidden in your post, but will still be visible via the comment's [permalink](https://dev.to/shrsv/power-up-your-go-apps-using-postgresql-as-a-job-queue-with-river-2e3g). 
Hide child comments as well
Confirm 
For further actions, you may consider blocking this person and/or [reporting abuse](https://dev.to/report-abuse)
[ ![](https://media2.dev.to/dynamic/image/width=90,height=90,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.us-east-2.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F1001514%2F17b7d334-44b1-417a-9268-346e6a34988a.jpg) Shrijith Venkatramana  ](https://dev.to/shrsv)
Follow
Founder @ hexmos.com. Building https://hexmos.com/livereview/git-lrc 
  * Education 
UCI 
  * Work 
hexmos.com 
  * Joined 
Jan 4, 2023


###  More from [Shrijith Venkatramana](https://dev.to/shrsv)
[ The Transformer Architecture Behind Modern LLMs: A Developer's Guide to the Diagram That Changed AI  #ai #webdev #programming #productivity ](https://dev.to/shrsv/the-transformer-architecture-behind-modern-llms-a-developers-guide-to-the-diagram-that-changed-ai-2e4) [ Self-Attention: The Brilliant Idea That Made Large Language Models Possible  #ai #webdev #programming #productivity ](https://dev.to/shrsv/self-attention-the-brilliant-idea-that-made-large-language-models-possible-1oj) [ Sequence Transduction: The Forgotten Problem That Led to Modern LLMs  #ai #webdev #programming #productivity ](https://dev.to/shrsv/sequence-transduction-the-forgotten-problem-that-led-to-modern-llms-439e)
💎 DEV Diamond Sponsors 
Thank you to our Diamond Sponsors for supporting the DEV Community 
[ ![Google AI - Official AI Model and Platform Partner](https://media2.dev.to/dynamic/image/width=880%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fxjlyhbdqehj3akhz166w.png) ](https://aistudio.google.com/?utm_source=partner&utm_medium=partner&utm_campaign=FY25-Global-DEVpartnership-sponsorship-AIS&utm_content=-&utm_term=-&bb=146443)
Google AI is the official AI Model and Platform Partner of DEV
[ ![Neon - Official Database Partner](https://media2.dev.to/dynamic/image/width=880%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fbnl88cil6afxzmgwrgtt.png) ](https://neon.tech/?ref=devto&bb=146443)
Neon is the official database partner of DEV
[ ![Algolia - Official Search Partner](https://media2.dev.to/dynamic/image/width=880%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fv30ephnolfvnlwgwm0yz.png) ](https://www.algolia.com/developers/?utm_source=devto&utm_medium=referral&bb=146443)
Algolia is the official search partner of DEV
[DEV Community](https://dev.to/) — A space to discuss and keep up software development and manage your software career 
  * [ Home ](https://dev.to/)
  * [ TEST ](https://dev.to/test)
  * [ Test ](https://google.com)
  * [ DEV Challenges ](https://dev.to/challenges)
  * [ Brand?? ](https://dev.to/brand)
  * [ DEV++ ](https://dev.to/++)
  * [ Second test ](https://dev.to/secondtest)
  * [ Test 2 ](https://dev.to/test2)
  * [ Videos ](https://dev.to/videos)
  * [ DEV Education Tracks ](https://dev.to/deved)
  * [ DEV Help ](https://dev.to/help)
  * [ Advertise on DEV ](https://dev.to/advertise)
  * [ Organization Accounts ](https://dev.to/organizations)
  * [ DEV Showcase ](https://dev.to/showcase)
  * [ About ](https://dev.to/about)
  * [ Contact ](https://dev.to/contact)
  * [ Free Postgres Database ](https://dev.to/free-postgres-database-tier)
  * [ DEV Shop ](https://shop.forem.com/)
  * [ MLH ](https://mlh.io/)


  * [ Code of Conduct ](https://dev.to/code-of-conduct)
  * [ Privacy Policy ](https://dev.to/privacy)
  * [ Terms of Use ](https://dev.to/terms)


Built on [Forem](https://www.forem.com) — the [open source](https://dev.to/t/opensource) software that powers [DEV](https://dev.to) and other inclusive communities.
Made with love and [Ruby on Rails](https://dev.to/t/rails). DEV Community © 2016 - 2026.
![DEV Community](https://media2.dev.to/dynamic/image/width=190,height=,fit=scale-down,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F8j7kvp660rqzt99zui8e.png)
We're a place where coders share, stay up-to-date and grow their careers. 
[ Log in ](https://dev.to/enter?signup_subforem=1) [ Create account ](https://dev.to/enter?signup_subforem=1&state=new-user)
![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg) ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg) ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg) ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg) ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg)

