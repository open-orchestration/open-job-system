---
id: d1f3c9011
topic: gap-fill
title: "KEDA event-driven autoscaling: ScaledObject vs ScaledJob"
status: draft
shape: comparison
---

# KEDA event-driven autoscaling: ScaledObject vs ScaledJob

KEDA scales event-driven workloads through two distinct custom resources: a `ScaledObject` for scaling Deployments, StatefulSets, and Custom Resources, and a `ScaledJob` for running and scaling work as Kubernetes Jobs. The two address different processing shapes — long-lived replicas that each pull many events versus one Job per event — and the choice between them turns largely on whether the work is long-running.

## ScaledObject — scaling Deployments, StatefulSets & Custom Resources

A ScaledObject lets you define the Kubernetes Deployment or StatefulSet that you want KEDA to scale based on a scale trigger, and KEDA monitors that service and automatically scales the resource out/in based on the events that occur [c3d1ba0f9]. Deployments and StatefulSets are the most common way to scale workloads with KEDA [c3d1ba0f9]. Behind the scenes, KEDA monitors the event source and feeds that data to Kubernetes and the HPA (Horizontal Pod Autoscaler) to drive rapid scale of a resource, with each replica of the resource actively pulling items from the event source [c3d1ba0f9]. Scaling with Deployments/StatefulSets lets you scale based on events while preserving rich connection and processing semantics with the event source, such as in-order processing, retries, deadletter, and checkpointing [c3d1ba0f9].

KEDA can also scale any workload defined as a Custom Resource (for example an `ArgoRollout` resource), and the scaling behaves the same way as scaling an arbitrary Kubernetes Deployment or StatefulSet [c3d1ba0f9]. The only constraint is that the target Custom Resource must define a `/scale` subresource [c3d1ba0f9].

### Scale-to-zero and the two-phase scaling model

Using a Kafka topic as an example event source: when no messages are pending processing, KEDA can scale the deployment to zero; when a message arrives, KEDA detects the event and activates the deployment; as more messages arrive, KEDA feeds the data to the HPA to drive scale out, and each replica processes messages, very likely a batch in a distributed manner [c3d1ba0f9].

KEDA has two distinct phases during autoscaling [c3d1ba0f9]. In the **activation phase**, KEDA (the operator) decides whether the workload should be scaled from/to zero, based on the result of the scaler's `IsActive` function, and this applies only to 0<->1 scaling [c3d1ba0f9]. In the **scaling phase**, once KEDA has decided to scale out to 1 instance, the HPA controller takes scaling decisions based on the generated HPA configuration and the metrics exposed by KEDA, and this phase applies to 1<->N scaling [c3d1ba0f9]. If the minimum replicas is >= 1, the scaler is always active and the activation value is ignored [c3d1ba0f9]. The activation value is always optional with a default of 0, while the scaling value is not [c3d1ba0f9].

### Polling interval, caching, and pausing

Metric caching is governed by the polling interval specified in `.spec.pollingInterval`: enabling `useCachedMetrics` makes the KEDA Metrics Server read the metric from a cache (updated periodically during the polling interval) rather than querying the scaler on every HPA request, which can significantly reduce load on the scaler service [c3d1ba0f9]. This caching feature is not supported for the `cpu`, `memory`, or `cron` scaler [c3d1ba0f9]. Autoscaling can be paused by adding the `autoscaling.keda.sh/paused` or `autoscaling.keda.sh/paused-replicas: "<number>"` annotation to the `ScaledObject` definition: `paused` pauses scaling immediately at the current instance count, while `paused-replicas` scales the workload to the specified replica count and then pauses [c3d1ba0f9].

### Long-running executions are the weak spot

A key consideration is that this replica-based pattern handles long-running executions poorly: if a deployment processes RabbitMQ messages that each take 3 hours, and the HPA scales down from 4 replicas to 2, there is no way to control which replicas are terminated, so the HPA may terminate a replica that is 2.9 hours into a 3-hour message [c3d1ba0f9]. One mitigation is to leverage Kubernetes container lifecycle hooks to delay termination until the current batch completes, though the pod will remain in the `Terminating` state during that delay [c3d1ba0f9]. The other alternative the doc gives for long-running executions is to run the event-driven code in Kubernetes Jobs instead of Deployments or Custom Resources [c3d1ba0f9].

## ScaledJob — scaling Kubernetes Jobs

As an alternate to scaling event-driven code as deployments, you can run and scale your code as Kubernetes Jobs, and the primary reason to consider this option is to handle processing long-running executions [c9e3c6415]. Rather than processing multiple events within a deployment, a single Kubernetes Job is scheduled for each detected event; that job initializes, pulls a single event from the message source, processes to completion, and terminates [c9e3c6415].

For a RabbitMQ queue, the flow is: when no messages await processing, no jobs are created; when a message arrives, KEDA creates a job; when the job starts running it pulls a single message and processes it to completion; as additional messages arrive, additional jobs are created, each processing a single message to completion; and completed/failed jobs are periodically removed per `SuccessfulJobsHistoryLimit` and `FailedJobsHistoryLimit` [c9e3c6415].

A ScaledJob is configured with a `jobTargetRef` (the Job template) plus fields including `pollingInterval` (Optional, Default: 30 seconds), `maxReplicaCount` (Optional, Default: 100), `successfulJobsHistoryLimit` (Optional, Default: 100 — how many completed jobs to keep), and `failedJobsHistoryLimit` (Optional, Default: 100 — how many failed jobs to keep) [c9e3c6415]. A `scalingStrategy` block selects the scaling strategy (Default: `default`), with `customScalingQueueLengthDeduction` and `customScalingRunningJobPercentage` available to tune the `custom` strategy [c9e3c6415]. Autoscaling of a ScaledJob can be paused by adding the `autoscaling.keda.sh/paused: true` annotation to the `ScaledJob` definition, and re-enabled by removing the annotation or setting its value to `false` [c9e3c6415].

## When to use each

Use a **ScaledObject** when you want long-lived replicas that each actively pull and process many events while preserving connection/processing semantics such as in-order processing, retries, deadletter, and checkpointing — the most common KEDA pattern for Deployments and StatefulSets [c3d1ba0f9]. Use a **ScaledJob** when the primary concern is processing long-running executions, scheduling one Kubernetes Job per detected event so each job pulls a single event and runs it to completion without risk of mid-processing termination from replica scale-down [c9e3c6415].
