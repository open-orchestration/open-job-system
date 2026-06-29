[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781557625534

userId:

deviceId: 186bf563-dfba-4c40-bec9-b944c491d8a1

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/child-workflows#__docusaurus_skipToContent_fallback)

[![Temporal logo](https://docs.temporal.io/img/assets/temporal-logo-dark.svg)](https://temporal.io/)[Home](https://docs.temporal.io/) [Courses](https://learn.temporal.io/getting_started/) [SDKs](https://docs.temporal.io/develop) [AI Cookbook](https://docs.temporal.io/ai-cookbook) [Code Exchange](https://temporal.io/code-exchange) [Temporal Cloud](https://docs.temporal.io/cloud)

Ask AI

Search`Ctrl`  `K`

- [Home](https://docs.temporal.io/)
- [Quickstarts](https://docs.temporal.io/quickstarts)
- [Evaluate](https://docs.temporal.io/evaluate/)

- [Develop](https://docs.temporal.io/develop/)

- [Temporal Cloud](https://docs.temporal.io/cloud)

- [Deploy to production](https://docs.temporal.io/production-deployment)

- [CLI (temporal)](https://docs.temporal.io/cli)

- [References](https://docs.temporal.io/references/)

- [Troubleshooting](https://docs.temporal.io/troubleshooting/)

- [Best practices](https://docs.temporal.io/best-practices/)

- [Encyclopedia](https://docs.temporal.io/encyclopedia/)

  - [Temporal](https://docs.temporal.io/temporal)
  - [About the SDKs](https://docs.temporal.io/encyclopedia/temporal-sdks)
  - [Temporal Client](https://docs.temporal.io/temporal-client)
  - [Workflows](https://docs.temporal.io/workflows)

  - [Activities](https://docs.temporal.io/activities)

  - [Failures and error handling](https://docs.temporal.io/encyclopedia/failures-and-error-handling)

  - [Workers](https://docs.temporal.io/workers)

  - [Event History](https://docs.temporal.io/encyclopedia/event-history/)

  - [Workflow Message Passing](https://docs.temporal.io/encyclopedia/workflow-message-passing/)

  - [Child Workflows](https://docs.temporal.io/child-workflows)

    - [Parent Close Policy](https://docs.temporal.io/parent-close-policy)
  - [Visibility](https://docs.temporal.io/visibility)

  - [Temporal Service](https://docs.temporal.io/temporal-service)

  - [Namespaces](https://docs.temporal.io/namespaces)

  - [Temporal Nexus](https://docs.temporal.io/nexus)

  - [Extensibility](https://docs.temporal.io/encyclopedia/extensibility)

  - [Web UI](https://docs.temporal.io/web-ui)
- [Interactive Demos](https://docs.temporal.io/child-workflows#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- Child Workflows

On this page

# Child Workflows

Copy

A Child Workflow Execution is a [Workflow Execution](https://docs.temporal.io/workflow-execution) that is spawned from within another Workflow in the same Namespace.

- [Go SDK Child Workflow feature guide](https://docs.temporal.io/develop/go/workflows/child-workflows)
- [Java SDK Child Workflow feature guide](https://docs.temporal.io/develop/java/workflows/child-workflows)
- [PHP SDK Child Workflow feature guide](https://docs.temporal.io/develop/php/workflows/child-workflows)
- [Python SDK Child Workflow feature guide](https://docs.temporal.io/develop/python/workflows/child-workflows)
- [TypeScript SDK Child Workflow feature guide](https://docs.temporal.io/develop/typescript/workflows/child-workflows)
- [.NET SDK Child Workflow feature guide](https://docs.temporal.io/develop/dotnet/workflows/child-workflows)
- [Ruby SDK Child Workflow feature guide](https://docs.temporal.io/develop/ruby/workflows/child-workflows)
- [Rust SDK Child Workflow feature guide](https://docs.temporal.io/develop/rust/workflows/child-workflows)

A Workflow Execution can be both a Parent and a Child Workflow Execution because any Workflow can spawn another Workflow.

![Parent and Child Workflow Execution entity relationship](https://docs.temporal.io/diagrams/parent-child-workflow-execution-relationship.svg)

Parent and Child Workflow Execution entity relationship

A Parent Workflow Execution must await on the Child Workflow Execution to spawn.
The Parent can optionally await on the result of the Child Workflow Execution.
Consider the Child's [Parent Close Policy](https://docs.temporal.io/parent-close-policy) if the Parent does not await on the result of the Child, which includes any use of Continue-As-New by the Parent.

info

Child Workflows do not carry over when the Parent uses [Continue-As-New](https://docs.temporal.io/workflow-execution/continue-as-new).
This means that if a Parent Workflow Execution uses Continue-As-New, any ongoing Child Workflow Executions will not be retained in the new continued instance of the Parent.

When a Parent Workflow Execution reaches a Closed status, the Temporal Service propagates Cancellation Requests or Terminations to Child Workflow Executions depending on the Child's [Parent Close Policy](https://docs.temporal.io/parent-close-policy).

If a Child Workflow Execution uses Continue-As-New, from the Parent Workflow Execution's perspective the entire chain of Runs is treated as a single execution.

![Parent and Child Workflow Execution entity relationship with Continue As New](https://docs.temporal.io/diagrams/parent-child-workflow-execution-with-continue-as-new.svg)

Parent and Child Workflow Execution entity relationship with Continue As New

## When to use Child Workflows [​](https://docs.temporal.io/child-workflows\#when-to-use-child-workflows "Direct link to When to use Child Workflows")

There is no reason to use Child Workflows just for code organization.
You can use object oriented structure and other code organization techniques to deal with complexities.
It is typically recommended to start from a single Workflow Definition if your problem has bounded size in terms of the number of Activity Executions and processed Signals.
It is simpler than multiple asynchronously communicating Workflows.

However, there are several valid reasons for using Child Workflows.

### Create a separate service [​](https://docs.temporal.io/child-workflows\#create-a-separate-service "Direct link to Create a separate service")

Because a Child Workflow Execution can be processed by a completely separate set of [Workers](https://docs.temporal.io/workers#worker) than the Parent Workflow Execution, it can act as an entirely separate service.
However, this also means that a Parent Workflow Execution and a Child Workflow Execution do not share any local state.
As all Workflow Executions, they can communicate only via asynchronous [Signals](https://docs.temporal.io/sending-messages#sending-signals).

### Partition problems into smaller chunks [​](https://docs.temporal.io/child-workflows\#partition-problems-into-smaller-chunks "Direct link to Partition problems into smaller chunks")

An individual Workflow Execution has an [Event History](https://docs.temporal.io/workflow-execution/event#event-history) size limit, which imposes a couple of considerations for using Child Workflows.

On one hand, because Child Workflow Executions have their own Event Histories, they are often used to partition large workloads into smaller chunks.
For example, a single Workflow Execution does not have enough space in its Event History to spawn 100,000 [Activity Executions](https://docs.temporal.io/activity-execution).
But a Parent Workflow Execution can spawn 1,000 Child Workflow Executions that each spawn 1,000 Activity Executions to achieve a total of 1,000,000 Activity Executions.

However, because a Parent Workflow Execution Event History contains [Events](https://docs.temporal.io/workflow-execution/event#event) that correspond to the status of the Child Workflow Execution, a single Parent should not spawn more than 1,000 Child Workflow Executions.

In general, however, Child Workflow Executions result in more overall Events recorded in Event Histories than Activities.
Because each entry in an Event History is a _cost_ in terms of compute resources, this could become a factor in very large workloads.
Therefore, we recommend starting with a single Workflow implementation that uses Activities until there is a clear need for Child Workflows.

### Represent a single resource [​](https://docs.temporal.io/child-workflows\#represent-a-single-resource "Direct link to Represent a single resource")

As all Workflow Executions, a Child Workflow Execution can create a one to one mapping with a resource.
It can be used to manage the resource using its ID to guarantee uniqueness.
For example, a Workflow that manages host upgrades could spawn a Child Workflow Execution per host (hostname being a Workflow ID) and use them to ensure that all operations on the host are serialized.

### Periodic logic execution [​](https://docs.temporal.io/child-workflows\#periodic-logic-execution "Direct link to Periodic logic execution")

A Child Workflow can be used to execute some periodic logic without overwhelming the Parent Workflow Event History.
In this scenario, the Parent Workflow starts a Child Workflow which executes periodic logic calling [Continue-As-New](https://docs.temporal.io/workflow-execution/continue-as-new) as many times as needed, then completes.
From the Parent point of view, it is just a single Child Workflow invocation.

### Child Workflow versus an Activity [​](https://docs.temporal.io/child-workflows\#child-workflow-versus-an-activity "Direct link to Child Workflow versus an Activity")

Child Workflow Executions and Activity Executions are both started from Workflows, so you might feel confused about when to use which.
Here are some important differences:

- A Child Workflow has access to all Workflow APIs but is subject to the same [deterministic constraints](https://docs.temporal.io/workflow-definition#deterministic-constraints) as other Workflows.
An Activity has the inverse pros and cons—no access to Workflow APIs but no Workflow constraints.
- A Child Workflow Execution can continue on if its Parent is canceled with a [Parent Close Policy](https://docs.temporal.io/parent-close-policy) of `ABANDON`.
An Activity Execution is _always_ canceled when its Workflow Execution is canceled.
(It can react to a cancellation Signal for cleanup.)
The decision is roughly analogous to spawning a child process in a terminal to do work versus doing work in the same process.
- Temporal tracks all state changes within a Child Workflow Execution in Event History.
Only the input, output, and retry attempts of an Activity Execution is tracked.

A Workflow models composite operations that consist of multiple Activities or other Child Workflows.
An Activity usually models a single operation on the external world.

Our advice: **When in doubt, use an Activity.**

**Tags:**

- [Concepts](https://docs.temporal.io/tags/concepts)
- [Child Workflows](https://docs.temporal.io/tags/child-workflows)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Handling Signals, Queries, & Updates](https://docs.temporal.io/handling-messages) [Next\\
\\
Parent Close Policy](https://docs.temporal.io/parent-close-policy)

- [When to use Child Workflows](https://docs.temporal.io/child-workflows#when-to-use-child-workflows)
  - [Create a separate service](https://docs.temporal.io/child-workflows#create-a-separate-service)
  - [Partition problems into smaller chunks](https://docs.temporal.io/child-workflows#partition-problems-into-smaller-chunks)
  - [Represent a single resource](https://docs.temporal.io/child-workflows#represent-a-single-resource)
  - [Periodic logic execution](https://docs.temporal.io/child-workflows#periodic-logic-execution)
  - [Child Workflow versus an Activity](https://docs.temporal.io/child-workflows#child-workflow-versus-an-activity)

- [GitHub](https://github.com/temporalio)
- [Twitter](https://x.com/temporalio)
- [YouTube](https://www.youtube.com/c/Temporalio)
- [About the docs](https://github.com/temporalio/documentation/blob/main/README.md)

- [Temporal Cloud](https://temporal.io/cloud)
- [Meetups](https://temporal.io/community#events)
- [Support forum](https://community.temporal.io/)
- [Ask an expert](https://pages.temporal.io/ask-an-expert)

- [Learn Temporal](https://learn.temporal.io/)
- [Blog](https://temporal.io/blog)
- [Use cases](https://temporal.io/in-use)
- [Newsletter signup](https://pages.temporal.io/newsletter-subscribe)

- [Security](https://docs.temporal.io/security)
- [Privacy policy](https://temporal.io/global-privacy-policy)
- [Terms of service](https://temporal.io/terms-of-service)
- [We're hiring](https://temporal.io/careers)

[![Temporal logo](https://docs.temporal.io/img/favicon.png)](https://temporal.io/)

Copyright © 2026 Temporal Technologies Inc.

Feedback

reCAPTCHA

Recaptcha requires verification.

protected by **reCAPTCHA**