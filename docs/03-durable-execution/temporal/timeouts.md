[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781557623263

userId:

deviceId: e4e2ab4c-e04e-43d3-94c0-29cf19e5328e

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/encyclopedia/failures-and-error-handling#__docusaurus_skipToContent_fallback)

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

    - [Application failures](https://docs.temporal.io/encyclopedia/application-failures)
    - [Detecting Activity failures](https://docs.temporal.io/encyclopedia/detecting-activity-failures)
    - [Detecting Workflow failures](https://docs.temporal.io/encyclopedia/detecting-workflow-failures)
    - [Retry Policies](https://docs.temporal.io/encyclopedia/retry-policies)
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
- [Interactive Demos](https://docs.temporal.io/encyclopedia/failures-and-error-handling#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- Failures and error handling

# Failures and error handling

Copy

Temporal provides Durable Execution, which guarantees that your application runs to completion despite infrastructure issues, network problems, and Worker crashes.
However, not all failures are handled automatically by the platform.
Understanding the difference between platform-level and application-level failures is key to building reliable Temporal applications.

This section covers:

- **[Application failures](https://docs.temporal.io/encyclopedia/application-failures)**: What application failures are, how Temporal represents them, and how they propagate through your code.
- **[Detecting Activity failures](https://docs.temporal.io/encyclopedia/detecting-activity-failures)**: How to use timeouts and Heartbeats to detect when Activities fail or become unresponsive.
- **[Detecting Workflow failures](https://docs.temporal.io/encyclopedia/detecting-workflow-failures)**: How Workflow-level timeouts work and when they apply.
- **[Retry Policies](https://docs.temporal.io/encyclopedia/retry-policies)**: How to configure automatic retry behavior for Activities and Workflows.

For prescriptive guidance on building an error handling strategy, see [Error handling](https://docs.temporal.io/best-practices/error-handling).

**Tags:**

- [Concepts](https://docs.temporal.io/tags/concepts)
- [Failures](https://docs.temporal.io/tags/failures)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Standalone Activity](https://docs.temporal.io/standalone-activity) [Next\\
\\
Application failures](https://docs.temporal.io/encyclopedia/application-failures)

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