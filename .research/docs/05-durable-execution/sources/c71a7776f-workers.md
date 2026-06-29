[Skip to main content](https://temporal.io/comms#main-content)

[Skip to main content](https://docs.temporal.io/workers#__docusaurus_skipToContent_fallback)

[![Temporal logo](https://docs.temporal.io/img/assets/temporal-logo-dark.svg)![Temporal logo](https://docs.temporal.io/img/assets/temporal-logo.svg)](https://temporal.io/)[Home](https://docs.temporal.io/) [Courses](https://learn.temporal.io/getting_started/) [SDKs](https://docs.temporal.io/develop) [AI Cookbook](https://docs.temporal.io/ai-cookbook) [Code Exchange](https://temporal.io/code-exchange) [Temporal Cloud](https://docs.temporal.io/cloud)

Ask AI

Search

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

    - [Tasks](https://docs.temporal.io/tasks)
    - [Task Queues](https://docs.temporal.io/task-queue)
    - [Task Queue naming](https://docs.temporal.io/task-queue/naming)
    - [Task Routing and Worker sessions](https://docs.temporal.io/task-routing)
    - [Sticky Execution](https://docs.temporal.io/sticky-execution)
    - [Worker Shutdown Behavior](https://docs.temporal.io/encyclopedia/workers/worker-shutdown)
    - [Worker Versioning](https://docs.temporal.io/worker-versioning)
    - [Serverless Workers](https://docs.temporal.io/serverless-workers)
  - [Event History](https://docs.temporal.io/encyclopedia/event-history/)

  - [Workflow Message Passing](https://docs.temporal.io/encyclopedia/workflow-message-passing/)

  - [Child Workflows](https://docs.temporal.io/child-workflows)

  - [Visibility](https://docs.temporal.io/visibility)

  - [Temporal Service](https://docs.temporal.io/temporal-service)

  - [Namespaces](https://docs.temporal.io/namespaces)

  - [Temporal Nexus](https://docs.temporal.io/nexus)

  - [Extensibility](https://docs.temporal.io/encyclopedia/extensibility)

  - [Web UI](https://docs.temporal.io/web-ui)
- [Interactive Demos](https://docs.temporal.io/develop/standalone-activities-interactive-demo)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- Workers

On this page

# What is a Temporal Worker?

Copy

This page discusses the following:

- [Worker](https://docs.temporal.io/workers#worker)
- [Worker Program](https://docs.temporal.io/workers#worker-program)
- [Worker Entity](https://docs.temporal.io/workers#worker-entity)
- [Worker Identity](https://docs.temporal.io/workers#worker-identity)
- [Worker Process](https://docs.temporal.io/workers#worker-process)

## What is a Worker? [​](https://docs.temporal.io/workers\#worker "Direct link to What is a Worker?")

In day-to-day conversations, the term Worker is used to denote either a [Worker Program](https://docs.temporal.io/workers#worker-program), a [Worker Process](https://docs.temporal.io/workers#worker-process), or a [Worker Entity](https://docs.temporal.io/workers#worker-entity).
Temporal documentation aims to be explicit and differentiate between them.

## What is a Worker Program? [​](https://docs.temporal.io/workers\#worker-program "Direct link to What is a Worker Program?")

A Worker Program is the static code that defines the constraints of the Worker Process, developed using the APIs of a Temporal SDK.

info

- [How to run a development Worker using the Go SDK](https://docs.temporal.io/develop/go/workers/run-worker-process#develop-worker)

- [How to run a development Worker using the Java SDK](https://docs.temporal.io/develop/java/workers/run-worker-process)

- [How to run a development Worker using the PHP SDK](https://docs.temporal.io/develop/php/workers/run-worker-process#run-a-dev-worker)

- [How to run a development Worker using the Python SDK](https://docs.temporal.io/develop/python/workers/run-worker-process#run-a-dev-worker)

- [How to run a development Worker using the TypeScript SDK](https://docs.temporal.io/develop/typescript/workers/run-worker-process#run-a-dev-worker)

- [How to run a development Worker using the .NET SDK](https://docs.temporal.io/develop/dotnet/workers/run-worker-process)

- [How to connect a Go SDK Worker to Temporal Cloud](https://docs.temporal.io/develop/go/workers/run-worker-process#connect-to-temporal-cloud)

- [How to run a Temporal Cloud Worker using the TypeScript SDK](https://docs.temporal.io/develop/typescript/workers/run-worker-process#run-a-temporal-cloud-worker)


## What is a Worker Entity? [​](https://docs.temporal.io/workers\#worker-entity "Direct link to What is a Worker Entity?")

A Worker Entity is the individual Worker within a Worker Process that listens to a specific Task Queue.

A Worker Entity listens and polls on a single Task Queue.
A Worker Entity contains a Workflow Worker and/or an Activity Worker, which makes progress on Workflow Executions and Activity Executions, respectively.

**Can a Worker handle more Workflow Executions than its cache size or number of supported threads?**

Yes it can.
However, the trade off is added latency.

Workers are stateless, so any Workflow Execution in a blocked state can be safely removed from a Worker.
Later on, it can be resurrected on the same or different Worker when the need arises (in the form of an external event).
Therefore, a single Worker can handle millions of open Workflow Executions, assuming it can handle the update rate and that a slightly higher latency is not a concern.

**Operation guides:**

- [How to tune Workers](https://docs.temporal.io/develop/worker-performance)
- [Worker tuning quick reference](https://docs.temporal.io/develop/worker-tuning-reference) \- SDK defaults and metrics

## What is a Worker Identity? [​](https://docs.temporal.io/workers\#worker-identity "Direct link to What is a Worker Identity?")

Workers have an associated identifier that helps identify the specific Worker instance.
By default, Temporal SDKs set a Worker Identity to `${process.pid}@${os.hostname()}`, which combines the Worker's process ID (`process.pid`) and the hostname of the machine running the Worker (`os.hostname()`).

The Worker Identity is visible in various contexts, such as Event History and the list of pollers on a Task Queue.

You can use the Worker Identity to aid in debugging operational issues.
By providing a user assigned identifier, you can trace issues back to specific Worker instances.

**What are some limitations of the default identity?**

While the default identity format may seem sensible, it often proves to be of limited usefulness in cloud environments.
Some common issues include:

- **Docker containers**: When running Workers inside Docker containers, the process ID is always `1`, as each container typically runs a single process. This makes the process identifier meaningless for identification purposes.
- **Random hostnames**: In some cloud environments, such as Amazon ECS (Elastic Container Service), the hostname is a randomly generated string that does not provide any meaningful information about the Worker's execution context.
- **Ephemeral IP addresses**: In certain cases, the hostname might be set to an ephemeral IP address, which can change over time and does not uniquely identify a Worker instance.

**What are some recommended approaches?**

It is recommended that you ensure that the Worker Identity can be linked back to the corresponding machine, process, execution context, or log stream.
In some execution environments, this might require that you explicitly specify the Worker Identity.

Here are some approaches:

- **Use environment-specific identifiers**: Choose an identifier that is specific to your execution environment. For example, when running Workers on Amazon ECS, you can set the Worker Identity to the ECS Task ID, which uniquely identifies the task running the Worker.
- **Include relevant context**: Incorporate information that helps establish the context of the Worker, such as the deployment environment (`staging` or `production`), region, or any other relevant details.
- **Ensure uniqueness**: Make sure that the Worker Identity is unique within your system to avoid ambiguity when debugging issues.
- **Keep it concise**: While including relevant information is important, try to keep the Worker Identity concise and easily readable to facilitate quick identification and troubleshooting.

## What is a Worker Process? [​](https://docs.temporal.io/workers\#worker-process "Direct link to What is a Worker Process?")

![Component diagram of a Worker Process and the Temporal Server](https://docs.temporal.io/diagrams/worker-and-server-component.svg)

Component diagram of a Worker Process and the Temporal Server

A Worker Process is responsible for polling a [Task Queue](https://docs.temporal.io/task-queue), dequeueing a [Task](https://docs.temporal.io/tasks#task), executing your code in response to a Task, and responding to the [Temporal Service](https://docs.temporal.io/temporal-service) with the results.

More formally, a Worker Process is any process that implements the Task Queue Protocol and the Task Execution Protocol.

- A Worker Process is a Workflow Worker Process if the process implements the Workflow Task Queue Protocol and executes the Workflow Task Execution Protocol to make progress on a Workflow Execution.
A Workflow Worker Process can listen on an arbitrary number of Workflow Task Queues and can execute an arbitrary number of Workflow Tasks.
- A Worker Process is an Activity Worker Process if the process implements the Activity Task Queue Protocol and executes the Activity Task Processing Protocol to make progress on an Activity Execution.
An Activity Worker Process can listen on an arbitrary number of Activity Task Queues and can execute an arbitrary number of Activity Tasks.

**Worker Processes are external to a Temporal Service.**
Temporal Application developers are responsible for developing [Worker Programs](https://docs.temporal.io/workers#worker-program) and operating Worker Processes.
Said another way, the [Temporal Service](https://docs.temporal.io/temporal-service) (including the Temporal Cloud) doesn't execute any of your code (Workflow and Activity Definitions) on Temporal Service machines. The Temporal Service is solely responsible for orchestrating [State Transitions](https://docs.temporal.io/workflow-execution#state-transition) and providing Tasks to the next available [Worker Entity](https://docs.temporal.io/workers#worker-entity).

While data transferred in Event Histories is [secured by mTLS](https://docs.temporal.io/self-hosted-guide/security#encryption-in-transit-with-mtls), by default, it is still readable at rest in the Temporal Service.

To solve this, Temporal SDKs offer a [Data Converter API](https://docs.temporal.io/dataconversion) that you can use to customize the serialization of data going out of and coming back in to a Worker Entity, with the net effect of guaranteeing that the Temporal Service cannot read sensitive business data.

In many of our tutorials, we show you how to run both a Temporal Service and one Worker on the same machine for local development.
However, a production-grade Temporal Application typically has a _fleet_ of Worker Processes, all running on hosts external to the Temporal Service.
A Temporal Application can have as many Worker Processes as needed.

A Worker Process can be both a Workflow Worker Process and an Activity Worker Process.
Many SDKs support the ability to have multiple Worker Entities in a single Worker Process.
(Worker Entity creation and management differ between SDKs.)
A single Worker Entity can listen to only a single Task Queue.
But if a Worker Process has multiple Worker Entities, the Worker Process could be listening to multiple Task Queues.

![Entity relationship diagram (meta model) of Worker Processes, Task Queues, and Tasks](https://docs.temporal.io/diagrams/worker-and-server-entity-relationship.svg)

Entity relationship diagram (meta model) of Worker Processes, Task Queues, and Tasks

Worker Processes executing Activity Tasks must have access to any resources needed to execute the actions that are defined in Activity Definitions, such as the following:

- Network access for external API calls.
- Credentials for infrastructure provisioning.
- Specialized GPUs for machine learning utilities.

The Temporal Service itself has [internal workers](https://temporal.io/blog/workflow-engine-principles/#system-workflows-1910) for system Workflow Executions.
However, these internal workers are not visible to the developer.

**Tags:**

- [Workers](https://docs.temporal.io/tags/workers)
- [Concepts](https://docs.temporal.io/tags/concepts)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Retry Policies](https://docs.temporal.io/encyclopedia/retry-policies) [Next\\
\\
Tasks](https://docs.temporal.io/tasks)

- [What is a Worker?](https://docs.temporal.io/workers#worker)
- [What is a Worker Program?](https://docs.temporal.io/workers#worker-program)
- [What is a Worker Entity?](https://docs.temporal.io/workers#worker-entity)
- [What is a Worker Identity?](https://docs.temporal.io/workers#worker-identity)
- [What is a Worker Process?](https://docs.temporal.io/workers#worker-process)

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

[![Temporal logo](https://docs.temporal.io/img/favicon.png)![Temporal logo](https://docs.temporal.io/img/favicon.png)](https://temporal.io/)

Copyright © 2026 Temporal Technologies Inc.

Feedback