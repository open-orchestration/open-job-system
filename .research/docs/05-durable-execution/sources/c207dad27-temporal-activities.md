[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781468416389

userId:

deviceId: 54892bb4-56a6-4ca7-a886-c512e0361bf8

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/activities#__docusaurus_skipToContent_fallback)

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

    - [Activity Definition](https://docs.temporal.io/activity-definition)
    - [Activity Execution](https://docs.temporal.io/activity-execution)
    - [Activity Operations](https://docs.temporal.io/activity-operations)
    - [Local Activity](https://docs.temporal.io/local-activity)
    - [Standalone Activity](https://docs.temporal.io/standalone-activity)
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
- [Interactive Demos](https://docs.temporal.io/activities#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- Activities

# What is a Temporal Activity?

Copy

This guide provides a comprehensive overview of Temporal Activities including
[Activity Definition](https://docs.temporal.io/activity-definition), [Activity Type](https://docs.temporal.io/activity-definition#activity-type),
[Activity Execution](https://docs.temporal.io/activity-execution), [Local Activity](https://docs.temporal.io/local-activity), and [Standalone Activity](https://docs.temporal.io/standalone-activity).

An Activity is a normal function or method that executes a single, well-defined action (either short or long running),
such as calling another service, transcoding a media file, or sending an email message. Activity code can be
non-deterministic. We recommend that it be [idempotent](https://docs.temporal.io/activity-definition#idempotency).

Activities are the most common Temporal primitive and encompass small units of work such as:

- Single write operations, like updating user information or submitting a credit card payment
- Batches of similar writes, like creating multiple orders or sending multiple messages
- One or more read operations followed by a write operation, like checking a product status and user address before updating an order status
- A read that should be memoized, like an LLM call, a large download, or a slow-polling read

Larger pieces of functionality should be broken up into multiple activities. This makes it easier to do failure recovery, have short timeouts, and be idempotent.

Workflow code orchestrates the execution of Activities, persisting the results. If an Activity Execution fails,
any future attempt will start from the initial state, unless your code uses ( [Heartbeat details payloads](https://docs.temporal.io/encyclopedia/detecting-activity-failures#activity-heartbeat))
for checkpointing (storing state on the server, and using it when resuming subsequent attempts).

Activity Functions are executed by Worker Processes. When the Activity Function returns, the Worker sends the results
back to the Temporal Service as part of the [ActivityTaskCompleted](https://docs.temporal.io/references/events#activitytaskcompleted) Event. The
Event is added to the Workflow Execution's Event History. For other Activity-related Events, see
[Activity Events](https://docs.temporal.io/workflow-execution/event#activity-events).

If you only want to execute one Activity Function, then you don't need to use a Workflow: you can
use your SDK Client to invoke it directly as a [Standalone Activity](https://docs.temporal.io/standalone-activity).

**Tags:**

- [Concepts](https://docs.temporal.io/tags/concepts)
- [Activities](https://docs.temporal.io/tags/activities)
- [Durable Execution](https://docs.temporal.io/tags/durable-execution)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Patching](https://docs.temporal.io/patching) [Next\\
\\
Activity Definition](https://docs.temporal.io/activity-definition)

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