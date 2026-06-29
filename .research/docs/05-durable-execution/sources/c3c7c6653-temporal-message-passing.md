[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781482910266

userId:

deviceId: cab4e020-4c1c-4298-a13d-e63a76ac1559

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/encyclopedia/workflow-message-passing#__docusaurus_skipToContent_fallback)

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

    - [Sending Signals, Queries, & Updates](https://docs.temporal.io/sending-messages)
    - [Handling Signals, Queries, & Updates](https://docs.temporal.io/handling-messages)
  - [Child Workflows](https://docs.temporal.io/child-workflows)

  - [Visibility](https://docs.temporal.io/visibility)

  - [Temporal Service](https://docs.temporal.io/temporal-service)

  - [Namespaces](https://docs.temporal.io/namespaces)

  - [Temporal Nexus](https://docs.temporal.io/nexus)

  - [Extensibility](https://docs.temporal.io/encyclopedia/extensibility)

  - [Web UI](https://docs.temporal.io/web-ui)
- [Interactive Demos](https://docs.temporal.io/encyclopedia/workflow-message-passing#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- Workflow Message Passing

On this page

# Temporal Workflow message passing - Signals, Queries, & Updates

Copy

Workflows can be thought of as stateful web services that can receive messages. The Workflow can have powerful message
handlers akin to endpoints that react to the incoming messages in combination with the current state of the Workflow.
Temporal supports three types of messages: Signals, Queries, and Updates:

- Queries are read requests. They can read the current state of the Workflow but cannot block in doing so.
- Signals are asynchronous write requests. They cause changes in the running Workflow, but you cannot await any response
or error.
- Updates are synchronous, tracked write requests. The sender of the Update can wait for a response on completion or an
error on failure.

## How to choose between Signals, Updates, and Queries as a Workflow author? [​](https://docs.temporal.io/encyclopedia/workflow-message-passing\#choosing-messages "Direct link to How to choose between Signals, Updates, and Queries as a Workflow author?")

This section will help you write Workflows that receive messages.

### For write requests [​](https://docs.temporal.io/encyclopedia/workflow-message-passing\#for-write-requests "Direct link to For write requests")

Unlike Signals, Updates must be synchronous and must wait for the Worker running the Workflow to acknowledge the
request.

The following table compares when to use **Signals** versus **Updates**.

| **Requirement type** | **Use Signals when...** | **Use Updates when...** |
| --- | --- | --- |
| **Asynchronous communication** | Clients want to quickly move on after sending an asynchronous message. | Clients want to track the completion of the message. |
| **Result handling** | Clients are okay with “fire and forget” — no result or exception needed. | Clients need a result or exception without performing a query. |
| **Worker availability** | Clients don't depend on the Worker being available. | You want to validate the Update before accepting it into the Workflow and its history. |
| **Concurrency and throughput** | You don’t want to limit the number of messages processed concurrently by a single Workflow. | You don’t need more concurrent Updates per Workflow than the allowed limits for [Cloud](https://docs.temporal.io/cloud/limits#per-workflow-execution-update-limits) or [Self-Hosted](https://docs.temporal.io/self-hosted-guide/defaults). |
| **Latency sensitivity** | Since clients don’t expect a result, latency is often not relevant when using Signals. | Clients want a low-latency end-to-end operation and are willing to wait for completion or validation. |

### For read requests [​](https://docs.temporal.io/encyclopedia/workflow-message-passing\#for-read-requests "Direct link to For read requests")

You normally want to do a Query, because:

- Queries are efficient–they never add entries to the [Workflow Event History](https://docs.temporal.io/workflow-execution/event#event-history),
whereas an Update would (if accepted).
- Queries can operate on completed Workflows.

However, because Queries cannot block, sometimes Updates are best. When your goal is to do a read once the Workflow
achieves a certain desired state, you have two options:

- You could poll periodically with Queries until the Workflow is ready.
- You could write your read operation as an Update, which will give you better efficiency and latency, though it will
write an entry to the [Workflow Event History](https://docs.temporal.io/workflow-execution/event#event-history).

### For read/write requests [​](https://docs.temporal.io/encyclopedia/workflow-message-passing\#for-readwrite-requests "Direct link to For read/write requests")

Use an Update for synchronous read/write requests. If your request must be asynchronous, consider sending a Signal
followed by polling with a Query.

**Tags:**

- [Concepts](https://docs.temporal.io/tags/concepts)
- [Signals](https://docs.temporal.io/tags/signals)
- [Queries](https://docs.temporal.io/tags/queries)
- [Updates](https://docs.temporal.io/tags/updates)
- [Messages](https://docs.temporal.io/tags/messages)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
TypeScript](https://docs.temporal.io/encyclopedia/event-history/event-history-typescript) [Next\\
\\
Sending Signals, Queries, & Updates](https://docs.temporal.io/sending-messages)

- [How to choose between Signals, Updates, and Queries as a Workflow author?](https://docs.temporal.io/encyclopedia/workflow-message-passing#choosing-messages)
  - [For write requests](https://docs.temporal.io/encyclopedia/workflow-message-passing#for-write-requests)
  - [For read requests](https://docs.temporal.io/encyclopedia/workflow-message-passing#for-read-requests)
  - [For read/write requests](https://docs.temporal.io/encyclopedia/workflow-message-passing#for-readwrite-requests)

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