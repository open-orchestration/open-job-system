---
id: d14148357
topic: cloud-aws
title: Step Functions Standard vs Express workflow types
status: draft
shape: comparison
---

# Step Functions Standard vs Express workflow types

When you create a Step Functions state machine, you must choose a **Type** of either Standard (default) or Express [c8acdab63]. Both types are defined using the Amazon States Language [c8acdab63]. The chosen workflow type cannot be updated after you create a state machine [c8acdab63].

## Execution duration limits

Standard Workflows are intended for long-running, durable, and auditable workflows and can run for up to one year [c8acdab63]. Express Workflows can run for up to five minutes [c8acdab63].

## Execution-guarantee semantics

Standard Workflows follow an *exactly-once* model, where tasks and states are never run more than once unless `Retry` behavior is specified in ASL [c8acdab63]. This exactly-once model makes Standard Workflows suited to orchestrating non-idempotent actions, such as starting an Amazon EMR cluster or processing payments [c8acdab63].

Express Workflows use an *at-least-once* model, so an execution could potentially run more than once [c8acdab63]. The at-least-once model makes Express Workflows better suited for orchestrating idempotent actions, such as transforming input data to store in Amazon DynamoDB using a PUT action [c8acdab63]. Express Workflows further divide into two sub-types: Asynchronous Express Workflows provide *at-least-once* execution, while Synchronous Express Workflows provide *at-most-once* execution [c8acdab63].

For Standard Workflows, execution state internally persists between state transitions [c8acdab63]. For both Asynchronous and Synchronous Express Workflows, execution state does not persist between state transitions [c8acdab63]. Standard Workflows automatically return an idempotent response on starting an execution with the same name as a currently-running workflow; the new workflow does not start and an exception is thrown once the currently-running workflow is complete [c8acdab63]. For Express Workflows, idempotency is not automatically managed: with the asynchronous type, starting multiple workflows with the same name results in concurrent executions and can result in loss of internal workflow state if the state machine logic is not idempotent [c8acdab63].

## Execution history and state-transition recording

For Standard Workflows, you can retrieve the full execution history using the Step Functions API for up to 90 days after the execution completes [c8acdab63]. Standard Workflow executions can be listed and described with Step Functions APIs, visually debugged through the console, and inspected in CloudWatch Logs by enabling logging on the state machine [c8acdab63]. After running Standard workflows, you can access information about each state, its input and output, and when it was active and for how long, by viewing the Execution Details page in the Step Functions console [cd57f8ab2].

Express Workflows maintain as many execution history entries as you can generate within a 5-minute period [c8acdab63]. Express Workflow execution history is not captured by Step Functions itself; logging must be enabled through Amazon CloudWatch Logs [c8acdab63]. After Express Workflow executions, and if logging is enabled, you can see execution history in the Step Functions console or Amazon CloudWatch Logs [cd57f8ab2]. Standard execution history data is removed after 90 days, and workflow names can be reused after removal of out-of-date execution data [c8acdab63].

A *state transition* is counted each time a step in your execution is completed [c8acdab63]. Standard Workflows have a supported state transition rate governed by quotas, whereas Express Workflows have no limit on state transition rate [c8acdab63].

## Pricing model basis

Standard Workflow executions are billed according to the number of state transitions processed [c8acdab63]. Express Workflow executions are billed by number of executions, total duration of execution, and memory consumed during execution [c8acdab63].

## Feature support and suited workloads

Standard Workflows support all service integrations and patterns, including Distributed Map and Activities [c8acdab63]. Express Workflows support all service integrations but do not support the Job-run (`.sync`) or Callback (`.waitForTaskToken`) service integration patterns, and they do not support Distributed Map or Activities [c8acdab63].

Standard Workflows are ideal for long-running, durable, and auditable workflows [c8acdab63]. Express Workflows are ideal for high-volume, event-processing workloads such as IoT data ingestion, streaming data processing and transformation, and mobile application backends [c8acdab63]. Both Standard and Express workflows can start in response to events, such as HTTP requests from Amazon API Gateway, IoT rules, and over 140 other event sources in Amazon EventBridge [c8acdab63].
