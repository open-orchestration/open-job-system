- [Documentation](https://www.inngest.com/docs)
- [Examples](https://www.inngest.com/docs/examples)
- [Patterns](https://www.inngest.com/docs/patterns)

Search... `Ctrl+K`

[Contact sales](https://www.inngest.com/contact?ref=docs-header) [Sign Up](https://app.inngest.com/sign-up?ref=docs-header)

Search...

- [Documentation](https://www.inngest.com/docs)
- [Examples](https://www.inngest.com/docs/examples)
- [Patterns](https://www.inngest.com/docs/patterns)

LearnReference

TypeScript

[Home](https://www.inngest.com/docs)

Quick starts

  - [Next.js](https://www.inngest.com/docs/getting-started/nextjs-quick-start)

Node.js

  - [Python](https://www.inngest.com/docs/getting-started/python-quick-start)

Concepts

  - [How Durable execution works](https://www.inngest.com/docs/learn/how-functions-are-executed)

Durable Functions

Durable Endpointsnew

Steps

Error handling

Flow control

Cancellation

Realtimenew

Environments and Apps

Guides

  - [Local development](https://www.inngest.com/docs/local-development)

CLInew

Events and Triggers

Agents

Deploying

    - [Overview](https://www.inngest.com/docs/platform/deployment)
    - [Sync your app](https://www.inngest.com/docs/apps/cloud)
    - [Connect (workers)beta](https://www.inngest.com/docs/setup/connect)
    - [Checkpointingnew](https://www.inngest.com/docs/setup/checkpointing)

Cloud providers

  - [Optimizing Performance](https://www.inngest.com/docs/improve-performance)
  - [Versioning](https://www.inngest.com/docs/learn/versioning)
  - [Logging](https://www.inngest.com/docs/guides/logging)

Middleware

Platform

Manage

Monitor

  - [Inspecting runs](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs)
  - [Tracesnew](https://www.inngest.com/docs/platform/monitor/traces)
  - [Observability and metrics](https://www.inngest.com/docs/platform/monitor/observability-metrics)
  - [Insightsnew](https://www.inngest.com/docs/platform/monitor/insights)
  - [Events](https://www.inngest.com/docs/platform/monitor/inspecting-events)

Integrations

AI

  - [Agent Plugins and Skills](https://www.inngest.com/docs/ai-dev-tools/agent-skills)
  - [Dev Server MCP](https://www.inngest.com/docs/ai-dev-tools/mcp)
  - [AgentKit](https://agentkit.inngest.com/)

Resources

  - [Security](https://www.inngest.com/docs/learn/security)
  - [Glossary](https://www.inngest.com/docs/learn/glossary)
  - [Release phases](https://www.inngest.com/docs/release-phases)
  - [FAQ](https://www.inngest.com/docs/faq)
  - [Limitations](https://www.inngest.com/docs/usage-limits/inngest)

- [Contact sales](https://www.inngest.com/contact?ref=docs-mobile-nav) [Sign Up](https://app.inngest.com/sign-up?ref=docs-mobile-nav)

#### On this page

- [Inspecting a Function run](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs#top)
- [Accessing Function runs](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs#accessing-function-runs)
- [Searching Function runs](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs#searching-function-runs)
- [Searchable properties](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs#searchable-properties)
- [Searching for errors](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs#searching-for-errors)
- [The Function run details](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs#the-function-run-details)
- [Performing actions from the Function run details](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs#performing-actions-from-the-function-run-details)

TypeScript SDK v4 is now available! [See what's new](https://www.inngest.com/docs/reference/typescript/v4/migrations/v3-to-v4)

Platform [Monitor](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs)

# Inspecting a Function run

Copy MarkdownOpen

You identified a failed Function run and want to identify the root cause? Or simply want to dig into a run's timings?
The Function run details will provide all the information to understand how this run ran and the tools to reproduce it locally.

## [Accessing Function runs](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs\#accessing-function-runs)

Functions runs across all application of the currently [selected environment](https://www.inngest.com/docs/platform/environments) are accessible via the "Runs" page in the left side navigation.

![The "Handle failed payments" Function runs list features a run in a failing state.](https://www.inngest.com/_next/image?url=%2Fassets%2Fdocs%2Fplatform%2Fmonitor%2Finspecting-function-runs%2Ffunction-runs.png&w=3840&q=75)

_Runs can be filtered using a Status, Queued or Started at and Application filters._

Accessing the runs of a specific Function is achieved via the "Functions" menu, as described in [the function run details section](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs#the-function-run-details).

## [Searching Function runs](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs\#searching-function-runs)

Advanced filters are available using a [CEL expression](https://www.inngest.com/docs/guides/writing-expressions). The search feature is available by clicking on the "Show search" button next to the other run filters.

![The runs list features an advance search feature that filters results using a CEL query.](https://www.inngest.com/_next/image?url=%2Fassets%2Fdocs%2Fplatform%2Fmonitor%2Finspecting-function-runs%2Ffunction-runs-search.png&w=3840&q=75)

### [Searchable properties](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs\#searchable-properties)

Only basic search operators and `event` and `output` variables are available for now:

| Field name | Type | Operators |
| --- | --- | --- |
| event.id | `string` | `==`, `!=` |
| event.name | `string` | `==`, `!=` |
| event.ts | `int64` | `==`, `!=`, `>`, `>=`, `<`, `<=` |
| event.v | `string` | `==`, `!=` |
| event.data | `map[string]any` | `==`, `!=`, `>`, `>=`, `<`, `<=` |
| output | `any` | `==`, `!=`, `>`, `>=`, `<`, `<=` |

A few examples of valid search queries are `event.data.hello == "world"` and `output.success != true`. [Learn more about how expressions are used in Inngest.](https://www.inngest.com/docs/guides/writing-expressions)

You can combine multiple search queries using the `&&` operator or `||` operator. Adding a new line is the equivalent of using the `&&` operator.

### [Searching for errors](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs\#searching-for-errors)

Errors are serialized as JSON on the `output` object. When supported by the language SDK, errors are deserialized into a structured object. Here is an example of a error in TypeScript:

Example TypeScript code

CopyCopied

```typescript
throw new NonRetriableError("Failed to import data");
```

Example TypeScript error

CopyCopied

```json
{
  "name": "NonRetriableError",
  "message": "Failed to import data",
  "stack": "NonRetriableError: Failed to import data\n    at V1InngestExecution.userFnToRun (/opt/render/project/src/build/inngest/ai.js:143:15) ..."
}
```

This error can be searched using the following CEL expression:

CopyCopied

```
output.name == "NonRetriableError" && output.message == "Failed to import data"
```

Using custom error types in TypeScript can make it easier to search by the type of error:

Example TypeScript code

CopyCopied

```typescript
import { NonRetriableError } from "inngest";

class UserNotFoundError extends NonRetriableError {
  constructor(message: string) {
    super(message);
    this.name = "UserNotFoundError";
  }
}
inngest.createFunction(
  { id: "my-fn", triggers: { event: "user" } },
  async ({ step, event }) => {
    await step.run("get-user", async () => {
      const user = await getUser(event.data.userId);
      if (!user) {
        throw new UserNotFoundError(`User not found (${event.data.userId})`);
      }
      // ...
    });
  }
);
```

Example search query

CopyCopied

```
event.data.userId == "12345" && output.name == "UserNotFoundError"
```

## [The Function run details](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs\#the-function-run-details)

A _Handle failed payments_ function failed after retrying 5 times:

![The "Handle failed payments" Function runs list features a run in a failing state.](https://www.inngest.com/_next/image?url=%2Fassets%2Fdocs%2Fplatform%2Fmonitor%2Finspecting-function-runs%2Fhandle-failed-payments-function-run-failed.png&w=3840&q=75)

Clicking on the failed Function Runs expands the run detail view:

![The Function run details view displays the event payload on the left, some technical attributes (function version, timings) on the right and a timeline of steps on the bottom left.](https://www.inngest.com/_next/image?url=%2Fassets%2Fdocs%2Fplatform%2Fmonitor%2Finspecting-function-runs%2Ffunction-run-logs.png&w=3840&q=75)

The Function run details panel is divided in 3 parts:

- On the top right: the **Trigger details** helpful when exchanging with Support
- On the right: the **Event payload** that triggered the Function run
- On the bottom right: the **Run details** with its timeline, a clear with of the Function's steps execution

The Function run details informs us that our Function run failed because of an `Error: Failed to downgrade user` error.

This is a first clue, let's have a closer look at the Timeline to identify the root cause:

We can now spot that the `downgrade-account-billing-plan` failed.

Let's expand this step to look at the retries and errors.

![The Timelime of steps features two steps: a first one to fetch the subscription from Stripe and second one to update it. The second is marked as failed.](https://www.inngest.com/_next/image?url=%2Fassets%2Fdocs%2Fplatform%2Fmonitor%2Finspecting-function-runs%2Ffunction-run-logs-timeline-1.png&w=3840&q=75)

![Expanding the second step lists all the attempted retries along with their respective error.](https://www.inngest.com/_next/image?url=%2Fassets%2Fdocs%2Fplatform%2Fmonitor%2Finspecting-function-runs%2Ffunction-run-logs-timeline-2.png&w=3840&q=75)

Expanding a step provides the same level of details (the error message and timings) along with retries information.

It seems that our `downgrade-account-billing-plan` step raised the same error during the following 5 retries, we might have to perform a fix in the database.

💡 **Tips**

Clicking on the

icon next to "Run details" open it in a new tab with a full-page layout.

![Clicking on the icon next to "Run details" open it in a new tab with a full-page layout](https://www.inngest.com/_next/image?url=%2Fassets%2Fdocs%2Fplatform%2Fmonitor%2Finspecting-function-runs%2Ffunction-runs-details-open-new-tab.png&w=3840&q=75)

It is useful for Function having a lot of steps or retries!

## [Performing actions from the Function run details](https://www.inngest.com/docs/platform/monitor/inspecting-function-runs\#performing-actions-from-the-function-run-details)

The Function run details provides two main actions: replay the Function Run or sending the trigger event to your local Inngest Dev Server.

Sending the trigger Event to your local Inngest Dev Server provides a quick way to reproduce issues that are not linked to external factors (ex: new function version recently deployed, data issues).

After looking at the Function run details, the failure is judged temporary or fixed by a recent deployment, you can replay the Function run by using the "Rerun" button at the top right of the screen.

![The rerun button is accessible in the header of the "run details" section of the Function run detail](https://www.inngest.com/_next/image?url=%2Fassets%2Fdocs%2Fplatform%2Fmonitor%2Finspecting-function-runs%2Ffunction-runs-details-open-new-tab.png&w=3840&q=75)

Was this page helpful?

Yes

No

[Edit this page on GitHub](https://github.com/inngest/website/tree/main/pages/docs/platform/monitor/inspecting-function-runs.mdx)

[Previous](https://www.inngest.com/docs/platform/api-keys) [API keys](https://www.inngest.com/docs/platform/api-keys)

[Next](https://www.inngest.com/docs/platform/monitor/traces) [Traces](https://www.inngest.com/docs/platform/monitor/traces)

© 2026 Inngest Inc. All rights reserved.

[We're hiring!](https://www.inngest.com/careers)

[Star our open source repository](https://github.com/inngest/inngest) [Join our Discord community](https://www.inngest.com/discord?ref=social-badge) [Follow us on X](https://twitter.com/inngest) [Follow us on Bluesky](https://bsky.app/profile/inngest.com)