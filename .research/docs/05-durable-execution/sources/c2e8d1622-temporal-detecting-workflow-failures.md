[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781557621308

userId:

deviceId: c5151e10-59c1-4241-a1fd-72cbd5991945

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#__docusaurus_skipToContent_fallback)

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
- [Interactive Demos](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- [Failures and error handling](https://docs.temporal.io/encyclopedia/failures-and-error-handling)
- Detecting Workflow failures

On this page

# Detecting Workflow failures

Copy

Each Workflow Timeout controls the maximum duration of a different aspect of a Workflow Execution. Workflow Timeouts are set when starting the Workflow Execution.

Before we continue, we want to note that we generally do not recommend setting Workflow Timeouts, because Workflows are designed to be long-running and resilient.
Instead, setting a Timeout can limit its ability to handle unexpected delays or long-running processes.
If you need to perform an action inside your Workflow after a specific period of time, we recommend using a Timer.

- [Workflow Execution Timeout](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#workflow-execution-timeout)
- [Workflow Run Timeout](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#workflow-run-timeout)
- [Workflow Task Timeout](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#workflow-task-timeout)

## Workflow Execution Timeout [​](https://docs.temporal.io/encyclopedia/detecting-workflow-failures\#workflow-execution-timeout "Direct link to Workflow Execution Timeout")

**What is a Workflow Execution Timeout in Temporal?**

A Workflow Execution Timeout is the maximum time that a Workflow Execution can be executing (have an Open status) including retries and any usage of Continue As New.

Related 📚

- [![](https://docs.temporal.io/img/sdks/svgs/golang.svg)Set a Workflow Execution Timeout using the Go SDK](https://docs.temporal.io/develop/go/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/java.svg)Set a Workflow Execution Timeout using the Java SDK](https://docs.temporal.io/develop/java/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/php.svg)Set a Workflow Execution Timeout using the PHP SDK](https://docs.temporal.io/develop/php/workflows/timeouts#workflow-timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/python.svg)Set a Workflow Execution Timeout using the Python SDK](https://docs.temporal.io/develop/python/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/typescript.svg)Set a Workflow Execution Timeout using the TypeScript SDK](https://docs.temporal.io/develop/typescript/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/dotnet.svg)Set a Workflow Execution Timeout using the .NET SDK](https://docs.temporal.io/develop/dotnet/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/rust.svg)Set a Workflow Execution Timeout using the Rust SDK](https://docs.temporal.io/develop/rust/workflows/timeouts) feature-guide


![Workflow Execution Timeout period](https://docs.temporal.io/diagrams/workflow-execution-timeout.svg)

Workflow Execution Timeout period

**The default value is ∞ (infinite).**
If this timeout is reached, the Workflow Execution changes to a Timed Out status.
This timeout is different from the [Workflow Run Timeout](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#workflow-run-timeout).
This timeout is most commonly used for stopping the execution of a [Temporal Cron Job](https://docs.temporal.io/cron-job) after a certain amount of time has passed.

## Workflow Run Timeout [​](https://docs.temporal.io/encyclopedia/detecting-workflow-failures\#workflow-run-timeout "Direct link to Workflow Run Timeout")

**What is a Workflow Run Timeout in Temporal?**

A Workflow Run is the instance of a specific Workflow Execution.

Due to the potential for Workflow Retries or Continue-as-New, a Workflow Execution may have multiple Workflow runs. For example, if a Workflow that specifies a Retry Policy initially fails and then succeeds during the next retry attempt, there is a single Workflow Execution that spans two Workflow Runs. Both runs will share the same Workflow ID but have a unique Run ID to distinguish them.

A Workflow Run Timeout restricts the maximum duration of a single Workflow Run. If the Workflow Run Timeout is reached, the Workflow Execution will be Timed Out. Because this Timeout only applies to an individual Workflow Run, this does not include retries or Continue-As-New.

Related 📚

- [![](https://docs.temporal.io/img/sdks/svgs/golang.svg)Set a Workflow Run Timeout using the Go SDK](https://docs.temporal.io/develop/go/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/java.svg)Set a Workflow Run Timeout using the Java SDK](https://docs.temporal.io/develop/java/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/php.svg)Set a Workflow Run Timeout using the PHP SDK](https://docs.temporal.io/develop/php/workflows/timeouts#workflow-timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/python.svg)Set a Workflow Run Timeout using the Python SDK](https://docs.temporal.io/develop/python/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/typescript.svg)Set a Workflow Run Timeout using the TypeScript SDK](https://docs.temporal.io/develop/typescript/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/dotnet.svg)Set a Workflow Timeout using the .NET SDK](https://docs.temporal.io/develop/dotnet/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/rust.svg)Set a Workflow Timeout using the Rust SDK](https://docs.temporal.io/develop/rust/workflows/timeouts) feature-guide


![Workflow Run Timeout period](https://docs.temporal.io/diagrams/workflow-run-timeout.svg)

Workflow Run Timeout period

**The default is set to the same value as the [Workflow Execution Timeout](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#workflow-execution-timeout).**
This timeout is most commonly used to limit the execution time of a single [Temporal Cron Job Execution](https://docs.temporal.io/cron-job).

If the Workflow Run Timeout is reached, the Workflow Execution will be Timed Out.

## Workflow Task Timeout [​](https://docs.temporal.io/encyclopedia/detecting-workflow-failures\#workflow-task-timeout "Direct link to Workflow Task Timeout")

**What is a Workflow Task Timeout in Temporal?**

A Workflow Task Timeout is the maximum amount of time allowed for a [Worker](https://docs.temporal.io/workers#worker) to execute a [Workflow Task](https://docs.temporal.io/tasks#workflow-task) after the Worker has pulled that Workflow Task from the [Task Queue](https://docs.temporal.io/task-queue).

This Timeout is primarily available to recognize whether a Worker has gone down so that the Workflow Execution can be recovered on a different Worker.

Related 📚

- [![](https://docs.temporal.io/img/sdks/svgs/golang.svg)Set a Workflow Task Timeout using the Go SDK](https://docs.temporal.io/develop/go/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/java.svg)Set a Workflow Task Timeout using the Java SDK](https://docs.temporal.io/develop/java/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/php.svg)Set a Workflow Task Timeout using the PHP SDK](https://docs.temporal.io/develop/php/workflows/timeouts#workflow-timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/python.svg)Set a Workflow Task Timeout using the Python SDK](https://docs.temporal.io/develop/python/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/typescript.svg)Set a Workflow Task Timeout using the TypeScript SDK](https://docs.temporal.io/develop/typescript/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/dotnet.svg)Set a Workflow Task Timeout using the .NET SDK](https://docs.temporal.io/develop/dotnet/workflows/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/rust.svg)Set a Workflow Task Timeout using the Rust SDK](https://docs.temporal.io/develop/rust/workflows/timeouts) feature-guide


![Workflow Task Timeout period](https://docs.temporal.io/diagrams/workflow-task-timeout.svg)

Workflow Task Timeout period

**The default value is 10 seconds.**
This timeout is primarily available to recognize whether a Worker has gone down so that the Workflow Execution can be recovered on a different Worker.
The main reason for increasing the default value is to accommodate a Workflow Execution that has an extensive Workflow Execution History, requiring more than 10 seconds for the Worker to load.
It's worth mentioning that although you can extend the timeout up to the maximum value of 120 seconds, it's not recommended to move beyond the default value.

## Detecting Workflow Task Failures [​](https://docs.temporal.io/encyclopedia/detecting-workflow-failures\#detecting-workflow-task-failures "Direct link to Detecting Workflow Task Failures")

Use the `TemporalReportedProblems` Search Attribute to detect Workflows with failed Workflow Tasks.
A failed Workflow Task does not cause the Workflow to fail. Some Tasks within a Workflow may be intended to fail.
For example, a Workflow Task may check a remote data source for new messages. If there aren't any, the Task will fail as intended.
If your Task has code to handle the failure, the Workflow will proceed.
However, if your Workflow has a Task that fails and the failure is not handled, the Workflow will continue to run, but will not complete.
Detecting Workflows in this state is a common troubleshooting issue.

To identify Workflows with Task failures, you can use the Temporal Web UI. See [Task Failures View](https://docs.temporal.io/web-ui/#task-failures-view) for more details.

You can also detect Workflows with Task failures by searching for the `TemporalReportedProblems` search attribute with your observability tools.

Activating Workflow Task Failure

To enable the Task Failures View for a Namespace, you need to update the Dynamic Config for that Namespace. See [Activating Task Failures View](https://docs.temporal.io/web-ui/#activate-task-failures-view).

**Tags:**

- [Concepts](https://docs.temporal.io/tags/concepts)
- [Workflows](https://docs.temporal.io/tags/workflows)
- [Failures](https://docs.temporal.io/tags/failures)
- [Timeouts](https://docs.temporal.io/tags/timeouts)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Detecting Activity failures](https://docs.temporal.io/encyclopedia/detecting-activity-failures) [Next\\
\\
Retry Policies](https://docs.temporal.io/encyclopedia/retry-policies)

- [Workflow Execution Timeout](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#workflow-execution-timeout)
- [Workflow Run Timeout](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#workflow-run-timeout)
- [Workflow Task Timeout](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#workflow-task-timeout)
- [Detecting Workflow Task Failures](https://docs.temporal.io/encyclopedia/detecting-workflow-failures#detecting-workflow-task-failures)

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