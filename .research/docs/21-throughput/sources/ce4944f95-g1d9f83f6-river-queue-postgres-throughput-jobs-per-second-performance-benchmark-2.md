[July 16: Mike Stonebraker & Cockroach Labs: Agents on ACID?](https://www.cockroachlabs.com/webinars/are-your-agents-on-acid/?utm_source=dbosws)
[](https://dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres)
[![DBOS - Logo](https://cdn.prod.website-files.com/672411cbf038560468c9e63b/67241465129b580e4b924af4_Vectors-Wrapper.svg)](https://dbos.dev/)
Products
[ DBOS Transact Open source durable execution library ](https://dbos.dev/dbos-transact)[ DBOS Conductor Control plane for agents & workflows ](https://dbos.dev/dbos-conductor)
[Pricing](https://dbos.dev/dbos-pricing)[Customers](https://dbos.dev/customer-stories)
Resources
[ About DBOS Meet the team simplifying reliability. ](https://dbos.dev/about)[ Videos Demos, deep dives, and more DBOS. ](https://dbos.dev/videos)[ Partners Explore the DBOS ecosystem. ](https://dbos.dev/partners)
Docs
[ Quickstart Launch your first workflow in minutes. ](https://docs.dbos.dev/quickstart)[ Docs Step-by-step guides & real-world use cases. ](https://docs.dbos.dev/)[ Example Applications Ready-to-run code to spark your project. ](https://docs.dbos.dev/examples)
[Blog](https://dbos.dev/blog)
[](https://discord.com/invite/jsmC6pXGgX)
Explore
...
[dbos/dbos-transact-ts Durable Execution Library - TypeScript](https://github.com/dbos-inc/dbos-transact-ts)[dbos/dbos-transact-py Durable Execution Library - Python](https://github.com/dbos-inc/dbos-transact-py)[dbos-inc/dbos-transact-go Durable Execution Library - Go](https://github.com/dbos-inc/dbos-transact-go)[dbos-inc/dbos-transact-java Durable Execution Library - Java](https://github.com/dbos-inc/dbos-transact-java)[dbos-inc/dbos-demo-apps Demo DBOS applications](https://github.com/dbos-inc/dbos-demo-apps)[See all repos](https://github.com/dbos-inc)
[Sign in](https://console.dbos.dev/)[Get started](https://console.dbos.dev/)
[July 24: DBOS User Group Meeting](https://lu.ma/sfx9yccw)
[![DBOS - Logo](https://cdn.prod.website-files.com/672411cbf038560468c9e63b/67241465129b580e4b924af4_Vectors-Wrapper.svg)](https://dbos.dev/old-home-3)
Products
[ DBOS Transact Open source durable execution library ](https://dbos.dev/dbos-transact)[ DBOS Cloud Deploy with a click, scale to millions ](https://dbos.dev/dbos-cloud)
[Customers](https://dbos.dev/customer-stories)[Pricing](https://dbos.dev/dbos-pricing)[Blog](https://dbos.dev/blog)[Docs](https://docs.dbos.dev/)
Resources
[ About DBOS See our story, meet our team. ](https://dbos.dev/about)[ Videos DBOS concepts and best practices ](https://dbos.dev/videos)
[Start your project](https://console.dbos.dev/login-redirect)
[Login](https://console.dbos.dev/login-redirect)
[](https://github.com/dbos-inc/dbos-transact-py)[](https://discord.com/invite/jsmC6pXGgX)[Login](https://console.dbos.dev/launch)
[Start your project](https://console.dbos.dev/)
[Back to posts](https://dbos.dev/blog)
# Does Postgres Scale?
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/672d931372eb3a8fff51db11_65ec0883347d350eebbab02c_peter-kraft-website2.png)
Peter Kraft
April 23, 2026
Benchmarks
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2ef1c3fc50d09e3def99_Workflow-Execution-on-Postgres-Benchmark.png)
[![](https://cdn.prod.website-files.com/672411cbf038560468c9e63b/6a3887bc33e1d1fe520167bc_googlefavicon.avif)Add to Google](https://www.google.com/preferences/source?q=https://www.dbos.dev)
Share this post
[ ](https://www.linkedin.com/shareArticle?mini=true&url=https://www.dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres&title=Does%20Postgres%20Scale?)
[ ](https://twitter.com/intent/tweet?url=https://www.dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres&hashtags=dbos)
[ ](https://www.facebook.com/sharer/sharer.php?u=https://www.dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres)
When building a [durable workflow execution system on Postgres](https://github.com/dbos-inc), one of the most common questions we get is “does Postgres scale?” There are plenty of posts from top tech teams asserting that [Postgres](https://www.figma.com/blog/how-figmas-databases-team-lived-to-tell-the-scale/) [does scale](https://www.notion.com/blog/the-great-re-shard), but not all show **how** its performance scales in practice.
In this blog post, we benchmark the scalability of a single Postgres server. We focus on the performance of Postgres writes as those are the bottleneck in workflow execution: a durable workflow has to write to the database multiple times to checkpoint its inputs, its outcome, and the outcome of each of its steps. First, we measure raw Postgres write throughput in a vacuum. Then we analyze the performance of two durable workflow workloads: one that starts workflows locally, and one that uses a Postgres-backed queue.
We find that Postgres scales even better than we expected: a single server can support a sustained throughput of 144K writes per second, or process 43K workflows per second. That translates to 12 billion writes or 4 billion workflows per day, more than enough for most use cases.
All benchmark code is open-source [here](http://github.com/dbos-inc/dbos-postgres-benchmark). All experiments were conducted on an AWS RDS db.m7i.24xlarge instance with 96 vCPUs, 384 GB of RAM, and 120K provisioned IOPS on an io2 volume.
### Postgres Point Write Performance
We first measure the maximum write throughput Postgres can sustain to a single table. We use a simple three-column table with a UUIDv7 primary key, a TEXT data field, and a timestamp:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a806e_5415db4d.png)
Then we benchmark how many rows we can insert per second from a large number of async Python clients. Each row is inserted in a separate transaction:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8071_315695b0.png)
Overall, we find a Postgres server can handle up to 144K of these writes per second. That’s a lot, equivalent to 12 billion writes per day.
![Postgres write performance benchmark results on AWS](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8074_32f2e95b.png)
To make sure we’re reaching the limits of Postgres scalability, we also analyzed the bottleneck that constrains further performance. We first checked top-line metrics like CPU and IOPS, but found they weren’t fully utilized. To find the real bottleneck, we then queried the built-in Postgres [pg_stat_activity](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW) table to inspect what each Postgres backend process was doing at each moment in time:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a806b_fb9b59f1.png)
We found that the bottleneck was in flushing the Postgres [write-ahead log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) to disk. When performing a write, Postgres never directly modifies data pages on disk. Instead, it first appends a description of the write to the WAL, then flushes the WAL to disk (using the [fsync](https://man7.org/linux/man-pages/man2/fsync.2.html) system call), then acknowledges the commit to the client. The actual data files are updated later in the background. This design maximizes performance as only the relatively cheap WAL write is done synchronously, while the more expensive disk updates are done in the background.
When looking at Postgres process activity, we found that at any point in time, exactly one process was flushing the WAL to disk (in a [group commit](https://www.postgresql.org/docs/current/wal-configuration.html), so flushing the entire buffer, including data from other processes) and the vast majority of other processes were waiting on the WAL lock for their data to be flushed. The bottleneck in performance was how quickly Postgres could commit write transactions by flushing their WAL entries to disk. This is a [commonly observed bottleneck](https://postgrespro.com/list/thread-id/2206973) for extremely write-intensive workloads, as Postgres only has one WAL and every write needs to go through it.  

![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8065_ab61e818.png)
### Durable Workflow Performance
We next measure the performance of Postgres-backed durable workflows. A durable workflow performs exactly two Postgres writes:
  * One when it starts to create its database entry and record its inputs and initial status
  * One when it completes to record its outcome and final status


If a workflow has steps, it also performs one write per step to checkpoint that step’s outcome.
In this benchmark, we evaluate simple no-op workflows with no steps:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8068_6747bc60.png)
We start many workflows concurrently from many async Python clients:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a807a_357f3116.png)
Overall, we find a single Postgres server can process up to 43K workflows per second. In other words, adding Postgres-backed durability to an application executing 43K workflows per second will not bottleneck its performance:
![Postgres workflow performance benchmark results on AWS](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a807e_a95b7a54.png)
Like in the previous benchmark, we next looked for the bottleneck constraining further performance. Again, we found the bottleneck was in the WAL: how quickly Postgres could commit workflow INSERTs and UPDATEs by flushing their WAL entries to disk. This is unsurprising as both workloads are completely write-dominated. Two factors explain the difference between raw Postgres INSERT performance and workflow performance:
  1. A workflow requires two writes, so 43K workflows per second is actually 86K Postgres writes per second.
  2. The workflow_status table is much larger than the simple write benchmark table (31 columns versus 3, 9 indexes versus 1), so updates to that table require flushing much more data.


### Durable Queues Performance
We next measure the scalability of Postgres-backed queues. This is similar to the previous benchmark, but instead of directly executing workflows, clients enqueue them onto a Postgres queue. Workers then dequeue and execute them. This requires four Postgres writes per workflow:
  * One write to enqueue the workflow, creating its database entry and recording its inputs and initial status
  * One write to dequeue the workflow, updating its status (this write is batched with all other workflows dequeued by the same executor at the same time)
  * One write when the dequeued workflow is started, updating its status
  * One write when the workflow completes, recording its outcome and final status


Overall, we find a single Postgres server can process up to 12.1K queued workflows per second:
![Postgres queued workflow performance benchmark results on AWS](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8081_65310fef.png)
Again, we looked for the bottleneck in performance. Interestingly, the bottleneck this time was not in the WAL, but in lock contention in the workflow_status table. All client processes were enqueueing to or dequeueing from the same few rows at the head of the queue, and contention between them limited performance (despite optimizations like SKIP LOCKED). We hypothesize that this problem is exacerbated by Python being a relatively inefficient language, so many clients are needed to saturate Postgres–a faster language like Go would require fewer clients, and thus introduce less dequeue contention.
To eliminate the contention bottleneck, we also test distributing work across multiple queues (or, equivalently, multiple partitions of the same queue). We find that maximum achievable workflow throughput increases with the number of queues (with diminishing returns).Ultimately, with enough queues or partitions, queued workflows achieve a throughput of 30.6K workflows/sec. This is about two-thirds of the 43K workflows per second achieved when directly starting workflows, which makes sense as queued workflows require more writes (three non-batched and one batched versus two non-batched). At that scale, the database bottleneck again shifts to the WAL.
![Postgres multiple workflow queues performance benchmark results on AWS](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8077_ee68567a.png)
Overall, this benchmark shows that Postgres scales impressively well. In one second, a single Postgres server can perform 144K small writes or process 43K durable workflows. That translates to 12 billion writes or 4 billion workflows per day, enough for most applications. For more performance, a workload can shard across multiple Postgres servers to handle almost any load.
### Learn More
If you like building scalable, reliable systems, we’d love to hear from you. At DBOS, our goal is to make durable workflows as simple and performant as possible. Check it out:
  * Quickstart:[ https://docs.dbos.dev/quickstart](https://docs.dbos.dev/quickstart)
  * GitHub:[ https://github.com/dbos-inc](https://github.com/dbos-inc)
  * Discord community: <https://discord.gg/eMUHrvbu67>


Insights
### Recent articles
The latest in durable execution, AI workflows & more.
[](https://dbos.dev/blog/new-in-dbos-june-2026)
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/6a356d3e4e15a1514a4362f0_DBOS-New-Features-June-2026.png)
Product news
Jun 18, 2026
### What's New in DBOS - June 2026
New in DBOS: RBAC support, OpenMetrics, Bulk Workflow forking, Google ADK plugin, and more.
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/672d9313f2a3c344e2e0436d_65ec05e8b3a939d61c07c620_qian-li-dbos.jpeg)
Qian Li
[](https://dbos.dev/blog/co-locating-workflow-state-with-your-data)
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/6a302850af242b318fadeb41_Transactional-outbox-idempotency-atomicity2.jpg)
DBOS Architecture
Jun 15, 2026
### Just Co-Locate Data in Postgres
When workflow metadata and application data live in the same Postgres database, they can be updated in the same database transaction, which simplifies problems like workflow task idempotency and atomicity.
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/672d931372eb3a8fff51db11_65ec0883347d350eebbab02c_peter-kraft-website2.png)
Peter Kraft
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/672d9313f2a3c344e2e0436d_65ec05e8b3a939d61c07c620_qian-li-dbos.jpeg)
Qian Li
[](https://dbos.dev/blog/making-postgres-queues-scale)
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/6a1e552a2351abeae742f544_Use-Postgres-for-Queueing-at-Scale.png)
How To
Jun 2, 2026
### Just Use Postgres for Task Queues
Lessons learned from scaling Postgres-backed durable queues for tens of billions of workflows per month.
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/672d9313f2a3c344e2e0436d_65ec05e8b3a939d61c07c620_qian-li-dbos.jpeg)
Qian Li
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/672d931372eb3a8fff51db11_65ec0883347d350eebbab02c_peter-kraft-website2.png)
Peter Kraft
[Back to insights](https://dbos.dev/blog)
# Does Postgres Scale?
Peter Kraft
April 23, 2026
Benchmarks
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2ef1c3fc50d09e3def99_Workflow-Execution-on-Postgres-Benchmark.png)
When building a [durable workflow execution system on Postgres](https://github.com/dbos-inc), one of the most common questions we get is “does Postgres scale?” There are plenty of posts from top tech teams asserting that [Postgres](https://www.figma.com/blog/how-figmas-databases-team-lived-to-tell-the-scale/) [does scale](https://www.notion.com/blog/the-great-re-shard), but not all show **how** its performance scales in practice.
In this blog post, we benchmark the scalability of a single Postgres server. We focus on the performance of Postgres writes as those are the bottleneck in workflow execution: a durable workflow has to write to the database multiple times to checkpoint its inputs, its outcome, and the outcome of each of its steps. First, we measure raw Postgres write throughput in a vacuum. Then we analyze the performance of two durable workflow workloads: one that starts workflows locally, and one that uses a Postgres-backed queue.
We find that Postgres scales even better than we expected: a single server can support a sustained throughput of 144K writes per second, or process 43K workflows per second. That translates to 12 billion writes or 4 billion workflows per day, more than enough for most use cases.
All benchmark code is open-source [here](http://github.com/dbos-inc/dbos-postgres-benchmark). All experiments were conducted on an AWS RDS db.m7i.24xlarge instance with 96 vCPUs, 384 GB of RAM, and 120K provisioned IOPS on an io2 volume.
### Postgres Point Write Performance
We first measure the maximum write throughput Postgres can sustain to a single table. We use a simple three-column table with a UUIDv7 primary key, a TEXT data field, and a timestamp:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a806e_5415db4d.png)
Then we benchmark how many rows we can insert per second from a large number of async Python clients. Each row is inserted in a separate transaction:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8071_315695b0.png)
Overall, we find a Postgres server can handle up to 144K of these writes per second. That’s a lot, equivalent to 12 billion writes per day.
![Postgres write performance benchmark results on AWS](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8074_32f2e95b.png)
To make sure we’re reaching the limits of Postgres scalability, we also analyzed the bottleneck that constrains further performance. We first checked top-line metrics like CPU and IOPS, but found they weren’t fully utilized. To find the real bottleneck, we then queried the built-in Postgres [pg_stat_activity](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW) table to inspect what each Postgres backend process was doing at each moment in time:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a806b_fb9b59f1.png)
We found that the bottleneck was in flushing the Postgres [write-ahead log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) to disk. When performing a write, Postgres never directly modifies data pages on disk. Instead, it first appends a description of the write to the WAL, then flushes the WAL to disk (using the [fsync](https://man7.org/linux/man-pages/man2/fsync.2.html) system call), then acknowledges the commit to the client. The actual data files are updated later in the background. This design maximizes performance as only the relatively cheap WAL write is done synchronously, while the more expensive disk updates are done in the background.
When looking at Postgres process activity, we found that at any point in time, exactly one process was flushing the WAL to disk (in a [group commit](https://www.postgresql.org/docs/current/wal-configuration.html), so flushing the entire buffer, including data from other processes) and the vast majority of other processes were waiting on the WAL lock for their data to be flushed. The bottleneck in performance was how quickly Postgres could commit write transactions by flushing their WAL entries to disk. This is a [commonly observed bottleneck](https://postgrespro.com/list/thread-id/2206973) for extremely write-intensive workloads, as Postgres only has one WAL and every write needs to go through it.  

![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8065_ab61e818.png)
### Durable Workflow Performance
We next measure the performance of Postgres-backed durable workflows. A durable workflow performs exactly two Postgres writes:
  * One when it starts to create its database entry and record its inputs and initial status
  * One when it completes to record its outcome and final status


If a workflow has steps, it also performs one write per step to checkpoint that step’s outcome.
In this benchmark, we evaluate simple no-op workflows with no steps:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8068_6747bc60.png)
We start many workflows concurrently from many async Python clients:
![](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a807a_357f3116.png)
Overall, we find a single Postgres server can process up to 43K workflows per second. In other words, adding Postgres-backed durability to an application executing 43K workflows per second will not bottleneck its performance:
![Postgres workflow performance benchmark results on AWS](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a807e_a95b7a54.png)
Like in the previous benchmark, we next looked for the bottleneck constraining further performance. Again, we found the bottleneck was in the WAL: how quickly Postgres could commit workflow INSERTs and UPDATEs by flushing their WAL entries to disk. This is unsurprising as both workloads are completely write-dominated. Two factors explain the difference between raw Postgres INSERT performance and workflow performance:
  1. A workflow requires two writes, so 43K workflows per second is actually 86K Postgres writes per second.
  2. The workflow_status table is much larger than the simple write benchmark table (31 columns versus 3, 9 indexes versus 1), so updates to that table require flushing much more data.


### Durable Queues Performance
We next measure the scalability of Postgres-backed queues. This is similar to the previous benchmark, but instead of directly executing workflows, clients enqueue them onto a Postgres queue. Workers then dequeue and execute them. This requires four Postgres writes per workflow:
  * One write to enqueue the workflow, creating its database entry and recording its inputs and initial status
  * One write to dequeue the workflow, updating its status (this write is batched with all other workflows dequeued by the same executor at the same time)
  * One write when the dequeued workflow is started, updating its status
  * One write when the workflow completes, recording its outcome and final status


Overall, we find a single Postgres server can process up to 12.1K queued workflows per second:
![Postgres queued workflow performance benchmark results on AWS](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8081_65310fef.png)
Again, we looked for the bottleneck in performance. Interestingly, the bottleneck this time was not in the WAL, but in lock contention in the workflow_status table. All client processes were enqueueing to or dequeueing from the same few rows at the head of the queue, and contention between them limited performance (despite optimizations like SKIP LOCKED). We hypothesize that this problem is exacerbated by Python being a relatively inefficient language, so many clients are needed to saturate Postgres–a faster language like Go would require fewer clients, and thus introduce less dequeue contention.
To eliminate the contention bottleneck, we also test distributing work across multiple queues (or, equivalently, multiple partitions of the same queue). We find that maximum achievable workflow throughput increases with the number of queues (with diminishing returns).Ultimately, with enough queues or partitions, queued workflows achieve a throughput of 30.6K workflows/sec. This is about two-thirds of the 43K workflows per second achieved when directly starting workflows, which makes sense as queued workflows require more writes (three non-batched and one batched versus two non-batched). At that scale, the database bottleneck again shifts to the WAL.
![Postgres multiple workflow queues performance benchmark results on AWS](https://cdn.prod.website-files.com/672411cbf038560468c9e68f/69ea2dc7999383569d2a8077_ee68567a.png)
Overall, this benchmark shows that Postgres scales impressively well. In one second, a single Postgres server can perform 144K small writes or process 43K durable workflows. That translates to 12 billion writes or 4 billion workflows per day, enough for most applications. For more performance, a workload can shard across multiple Postgres servers to handle almost any load.
### Learn More
If you like building scalable, reliable systems, we’d love to hear from you. At DBOS, our goal is to make durable workflows as simple and performant as possible. Check it out:
  * Quickstart:[ https://docs.dbos.dev/quickstart](https://docs.dbos.dev/quickstart)
  * GitHub:[ https://github.com/dbos-inc](https://github.com/dbos-inc)
  * Discord community: <https://discord.gg/eMUHrvbu67>


Share this post
[ ](https://www.linkedin.com/shareArticle?mini=true&url=https://www.dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres&title=Does%20Postgres%20Scale?)
[ ](https://twitter.com/intent/tweet?url=https://www.dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres&hashtags=dbos)
[ ](https://www.facebook.com/sharer/sharer.php?u=https://www.dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres)
![DBOS - Logo](https://cdn.prod.website-files.com/672411cbf038560468c9e63b/67241465129b580e4b924af4_Vectors-Wrapper.svg)
DBOS radically simplifies cloud application devops and deployment.
[](https://www.linkedin.com/company/dbos-inc/)[](https://github.com/dbos-inc)[](https://discord.com/invite/jsmC6pXGgX)[](https://twitter.com/DBOS_Inc)[](https://dbos.dev/contact)
Products
[DBOS Cloud](https://dbos.dev/dbos-cloud)[DBOS Transact](https://dbos.dev/dbos-transact)[Pricing Plans](https://dbos.dev/dbos-pricing)[Contact Us](https://dbos.dev/contact)
Solutions
[Cron Job Platform](https://dbos.dev/solutions/cron-hosting)[Durable AI Workflows](https://dbos.dev/solutions/agentic-ai-platform)[Durable Data Pipelines](https://dbos.dev/solutions/data-pipeline-platform)[Cloud Modernization](https://dbos.dev/solutions/cloud-modernization)
Developers
[Docs](https://docs.dbos.dev/)[Quickstart Guide](https://docs.dbos.dev/quickstart)[Examples](https://docs.dbos.dev/examples)[Tutorials](https://docs.dbos.dev/cloud-tutorials/application-management)
Company
[About Us](https://dbos.dev/about)[Privacy Policy](https://dbos.dev/privacy)[Terms of Service](https://dbos.dev/terms-of-service)[Cookies](https://dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres)
Copyright © DBOS, Inc. 2025
### Build your reliable backend.   
Effortlessly.  

[Contact sales](https://dbos.dev/contact)
[Start your project](https://console.dbos.dev/)
## Get started with DBOS
Use the open source DBOS Transact library, free forever. Pair it with DBOS Pro for premium tooling and support.
[Start for free](https://console.dbos.dev/)
[Explore plans](https://dbos.dev/dbos-pricing)
Subscribe to DBOS Insights
Monthly updates on durable workflow execution and observability.
By subscribing you agree to with our [Privacy Policy](https://dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres)
You've successfully subscribed!
Oops! Please check your email and try again.
Products
[DBOS Transact](https://dbos.dev/dbos-transact)[DBOS Conductor](https://dbos.dev/dbos-conductor)[Pricing Plans](https://dbos.dev/dbos-pricing)[DBOS vs. Temporal](https://dbos.dev/compare/dbos-vs-temporal)
Use Cases
[Cron Job Platform](https://www.dbos.dev/solutions/cron-hosting)[Durable AI Workflows](https://www.dbos.dev/solutions/agentic-ai-platform)[Durable Data Pipelines](https://www.dbos.dev/solutions/data-pipeline-platform)[Cloud Modernization](https://www.dbos.dev/solutions/cloud-modernization)
Customer Stories
[Bristol Myers Squibb](https://www.dbos.dev/case-studies/bms)[Yutori](https://www.dbos.dev/case-studies/yutori-large-scale-durable-agentic-ai)[Dosu](https://www.dbos.dev/case-studies/dosu)[All stories](https://dbos.dev/customer-stories)
Developers
[Docs](https://docs.dbos.dev/)[Quickstart Guide](https://docs.dbos.dev/quickstart)[Examples](https://docs.dbos.dev/python/examples/widget-store)[Tutorials](https://docs.dbos.dev/python/tutorials/workflow-tutorial)[LLMs.txt](https://cdn.prod.website-files.com/672411cbf038560468c9e63b/69ffde3e8264252e8f396c96_llms.txt)
Company
[Contact Sales](https://dbos.dev/contact)[Blog](https://dbos.dev/blog)[About Us](https://dbos.dev/about)[Our Team](https://www.dbos.dev/about#team)[Partners](https://dbos.dev/partners)[Careers](https://dbos.dev/jobs)
[![DBOS - Logo](https://cdn.prod.website-files.com/672411cbf038560468c9e63b/67241465129b580e4b924af4_Vectors-Wrapper.svg)](https://dbos.dev/)
© 2026 DBOS, Inc. All rights reserved.
[Privacy Policy](https://dbos.dev/privacy)[Terms of Service](https://dbos.dev/terms-of-service)[Cookies Settings](https://dbos.dev/blog/benchmarking-workflow-execution-scalability-on-postgres)
[](https://discord.com/invite/jsmC6pXGgX)[](https://github.com/dbos-inc)[](https://twitter.com/DBOS_Inc)[](https://www.linkedin.com/company/dbos-inc/)[](https://www.youtube.com/@DBOS-Inc)

