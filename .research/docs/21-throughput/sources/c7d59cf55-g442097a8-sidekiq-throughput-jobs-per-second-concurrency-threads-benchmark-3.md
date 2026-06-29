Toggle navigation [Sidekiq](https://sidekiq.org/)Simple, efficient background jobs for Ruby.
  * [Pro](https://sidekiq.org/products/pro)
  * [Enterprise](https://sidekiq.org/products/enterprise)
  * [Wiki](https://sidekiq.org/wiki/Home)
  * [Support](https://sidekiq.org/support)
  * [Your Account](https://billing.stripe.com/p/login/6oEdUD7M86Wg42QeUU)


# Scaling
Last synchronized at 2026-06-10T22:44:32Z
Sidekiq’s architecture makes it easy to scale up to thousands of jobs per second and millions of jobs per day. Scaling Sidekiq can simply be a matter of “adding more servers”, but how do you optimize each server, how “big” do the servers need to be, and how do you know when to add more? Those are the questions this guide will answer.
## Concepts and terms
Let’s start with an overview of Sidekiq’s architecture and the various “levers” we have available to us. We’ll also define some terms we’ll use throughout this guide.
  * **Concurrency** - The Sidekiq setting that controls the number of threads available to a single Sidekiq process.
  * **Swarm** - A feature of [Sidekiq Enterprise](https://github.com/sidekiq/sidekiq/wiki/Ent-Multi-Process) that supports running multiple Sidekiq processes on a single container.
  * **Container** - A container instance running one or more Sidekiq processes. You might call this a server, service, dyno, pod, etc. We’ll just call them containers.
  * **Total concurrency** - The total number of Sidekiq threads across all containers and processes.


Here’s a diagram that shows the relationship between these concepts:
![Relationship between concurrency, containers, and process swarms](https://github.com/sidekiq/sidekiq/assets/372/b16f4c81-17eb-470d-8d87-d710fc13c0e6)
Sidekiq is of course all about queues, so let’s clarify some terms here.
  * **Queues** - You put your jobs into queues (which live in Redis), and Sidekiq processes the jobs in the queue, oldest first (FIFO). When starting a Sidekiq process, you tell it which queues to monitor and how to prioritize them.
  * **Queue assignment** - You can assign queues (or groups of queues) to specific Sidekiq processes, or you can have a single queue assignment used by all Sidekiq processes.
  * **Queue priority** - When assigning multiple queues to a process, Sidekiq has a couple [fetch algorithms](https://github.com/sidekiq/sidekiq/wiki/Reliability#fetch-algorithms) that dictate how it pulls jobs from those queues: strict and weighted. We’ll call those the queue priority.


![Relationship between Sidekiq queue assignments and priority](https://github.com/sidekiq/sidekiq/assets/372/35137361-df39-42c7-9393-e3b374e0560f)
And finally we have our connection pools. Yes, multiple connection pools.
  * **Database connection pool** - A pool of database connections shared by all Sidekiq threads within a process. This is managed by Rails and configured in `database.yml`.
  * **Redis connection pool** - A pool of Redis connections shared by all Sidekiq threads and Sidekiq internals within a process. This is managed by [redis-client](https://github.com/redis-rb/redis-client#configuration) and is configured automatically by Sidekiq based on your concurrency.


![Diagram of connection pools used by Sidekiq](https://github.com/sidekiq/sidekiq/assets/372/22f3501b-9b01-4e23-b6f1-631f179df584)
In total this is a lot of concepts and configurations. The good news is most of them are handled for us or are straightforward to configure ourselves.
## A Sidekiq starting point
These are some general recommendations that will help things run smoothly in the beginning of an app and prepare you to scale later.
**The fewer queues the better.** Don’t make your life harder than it needs to be. Two or three queues are _plenty_ for a new app. We’ll talk later about when it makes sense to add more queues, but scaling will generally be more challenging the more queues you have.
**Name your queues based on priority or urgency.** Some teams name their queues using domain specific terms that are no help at all when it comes to planning queue priority or latency requirements. “Urgent”, “default”, and “low” are much easier to work with. You might take a step further and embrace [Gusto’s approach](https://engineering.gusto.com/scaling-sidekiq-at-gusto-3f9e3279e63) of latency-based queue names such as “within_30_seconds”, “within_5_minutes”, etc. This approach makes it _very_ clear which queues have priority and when queue latency is unacceptable.
**Keep your jobs as small as possible!** [Fan out large jobs into many small jobs.](https://naildrivin5.com/blog/2023/11/09/fan-out-sidekiq-jobs-to-manage-large-workloads.html) Smaller jobs are much easier to scale, but we’ll talk later about strategies to use when this isn’t possible.
**Run a single Sidekiq process per container.** You can add Sidekiq Swarm later, but don’t assume you’ll need it. This is one less variable to juggle when scaling. Keep it simple.
**Choose a container size based on memory.** If you’re working with a lot of large files, such as generating PDF’s or importing large CSV files, you’ll need more memory. If you’re not doing that, you can probably get away with 1GB or less.
**Start with five threads per process (concurrency).** This is just a starting point—you will need to tweak it. Many teams get too ambitious with their concurrency, saturating their CPU and slowing down all jobs. The good news is _five is the Sidekiq default_ , so if you don’t do anything, you’ll have a good starting point.
These guidelines will get you started, but what about optimizing your configuration and scaling beyond the basics? That’s what we’ll tackle in the following sections.
## Find your concurrency sweet spot
Depending on your container CPU and the type of work your jobs are doing (mainly the percentage of time spent in I/O), you’ll probably need to tweak your concurrency setting. As a very simple rule, you want to CPU usage to be _high but not 100%_ when all threads are in use.
If CPU is hitting 100%, you need to reduce your concurrency. If your CPU usage never goes above 50% as max throughput, you probably want to increases your concurrency.
**Use`RAILS_MAX_THREADS` to tweak concurrency.** When you decide to tweak your concurrency, you _could_ configure it with the `-c` CLI flag, but Sidekiq will also respect the `RAILS_MAX_THREADS` environment variable. This is what Rails uses by default to configure your database pool in `database.yml`, so _by embracing this convention, your database pool will always be correctly sized for your Sidekiq process_.
## Autoscale your Sidekiq containers
Don’t waste your energy calculating how many containers you need to run. Sidekiq loads are highly variable by nature, and you don’t want to pay for a cluster of 10 containers when no jobs are enqueued. Autoscaling solves this problem by automatically scaling your containers up and down, but what metric should you use for autoscaling?
Sidekiq workloads are more often I/O-bound than CPU-bound—in other words, you can easily encounter a queue backlog even when CPU utilization is low. This makes CPU an inappropriate and frustrating metric to use for autoscaling, even though it’s the most commonly-used metric used by tools like AWS CloudWatch.
Instead, you should autoscale your Sidekiq containers using queue latency. Your business requirements will have an implicit (or hopefully explicit) expectation how long each job can reasonably wait before being processed. This expectation makes queue latency the perfect metric for autoscaling. (And if you’re using latency-based queue names, you’ve already identified those latency expectations!)
Several services exist for autoscaling Sidekiq based on queue latency:
  * Heroku: [Judoscale](https://judoscale.com), [HireFire](https://hirefire.io)
  * Render: Judoscale
  * AWS: CloudWatch*, Judoscale
  * Kubernetes: [HPA*](https://github.com/sidekiq/sidekiq/wiki/Kubernetes#autoscaling)


_(*) You’ll need to measure queue latency yourself and report it to CloudWatch or HPA._
## Assign queues to dedicated processes
Sometimes it makes sense to add a queue for a specific job or a particular “shape” of job. Some examples:
  * If you’re unable to break down large jobs into smaller jobs, you might not want those long-running jobs to become a bottleneck in your queue.
  * If you have some jobs that use lots of memory, you might need a larger container for those jobs.
  * If you have jobs that can’t be processed in parallel, you might need those jobs on a dedicated queue that run single-threaded.


These aren’t ideal scenarios, but they’re real-world scenarios that many apps will encounter. It’s best to treat these queues as the anomalies they are and dedicate them to their own Sidekiq process. This way your long-running jobs will only block other long-running jobs, and your memory-hungry jobs won’t require all of your jobs to run on larger, higher-priced containers.
This isolation makes scaling easier because you’re scaling your “special” queues separately from your “normal” queues. Here’s what it might look like in a `Procfile`, using `RAILS_MAX_THREADS` to force the memory-hungry jobs to be processed single-threaded (reducing memory bloat):

```
web: bundle exec rails s
worker: bundle exec sidekiq -q within_30_sec -q within_5_min -q within_5_hours
worker_high_mem: RAILS_MAX_THREADS=1 bundle exec sidekiq -q high_mem

```

## Scaling problems & solutions
The best way to make scaling easy is by keeping it simple: a few queues with small jobs. But of course keeping it simple isn’t always easy, especially in a legacy codebase or a large team. Here are some of the problems or anti-patterns you’ll generally want to avoid:
  * **Not enough connections in your database pool.** If you’re seeing the dreaded [`ActiveRecord::ConnectionTimeoutError`](https://github.com/sidekiq/sidekiq/wiki/Problems-and-Troubleshooting#cannot-get-database-connection-within-500-seconds) in your Sidekiq jobs, chances are you’ve misconfigured your database connection pool. Make sure your `database.yml` is using `RAILS_MAX_THREADS` as the pool size, and use `RAILS_MAX_THREADS` instead of `-c` to configure your concurrency.
  * **ERR max number of clients reached.** Unlike the error above, this error is coming from Redis, and it usually means you’re using a Redis service with an extremely [limited number of connections available](https://github.com/sidekiq/sidekiq/wiki/Problems-and-Troubleshooting#heroku-err-max-number-of-clients-reached). You can either upgrade your Redis service or reduce your concurrency setting.
  * **Slow job performance / saturated CPU.** These go hand-in-hand when you’ve set your concurrency too high. Reduce your concurrency or use a more powerful container.
  * **Sporadic queue backlogs.** Most apps have extremely variable load patterns for background jobs. If you don’t have autoscaling in place, you’ll need to run more containers to avoid these backlogs.
  * **Unreliable autoscaling.** If you’re not scaling up and down when expected, you’re probably autoscaling based on CPU. Autoscale based on queue latency instead.
  * **Memory bloat.** If your worker containers are using way more memory than you expect, you can either [fix the memory bloat](https://github.com/sidekiq/sidekiq/wiki/Problems-and-Troubleshooting#memory-bloat), or isolate those jobs to their own queue and process, potentially processing them single-threaded.
  * **Upstream (database) slow-down.** It’s easy to scale Sidekiq to the point that you’re overloading your database. There’s no Sidekiq fix here—you either need to reduce total concurrency to alleviate DB pressure, upgrade your database, or make your queries more efficient.


## Scaling Redis
The short answer is here is that Redis is almost never the problem when scaling Sidekiq. But for very high-scale apps, you might hit the limits of what’s possible with a single Redis server. The [sharding wiki article](https://github.com/sidekiq/sidekiq/wiki/Sharding) walks you through some options here, and now [Dragonfly](https://github.com/sidekiq/sidekiq/wiki/Using-Dragonfly) might be an even better option.
Just remember that _most apps don’t need this_! Make sure you’ve worked through the earlier suggestions and confirmed that Redis is your bottleneck before proceeding down these paths.
## Further reading
Nate Berkopec dives deep into many of the ideas discussed above in his excellent book [Sidekiq in Practice](https://nateberk.gumroad.com/l/sidekiqinpractice). He also has an in-depth article that explains the relationship between [processes, threads, and the GVL](https://www.speedshop.co/2020/05/11/the-ruby-gvl-and-scaling.html). For more on latency-based queue names, check out [Scaling Sidekiq at Gusto](https://engineering.gusto.com/scaling-sidekiq-at-gusto-3f9e3279e63).
[← Reliability](https://sidekiq.org/wiki/Reliability)
[Scheduled-Jobs →](https://sidekiq.org/wiki/Scheduled-Jobs)
  * [API](https://sidekiq.org/wiki/API)
  * [Active-Job](https://sidekiq.org/wiki/Active-Job)
  * [Advanced-Options](https://sidekiq.org/wiki/Advanced-Options)
  * [Batches](https://sidekiq.org/wiki/Batches)
  * [Best-Practices](https://sidekiq.org/wiki/Best-Practices)
  * [Build-vs-Buy](https://sidekiq.org/wiki/Build-vs-Buy)
  * [Bulk-Queueing](https://sidekiq.org/wiki/Bulk-Queueing)
  * [Comm-Installation](https://sidekiq.org/wiki/Comm-Installation)
  * [Commercial-FAQ](https://sidekiq.org/wiki/Commercial-FAQ)
  * [Commercial-Support](https://sidekiq.org/wiki/Commercial-Support)
  * [Commercial-collaboration](https://sidekiq.org/wiki/Commercial-collaboration)
  * [Complex-Job-Workflows-with-Batches](https://sidekiq.org/wiki/Complex-Job-Workflows-with-Batches)
  * [Delayed-extensions](https://sidekiq.org/wiki/Delayed-extensions)
  * [Deployment](https://sidekiq.org/wiki/Deployment)
  * [Devise](https://sidekiq.org/wiki/Devise)
  * [Embedding](https://sidekiq.org/wiki/Embedding)
  * [Ent-Encryption](https://sidekiq.org/wiki/Ent-Encryption)
  * [Ent-Historical-Metrics](https://sidekiq.org/wiki/Ent-Historical-Metrics)
  * [Ent-Leader-Election](https://sidekiq.org/wiki/Ent-Leader-Election)
  * [Ent-Multi-Process](https://sidekiq.org/wiki/Ent-Multi-Process)
  * [Ent-Periodic-Jobs](https://sidekiq.org/wiki/Ent-Periodic-Jobs)
  * [Ent-Rate-Limiting](https://sidekiq.org/wiki/Ent-Rate-Limiting)
  * [Ent-Rolling-Restarts](https://sidekiq.org/wiki/Ent-Rolling-Restarts)
  * [Ent-Unique-Jobs](https://sidekiq.org/wiki/Ent-Unique-Jobs)
  * [Ent-Web-UI](https://sidekiq.org/wiki/Ent-Web-UI)
  * [Error-Handling](https://sidekiq.org/wiki/Error-Handling)
  * [FAQ](https://sidekiq.org/wiki/FAQ)
  * [Getting-Started](https://sidekiq.org/wiki/Getting-Started)
  * [Heroku](https://sidekiq.org/wiki/Heroku)
  * [Home](https://sidekiq.org/wiki/Home)
  * [Iteration](https://sidekiq.org/wiki/Iteration)
  * [Job-Format](https://sidekiq.org/wiki/Job-Format)
  * [Job-Lifecycle](https://sidekiq.org/wiki/Job-Lifecycle)
  * [Kubernetes](https://sidekiq.org/wiki/Kubernetes)
  * [Logging](https://sidekiq.org/wiki/Logging)
  * [Memory](https://sidekiq.org/wiki/Memory)
  * [Metrics](https://sidekiq.org/wiki/Metrics)
  * [Middleware](https://sidekiq.org/wiki/Middleware)
  * [Miscellaneous-Features](https://sidekiq.org/wiki/Miscellaneous-Features)
  * [Monitoring](https://sidekiq.org/wiki/Monitoring)
  * [Pro-API](https://sidekiq.org/wiki/Pro-API)
  * [Pro-Expiring-Jobs](https://sidekiq.org/wiki/Pro-Expiring-Jobs)
  * [Pro-Metrics](https://sidekiq.org/wiki/Pro-Metrics)
  * [Pro-Reliability-Client](https://sidekiq.org/wiki/Pro-Reliability-Client)
  * [Pro-Reliability-Server](https://sidekiq.org/wiki/Pro-Reliability-Server)
  * [Pro-Web-UI](https://sidekiq.org/wiki/Pro-Web-UI)
  * [Problems-and-Troubleshooting](https://sidekiq.org/wiki/Problems-and-Troubleshooting)
  * [Profiling](https://sidekiq.org/wiki/Profiling)
  * [Really-Complex-Workflows-with-Batches](https://sidekiq.org/wiki/Really-Complex-Workflows-with-Batches)
  * [Related-Projects](https://sidekiq.org/wiki/Related-Projects)
  * [Reliability](https://sidekiq.org/wiki/Reliability)
  * [Scaling](https://sidekiq.org/wiki/Scaling)
  * [Scheduled-Jobs](https://sidekiq.org/wiki/Scheduled-Jobs)
  * [Sharding](https://sidekiq.org/wiki/Sharding)
  * [Signals](https://sidekiq.org/wiki/Signals)
  * [Testimonials](https://sidekiq.org/wiki/Testimonials)
  * [Testing](https://sidekiq.org/wiki/Testing)
  * [The-Basics](https://sidekiq.org/wiki/The-Basics)
  * [Using-Dragonfly](https://sidekiq.org/wiki/Using-Dragonfly)
  * [Using-Redis](https://sidekiq.org/wiki/Using-Redis)


#### Questions, comments, & concerns?info@contribsys.com
Sidekiq[![](https://sidekiq.org/img/hero-award.svg)](https://rubyheroes.com/)[![](https://sidekiq.org/img/rookie-award.png)](https://www.blackducksoftware.com/open-source-rookies/2012-recipients)
[![](https://sidekiq.org/img/cs-footer-logo.png)](https://contribsys.com/)
* * *
[About](https://sidekiq.org/about)  
[Pro](https://sidekiq.org/products/pro)  
[Enterprise](https://sidekiq.org/products/enterprise)
[Wiki](https://sidekiq.org/wiki/Home)  
[Support](https://sidekiq.org/support)  
[Source ](https://github.com/sidekiq/sidekiq/)
[Status ](https://status.sidekiq.org)  
[On Mastodon ](https://ruby.social/@sidekiq)  
[At Rubyconf ](https://confreaks.com/videos/1290-rubyconf2012-asynchronous-processing-for-fun-and-profit)
Copyright © Contributed Systems LLC.  
Made with care in Portland, OR.  
[Site Source](https://github.com/sidekiq/site) (PRs welcome!) 

