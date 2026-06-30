---
id: d87204291
topic: data-pipeline
title: "Data-Pipeline Job Scheduling: Apache Spark and Apache NiFi"
status: draft
shape: survey
---

# Data-Pipeline Job Scheduling: Apache Spark and Apache NiFi

Survey of how two Apache data-pipeline engines schedule and execute work. Spark claims carry only `[cfb07f903]`; NiFi claims carry only `[cfaca0434]`.

## Apache Spark

Spark has several facilities for scheduling resources between computations [cfb07f903]. Each Spark application (instance of SparkContext) runs an independent set of executor processes [cfb07f903]. The cluster managers that Spark runs on provide facilities for scheduling across applications [cfb07f903]. Within each Spark application, multiple "jobs" (Spark actions) may run concurrently if they were submitted by different threads — common when the application serves requests over the network [cfb07f903]. Spark includes a fair scheduler to schedule resources within each SparkContext [cfb07f903].

### Scheduling across applications (cluster-manager level)

When running on a cluster, each Spark application gets an independent set of executor JVMs that only run tasks and store data for that application [cfb07f903]. The simplest option, available on all cluster managers, is *static partitioning* of resources: each application is given a maximum amount of resources it can use and holds onto them for its whole duration — the approach used in standalone, YARN, and K8s modes [cfb07f903]. In standalone mode, by default applications run in FIFO (first-in-first-out) order and each tries to use all available nodes, limitable via `spark.cores.max` [cfb07f903]. None of the modes currently provide memory sharing across applications [cfb07f903].

*Dynamic Resource Allocation* is a mechanism to dynamically adjust the resources an application occupies based on the workload — giving resources back to the cluster when no longer used and requesting them again when there is demand [cfb07f903]. It is disabled by default and available on all coarse-grained cluster managers (standalone, YARN, K8s mode), and requires `spark.dynamicAllocation.enabled` set to `true` [cfb07f903]. Under the request policy, an application requests additional executors when it has pending tasks waiting to be scheduled, requesting executors in rounds with the number increasing exponentially from the previous round [cfb07f903]. Under the remove policy, an application removes an executor when it has been idle for more than `spark.dynamicAllocation.executorIdleTimeout` seconds [cfb07f903].

### Scheduling within an application (FIFO default vs fair scheduler)

Inside a given SparkContext instance, multiple parallel jobs can run simultaneously if they were submitted from separate threads; a "job" means a Spark action (e.g. `save`, `collect`) and any tasks needed to evaluate it, and Spark's scheduler is fully thread-safe [cfb07f903]. By default, Spark's scheduler runs jobs in FIFO fashion: each job is divided into "stages" (e.g. map and reduce phases), and the first job gets priority on all available resources while its stages have tasks to launch, then the second job, etc. [cfb07f903]. Starting in Spark 0.8 it is also possible to configure fair sharing between jobs; under fair sharing Spark assigns tasks between jobs in a "round robin" fashion so all jobs get a roughly equal share of cluster resources — best for multi-user settings [cfb07f903]. The fair scheduler is enabled by setting the `spark.scheduler.mode` property to `FAIR` [cfb07f903].

The fair scheduler supports grouping jobs into *pools* and setting different scheduling options (e.g. weight) for each pool, e.g. a "high-priority" pool; this approach is modeled after the Hadoop Fair Scheduler [cfb07f903]. Without intervention, newly submitted jobs go into a *default pool*, but a job's pool is set by adding the `spark.scheduler.pool` local property to the SparkContext in the submitting thread [cfb07f903]. By default each pool gets an equal share of the cluster, but inside each pool jobs run in FIFO order [cfb07f903]. Each pool supports three properties: `schedulingMode` (FIFO or FAIR), `weight` (its share relative to other pools), and `minShare` (a minimum number of CPU cores) [cfb07f903]. PySpark by default does not synchronize PVM threads with JVM threads, so launching multiple jobs in multiple PVM threads does not guarantee each job launches in its corresponding JVM thread; `pyspark.InheritableThread` is recommended [cfb07f903].

## Apache NiFi

Apache NiFi is a dataflow system based on the concepts of flow-based programming [cfaca0434]. It supports powerful and scalable directed graphs of data routing, transformation, and system mediation logic [cfaca0434]. NiFi has a web-based user interface for design, control, feedback, and monitoring of dataflows [cfaca0434].

### Configurable quality-of-service tradeoffs

NiFi is highly configurable along several dimensions of quality of service, such as loss-tolerant versus guaranteed delivery, low latency versus high throughput, and priority-based queuing [cfaca0434]. NiFi provides fine-grained data provenance for all data received, forked, joined, cloned, modified, sent, and ultimately dropped upon reaching its configured end-state [cfaca0434].

## Dropped sources

None. Both cited sources were anchored to their document bodies.

## Cross-check

- **Spark terms** (`spark-job-scheduling.md`): "static partitioning", FIFO (first-in-first-out), `spark.cores.max`, Dynamic Resource Allocation, `spark.dynamicAllocation.enabled`, request/remove policy, `executorIdleTimeout`, "stages", fair sharing "round robin", Spark 0.8, `spark.scheduler.mode=FAIR`, pools, `spark.scheduler.pool`, `schedulingMode`/`weight`/`minShare`, Hadoop Fair Scheduler, `pyspark.InheritableThread` — all verified in body prose.
- **NiFi terms** (`nifi-docs.md`): "flow-based programming", "directed graphs", "web-based user interface for design, control, feedback, and monitoring", "loss-tolerant versus guaranteed delivery, low latency versus high throughput, and priority-based queuing", "fine-grained data provenance" — all verified in the Overview body paragraph.
- **Back pressure**: NOT present in NiFi body prose; the only occurrence is a nav/component link (`RestrictBackpressureSettings`). Per body-only rule, no back-pressure claim was made.
- No cross-attribution: every Spark sentence cites only `[cfb07f903]`; every NiFi sentence cites only `[cfaca0434]`.
