[ Skip to main content ](https://temporal.io/blog/scaling-temporal-the-basics#main-content)
[New features for faster build and reliable AI | See what you missed at Replay 2026 › ](https://temporal.io/replay/2026) [About](https://temporal.io/about)[Careers](https://temporal.io/careers)[Talk to Sales](https://pages.temporal.io/contact-us)
[![Temporal Logo](https://temporal.io/images/logos/logo-temporal-with-copy-white-text.svg)](https://temporal.io/)
  * Platform 
    * [Overview](https://temporal.io/product)
    * [How Temporal Works](https://temporal.io/how-it-works)
    * [Temporal Cloud](https://temporal.io/cloud)
    * [Security](https://temporal.io/security)
  * Platform 
  * [Docs](https://docs.temporal.io)
  * [Pricing](https://temporal.io/pricing)
  * Use Cases 
    * [Customer Stories](https://temporal.io/in-use)
    * By Industry
      * [AI](https://temporal.io/solutions/ai)
      * [Financial Services](https://temporal.io/solutions/financial-services)
    * By Audience
      * [Platform Engineering](https://temporal.io/solutions/platform-engineering)
      * [Startups](https://temporal.io/startup)
      * [Partners](https://temporal.io/partners)
  * Use Cases 
  * Resources 
    * [Resource Library](https://temporal.io/resources)
    * [Learn Temporal](https://learn.temporal.io)
    * [Community](https://temporal.io/community)
    * [Code Exchange](https://temporal.io/code-exchange)
    * [Blog](https://temporal.io/blog)
    * [Changelog](https://temporal.io/changelog)
  * Resources 


[](https://github.com/temporalio)
[ Try Free ](https://temporal.io/get-cloud)[ Log In ](https://cloud.temporal.io/)
  * [Blog](https://temporal.io/blog)
  * [Temporal Concepts](https://temporal.io/blog/categories/temporal-concepts)


# Scaling Temporal: The basics
AUTHORS
Rob Holland
DATE
May 23, 2023
CATEGORY
[Temporal Concepts](https://temporal.io/blog/categories/temporal-concepts)
DURATION
15 MIN
  * Temporal Primitives
  * Scaling


TABLE OF CONTENTS
  1. [Scaling Temporal: The Basics](https://temporal.io/blog/scaling-temporal-the-basics#scaling-temporal-the-basics)
  2. [Our Cluster](https://temporal.io/blog/scaling-temporal-the-basics#our-cluster)
  3. [Scaling Up](https://temporal.io/blog/scaling-temporal-the-basics#scaling-up)
  4. [Round two!](https://temporal.io/blog/scaling-temporal-the-basics#round-two)
  5. [Scale](https://temporal.io/blog/scaling-temporal-the-basics#scale-1)
  6. [Summary](https://temporal.io/blog/scaling-temporal-the-basics#summary)


Scaling your own Temporal Cluster can be a complex subject because there are infinite variations on workload patterns, business goals, and operational goals. So, for this post, we will help make it simple and focus on metrics and terminology that can be used to discuss scaling a Temporal Cluster for any kind of workflow architecture. By far the simplest way to scale is to use Temporal Cloud. Our custom persistence layer and expertly managed Temporal Clusters can support extreme levels of load, and you pay only for what you use as you grow. In this post, we'll walk through a process for scaling a self-hosted instance of Temporal Cluster. In the [next post in the series](https://temporal.io/blog/tuning-temporal-server-request-latency-on-kubernetes), we look at tuning a Cluster's request latency on Kubernetes. 
## Scaling Temporal: The Basics[#](https://temporal.io/blog/scaling-temporal-the-basics#scaling-temporal-the-basics)
Out of the box, our Temporal Cluster is configured with the development-level defaults. We’ll work through some **load** , **measure** , **scale** iterations to move towards a production-level setup, touching on Kubernetes resource management, Temporal shard count configuration, and polling optimization. The process we’ll follow is:
  1. **Load** : Set or adjust the level of load we want to test with. Normally, we’ll be increasing the load as we improve our configuration.
  2. **Measure** : Check our monitoring to spot bottlenecks or problem areas under our new level of load.
  3. **Scale** : Adjust Kubernetes or Temporal configuration to remove bottlenecks, ensuring we have safe headroom for CPU and memory usage. We may also need to adjust node or persistence instance sizes here, either to scale up for more load or scale things down to save costs if we have more headroom than we need.
  4. Repeat


## Our Cluster[#](https://temporal.io/blog/scaling-temporal-the-basics#our-cluster)
For our load testing we’ve deployed Temporal on Kubernetes, and we’re using MySQL for the persistence backend. The MySQL instance has 4 CPU cores and 32GB RAM, and each Temporal service (Frontend, History, Matching, and Worker) has 2 pods, with [requests](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) for 1 CPU core and 1GB RAM as a starting point. We’re not setting CPU limits for our pods—see our upcoming _Temporal on Kubernetes_ post for more details on why. For monitoring we’ll use Prometheus and Grafana, installed via the [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) stack, giving us some useful Kubernetes metrics.
![Temporal Cluster diagram](https://images.ctfassets.net/0uuz8ydxyd9p/7jAvPG8jSHNbpI7WRFsEM3/614dcb36bf01a6816f470ded01b953f2/cluster.png)
## Scaling Up[#](https://temporal.io/blog/scaling-temporal-the-basics#scaling-up)
Our goal in this post will be to see what performance we can achieve while keeping our persistence database (MySQL in this case) at or below 80% CPU. Temporal is designed to be horizontally scalable, so it is almost always the case that it can be scaled to the point that the persistence backend becomes the bottleneck.
### Load[#](https://temporal.io/blog/scaling-temporal-the-basics#load)
To create load on a Temporal Cluster, we need to start Workflows and have Workers to run them. To make it easy to set up load tests, we have packaged a simple Workflow and some [Activities](https://docs.temporal.io/activities) in the [benchmark-workers package](https://github.com/temporalio/benchmark-workers/pkgs/container/benchmark-workers). Running a `benchmark-worker` container will bring up a load test Worker with default Temporal Go SDK settings. The only configuration it needs out of the box is the host and port for the Temporal Frontend service.
To run a benchmark Worker with default settings we can use:

```
kubectl run benchmark-worker \
    --image ghcr.io/temporalio/benchmark-workers:main \
    --image-pull-policy Always \
    --env "TEMPORAL_GRPC_ENDPOINT=temporal-frontend.temporal:7233"
```

Once our Workers are running, we need something to start Workflows in a predictable way. The benchmark-workers package includes a runner that starts a configurable number of Workflows in parallel, starting a new execution each time one of the Workflows completes. This gives us a simple dial to increase load, by increasing the number of parallel Workflows that will be running at any given time.
To run a benchmark runner we can use:

```
kubectl run benchmark-worker \
    --image ghcr.io/temporalio/benchmark-workers:main \
    --image-pull-policy Always \
    --env "TEMPORAL_GRPC_ENDPOINT=temporal-frontend.temporal:7233" \
    --command -- runner -t ExecuteActivity '{ "Count": 3, "Activity": "Echo", "Input": { "Message": "test" } }'
```

For our load test, we’ll use a deployment rather than `kubectl` to deploy the Workers and runner. This allows us to easily scale the Workers and collect metrics from them via Prometheus. We’ll use a deployment similar to the example here: [github.com/temporalio/benchmark-workers/blob/main/deployment.yaml](https://github.com/temporalio/benchmark-workers/blob/main/deployment.yaml)
For this test we’ll start off with the default runner settings, which will keep 10 parallel Workflows executions active. You can find details of the available configuration options in the [README](https://github.com/temporalio/benchmark-workers#readme).
### Measure[#](https://temporal.io/blog/scaling-temporal-the-basics#measure)
When deciding how to measure system performance under load, the first metric that might come to mind is the number of Workflows completed per second. However, Workflows in Temporal can vary enormously between different use cases, so this turns out to not be a very useful metric. A load test using a Workflow which just runs one Activity might produce a relatively high result compared to a system running a batch processing Workflow which calls hundreds of Activities. For this reason, we use a metric called [**State Transitions**](https://docs.temporal.io/workflows#state-transition) as our measure of performance. State Transitions represent Temporal writing to its persistence backend, which is a reasonable proxy of how much work Temporal itself is doing to ensure your executions are durable. Using State Transitions per second allows us to compare numbers across different workloads. Using Prometheus, you can monitor State Transitions with the query:

```
sum(rate(state_transition_count_count{namespace="default"}[1m]))

```

Now we have State Transitions per second as our throughput metric, we need to qualify it with some other metrics for business or operational goals (commonly called Service Level Objectives or SLOs). The values you decide on for a production SLO will vary. To start our load tests, we are going to work on handling a fixed level of load (as opposed to spiky) and expect a StartWorkflowExecution request latency of less than 150ms. If a load test can run within our StartWorkflowExecution latency SLO, we’ll consider that the cluster can handle the load. As we progress we’ll add other SLOs to help us decide if the cluster can be scaled to handle higher load, or to more efficiently handle the current load.
We can add a Prometheus alert to make sure we are meeting our SLO. We’re only concerned about `StartWorkflowExecution` requests for now, so we filter the operation metric tag to focus on those.

```
- alert: TemporalRequestLatencyHigh
  annotations:
    description: Temporal {{ $labels.operation }} request latency is currently {{ $value | humanize }}, outside of SLO 150ms.
    summary: Temporal request latency is too high.
  expr: |
    histogram_quantile(0.95, sum by (le, operation) (rate(temporal_request_latency_bucket{job="benchmark-monitoring",operation="StartWorkflowExecution"}[5m])))
    > 0.150
  for: 5m
  labels:
    namespace: temporal
    severity: critical
```

Checking our dashboard, we can see that unfortunately our alert is already firing, telling us we’re failing our SLO for request latency.
![SLO Dashboard: Showing alert firing for request latency](https://images.ctfassets.net/0uuz8ydxyd9p/1vuDxyXumf9Iq9DZAs3p8n/780a082dc9749902cfa6497019472b30/Scaling__1-mh.png)
### Scale[#](https://temporal.io/blog/scaling-temporal-the-basics#scale)
Obviously, this is not where we want to leave things, so let’s find out why our request latency is so high. The request we’re concerned with is the `StartWorkflowExecution` request, which is handled by the History service. Before we dig into where the bottleneck might be, we should introduce one of the main tuning aspects of Temporal performance, **[History Shards](https://docs.temporal.io/clusters/#history-shard)**.
Temporal uses shards (partitions) to divide responsibility for a Namespace’s Workflow histories amongst History pods, each of which will manage a set of the shards. Each Workflow history will belong to a single shard, and each shard will be managed by a single History pod. Before a Workflow history can be created or updated, there is a shard lock that must be obtained. This needs to be a very fast operation so that Workflow histories can be created and updated efficiently. Temporal allows you to choose the number of shards to partition across. The larger the shard count, the less lock contention there is, as each shard will own fewer histories, so there will be less waiting to obtain the lock.
We can measure the latency for obtaining the shard lock in Prometheus using:

```
histogram_quantile(0.95, sum by (le)(rate(lock_latency_bucket[1m])))

```

![History Dashboard: High shard lock latency](https://images.ctfassets.net/0uuz8ydxyd9p/7hNeLRnXBctLK7erfMfpeV/4232591701cb604cd2e72d24cb3453e1/Scaling__2-mh.png)
Looking at the History dashboard we can see that shard lock latency p95 is nearly 50ms. This is much higher than we’d like. For good performance we’d expect shard lock latency to be less than 5ms, ideally around 1ms. This tells us that we probably have too few shards.
The shard count on our cluster is set to the development default, which is 4. Temporal recommends that small production clusters use 512 shards. To give an idea of scale, it is rare for even large Temporal clusters to go beyond 4,096 shards.
The downside to increasing the shard count is that each shard requires resources to manage. An overly large shard count wastes CPU and Memory on History pods; each shard also has its own task processing queues, which puts extra pressure on the persistence database. _One thing to note about shard count in Temporal is that it is the one configuration setting which cannot (currently) be changed after the cluster is built_. For this reason it’s very important to do your own load testing or research to determine what a sensible shard count would be, **before** building a production cluster. In future we hope to make the shard count adjustable. As this is just a test cluster, we can rebuild it with a shard count of 512.
![History Dashboard: Shard latency dropped, but pod memory climbing](https://images.ctfassets.net/0uuz8ydxyd9p/1ACDp4CIlgckjgE4Pqidp5/c855c8f71ecfa25719b2822186f591ea/Scaling__3-mh.png)
After changing the shard count, the shard lock latency has dropped from around 50ms to around 1ms. That’s a huge improvement!
However, as we mentioned, each shard needs management. Part of the management includes a cache of Workflow histories for that shard. We can see the History pods’ memory usage is rising quickly. If the pods run out of memory, Kubernetes will terminate and restart them (OOMKilled). This causes Temporal to rebalance the shards onto the remaining History pod(s), only to then rebalance again once the new History pod comes up. Each time you make a scaling change, be sure to check that all Temporal pods are still within their CPU and memory requests—pods frequently being restarted is very bad for performance! To fix this, we can bump the memory limits for the History containers. Currently, it is hard to estimate the amount of memory a History pod is going to use because the limits are not set per host, or even in MB, but rather as a number of cache entries to store. There is work to improve this: [github.com/temporalio/temporal/issues/2941](https://github.com/temporalio/temporal/issues/2941). For now, we’ll set the History memory limit to 8GB and keep an eye on them—we can always raise it later if we find the pod needs more.
![History Dashboard: History pods with memory headroom](https://images.ctfassets.net/0uuz8ydxyd9p/lFR4cS7n4rnQcFnWnba3a/58833e80b80b65ba0691153894e9b715/Scaling__4-mh.png)
After this change, the History pods are looking good. Now that things are stable, let’s see what impact our changes have had on the State Transitions and our SLO.
![History Dashboard: State transitions up, latency within SLO](https://images.ctfassets.net/0uuz8ydxyd9p/61sgBu7aq8c8jMMMJRYcvN/dbd1d3e3232f5d79dfb21287c5250af0/Scaling__6-mh.png)
State Transitions are up from our starting point of 150/s to 395/s and we’re way below our SLO of 150ms for request latency, staying under 50ms, so that’s great! We’ve completed a **load** , **measure** , **scale** iteration and everything looks stable.
## Round two![#](https://temporal.io/blog/scaling-temporal-the-basics#round-two)
### Load[#](https://temporal.io/blog/scaling-temporal-the-basics#load-1)
After our shard adjustment, we’re stable, so let’s iterate again. We’ll increase the load to 20 parallel workflows.
![SLO Dashboard: State transitions up](https://images.ctfassets.net/0uuz8ydxyd9p/5jaByfR0fEJEff8Fa2Gvfk/269b4da15595d06fdd714bda6689c97e/Scaling__7-mh.png)
Checking our SLO dashboard, we can see the State Transitions have risen to 680/s. Our request latency is still fine, let’s bump the load to 30 parallel workflows and see if we get more State Transitions for free.
![SLO Dashboard: State transitions up](https://images.ctfassets.net/0uuz8ydxyd9p/5pds6aSQF43gP7JQlHkEzp/34fbda176b4558d4d76fde3bc41ac64a/Scaling__8-mh.png)
We can see we did get another raise in State Transitions, although not as dramatic. Time to check dashboards again.
### Measure[#](https://temporal.io/blog/scaling-temporal-the-basics#measure-1)
![History Dashboard: High CPU](https://images.ctfassets.net/0uuz8ydxyd9p/6U4GgTbHiDun0u9AhNiMoS/283a92144e3c31e97c422280583517a1/Scaling__9-mh.png)
History CPU is now exceeding its requests at times—we’d like to aim to have some headroom. Ideally, the majority of the time the process should use under 80% of its request, so let’s bump the History pods to 2 cores.
![History Dashboard: CPU has headroom](https://images.ctfassets.net/0uuz8ydxyd9p/5vXteyowBCu5yEGfJMTmdf/4f0df0946a8528e747a4b82504932b59/Scaling__10-mh.png)
History CPU is looking better now, how about our State Transitions?
![SLO Dashboard: State transitions up, request latency down](https://images.ctfassets.net/0uuz8ydxyd9p/4svsTIEvMoFk8p1ZHuUtEF/da30c588d18dee3f2e5b027d56462572/Scaling__11-mh.png)
We’re doing well! State Transitions are now up to 1,200/s and request latency is back down to 50ms. We’ve got the hang of the History scaling process, so let’s move on to look at another core Temporal sub-system, polling.
## Scale[#](https://temporal.io/blog/scaling-temporal-the-basics#scale-1)
While the History service is concerned with shuttling event histories to and from the persistence backend, the polling system (known as the Matching service) is responsible for matching tasks to your application workers efficiently.
If your Worker replica count and poller configuration are not optimized, then there will be a delay between the time a task is requested and when it is processed. This is known as Schedule-to-Start latency, and this will be our next SLO. We’ll aim for 150ms like we do for our Request Latency SLO.

```
- alert: TemporalWorkflowTaskScheduleToStartLatencyHigh
  annotations:
    description: Temporal Workflow Task Schedule to Start latency is currently {{ $value | humanize }}, outside of SLO 150ms.
    summary: Temporal Workflow Task Schedule to Start latency is too high.
  expr: |
    histogram_quantile(0.95, sum by (le) (rate(temporal_workflow_task_schedule_to_start_latency_bucket{namespace="default"}[5m])))
    > 0.150
  for: 5m
  labels:
    namespace: temporal
    severity: critical
- alert: TemporalActivityScheduleToStartLatencyHigh
  annotations:
    description: Temporal Activity Schedule to Start latency is currently {{ $value | humanize }}, outside of SLO 150ms.
    summary: Temporal Activity Schedule to Start latency is too high.
  expr: |
    histogram_quantile(0.95, sum by (le) (rate(temporal_activity_schedule_to_start_latency_bucket{namespace="default"}[5m])))
    > 0.150
  for: 5m
  labels:
    namespace: temporal
    severity: critical
```

After adding these alerts, let’s check out the polling dashboard.
![Polling Dashboard: Activity Schedule-to-Start latency is outside of our SLO](https://images.ctfassets.net/0uuz8ydxyd9p/3rZ9bGWgJSt10SSx5CZNsT/d3ae7acf9613980fc537a4304b458e1c/Scaling__12-mh.png)
So we can see here that our Schedule-to-Start latency for Activities is too high. We’re taking over 150 ms to begin an Activity after it’s been scheduled. The dashboard also shows another polling related metric which we call **Poll Sync Rate**. In an ideal world, when a Worker’s poller requests some work, the Matching service can hand it a task from its memory. This is known as “sync match”, short for synchronous matching. If the Matching service has a task in its memory too long, because it has not been able to hand out work quickly enough, the task is flushed to the persistence database. Tasks that were sent to the persistence database needed to be loaded back again later to hand to pollers (async matching). Compared with sync matching, async matching increases the load on the persistence database and is a lot less efficient. The ideal, then, is to have enough pollers to quickly consume all the tasks that land on a task queue. To have the least load on the persistence database and the highest throughput of tasks on a task queue, we should aim for both Workflow and Activity Poll Sync Rates to be 99% or higher. Improving the Poll Sync Rate will also improve the Schedule-to-Start Latency, as Workers will be able to receive the tasks more quickly.
We can measure the Poll Sync Rate in Prometheus using:

```
sum by (task_type) (rate(poll_success_sync[1m])) / sum by (task_type) (rate(poll_success[1m]))

```

In order to improve the Poll Sync Rate, we adjust the number of Worker pods and their poller configuration. In our setup we currently have only 2 Worker pods, configured to have 10 Activity pollers and 10 Workflow pollers. Let’s up that to 20 pollers of each kind.
![Polling Dashboard: Activity Schedule-to-Start latency improved, but still over SLO](https://images.ctfassets.net/0uuz8ydxyd9p/1eNCqEDaL8YpOzh9HZg01p/6a9ef9b984140cbdd22178ed41f6b411/Scaling__13-mh.png)
Better, but not enough. Let’s try 100 of each type.
![Polling Dashboard: Activity Schedule-to-Start latency within SLO](https://images.ctfassets.net/0uuz8ydxyd9p/4TVpVof4j52n6ZJZwMA3pg/61072500d1a914c33baea56f61a37944/Scaling__14-mh__1_.png)
Much better! Activity Poll Sync Rate is still not quite sticking at 99% though, bump Activity pollers to 150 didn’t fix it either. Let’s try adding 2 more Worker pods…
![Polling Dashboard: Poll Sync Rate > 99%](https://images.ctfassets.net/0uuz8ydxyd9p/3HtIYQStrxDiUaTvYo8cwP/2b23174471ac07ad60a4d7c6a8a65d23/Scaling__15-mh.png)
Nice, consistently above 99% for Poll Sync Rate for both Workflow and Activity now. A quick check of the Matching dashboard shows that the Matching pods are well within CPU and Memory requests, so we’re looking stable. Now let’s see how we’re doing for State Transitions.
![SLO Dashboard: State Transitions up to 1,350/second](https://images.ctfassets.net/0uuz8ydxyd9p/3iTC2pgTlHcCdjgY6MHTLj/8bfe80c9d541ae0f21fb5750468aacd6/Scaling__16-mh.png)
Looking good. Improving our polling efficiency has increased our State Transitions by around 150/second. One last check to see if we’re still within our persistence database CPU target of below 80%.
![Persistence Dashboard: Database CPU < 80%](https://images.ctfassets.net/0uuz8ydxyd9p/3j3qAqFod91T0wLTAau2iN/0ac24573769a3f6b974bd2c37e960b7c/Scaling__17-mh.png)
Yes! We’re nearly spot on, averaging around 79%. That brings us to the end of our second **load** , **measure** , **scale** iteration. The next step would either be to increase the database instance size and continue iterating to scale up, or if we’ve hit our desired performance target, we can instead check resource usage and reduce them where appropriate. This allows us to save some costs by potentially reducing node count.
## Summary[#](https://temporal.io/blog/scaling-temporal-the-basics#summary)
We’ve taken a cluster configured to the development default settings and scaled it from 150 to 1,350 State Transitions/second. To achieve this, we increased the shard count from 4 to 512, increased the History pod CPU and Memory requests, and adjusted our Worker replica count and poller configuration.
We hope you’ve found this useful. We’d love to discuss it further or answer any questions you might have. Please reach out with any questions or comments on the [Community Forum](https://community.temporal.io/) or [Slack](https://t.mp/slack). My name is Rob Holland, feel free to reach out to me directly on Slack if you like—would love to hear from you.
Check out the next post in the series: [Tuning Temporal Server request latency on Kubernetes](https://temporal.io/blog/tuning-temporal-server-request-latency-on-kubernetes).
SHARE
[](https://temporal.io/blog/feed.xml "Share on RSS") [](https://x.com/intent/post?url=https%3A%2F%2Ftemporal.io%2Fblog%2Fscaling-temporal-the-basics&text=$Scaling%20Temporal%3A%20The%20basics&via=temporalio "Share on X") [](https://bsky.app/intent/compose?text=Scaling%20Temporal%3A%20The%20basics%0Ahttps%3A%2F%2Ftemporal.io%2Fblog%2Fscaling-temporal-the-basics "Share on Bluesky") [](https://www.linkedin.com/shareArticle?url=https%3A%2F%2Ftemporal.io%2Fblog%2Fscaling-temporal-the-basics "Share on LinkedIn") [](https://www.hackernews.com/submitlink?u=https%3A%2F%2Ftemporal.io%2Fblog%2Fscaling-temporal-the-basics&t=Scaling%20Temporal%3A%20The%20basics "Share on Hacker News")
Temporal Cloud
Ready to see for yourself?
Sign up for Temporal Cloud today and get $1,000 in free credits.
[ Get started ](https://temporal.io/get-cloud)
### More Posts
  * Jun 11, 2026 [Temporal Concepts](https://temporal.io/blog/categories/temporal-concepts) 15 MIN READ
[Coordinate access to shared resources with a distributed lock built on Temporal Workflows](https://temporal.io/blog/coordinate-access-to-shared-resources-with-a-distributed-lock-built-on-temporal-workflows)
  * Jun 03, 2026 [Temporal Concepts](https://temporal.io/blog/categories/temporal-concepts) 27 MIN READ
[Track customer loyalty points with durable workflows](https://temporal.io/blog/entity-workflow-loyalty-points)


Build invincible applications
It sounds like magic, we promise it's not.
[ Documentation ](https://docs.temporal.io)[ Code Base ](https://github.com/temporalio)[ Samples ](https://learn.temporal.io/examples)
[ALL SYSTEMS OPERATIONAL ](https://status.temporal.io/)
Sign up for our newsletter
Email Address
Discover
[Overview](https://temporal.io/product)[How Temporal Works](https://temporal.io/how-it-works)[Temporal Cloud](https://temporal.io/cloud)[Pricing](https://temporal.io/pricing)[Security](https://temporal.io/security)[Trust Center](https://trust.temporal.io)[Startups](https://temporal.io/startup)
Explore
[Customer Stories](https://temporal.io/in-use)[Project-based tutorials](https://learn.temporal.io/tutorials/)[Example applications](https://learn.temporal.io/examples/)[Code Exchange](https://temporal.io/code-exchange)[Replay 2026 Recap](https://temporal.io/replay/2026)[Ask an expert](https://pages.temporal.io/ask-an-expert)[Blog](https://temporal.io/blog)
Developers
[Getting Started with Temporal](https://docs.temporal.io/quickstarts)[Start building your next app](https://docs.temporal.io/develop)[Temporal Cloud docs](https://docs.temporal.io/cloud)[Production deployments](https://docs.temporal.io/production-deployment)[Temporal 101](https://learn.temporal.io/courses/temporal_101/)[Temporal 102](https://learn.temporal.io/courses/temporal_102/)[Introduction to Temporal Cloud](https://learn.temporal.io/courses/intro_to_temporal_cloud/)
Community
[Join our Slack group](https://t.mp/slack)[Find a meetup near you](https://temporal.io/community)[Community forum](https://community.temporal.io/)[Events](https://temporal.io/events)
Company
[About](https://temporal.io/about)[Careers](https://temporal.io/careers)[News](https://temporal.io/news)[Contact us](https://pages.temporal.io/contact-us)[Partners](https://temporal.io/partners)
2026 © Temporal Technologies. All Rights Reserved.
[Privacy Policy](https://temporal.io/global-privacy-policy) [Candidate Privacy Policy](https://temporal.io/candidate-privacy-policy) [Terms of Service](https://temporal.io/terms-of-service) [Code of Conduct](https://temporal.io/code-of-conduct) [Sitemap](https://temporal.io/sitemap) Your Privacy Choices
[](https://www.youtube.com/temporalio) [](https://twitter.com/temporalio) [](https://github.com/temporalio) [](https://www.linkedin.com/company/temporal-technologies) [](https://t.mp/slack)
Cookie Policy
We use cookies and similar technologies to help personalize content, tailor and measure ads, and provide a better experience. By clicking Accept, you agree to this as outlined in our [cookie policy](https://temporal.io/temporal-cookie-policy).
Do not sell or share my personal information.
Accept Decline

