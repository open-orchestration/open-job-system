---
id: d2067494d
topic: cloud-azure
title: Azure managed job primitives and how they mirror the AWS stack
status: draft
shape: survey
---

# Azure managed job primitives and how they mirror the AWS stack

**Scope.** The managed Azure building blocks for a job system, from Microsoft Learn docs.
Covers Durable Functions, Service Bus, Queue Storage, Container Apps jobs, Event Grid, and
Batch. Establishes that Azure offers a primitive per layer parallel to AWS.

## Key claims (cited)

- **Orchestration — Durable Functions.** An **extension of Azure Functions** that lets you
  build **stateful workflows in a serverless environment** by writing **orchestrator,
  activity, and entity functions in code**, with the runtime managing state and checkpointing
  [ce4cbbd94].
- **Broker — Service Bus.** A **fully managed enterprise message broker** with message queues
  and publish-subscribe topics, used to decouple applications and services [c0008efe4].
- **Simple queue — Queue Storage.** A service for **storing large numbers of messages**,
  accessed over authenticated HTTP/HTTPS calls, with a message size up to **64 KB**
  [c6f022566].
- **Compute/jobs — Container Apps jobs.** Run **containerized tasks that run for a finite
  duration and then stop** — data processing, ML, or any on-demand scenario (run-to-completion)
  [c316f2ab2].
- **Eventing — Event Grid.** A **highly scalable, fully managed publish-subscribe service for
  message distribution**, supporting MQTT [c095a005f].
- **Batch — Azure Batch.** Runs **large-scale parallel and high-performance computing (HPC)
  batch jobs**, creating and managing a pool of compute nodes (virtual machines) [c7fb12ad9].

## Convergent vs contested

- **Convergent:** Azure provides a managed primitive for every job-stack layer, matching AWS
  almost one-to-one — Durable Functions ≈ Step Functions (orchestration), Service Bus ≈ SQS+SNS
  (broker + pub-sub), Queue Storage ≈ basic SQS, Container Apps jobs ≈ Batch/Fargate tasks,
  Event Grid ≈ EventBridge, Azure Batch ≈ AWS Batch.
- **Contested / differentiating:** Azure splits queueing into **two tiers** — Service Bus
  (enterprise broker: sessions, topics, dead-lettering) vs Queue Storage (simple, size-capped
  at 64 KB). And Durable Functions is **code-first** (orchestrator/activity/entity functions)
  rather than a separate state-machine DSL, unlike Step Functions' Amazon States Language.

## Implications for the system

- The Azure provider-adapter maps the abstract model onto: Durable Functions (orchestration),
  Service Bus (queue/broker when routing/sessions matter; Queue Storage for simple cases),
  Container Apps jobs (worker compute), Event Grid (eventing), Azure Batch (HPC/parallel).
- The near one-to-one AWS↔Azure mapping validates a **provider-adapter core**: the same
  abstract roles (orchestrate/queue/fan-out/execute/schedule) bind to each cloud's primitives.

## Gaps found → re-scan
- Durable Functions guarantees + checkpointing/replay mechanics vs Temporal/Step Functions (in-corpus: orchestrations, task-hubs, versioning, eternal-orchestrations).
- Service Bus delivery semantics (sessions, duplicate detection, dead-lettering) — not synthesized.
- Logic Apps and Data Factory roles (named in the catalog, not in this corpus slice).
