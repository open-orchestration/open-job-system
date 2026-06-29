[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781557630349

userId:

deviceId: a010449f-c592-40a2-b3da-a6c8ae8b98ee

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/develop/typescript/workflows/versioning#__docusaurus_skipToContent_fallback)

[![Temporal logo](https://docs.temporal.io/img/assets/temporal-logo-dark.svg)](https://temporal.io/)[Home](https://docs.temporal.io/) [Courses](https://learn.temporal.io/getting_started/) [SDKs](https://docs.temporal.io/develop) [AI Cookbook](https://docs.temporal.io/ai-cookbook) [Code Exchange](https://temporal.io/code-exchange) [Temporal Cloud](https://docs.temporal.io/cloud)

Ask AI

Search`Ctrl`  `K`

- [Home](https://docs.temporal.io/)
- [Quickstarts](https://docs.temporal.io/quickstarts)
- [Evaluate](https://docs.temporal.io/evaluate/)

- [Develop](https://docs.temporal.io/develop/)

  - [Go SDK](https://docs.temporal.io/develop/go/)

  - [Java SDK](https://docs.temporal.io/develop/java/)

  - [PHP SDK](https://docs.temporal.io/develop/php/)

  - [Python SDK](https://docs.temporal.io/develop/python/)

  - [TypeScript SDK](https://docs.temporal.io/develop/typescript/)

    - [Quickstart](https://docs.temporal.io/develop/typescript/set-up-your-local-typescript)
    - [Workflows](https://docs.temporal.io/develop/typescript/workflows/)

      - [Workflow basics](https://docs.temporal.io/develop/typescript/workflows/basics)
      - [Child Workflows](https://docs.temporal.io/develop/typescript/workflows/child-workflows)
      - [Continue-As-New](https://docs.temporal.io/develop/typescript/workflows/continue-as-new)
      - [Message passing](https://docs.temporal.io/develop/typescript/workflows/message-passing)
      - [Cancellation](https://docs.temporal.io/develop/typescript/workflows/cancellation)
      - [Cancellation scopes](https://docs.temporal.io/develop/typescript/workflows/cancellation-scopes)
      - [Timeouts](https://docs.temporal.io/develop/typescript/workflows/timeouts)
      - [Schedules](https://docs.temporal.io/develop/typescript/workflows/schedules)
      - [Timers](https://docs.temporal.io/develop/typescript/workflows/timers)
      - [Versioning](https://docs.temporal.io/develop/typescript/workflows/versioning)
    - [Activities](https://docs.temporal.io/develop/typescript/activities/)

    - [Workers](https://docs.temporal.io/develop/typescript/workers/)

    - [Client](https://docs.temporal.io/develop/typescript/client/)

    - [Nexus](https://docs.temporal.io/develop/typescript/nexus/)

    - [Platform](https://docs.temporal.io/develop/typescript/platform/)

    - [Best practices](https://docs.temporal.io/develop/typescript/best-practices/)

    - [Integrations](https://docs.temporal.io/develop/typescript/integrations/)
  - [.NET SDK](https://docs.temporal.io/develop/dotnet/)

  - [Ruby SDK](https://docs.temporal.io/develop/ruby/)

  - [Rust SDK](https://docs.temporal.io/develop/rust/)

  - [Environment configuration](https://docs.temporal.io/develop/environment-configuration)
  - [Activity retry simulator](https://docs.temporal.io/develop/activity-retry-simulator)
  - [Worker performance](https://docs.temporal.io/develop/worker-performance)
  - [Worker tuning reference](https://docs.temporal.io/develop/worker-tuning-reference)
  - [Safe deployments](https://docs.temporal.io/develop/safe-deployments)
  - [Plugins guide](https://docs.temporal.io/develop/plugins-guide)
  - [Task queue priority and fairness](https://docs.temporal.io/develop/task-queue-priority-fairness)
- [Temporal Cloud](https://docs.temporal.io/cloud)

- [Deploy to production](https://docs.temporal.io/production-deployment)

- [CLI (temporal)](https://docs.temporal.io/cli)

- [References](https://docs.temporal.io/references/)

- [Troubleshooting](https://docs.temporal.io/troubleshooting/)

- [Best practices](https://docs.temporal.io/best-practices/)

- [Encyclopedia](https://docs.temporal.io/encyclopedia/)

- [Interactive Demos](https://docs.temporal.io/develop/typescript/workflows/versioning#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Develop](https://docs.temporal.io/develop/)
- [TypeScript SDK](https://docs.temporal.io/develop/typescript/)
- [Workflows](https://docs.temporal.io/develop/typescript/workflows/)
- Versioning

On this page

# Versioning - TypeScript SDK

Copy

Since Workflow Executions in Temporal can run for long periods — sometimes months or even years — it's common to need to make changes to a Workflow Definition, even while a particular Workflow Execution is in progress.

The Temporal Platform requires that Workflow code is [deterministic](https://docs.temporal.io/workflow-definition#deterministic-constraints).
If you make a change to your Workflow code that would cause non-deterministic behavior on Replay, you'll need to use one of our Versioning methods to gracefully update your running Workflows.

Common causes include adding, removing, or reordering `await` calls on Command-producing APIs such as Activities and timers. Each `await` is a yield point that affects the Command sequence seen during Replay.

With Versioning, you can modify your Workflow Definition so that new executions use the updated code, while existing ones continue running the original version.
There are two primary Versioning methods that you can use:

- [Worker Versioning](https://docs.temporal.io/production-deployment/worker-deployments/worker-versioning). The Worker Versioning feature allows you to tag your Workers and programmatically roll them out in versioned deployments, so that old Workers can run old code paths and new Workers can run new code paths.
- [Versioning with Patching](https://docs.temporal.io/develop/typescript/workflows/versioning#patching). This method works by adding branches to your code tied to specific revisions. It applies a code change to new Workflow Executions while avoiding disruptive changes to in-progress Workflow Executions.

danger

Support for the experimental Worker Versioning method before 2025 will be removed from Temporal Server in March 2026. Refer to the [latest Worker Versioning docs](https://docs.temporal.io/worker-versioning) for guidance. You can still refer to the [Worker Versioning Legacy](https://docs.temporal.io/develop/typescript/worker-versioning-legacy) docs if needed.

## Versioning with Patching [​](https://docs.temporal.io/develop/typescript/workflows/versioning\#patching "Direct link to Versioning with Patching")

### Adding a patch [​](https://docs.temporal.io/develop/typescript/workflows/versioning\#adding-a-patch "Direct link to Adding a patch")

A Patch defines a logical branch in a Workflow for a specific change, similar to a feature flag.
It applies a code change to new Workflow Executions while avoiding disruptive changes to in-progress Workflow Executions.
When you want to make substantive code changes that may affect existing Workflow Executions, create a patch.

Suppose you have an initial Workflow that runs `activityA`:

```ts
// v1

export async function myWorkflow(): Promise<void> {

  await activityA();

  await sleep('1 days'); // arbitrary long sleep to simulate a long running workflow we need to patch

  await activityThatMustRunAfterA();

}
```

Now, you want to update your code to run `activityB` instead. This represents your desired end state.

```ts
// vFinal

export async function myWorkflow(): Promise<void> {

  await activityB();

  await sleep('1 days');

}
```

The problem is that you cannot deploy this `vFinal` revision directly until you're certain there are no more running Workflows created using the `v1` code, otherwise you are likely to cause a nondeterminism error.
Instead, you'll need to use the [`patched`](https://typescript.temporal.io/api/namespaces/workflow#patched) function to check which version of the code should be executed.

Patching is a three-step process:

1. Patch in any new, updated code using the `patched()` function. Run the new patched code alongside old code.
2. Remove old code and use `deprecatePatch()` to mark a particular patch as deprecated.
3. Once there are no longer any open Workflow Executions of the previous version of the code, remove `deprecatePatch()`.
Let's walk through this process in sequence.

### Patching in new code [​](https://docs.temporal.io/develop/typescript/workflows/versioning\#patching-in-new-code "Direct link to Patching in new code")

Using `patched` inserts a marker into the Event History.
During Replay, if a Worker encounters a history with that marker, it will fail the Workflow task when the Workflow code doesn't produce the same patch marker (in this case `your-change-id`).
This ensures you can safely deploy code from `v2` as a "feature flag" alongside the original version (`v1`).

```ts
// v2

import { patched } from '@temporalio/workflow';

export async function myWorkflow(): Promise<void> {

  if (patched('my-change-id')) {

    await activityB();

    await sleep('1 days');

  } else {

    await activityA();

    await sleep('1 days');

    await activityThatMustRunAfterA();

  }

}
```

### Deprecating patches [​](https://docs.temporal.io/develop/typescript/workflows/versioning\#deprecated-patches "Direct link to Deprecating patches")

After ensuring that all Workflows started with `v1` code have left retention, you can [deprecate the patch](https://typescript.temporal.io/api/namespaces/workflow#deprecatepatch).

Once your Workflows are no longer running the pre-patch code paths, you can deploy your code with `deprecatePatch()`.
These Workers will be running the most up-to-date version of the Workflow code, which no longer requires the patch.
Deprecated patches serve as a bridge between the final stage of the patching process and the final state that no longer has patches. They function similarly to regular patches by adding a marker to the Event History. However, this marker won't cause a replay failure when the Workflow code doesn't produce it.

```ts
// v3

import { deprecatePatch } from '@temporalio/workflow';

export async function myWorkflow(): Promise<void> {

  deprecatePatch('my-change-id');

  await activityB();

  await sleep('1 days');

}
```

### Removing a patch [​](https://docs.temporal.io/develop/typescript/workflows/versioning\#deploy-new-code "Direct link to Removing a patch")

Once your pre-patch Workflows have left retention, you can then safely deploy Workers that no longer use either the `patched()` or `deprecatePatch()` calls:

Patching allows you to make changes to currently running Workflows.
It is a powerful method for introducing compatible changes without introducing non-determinism errors.

### Workflow cutovers [​](https://docs.temporal.io/develop/typescript/workflows/versioning\#workflow-cutovers "Direct link to Workflow cutovers")

To understand why Patching is useful, it's helpful to demonstrate cutting over an entire Workflow.

Since incompatible changes only affect open Workflow Executions of the same type, you can avoid determinism errors by creating a whole new Workflow when making changes.
To do this, you can copy the Workflow Definition function, giving it a different name, and register both names with your Workers.

For example, you would duplicate `PizzaWorkflow` as `PizzaWorkflowV2`:

```typescript
function pizzaWorkflow(order: PizzaOrder): Promise<OrderConfirmation> {

  // this function contains the original code

}

function pizzaWorkflowV2(order: PizzaOrder): Promise<OrderConfirmation> {

  // this function contains the updated code

}
```

You would then need to update the Worker configuration, and any other identifier strings, to register both Workflow Types:

```typescript
const worker = await Worker.create({

  workflowsPath: require.resolve('./workflows'),

  // other configurations

});
```

The downside of this method is that it requires you to duplicate code and to update any commands used to start the Workflow.
This can become impractical over time.
This method also does not provide a way to version any still-running Workflows -- it is essentially just a cutover, unlike Patching.

### Testing a Workflow for replay safety [​](https://docs.temporal.io/develop/typescript/workflows/versioning\#testing-a-workflow-for-replay-safety "Direct link to Testing a Workflow for replay safety")

To determine whether your Workflow your needs a patch, or that you've patched it successfully, you should incorporate [Replay Testing](https://docs.temporal.io/develop/typescript/best-practices/testing-suite#replay).

## Worker Versioning [​](https://docs.temporal.io/develop/typescript/workflows/versioning\#worker-versioning "Direct link to Worker Versioning")

Temporal's [Worker Versioning](https://docs.temporal.io/production-deployment/worker-deployments/worker-versioning) feature allows you to tag your Workers and programmatically roll them out in Deployment Versions, so that old Workers can run old code paths and new Workers can run new code paths. This way, you can pin your Workflows to specific revisions, avoiding the need for patching.

**Tags:**

- [Patching](https://docs.temporal.io/tags/patching)
- [Workflows](https://docs.temporal.io/tags/workflows)
- [Versioning](https://docs.temporal.io/tags/versioning)
- [TypeScript SDK](https://docs.temporal.io/tags/type-script-sdk)
- [Temporal SDKs](https://docs.temporal.io/tags/temporal-sd-ks)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Timers](https://docs.temporal.io/develop/typescript/workflows/timers) [Next\\
\\
Workflows](https://docs.temporal.io/develop/typescript/activities/)

- [Versioning with Patching](https://docs.temporal.io/develop/typescript/workflows/versioning#patching)
  - [Adding a patch](https://docs.temporal.io/develop/typescript/workflows/versioning#adding-a-patch)
  - [Patching in new code](https://docs.temporal.io/develop/typescript/workflows/versioning#patching-in-new-code)
  - [Deprecating patches](https://docs.temporal.io/develop/typescript/workflows/versioning#deprecated-patches)
  - [Removing a patch](https://docs.temporal.io/develop/typescript/workflows/versioning#deploy-new-code)
  - [Workflow cutovers](https://docs.temporal.io/develop/typescript/workflows/versioning#workflow-cutovers)
  - [Testing a Workflow for replay safety](https://docs.temporal.io/develop/typescript/workflows/versioning#testing-a-workflow-for-replay-safety)
- [Worker Versioning](https://docs.temporal.io/develop/typescript/workflows/versioning#worker-versioning)

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