[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781482110640

userId:

deviceId: 1b992b36-8ca1-4c20-83b4-017532e40585

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/temporal#__docusaurus_skipToContent_fallback)

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

  - [Visibility](https://docs.temporal.io/visibility)

  - [Temporal Service](https://docs.temporal.io/temporal-service)

  - [Namespaces](https://docs.temporal.io/namespaces)

  - [Temporal Nexus](https://docs.temporal.io/nexus)

  - [Extensibility](https://docs.temporal.io/encyclopedia/extensibility)

  - [Web UI](https://docs.temporal.io/web-ui)
- [Interactive Demos](https://docs.temporal.io/temporal#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- Temporal

On this page

# What is Temporal?

Copy

Temporal is a scalable and reliable runtime for durable function executions called [Temporal Workflow Executions](https://docs.temporal.io/workflow-execution).

Said another way, it's a platform that guarantees the [Durable Execution](https://docs.temporal.io/temporal#durable-execution) of your application code.

It enables you to develop as if failures don't even exist.
Your application will run reliably even if it encounters problems, such as network outages or server crashes, which would be catastrophic for a typical application.
The Temporal Platform handles these types of problems, allowing you to focus on the business logic, instead of writing application code to detect and recover from failures.

![The Temporal System](https://docs.temporal.io/diagrams/temporal-system-simple.svg)

The Temporal System

## Durable Execution [​](https://docs.temporal.io/temporal\#durable-execution "Direct link to Durable Execution")

Durable Execution in the context of Temporal refers to the ability of a Workflow Execution to maintain its state and progress even in the face of failures, crashes, or server outages.
This is achieved through Temporal's use of an [Event History](https://docs.temporal.io/workflow-execution/event#event-history), which records the state of a Workflow Execution at each step.
If a failure occurs, the Workflow Execution can resume from the last recorded event, ensuring that progress isn't lost.
This durability is a key feature of Temporal Workflow Executions, making them reliable and resilient.
It enables application code to execute effectively once and to completion, regardless of whether it takes seconds or years.

## What is the Temporal Platform? [​](https://docs.temporal.io/temporal\#temporal-platform "Direct link to What is the Temporal Platform?")

The Temporal Platform consists of a [Temporal Service](https://docs.temporal.io/temporal-service) and [Worker Processes](https://docs.temporal.io/workers#worker-process).
Together these components create a runtime for Workflow Executions.

The Temporal Platform consists of a supervising software typically called the [Temporal Service](https://docs.temporal.io/temporal-service) and application code bundled as Worker Processes.
Together these components create a runtime for your application.

![The Temporal Platform](https://docs.temporal.io/diagrams/temporal-platform-simple.svg)

The Temporal Platform

A Temporal Service consists of the [Temporal Server](https://github.com/temporalio/temporal), written in Go, and a database.

Our software as a service (SaaS) offering, Temporal Cloud, offers an alternative to hosting the Temporal Service yourself.

Worker Processes are hosted and operated by you and execute your code. Workers run using one of our SDKs.

![Basic component topology of the Temporal Platform](https://docs.temporal.io/diagrams/temporal-platform-component-topology.svg)

Basic component topology of the Temporal Platform

## What is a Temporal Application? [​](https://docs.temporal.io/temporal\#temporal-application "Direct link to What is a Temporal Application?")

A Temporal Application is a set of [Temporal Workflow Executions](https://docs.temporal.io/workflow-execution).
Each Temporal Workflow Execution has exclusive access to its local state, executes concurrently to all other Workflow Executions, and communicates with other Workflow Executions and the environment via message passing.

A Temporal Application can consist of millions to billions of Workflow Executions.
Workflow Executions are lightweight
A Workflow Execution consumes few compute resources; in fact, if a Workflow Execution is suspended, such as when it is in a waiting state, the Workflow Execution consumes no compute resources at all.

**Reentrant Process**

A Temporal Workflow Execution is a Reentrant Process. A Reentrant Process is resumable, recoverable, and reactive.

- Resumable: Ability of a process to continue execution after execution was suspended on an _awaitable_.
- Recoverable: Ability of a process to continue execution after execution was suspended on a _failure_.
- Reactive: Ability of a process to react to external events.

Therefore, a Temporal Workflow Execution executes a [Temporal Workflow Definition](https://docs.temporal.io/workflow-definition), also called a Temporal Workflow Function, your application code, exactly once and to completion—whether your code executes for seconds or years, in the presence of arbitrary load and arbitrary failures.

## What is a Failure? [​](https://docs.temporal.io/temporal\#failure "Direct link to What is a Failure?")

[Temporal Failures](https://docs.temporal.io/references/failures) are representations (in the SDKs and Event History) of various types of errors that occur in the system.

Failure handling is an essential part of development.
For more information, including the difference between application-level and platform-level failures, see [Handling Failure From First Principles](https://dominik-tornow.medium.com/handling-failures-from-first-principles-1ed976b1b869).
For the practical application of those concepts in Temporal, see [Failure Handling in Practice](https://temporal.io/blog/failure-handling-in-practice).

For languages that throw (or raise) errors (or exceptions), throwing an error that is not a Temporal Failure from a Workflow fails the Workflow Task (and the Task will be retried until it succeeds), whereas throwing a Temporal Failure (or letting a Temporal Failure propagate from Temporal calls, like an [Activity Failure](https://docs.temporal.io/references/failures#activity-failure) from an Activity call) fails the Workflow Execution.
For more information, see [Application Failure](https://docs.temporal.io/references/failures#application-failure).

**Tags:**

- [Durable Execution](https://docs.temporal.io/tags/durable-execution)
- [Temporal](https://docs.temporal.io/tags/temporal)
- [Concepts](https://docs.temporal.io/tags/concepts)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Encyclopedia](https://docs.temporal.io/encyclopedia/) [Next\\
\\
About the SDKs](https://docs.temporal.io/encyclopedia/temporal-sdks)

- [Durable Execution](https://docs.temporal.io/temporal#durable-execution)
- [What is the Temporal Platform?](https://docs.temporal.io/temporal#temporal-platform)
- [What is a Temporal Application?](https://docs.temporal.io/temporal#temporal-application)
- [What is a Failure?](https://docs.temporal.io/temporal#failure)

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