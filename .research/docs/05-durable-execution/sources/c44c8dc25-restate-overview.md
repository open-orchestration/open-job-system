> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](https://docs.restate.dev/llms.txt)
>
> Use this file to discover all available pages before exploring further.

[Skip to main content](https://docs.restate.dev/#content-area)

[Restate home page![light logo](https://mintcdn.com/restate-6d46e1dc/0MkLgffDAGHkNDIZ/logo/light.svg?fit=max&auto=format&n=0MkLgffDAGHkNDIZ&q=85&s=70e648c2608af2d2c33dc26b3bce13d3)![dark logo](https://mintcdn.com/restate-6d46e1dc/0MkLgffDAGHkNDIZ/logo/dark.svg?fit=max&auto=format&n=0MkLgffDAGHkNDIZ&q=85&s=5be48044922541993e0e472f203bca46)](https://restate.dev/)

Search...

Ctrl KAsk Assistant

Search...

Navigation

Welcome to Restate!

[Learn](https://docs.restate.dev/) [Docs](https://docs.restate.dev/docs) [Guides](https://docs.restate.dev/guides) [Roadmap](https://docs.restate.dev/roadmap/oss) [AI / Agents](https://docs.restate.dev/ai)

- [Overview](https://docs.restate.dev/)
- Quickstart

- [Examples](https://github.com/restatedev/examples)

### Use Cases

- [AI Agents](https://docs.restate.dev/use-cases/ai-agents)
- [Workflows](https://docs.restate.dev/use-cases/workflows)
- [Microservice Orchestration](https://docs.restate.dev/use-cases/microservice-orchestration)
- [Event Processing](https://docs.restate.dev/use-cases/event-processing)

### Foundations

- [Key Concepts](https://docs.restate.dev/foundations/key-concepts)
- [Services](https://docs.restate.dev/foundations/services)
- [Handlers](https://docs.restate.dev/foundations/handlers)
- [Actions](https://docs.restate.dev/foundations/actions)
- [Invocations](https://docs.restate.dev/foundations/invocations)

### Tour of Restate for...

- [AI Agents](https://docs.restate.dev/ai/patterns/durable-agents)
- [Workflows](https://docs.restate.dev/tour/workflows)
- [Microservice Orchestration](https://docs.restate.dev/tour/microservice-orchestration)

# Welcome to Restate!

OpenAIOpen in ChatGPT

Build innately resilient backends and AI agents

OpenAIOpen in ChatGPT

Restate is a lightweight runtime to turn AI agents, workflows, and backend services into durable processes. Focus on your logic, not failure mechanics.
Write normal code and let Restate handles resilience and consistency automatically.

## [​](https://docs.restate.dev/\#key-capabilities)  Key capabilities

**Durable execution**: Code automatically stores completed steps and resumes from where it left off when recovering from failures.**Built-in state**: Maintain state beyond workflow executions and share it between functions with strong consistency guarantees.**Reliable communication**: Call services sync or async with guaranteed execution and exactly-once semantics.**Time-based coordination**: Sleep, schedule, and wait for external events with durable timers.**Workflows**: Coordinate long-running processes, human approvals, listen to webhooks and other signals.

## [​](https://docs.restate.dev/\#common-use-cases)  Common use cases

![ai_agents](https://docs.restate.dev/img/overview/ai_agents.svg)

[**AI agents** \\
\\
Manage stateful AI agents with reliable tool usage and long-running conversations.](https://docs.restate.dev/use-cases/ai-agents)

![workflows](https://docs.restate.dev/img/overview/workflows.svg)

[**Workflows** \\
\\
Build approval processes, multi-step operations, and business workflows that survive failures.](https://docs.restate.dev/use-cases/workflows)

![microservices](https://docs.restate.dev/img/overview/microservices.svg)

[**Microservice orchestration** \\
\\
Coordinate calls across multiple services with automatic retries and failure handling.](https://docs.restate.dev/use-cases/microservice-orchestration)

![event_processing](https://docs.restate.dev/img/overview/event_processing.png)

[**Event processing** \\
\\
Process events with exactly-once guarantees and automatic retry handling.](https://docs.restate.dev/use-cases/event-processing)

## [​](https://docs.restate.dev/\#first-time-here)  First time here?

[**Quickstart** \\
\\
Build your first Restate service in minutes.](https://docs.restate.dev/quickstart)

[**Concepts** \\
\\
Understand the core building blocks.](https://docs.restate.dev/foundations/key-concepts)

## Tour of Restate

Learn how to build common applications with Restate:[AI agents](https://docs.restate.dev/tour/vercel-ai-agents) •
[Workflows](https://docs.restate.dev/tour/workflows) •
[Microservice orchestration](https://docs.restate.dev/tour/microservice-orchestration)

[**Code with AI** \\
\\
Install the Restate plugin for Claude Code, Codex, or Cursor to build Restate apps with an expert agent.](https://docs.restate.dev/develop/ai-assistant)

## [​](https://docs.restate.dev/\#learning-resources)  Learning resources

[**Examples** \\
\\
A collection of examples that illustrate how to use Restate to solve common application challenges.](https://github.com/restatedev/examples)

[**AI Recipes** \\
\\
Learn how to build durable AI applications with Restate: agents, chatbots, multi-agent systems, …](https://docs.restate.dev/ai)

[**Guides** \\
\\
Learn how to do common tasks with Restate: patterns, integrations, deployment tutorials, …](https://docs.restate.dev/guides)

## [​](https://docs.restate.dev/\#reference)  Reference

## SDKs

Implement Restate applications in one of the available SDKs.

[TypeScript](https://docs.restate.dev/develop/ts/services) •
[Java](https://docs.restate.dev/develop/java/services) •
[Kotlin](https://docs.restate.dev/develop/java/services) •
[Python](https://docs.restate.dev/develop/python/services) •
[Go](https://docs.restate.dev/develop/go/services) •
[Rust](https://docs.rs/restate-sdk/latest/restate_sdk/)

## Service Lifecycle

Deploy and operate services on your preferred platform.[Deploy](https://docs.restate.dev/deploy/services/kubernetes) •
[Invoke](https://docs.restate.dev/services/invocation/http) •
[Versioning](https://docs.restate.dev/services/versioning) •
[Monitor & Inspect](https://docs.restate.dev/services/introspection)

[**Host Restate** \\
\\
Get started immediately with Restate Cloud, or host your own Restate server.](https://docs.restate.dev/cloud/getting-started)

## [​](https://docs.restate.dev/\#community)  Community

## Need help?

Join the Restate Discord or Slack communities.

[**Stay up to date**](https://lu.ma/restatedev)

[Follow us on Twitter, LinkedIn, Bluesky.](https://lu.ma/restatedev)

[**YouTube Channel**](https://www.youtube.com/@restatedev)

[Restate 1.6: more control, more clouds, less tuning - Community Meeting February 2026 - YouTube\\
\\
Tap to unmute](https://www.youtube.com/@restatedev)

[Restate 1.6: more control, more clouds, less tuning - Community Meeting February 2026](https://www.youtube.com/watch?v=rXhpJRWmujw) [Restate](https://www.youtube.com/channel/UCF1bh60hUZkQlLOjMU0cOAA)

Restate454 subscribers

[Watch on](https://www.youtube.com/watch?v=rXhpJRWmujw)

Watch intro videos, community meetings and talks about Restate.

[**Events** \\
\\
Luma\\
\\
Subscribe and attend our events.](https://lu.ma/restatedev)

Was this page helpful?

YesNo

[Restate](https://docs.restate.dev/quickstart)

Ctrl+I

[website](https://restate.dev/) [github](https://github.com/restatedev/restate) [discord](https://discord.restate.dev/) [slack](https://slack.restate.dev/) [youtube](https://www.youtube.com/@restatedev) [linkedin](https://linkedin.com/company/restatedev) [x](https://x.com/restatedev) [bluesky](https://bsky.app/profile/restate.dev)

[Powered byThis documentation is built and hosted on Mintlify, a developer documentation platform](https://www.mintlify.com/?utm_campaign=poweredBy&utm_medium=referral&utm_source=restate-6d46e1dc)

Assistant

Responses are generated using AI and may contain mistakes.

![](https://scarf.restate.dev/a.png?x-pxid=792a64ae-afe4-487d-9eb6-5dacca7dd248)