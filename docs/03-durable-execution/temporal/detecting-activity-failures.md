[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781557621596

userId:

deviceId: ce8be444-6593-4a9f-9dee-11981fc57de3

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/encyclopedia/detecting-activity-failures#__docusaurus_skipToContent_fallback)

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
- [Interactive Demos](https://docs.temporal.io/encyclopedia/detecting-activity-failures#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- [Failures and error handling](https://docs.temporal.io/encyclopedia/failures-and-error-handling)
- Detecting Activity failures

On this page

# Detecting Activity failures

Copy

A Workflow can detect different kinds of Activity Execution failures through the following timeouts:

- [Schedule-To-Start Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#schedule-to-start-timeout)
- [Start-To-Close Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#start-to-close-timeout)
- [Schedule-To-Close Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#schedule-to-close-timeout)
- [Activity Heartbeats](https://docs.temporal.io/encyclopedia/detecting-activity-failures#activity-heartbeat)

## Schedule-To-Start Timeout [​](https://docs.temporal.io/encyclopedia/detecting-activity-failures\#schedule-to-start-timeout "Direct link to Schedule-To-Start Timeout")

**What is a Schedule-To-Start Timeout in Temporal?**

A Schedule-To-Start Timeout is the maximum amount of time that is allowed from when an [Activity Task](https://docs.temporal.io/tasks#activity-task) is scheduled (that is, placed in a Task Queue) to when a [Worker](https://docs.temporal.io/workers#worker) starts (that is, picks up from the Task Queue) that Activity Task.
In other words, it's a limit for how long an Activity Task can be enqueued.

Related 📚

- [![](https://docs.temporal.io/img/sdks/svgs/golang.svg)Set a Schedule-To-Start Timeout using the Go SDK](https://docs.temporal.io/develop/go/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/java.svg)Set a Schedule-To-Start Timeout using the Java SDK](https://docs.temporal.io/develop/java/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/php.svg)Set a Schedule-To-Start Timeout using the PHP SDK](https://docs.temporal.io/develop/php/activities/timeouts#activity-timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/python.svg)Set a Schedule-To-Start Timeout using the Python SDK](https://docs.temporal.io/develop/python/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/typescript.svg)Set a Schedule-To-Start Timeout using the TypeScript SDK](https://docs.temporal.io/develop/typescript/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/dotnet.svg)Set a Schedule-To-Start Timeout using the .NET SDK](https://docs.temporal.io/develop/dotnet/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/rust.svg)Set a Schedule-To-Start Timeout using the Rust SDK](https://docs.temporal.io/develop/rust/activities/timeouts) feature-guide


The moment that the Task is picked by the Worker, from the Task Queue, is considered to be the start of the Activity Task Execution for the purposes of the Schedule-To-Start Timeout and associated metrics.
This definition of "Start" avoids issues that a clock difference between the Temporal Service and a Worker might create.

![Schedule-To-Start Timeout period](https://docs.temporal.io/diagrams/schedule-to-start-timeout.svg)

Schedule-To-Start Timeout period

"Schedule" in Schedule-To-Start and Schedule-To-Close have different frequency guarantees.

The Schedule-To-Start Timeout is enforced for each Activity Task, whereas the Schedule-To-Close Timeout is enforced once per Activity Execution.
Thus, "Schedule" in Schedule-To-Start refers to the scheduling moment of _every_ Activity Task in the sequence of Activity Tasks that make up the Activity Execution, while
"Schedule" in Schedule-To-Close refers to the _first_ Activity Task in that sequence.

A [Retry Policy](https://docs.temporal.io/encyclopedia/retry-policies) attached to an Activity Execution retries an Activity Task.

![Start-To-Close Timeout period with retries](https://docs.temporal.io/diagrams/schedule-to-start-timeout-with-retry.svg)

Start-To-Close Timeout period with retries

This timeout has two primary use cases:

1. Detect whether an individual Worker has crashed.
2. Detect whether the fleet of Workers polling the Task Queue is not able to keep up with the rate of Activity Tasks.

**The default Schedule-To-Start Timeout is ∞ (infinity).**

If this timeout is used, we recommend setting this timeout to the maximum time a Workflow Execution is willing to wait for an Activity Execution in the presence of all possible Worker outages, and have a concrete plan in place to reroute Activity Tasks to a different Task Queue.
This timeout **does not** trigger any retries regardless of the Retry Policy, as a retry would place the Activity Task back into the same Task Queue.
We do not recommend using this timeout unless you know what you are doing.

In most cases, we recommend monitoring the `temporal_activity_schedule_to_start_latency` metric to know when Workers slow down picking up Activity Tasks, instead of setting this timeout.

## Start-To-Close Timeout [​](https://docs.temporal.io/encyclopedia/detecting-activity-failures\#start-to-close-timeout "Direct link to Start-To-Close Timeout")

**What is a Start-To-Close Timeout in Temporal?**

A Start-To-Close Timeout is the maximum time allowed for a single [Activity Task Execution](https://docs.temporal.io/tasks#activity-task-execution).

Related 📚

- [![](https://docs.temporal.io/img/sdks/svgs/golang.svg)Set a Start-To-Close Timeout using the Go SDK](https://docs.temporal.io/develop/go/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/java.svg)Set a Start-To-Close Timeout using the Java SDK](https://docs.temporal.io/develop/java/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/php.svg)Set a Start-To-Close Timeout using the PHP SDK](https://docs.temporal.io/develop/php/activities/timeouts#activity-timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/python.svg)Set a Start-To-Close Timeout using the Python SDK](https://docs.temporal.io/develop/python/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/typescript.svg)Set a Start-To-Close Timeout using the TypeScript SDK](https://docs.temporal.io/develop/typescript/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/dotnet.svg)Set a Start-To-Close Timeout using the .NET SDK](https://docs.temporal.io/develop/dotnet/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/rust.svg)Set a Start-To-Close Timeout using the Rust SDK](https://docs.temporal.io/develop/rust/activities/timeouts) feature-guide


**The default Start-To-Close Timeout is the same as the default [Schedule-To-Close Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#schedule-to-close-timeout).**

An Activity Execution must have either this timeout (Start-To-Close) or the [Schedule-To-Close Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#schedule-to-close-timeout) set.
We recommend always setting this timeout; however, make sure that Start-To-Close Timeout is always set to be longer than the maximum possible time for the Activity Execution to complete.
For long running Activity Executions, we recommend also using [Activity Heartbeats](https://docs.temporal.io/encyclopedia/detecting-activity-failures#activity-heartbeat) and [Heartbeat Timeouts](https://docs.temporal.io/encyclopedia/detecting-activity-failures#heartbeat-timeout).

tip

We strongly recommend setting a Start-To-Close Timeout.

The Temporal Server doesn't detect failures when a Worker loses communication with the Server or crashes.
Therefore, the Temporal Server relies on the Start-To-Close Timeout to force Activity retries.

The main use case for the Start-To-Close timeout is to detect when a Worker crashes after it has started executing an Activity Task.

![Start-To-Close Timeout period](https://docs.temporal.io/diagrams/start-to-close-timeout.svg)

Start-To-Close Timeout period

A [Retry Policy](https://docs.temporal.io/encyclopedia/retry-policies) attached to an Activity Execution retries an Activity Task Execution.
Thus, the Start-To-Close Timeout is applied to each Activity Task Execution within an Activity Execution.

If the first Activity Task Execution returns an error the first time, then the full Activity Execution might look like this:

![Start-To-Close Timeout period with retries](https://docs.temporal.io/diagrams/start-to-close-timeout-with-retry.svg)

Start-To-Close Timeout period with retries

If this timeout is reached, the following actions occur:

- An [ActivityTaskTimedOut](https://docs.temporal.io/references/events#activitytasktimedout) Event is written to the Workflow Execution's mutable state.
- If a Retry Policy dictates a retry, the Temporal Service schedules another Activity Task.
  - The attempt count increments by 1 in the Workflow Execution's mutable state.
  - The Start-To-Close Timeout timer is reset.

## Schedule-To-Close Timeout [​](https://docs.temporal.io/encyclopedia/detecting-activity-failures\#schedule-to-close-timeout "Direct link to Schedule-To-Close Timeout")

**What is a Schedule-To-Close Timeout in Temporal?**

A Schedule-To-Close Timeout is the maximum amount of time allowed for the overall [Activity Execution](https://docs.temporal.io/activity-execution), from when the first [Activity Task](https://docs.temporal.io/tasks#activity-task) is scheduled to when the last Activity Task, in the chain of Activity Tasks that make up the Activity Execution, reaches a Closed status.

Related 📚

- [![](https://docs.temporal.io/img/sdks/svgs/golang.svg)Set a Schedule-To-Close Timeout using the Go SDK](https://docs.temporal.io/develop/go/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/java.svg)Set a Schedule-To-Close Timeout using the Java SDK](https://docs.temporal.io/develop/java/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/php.svg)Set a Schedule-To-Close Timeout using the PHP SDK](https://docs.temporal.io/develop/php/activities/timeouts#activity-timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/python.svg)Set a Schedule-To-Close Timeout using the Python SDK](https://docs.temporal.io/develop/python/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/typescript.svg)Set a Schedule-To-Close Timeout using the TypeScript SDK](https://docs.temporal.io/develop/typescript/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/dotnet.svg)Set a Schedule-To-Close Timeout using the .NET SDK](https://docs.temporal.io/develop/dotnet/activities/timeouts) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/rust.svg)Set a Schedule-To-Close Timeout using the Rust SDK](https://docs.temporal.io/develop/rust/activities/timeouts) feature-guide


![Schedule-To-Close Timeout period](https://docs.temporal.io/diagrams/schedule-to-close-timeout.svg)

Schedule-To-Close Timeout period

Example Schedule-To-Close Timeout period for an Activity Execution that has a chain Activity Task Executions:

![Schedule-To-Close Timeout period with a retry](https://docs.temporal.io/diagrams/schedule-to-close-timeout-with-retry.svg)

Schedule-To-Close Timeout period with a retry

**The default Schedule-To-Close Timeout is ∞ (infinity).**

An Activity Execution must have either this timeout (Schedule-To-Close) or [Start-To-Close](https://docs.temporal.io/encyclopedia/detecting-activity-failures#start-to-close-timeout) set.
This timeout can be used to control the overall duration of an Activity Execution in the face of failures (repeated Activity Task Executions), without altering the Maximum Attempts field of the Retry Policy.

tip

We strongly recommend setting a Start-To-Close Timeout.

The Temporal Server doesn't detect failures when a Worker loses communication with the Server or crashes.
Therefore, the Temporal Server relies on the Start-To-Close Timeout to force Activity retries.

## Activity Heartbeat [​](https://docs.temporal.io/encyclopedia/detecting-activity-failures\#activity-heartbeat "Direct link to Activity Heartbeat")

**What is an Activity Heartbeat in Temporal?**

An Activity Heartbeat is a ping from the Worker that is executing the Activity to the Temporal Service.
Each ping informs the Temporal Service that the Activity Execution is making progress and the Worker has not crashed.

Related 📚

- [![](https://docs.temporal.io/img/sdks/svgs/golang.svg)Heartbeat an Activity using the Go SDK](https://docs.temporal.io/develop/go/activities/timeouts#activity-heartbeats) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/java.svg)Heartbeat an Activity using the Java SDK](https://docs.temporal.io/develop/java/activities/timeouts#activity-heartbeats) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/php.svg)Heartbeat an Activity using the PHP SDK](https://docs.temporal.io/develop/php/activities/timeouts#activity-heartbeats) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/python.svg)Heartbeat an Activity using the Python SDK](https://docs.temporal.io/develop/python/activities/timeouts#activity-heartbeats) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/typescript.svg)Heartbeat an Activity using the TypeScript SDK](https://docs.temporal.io/develop/typescript/activities/timeouts#activity-heartbeat-timeout) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/dotnet.svg)Heartbeat an Activity using the .NET SDK](https://docs.temporal.io/develop/dotnet/activities/timeouts#activity-heartbeats) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/rust.svg)Heartbeat an Activity using the Rust SDK](https://docs.temporal.io/develop/rust/activities/timeouts#activity-heartbeats) feature-guide


Activity Heartbeats work in conjunction with a [Heartbeat Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#heartbeat-timeout).

Activity Heartbeats are implemented within the Activity Definition.
Custom progress information can be included in the Heartbeat which can then be used by the Activity Execution should a retry occur.

An Activity Heartbeat can be recorded as often as needed (e.g. once a minute or every loop iteration).
It is often a good practice to Heartbeat on anything but the shortest Activity Execution.
Temporal SDKs control the rate at which Heartbeats are sent to the Temporal Service.

Heartbeating is not required from [Local Activities](https://docs.temporal.io/local-activity), and does nothing.

For _long-running_ Activities, we recommend using a relatively short Heartbeat Timeout and a frequent Heartbeat.
That way if a Worker fails it can be handled in a timely manner.

A Heartbeat can include an application layer payload that can be used to _save_ Activity Execution progress.
If an [Activity Task Execution](https://docs.temporal.io/tasks#activity-task-execution) times out due to a missed Heartbeat, the next Activity Task can access and continue with that payload.

Activity Cancellations are delivered to Activities from the Temporal Service when they Heartbeat. Activities that don't Heartbeat can't receive a Cancellation.
Heartbeat throttling may lead to Cancellation getting delivered later than expected.

### Throttling [​](https://docs.temporal.io/encyclopedia/detecting-activity-failures\#throttling "Direct link to Throttling")

Heartbeats may not always be sent to the Temporal Service—they may be throttled by the Worker.
The throttle interval is the smaller of the following:

- If `heartbeatTimeout` is provided, `heartbeatTimeout * 0.8`; otherwise, `defaultHeartbeatThrottleInterval`
- `maxHeartbeatThrottleInterval`

`defaultHeartbeatThrottleInterval` is 30 seconds by default, and `maxHeartbeatThrottleInterval` is 60 seconds by default.
Each can be set in Worker options.

Throttling is implemented as follows:

- After sending a Heartbeat, the Worker sets a timer for the throttle interval.
- The Worker stops sending Heartbeats, but continues receiving Heartbeats from the Activity and remembers the most recent one.
- When the timer fires, the Worker:
  - Sends the most recent Heartbeat.
  - Sets the timer again.

Throttling allows the Worker to reduce network traffic and load on the Temporal Service by suppressing Heartbeats that aren’t necessary to prevent a Heartbeat Timeout.
Throttling does not apply to the final Heartbeat message in the case of Activity Failure.
If an Activity fails just after recording progress information in a Heartbeat message, that progress information will be available during the next retry attempt, provided that the Worker itself did not crash before delivering it to the Temporal Service.

### Which Activities should Heartbeat? [​](https://docs.temporal.io/encyclopedia/detecting-activity-failures\#which-activities-should-heartbeat "Direct link to Which Activities should Heartbeat?")

Heartbeating is best thought about not in terms of time, but in terms of "How do you know you are making progress?"
For short-term operations, progress updates are not a requirement.
However, checking the progress and status of Activity Executions that run over long periods is almost always useful.

Consider the following when setting Activity Heartbeats:

- Your underlying task must be able to report definite progress.
Note that your Workflow cannot read this progress information while the Activity is still executing (or it would have to store it in Event History).
You can report progress to external sources if you need it exposed to the user.

- Your Activity Execution is long-running, and you need to verify whether the Worker that is processing your Activity is still alive and has not run out of memory or silently crashed.


For example, the following scenarios are suitable for Heartbeating:

- Reading a large file from Amazon S3.
- Running a ML training job on some local GPUs.

And the following scenarios are not suitable for Heartbeating:

- Making a quick API call.
- Reading a small file from disk.

### Heartbeat Timeout [​](https://docs.temporal.io/encyclopedia/detecting-activity-failures\#heartbeat-timeout "Direct link to Heartbeat Timeout")

**What is a Heartbeat Timeout in Temporal?**

A Heartbeat Timeout is the maximum time between [Activity Heartbeats](https://docs.temporal.io/encyclopedia/detecting-activity-failures#activity-heartbeat).

Related 📚

- [![](https://docs.temporal.io/img/sdks/svgs/golang.svg)Set a Heartbeat Timeout using the Go SDK](https://docs.temporal.io/develop/go/activities/timeouts#activity-heartbeats) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/java.svg)Set a Heartbeat Timeout using the Java SDK](https://docs.temporal.io/develop/java/activities/timeouts#heartbeat-timeout) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/php.svg)Set a Heartbeat Timeout using the PHP SDK](https://docs.temporal.io/develop/php/activities/timeouts#heartbeat-timeout) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/python.svg)Set a Heartbeat Timeout using the Python SDK](https://docs.temporal.io/develop/python/activities/timeouts#heartbeat-timeout) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/typescript.svg)Set a Heartbeat Timeout using the TypeScript SDK](https://docs.temporal.io/develop/typescript/activities/timeouts#activity-heartbeat-timeout) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/dotnet.svg)Set a Heartbeat Timeout using the .NET SDK](https://docs.temporal.io/develop/dotnet/activities/timeouts#heartbeat-timeout) feature-guide

- [![](https://docs.temporal.io/img/sdks/svgs/rust.svg)Set a Heartbeat Timeout using the Rust SDK](https://docs.temporal.io/develop/rust/activities/timeouts#heartbeat-timeout) feature-guide


![Heartbeat Timeout periods](https://docs.temporal.io/diagrams/heartbeat-timeout.svg)

Heartbeat Timeout periods

If this timeout is reached, the Activity Task fails and a retry occurs if a [Retry Policy](https://docs.temporal.io/encyclopedia/retry-policies) dictates it.

**Tags:**

- [Concepts](https://docs.temporal.io/tags/concepts)
- [Activities](https://docs.temporal.io/tags/activities)
- [Failures](https://docs.temporal.io/tags/failures)
- [Timeouts](https://docs.temporal.io/tags/timeouts)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Application failures](https://docs.temporal.io/encyclopedia/application-failures) [Next\\
\\
Detecting Workflow failures](https://docs.temporal.io/encyclopedia/detecting-workflow-failures)

- [Schedule-To-Start Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#schedule-to-start-timeout)
- [Start-To-Close Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#start-to-close-timeout)
- [Schedule-To-Close Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#schedule-to-close-timeout)
- [Activity Heartbeat](https://docs.temporal.io/encyclopedia/detecting-activity-failures#activity-heartbeat)
  - [Throttling](https://docs.temporal.io/encyclopedia/detecting-activity-failures#throttling)
  - [Which Activities should Heartbeat?](https://docs.temporal.io/encyclopedia/detecting-activity-failures#which-activities-should-heartbeat)
  - [Heartbeat Timeout](https://docs.temporal.io/encyclopedia/detecting-activity-failures#heartbeat-timeout)

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