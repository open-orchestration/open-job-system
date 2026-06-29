[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781496832143

userId:

deviceId: 3f086ae3-1f4a-4740-9e27-2e2cf5479401

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/workflows#__docusaurus_skipToContent_fallback)

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

    - [Workflow Definition](https://docs.temporal.io/workflow-definition)
    - [Workflow Execution](https://docs.temporal.io/workflow-execution)

    - [Dynamic handler](https://docs.temporal.io/dynamic-handler)
    - [Schedule](https://docs.temporal.io/schedule)
    - [Cron Job](https://docs.temporal.io/cron-job)
    - [Patching](https://docs.temporal.io/patching)
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
- [Interactive Demos](https://docs.temporal.io/workflows#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- Workflows

On this page

# Temporal Workflow

Copy

This guide provides a comprehensive overview of Temporal Workflows and covers the following:

- [Workflow Definition](https://docs.temporal.io/workflow-definition)
- [Workflow Execution](https://docs.temporal.io/workflow-execution)
- [Schedules](https://docs.temporal.io/schedule)
- [Dynamic Handler](https://docs.temporal.io/dynamic-handler)
- [Cron Job](https://docs.temporal.io/cron-job)

## Intro to Workflows [​](https://docs.temporal.io/workflows\#intro-to-workflows "Direct link to Intro to Workflows")

Conceptually, a workflow defines a sequence of steps. With Temporal, those steps are defined by writing code, known as a Workflow Definition, and are carried out by running that code, which results in a Workflow Execution.

In day-to-day conversations, the term Workflow might refer to Workflow Type, a Workflow Definition, or a Workflow Execution.

1. A **Workflow Definition** is the code that defines your Workflow.
2. The **Workflow Type** is the name that maps to a Workflow Definition. It's an identifier that makes it possible to distinguish one type of Workflow (such as order processing) from another (such as customer onboarding).
3. A **Workflow Execution** is a running Workflow, which is created by combining a Workflow Definition with a request to execute it. You can execute a Workflow Definition any number of times, potentially providing different input each time (i.e., a Workflow Definition for order processing might process order #123 in one execution and order #567 in another execution). It is the actual instance of the Workflow Definition running in the Temporal Platform.

You'll develop those Workflows by writing code in a general-purpose programming language such as Go, Java, TypeScript, or Python. The code you write is the same code that will be executed at runtime, so you can use your favorite tools and libraries to develop Temporal Workflows.

Temporal Workflows are resilient. They can run—and keep running—for years, even if the underlying infrastructure fails. If the application itself crashes, Temporal will automatically recreate its pre-failure state so it can continue right where it left off.

Each Workflow Execution emits a series of **Commands** and processes a sequence of **Events**, which are recorded in an **Event History**.

### How Workflow replay works [​](https://docs.temporal.io/workflows\#how-workflow-replay-works "Direct link to How Workflow replay works")

When a Workflow [yields](https://en.wikipedia.org/wiki/Yield_(multithreading)) or encounters an error, the goal of Temporal is to bring the Workflow back to the exact same state it was in before the pause occurred. To make that possible, Temporal keeps the Event History. This is a complete, ordered log of everything that has already happened in a Workflow.

The Event History could look like this for example:

- Started Timer for 5 minutes
- Scheduled Activity X
- Activity X completed with result Y
- Received Signal Z

This history is the source of truth for everything that happens in the Workflow.

#### Resuming a Workflow [​](https://docs.temporal.io/workflows\#resuming-a-workflow "Direct link to Resuming a Workflow")

When it's time to continue the Workflow, Temporal doesn't restore memory from a snapshot. It starts the Workflow code from the beginning, replays the Event History step by step, and uses that history to guide the code back to the exact state as before. So the Workflow code is re-run, but uses the recorded events instead of redoing work. Although Temporal doesn't always have to start from the beginning if the state is cached.

Because the Workflow is re-executed to rebuild its state:

- It has to make the same decisions when given the same history, which makes a Workflow deterministic.
- It shouldn't depend on any values _not_ recorded in the history which would be different between runs.

For example:

- A direct call to `Date.now()` could return a different value on replay.
- A random number could change.
- A network call, which wasn't performed inside an Activity, could return something new.

If those values changed, the Workflow could take a different path and fail to match the recorded history. To solve this, Temporal provides replay-safe versions of common operations:

- Time is read from the Workflow context so it matches the recorded history.
- Timers are recorded as events and don’t “wait” again during replay.
- Randomness and similar values can be captured once and reused.

These APIs make sure the Workflow receives the same values during replay as it did originally. Activities handle everything that interacts with the outside world, like:

- API calls
- Database queries
- LLM invocations
- File I/O

When a Workflow calls an Activity, the Activity runs once, its result is recorded in the Event History. During replay, that result is reused, not recomputed. So Activities aren't executed again during replay.

**Tags:**

- [Concepts](https://docs.temporal.io/tags/concepts)
- [Workflows](https://docs.temporal.io/tags/workflows)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Temporal Client](https://docs.temporal.io/temporal-client) [Next\\
\\
Workflow Definition](https://docs.temporal.io/workflow-definition)

- [Intro to Workflows](https://docs.temporal.io/workflows#intro-to-workflows)
  - [How Workflow replay works](https://docs.temporal.io/workflows#how-workflow-replay-works)
    - [Resuming a Workflow](https://docs.temporal.io/workflows#resuming-a-workflow)

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