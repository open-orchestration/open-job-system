---
id: d4e4f56ce
topic: cloud-aws
title: "AWS managed job primitives: orchestration, queue, pub-sub, compute, scheduling"
status: draft
shape: survey
---

# AWS managed job primitives: orchestration, queue, pub-sub, compute, scheduling

**Scope.** The managed AWS building blocks for a job system and their delivery semantics,
from AWS official docs. Covers Step Functions, SQS, Lambda, SNS, and EventBridge Scheduler;
the corpus also holds Glue, MWAA, and EventBridge (event bus) not synthesized here.

## Key claims (cited)

- **Orchestration — Step Functions.** Step Functions is based on **state machines and
  tasks**; state machines are called workflows, which are a series of **event-driven steps**,
  and each step is a **state**; Standard workflows have **exactly-once** workflow execution
  [c4f4b67ee]. States are defined in the **Amazon States Language**, a JSON-based structured
  language [c1061168e]; **Express** workflows instead use an **at-least-once** model, better
  suited to orchestrating idempotent actions [c8acdab63].
- **Queue — SQS.** Standard queues support **at-least-once** message delivery [cb96f3ced],
  while FIFO queues add **exactly-once processing** [c399ef9b9].
- **Compute — Lambda.** AWS Lambda is a **compute service that runs code without the need to
  manage servers** (serverless) [c7ae5dfae].
- **Pub-sub — SNS.** Amazon SNS is a **fully managed service that provides message delivery
  from publishers (producers) to subscribers (consumers)**, communicating asynchronously
  [ced180d84].
- **Scheduling — EventBridge Scheduler.** A **serverless scheduler that lets you create, run,
  and manage tasks from one central, managed service**, with **at-least-once event delivery
  to targets** [c878a13f4].

## Convergent vs contested

- **Convergent:** AWS supplies a managed primitive for every layer of the job stack —
  orchestrate (Step Functions), queue (SQS), fan-out (SNS), execute (Lambda), schedule
  (EventBridge Scheduler) — so a job system can be assembled without running any servers.
- **Contested / differentiating:** **Delivery guarantees vary by service and configuration**,
  not globally — SQS standard is at-least-once but FIFO is exactly-once; Step Functions
  Standard workflows are exactly-once; EventBridge Scheduler is at-least-once to targets. The
  guarantee is a per-primitive choice, so the assembled system inherits the weakest link.

## Implications for the system

- For the AWS provider-adapter, map the abstract model onto: Step Functions (durable
  orchestration), SQS (queue, FIFO when ordering/dedup matters), SNS (fan-out), Lambda
  (worker compute), EventBridge Scheduler (cron/delayed).
- Make delivery-guarantee an explicit per-binding decision: choose SQS FIFO / Step Functions
  Standard where exactly-once is required, and design idempotent consumers everywhere else
  since the default primitives are at-least-once.

## Gaps found → re-scan
- SQS visibility timeout, DLQ/redrive, and Lambda async-invoke + destinations mechanics (in-corpus, not synthesized).
- Step Functions Express vs Standard tradeoffs (cost/latency/guarantee) and Map/Distributed mode.
- EventBridge (event bus) and Glue/MWAA roles; cross-service composition patterns.
