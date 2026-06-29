[![](https://spark.apache.org/images/spark-logo-rev.svg)](https://spark.apache.org/docs/latest/index.html) 4.1.2

- [Overview](https://spark.apache.org/docs/latest/index.html)
- [Programming Guides](https://spark.apache.org/docs/latest/job-scheduling.html#)
[Quick Start](https://spark.apache.org/docs/latest/quick-start.html) [RDDs, Accumulators, Broadcasts Vars](https://spark.apache.org/docs/latest/rdd-programming-guide.html) [SQL, DataFrames, and Datasets](https://spark.apache.org/docs/latest/sql-programming-guide.html) [Structured Streaming](https://spark.apache.org/docs/latest/streaming/index.html) [Spark Streaming (DStreams)](https://spark.apache.org/docs/latest/streaming-programming-guide.html) [MLlib (Machine Learning)](https://spark.apache.org/docs/latest/ml-guide.html) [GraphX (Graph Processing)](https://spark.apache.org/docs/latest/graphx-programming-guide.html) [SparkR (R on Spark)](https://spark.apache.org/docs/latest/sparkr.html) [PySpark (Python on Spark)](https://spark.apache.org/docs/latest/api/python/getting_started/index.html) [Declarative Pipelines](https://spark.apache.org/docs/latest/declarative-pipelines-programming-guide.html)

- [API Docs](https://spark.apache.org/docs/latest/job-scheduling.html#)
[Python](https://spark.apache.org/docs/latest/api/python/index.html) [Scala](https://spark.apache.org/docs/latest/api/scala/org/apache/spark/index.html) [Java](https://spark.apache.org/docs/latest/api/java/index.html) [R](https://spark.apache.org/docs/latest/api/R/index.html) [SQL, Built-in Functions](https://spark.apache.org/docs/latest/api/sql/index.html)

- [Deploying](https://spark.apache.org/docs/latest/job-scheduling.html#)
[Overview](https://spark.apache.org/docs/latest/cluster-overview.html) [Submitting Applications](https://spark.apache.org/docs/latest/submitting-applications.html)



[Spark Standalone](https://spark.apache.org/docs/latest/spark-standalone.html) [YARN](https://spark.apache.org/docs/latest/running-on-yarn.html) [Kubernetes](https://spark.apache.org/docs/latest/running-on-kubernetes.html)

- [More](https://spark.apache.org/docs/latest/job-scheduling.html#)
[Configuration](https://spark.apache.org/docs/latest/configuration.html) [Monitoring](https://spark.apache.org/docs/latest/monitoring.html) [Tuning Guide](https://spark.apache.org/docs/latest/tuning.html) [Job Scheduling](https://spark.apache.org/docs/latest/job-scheduling.html) [Security](https://spark.apache.org/docs/latest/security.html) [Hardware Provisioning](https://spark.apache.org/docs/latest/hardware-provisioning.html) [Migration Guide](https://spark.apache.org/docs/latest/migration-guide.html)



[Building Spark](https://spark.apache.org/docs/latest/building-spark.html) [Contributing to Spark](https://spark.apache.org/contributing.html) [Third Party Projects](https://spark.apache.org/third-party-projects.html)

- ```

```


# Job Scheduling [Anchor link for: job scheduling](https://spark.apache.org/docs/latest/job-scheduling.html\#job-scheduling)

- [Overview](https://spark.apache.org/docs/latest/job-scheduling.html#overview)
- [Scheduling Across Applications](https://spark.apache.org/docs/latest/job-scheduling.html#scheduling-across-applications)
  - [Dynamic Resource Allocation](https://spark.apache.org/docs/latest/job-scheduling.html#dynamic-resource-allocation)
    - [Configuration and Setup](https://spark.apache.org/docs/latest/job-scheduling.html#configuration-and-setup)
    - [Caveats](https://spark.apache.org/docs/latest/job-scheduling.html#caveats)
    - [Resource Allocation Policy](https://spark.apache.org/docs/latest/job-scheduling.html#resource-allocation-policy)
      - [Request Policy](https://spark.apache.org/docs/latest/job-scheduling.html#request-policy)
      - [Remove Policy](https://spark.apache.org/docs/latest/job-scheduling.html#remove-policy)
    - [Graceful Decommission of Executors](https://spark.apache.org/docs/latest/job-scheduling.html#graceful-decommission-of-executors)
- [Scheduling Within an Application](https://spark.apache.org/docs/latest/job-scheduling.html#scheduling-within-an-application)
  - [Fair Scheduler Pools](https://spark.apache.org/docs/latest/job-scheduling.html#fair-scheduler-pools)
  - [Default Behavior of Pools](https://spark.apache.org/docs/latest/job-scheduling.html#default-behavior-of-pools)
  - [Configuring Pool Properties](https://spark.apache.org/docs/latest/job-scheduling.html#configuring-pool-properties)
  - [Scheduling using JDBC Connections](https://spark.apache.org/docs/latest/job-scheduling.html#scheduling-using-jdbc-connections)
  - [Concurrent Jobs in PySpark](https://spark.apache.org/docs/latest/job-scheduling.html#concurrent-jobs-in-pyspark)

# Overview [Anchor link for: overview](https://spark.apache.org/docs/latest/job-scheduling.html\#overview)

Spark has several facilities for scheduling resources between computations. First, recall that, as described
in the [cluster mode overview](https://spark.apache.org/docs/latest/cluster-overview.html), each Spark application (instance of SparkContext)
runs an independent set of executor processes. The cluster managers that Spark runs on provide
facilities for [scheduling across applications](https://spark.apache.org/docs/latest/job-scheduling.html#scheduling-across-applications). Second,
_within_ each Spark application, multiple “jobs” (Spark actions) may be running concurrently
if they were submitted by different threads. This is common if your application is serving requests
over the network. Spark includes a [fair scheduler](https://spark.apache.org/docs/latest/job-scheduling.html#scheduling-within-an-application) to schedule resources within each SparkContext.

# Scheduling Across Applications [Anchor link for: scheduling across applications](https://spark.apache.org/docs/latest/job-scheduling.html\#scheduling-across-applications)

When running on a cluster, each Spark application gets an independent set of executor JVMs that only
run tasks and store data for that application. If multiple users need to share your cluster, there are
different options to manage allocation, depending on the cluster manager.

The simplest option, available on all cluster managers, is _static partitioning_ of resources. With
this approach, each application is given a maximum amount of resources it can use and holds onto them
for its whole duration. This is the approach used in Spark’s [standalone](https://spark.apache.org/docs/latest/spark-standalone.html)
and [YARN](https://spark.apache.org/docs/latest/running-on-yarn.html) modes, as well as the [K8s](https://spark.apache.org/docs/latest/running-on-kubernetes.html) mode.
Resource allocation can be configured as follows, based on the cluster type:

- **Standalone mode:** By default, applications submitted to the standalone mode cluster will run in
FIFO (first-in-first-out) order, and each application will try to use all available nodes. You can limit
the number of nodes an application uses by setting the `spark.cores.max` configuration property in it,
or change the default for applications that don’t set this setting through `spark.deploy.defaultCores`.
Finally, in addition to controlling cores, each application’s `spark.executor.memory` setting controls
its memory use.
- **YARN:** The `--num-executors` option to the Spark YARN client controls how many executors it will allocate
on the cluster (`spark.executor.instances` as configuration property), while `--executor-memory`
(`spark.executor.memory` configuration property) and `--executor-cores` (`spark.executor.cores` configuration
property) control the resources per executor. For more information, see the
[YARN Spark Properties](https://spark.apache.org/docs/latest/running-on-yarn.html#spark-properties).
- **K8s:** The same as the situation with Yarn, please refer to the description of Yarn above. Furthermore,
Spark on K8s offers higher priority versions of `spark.kubernetes.executor.limit.cores` and
`spark.kubernetes.executor.request.cores` than `spark.executor.cores`. For more information, see the
[K8s Spark Properties](https://spark.apache.org/docs/latest/running-on-kubernetes.html#spark-properties).

Note that none of the modes currently provide memory sharing across applications. If you would like to share
data this way, we recommend running a single server application that can serve multiple requests by querying
the same RDDs.

## Dynamic Resource Allocation [Anchor link for: dynamic resource allocation](https://spark.apache.org/docs/latest/job-scheduling.html\#dynamic-resource-allocation)

Spark provides a mechanism to dynamically adjust the resources your application occupies based
on the workload. This means that your application may give resources back to the cluster if they
are no longer used and request them again later when there is demand. This feature is particularly
useful if multiple applications share resources in your Spark cluster.

This feature is disabled by default and available on all coarse-grained cluster managers, i.e.
[standalone mode](https://spark.apache.org/docs/latest/spark-standalone.html), [YARN mode](https://spark.apache.org/docs/latest/running-on-yarn.html) and [K8s mode](https://spark.apache.org/docs/latest/running-on-kubernetes.html).

### Configuration and Setup [Anchor link for: configuration and setup](https://spark.apache.org/docs/latest/job-scheduling.html\#configuration-and-setup)

There are several ways for using this feature.
Regardless of which approach you choose, your application must set `spark.dynamicAllocation.enabled` to `true` first, additionally,

- your application must set `spark.shuffle.service.enabled` to `true` after you set up an _external shuffle service_ on each worker node in the same cluster, or
- your application must set `spark.dynamicAllocation.shuffleTracking.enabled` to `true`, or
- your application must set both `spark.decommission.enabled` and `spark.storage.decommission.shuffleBlocks.enabled` to `true`, or
- your application must configure `spark.shuffle.sort.io.plugin.class` to use a custom `ShuffleDataIO` who’s `ShuffleDriverComponents` supports reliable storage.

The purpose of the external shuffle service or the shuffle tracking or the `ShuffleDriverComponents` supports reliable storage is to allow executors to be removed
without deleting shuffle files written by them (more detail described
[below](https://spark.apache.org/docs/latest/job-scheduling.html#graceful-decommission-of-executors)). While it is simple to enable shuffle tracking, the way to set up the external shuffle service varies across cluster managers:

In standalone mode, simply start your workers with `spark.shuffle.service.enabled` set to `true`.

In YARN mode, follow the instructions [here](https://spark.apache.org/docs/latest/running-on-yarn.html#configuring-the-external-shuffle-service).

All other relevant configurations are optional and under the `spark.dynamicAllocation.*` and
`spark.shuffle.service.*` namespaces. For more detail, see the
[configurations page](https://spark.apache.org/docs/latest/configuration.html#dynamic-allocation).

### Caveats [Anchor link for: caveats](https://spark.apache.org/docs/latest/job-scheduling.html\#caveats)

- In [standalone mode](https://spark.apache.org/docs/latest/spark-standalone.html), without explicitly setting `spark.executor.cores`, each executor will get all the available cores of a worker. In this case, when dynamic allocation enabled, spark will possibly acquire much more executors than expected. When you want to use dynamic allocation in [standalone mode](https://spark.apache.org/docs/latest/spark-standalone.html), you are recommended to explicitly set cores for each executor before the issue [SPARK-30299](https://issues.apache.org/jira/browse/SPARK-30299) got fixed.
- In [K8s mode](https://spark.apache.org/docs/latest/running-on-kubernetes.html), we can not use this feature by setting `spark.shuffle.service.enabled` to `true` due to Spark on K8s doesn’t yet support the external shuffle service.

### Resource Allocation Policy [Anchor link for: resource allocation policy](https://spark.apache.org/docs/latest/job-scheduling.html\#resource-allocation-policy)

At a high level, Spark should relinquish executors when they are no longer used and acquire
executors when they are needed. Since there is no definitive way to predict whether an executor
that is about to be removed will run a task in the near future, or whether a new executor that is
about to be added will actually be idle, we need a set of heuristics to determine when to remove
and request executors.

#### Request Policy [Anchor link for: request policy](https://spark.apache.org/docs/latest/job-scheduling.html\#request-policy)

A Spark application with dynamic allocation enabled requests additional executors when it has
pending tasks waiting to be scheduled. This condition necessarily implies that the existing set
of executors is insufficient to simultaneously saturate all tasks that have been submitted but
not yet finished.

Spark requests executors in rounds. The actual request is triggered when there have been pending
tasks for `spark.dynamicAllocation.schedulerBacklogTimeout` seconds, and then triggered again
every `spark.dynamicAllocation.sustainedSchedulerBacklogTimeout` seconds thereafter if the queue
of pending tasks persists. Additionally, the number of executors requested in each round increases
exponentially from the previous round. For instance, an application will add 1 executor in the
first round, and then 2, 4, 8 and so on executors in the subsequent rounds.

The motivation for an exponential increase policy is twofold. First, an application should request
executors cautiously in the beginning in case it turns out that only a few additional executors is
sufficient. This echoes the justification for TCP slow start. Second, the application should be
able to ramp up its resource usage in a timely manner in case it turns out that many executors are
actually needed.

#### Remove Policy [Anchor link for: remove policy](https://spark.apache.org/docs/latest/job-scheduling.html\#remove-policy)

The policy for removing executors is much simpler. A Spark application removes an executor when
it has been idle for more than `spark.dynamicAllocation.executorIdleTimeout` seconds. Note that,
under most circumstances, this condition is mutually exclusive with the request condition, in that
an executor should not be idle if there are still pending tasks to be scheduled.

### Graceful Decommission of Executors [Anchor link for: graceful decommission of executors](https://spark.apache.org/docs/latest/job-scheduling.html\#graceful-decommission-of-executors)

Before dynamic allocation, if a Spark executor exits when the associated application has also exited
then all state associated with the executor is no longer needed and can be safely discarded.
With dynamic allocation, however, the application is still running when an executor is explicitly
removed. If the application attempts to access state stored in or written by the executor, it will
have to perform a recompute the state. Thus, Spark needs a mechanism to decommission an executor
gracefully by preserving its state before removing it.

This requirement is especially important for shuffles. During a shuffle, the Spark executor first
writes its own map outputs locally to disk, and then acts as the server for those files when other
executors attempt to fetch them. In the event of stragglers, which are tasks that run for much
longer than their peers, dynamic allocation may remove an executor before the shuffle completes,
in which case the shuffle files written by that executor must be recomputed unnecessarily.

The solution for preserving shuffle files is to use an external shuffle service, also introduced
in Spark 1.2. This service refers to a long-running process that runs on each node of your cluster
independently of your Spark applications and their executors. If the service is enabled, Spark
executors will fetch shuffle files from the service instead of from each other. This means any
shuffle state written by an executor may continue to be served beyond the executor’s lifetime.

In addition to writing shuffle files, executors also cache data either on disk or in memory.
When an executor is removed, however, all cached data will no longer be accessible. To mitigate this,
by default executors containing cached data are never removed. You can configure this behavior with
`spark.dynamicAllocation.cachedExecutorIdleTimeout`. When set `spark.shuffle.service.fetch.rdd.enabled`
to `true`, Spark can use ExternalShuffleService for fetching disk persisted RDD blocks. In case of
dynamic allocation if this feature is enabled executors having only disk persisted blocks are considered
idle after `spark.dynamicAllocation.executorIdleTimeout` and will be released accordingly. In future releases,
the cached data may be preserved through an off-heap storage similar in spirit to how shuffle files are preserved
through the external shuffle service.

# Scheduling Within an Application [Anchor link for: scheduling within an application](https://spark.apache.org/docs/latest/job-scheduling.html\#scheduling-within-an-application)

Inside a given Spark application (SparkContext instance), multiple parallel jobs can run simultaneously if
they were submitted from separate threads. By “job”, in this section, we mean a Spark action (e.g. `save`,
`collect`) and any tasks that need to run to evaluate that action. Spark’s scheduler is fully thread-safe
and supports this use case to enable applications that serve multiple requests (e.g. queries for
multiple users).

By default, Spark’s scheduler runs jobs in FIFO fashion. Each job is divided into “stages” (e.g. map and
reduce phases), and the first job gets priority on all available resources while its stages have tasks to
launch, then the second job gets priority, etc. If the jobs at the head of the queue don’t need to use
the whole cluster, later jobs can start to run right away, but if the jobs at the head of the queue are
large, then later jobs may be delayed significantly.

Starting in Spark 0.8, it is also possible to configure fair sharing between jobs. Under fair sharing,
Spark assigns tasks between jobs in a “round robin” fashion, so that all jobs get a roughly equal share
of cluster resources. This means that short jobs submitted while a long job is running can start receiving
resources right away and still get good response times, without waiting for the long job to finish. This
mode is best for multi-user settings.

This feature is disabled by default and available on all coarse-grained cluster managers, i.e.
[standalone mode](https://spark.apache.org/docs/latest/spark-standalone.html), [YARN mode](https://spark.apache.org/docs/latest/running-on-yarn.html),
[K8s mode](https://spark.apache.org/docs/latest/running-on-kubernetes.html).
To enable the fair scheduler, simply set the `spark.scheduler.mode` property to `FAIR` when configuring
a SparkContext:

```scala
val conf = new SparkConf().setMaster(...).setAppName(...)
conf.set("spark.scheduler.mode", "FAIR")
val sc = new SparkContext(conf)
```

## Fair Scheduler Pools [Anchor link for: fair scheduler pools](https://spark.apache.org/docs/latest/job-scheduling.html\#fair-scheduler-pools)

The fair scheduler also supports grouping jobs into _pools_, and setting different scheduling options
(e.g. weight) for each pool. This can be useful to create a “high-priority” pool for more important jobs,
for example, or to group the jobs of each user together and give _users_ equal shares regardless of how
many concurrent jobs they have instead of giving _jobs_ equal shares. This approach is modeled after the
[Hadoop Fair Scheduler](http://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/FairScheduler.html).

Without any intervention, newly submitted jobs go into a _default pool_, but jobs’ pools can be set by
adding the `spark.scheduler.pool` “local property” to the SparkContext in the thread that’s submitting them.
This is done as follows:

```scala
// Assuming sc is your SparkContext variable
sc.setLocalProperty("spark.scheduler.pool", "pool1")
```

After setting this local property, _all_ jobs submitted within this thread (by calls in this thread
to `RDD.save`, `count`, `collect`, etc) will use this pool name. The setting is per-thread to make
it easy to have a thread run multiple jobs on behalf of the same user. If you’d like to clear the
pool that a thread is associated with, simply call:

```scala
sc.setLocalProperty("spark.scheduler.pool", null)
```

## Default Behavior of Pools [Anchor link for: default behavior of pools](https://spark.apache.org/docs/latest/job-scheduling.html\#default-behavior-of-pools)

By default, each pool gets an equal share of the cluster (also equal in share to each job in the default
pool), but inside each pool, jobs run in FIFO order. For example, if you create one pool per user, this
means that each user will get an equal share of the cluster, and that each user’s queries will run in
order instead of later queries taking resources from that user’s earlier ones.

## Configuring Pool Properties [Anchor link for: configuring pool properties](https://spark.apache.org/docs/latest/job-scheduling.html\#configuring-pool-properties)

Specific pools’ properties can also be modified through a configuration file. Each pool supports three
properties:

- `schedulingMode`: This can be FIFO or FAIR, to control whether jobs within the pool queue up behind
each other (the default) or share the pool’s resources fairly.
- `weight`: This controls the pool’s share of the cluster relative to other pools. By default, all pools
have a weight of 1. If you give a specific pool a weight of 2, for example, it will get 2x more
resources as other active pools. Setting a high weight such as 1000 also makes it possible to implement
_priority_ between pools—in essence, the weight-1000 pool will always get to launch tasks first
whenever it has jobs active.
- `minShare`: Apart from an overall weight, each pool can be given a _minimum shares_ (as a number of
CPU cores) that the administrator would like it to have. The fair scheduler always attempts to meet
all active pools’ minimum shares before redistributing extra resources according to the weights.
The `minShare` property can, therefore, be another way to ensure that a pool can always get up to a
certain number of resources (e.g. 10 cores) quickly without giving it a high priority for the rest
of the cluster. By default, each pool’s `minShare` is 0.

The pool properties can be set by creating an XML file, similar to `conf/fairscheduler.xml.template`,
and either putting a file named `fairscheduler.xml` on the classpath, or setting `spark.scheduler.allocation.file` property in your
[SparkConf](https://spark.apache.org/docs/latest/configuration.html#spark-properties). The file path respects the hadoop configuration and can either be a local file path or HDFS file path.

```scala
// scheduler file at local
conf.set("spark.scheduler.allocation.file", "file:///path/to/file")
// scheduler file at hdfs
conf.set("spark.scheduler.allocation.file", "hdfs:///path/to/file")
```

The format of the XML file is simply a `<pool>` element for each pool, with different elements
within it for the various settings. For example:

```xml
<?xml version="1.0"?>
<allocations>
  <pool name="production">
    <schedulingMode>FAIR</schedulingMode>
    <weight>1</weight>
    <minShare>2</minShare>
  </pool>
  <pool name="test">
    <schedulingMode>FIFO</schedulingMode>
    <weight>2</weight>
    <minShare>3</minShare>
  </pool>
</allocations>
```

A full example is also available in `conf/fairscheduler.xml.template`. Note that any pools not
configured in the XML file will simply get default values for all settings (scheduling mode FIFO,
weight 1, and minShare 0).

## Scheduling using JDBC Connections [Anchor link for: scheduling using jdbc connections](https://spark.apache.org/docs/latest/job-scheduling.html\#scheduling-using-jdbc-connections)

To set a [Fair Scheduler](https://spark.apache.org/docs/latest/job-scheduling.html#fair-scheduler-pools) pool for a JDBC client session,
users can set the `spark.sql.thriftserver.scheduler.pool` variable:

```sql
SET spark.sql.thriftserver.scheduler.pool=accounting;
```

## Concurrent Jobs in PySpark [Anchor link for: concurrent jobs in pyspark](https://spark.apache.org/docs/latest/job-scheduling.html\#concurrent-jobs-in-pyspark)

PySpark, by default, does not support to synchronize PVM threads with JVM threads and
launching multiple jobs in multiple PVM threads does not guarantee to launch each job
in each corresponding JVM thread. Due to this limitation, it is unable to set a different job group
via `sc.setJobGroup` in a separate PVM thread, which also disallows to cancel the job via `sc.cancelJobGroup`
later.

`pyspark.InheritableThread` is recommended to use together for a PVM thread to inherit the inheritable attributes
such as local properties in a JVM thread.