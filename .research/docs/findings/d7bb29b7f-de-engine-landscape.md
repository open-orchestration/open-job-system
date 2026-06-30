---
id: d7bb29b7f
topic: durable-execution
title: "Durable-execution engine landscape: Cadence, Conductor, Resonate, Trigger.dev, Vercel Workflow"
status: draft
shape: survey
---

# Durable-execution engine landscape: Cadence, Conductor, Resonate, Trigger.dev, Vercel Workflow

This survey maps five durable-execution / workflow engines using only each project's own overview-page self-description, so a reader can tell them apart on programming model (code-as-workflow vs JSON/DSL definitions), hosting model (self-hosted OSS vs managed), and language focus. Every claim is the cited project's own framing of itself.

## Cadence

Cadence describes itself as "a new developer friendly way to develop distributed applications" [c135ef9ee]. It "borrows the core terminology from the workflow-automation space," so its concepts include workflows and activities [c135ef9ee]. In its model, workflows can react to events and return internal state through queries [c135ef9ee]. For interacting with the engine, the overview notes that "the HTTP API reference describes how to use HTTP API to interact with Cadence server" [c135ef9ee].

## Conductor (OSS)

Conductor describes itself as "an open source workflow orchestration engine that orchestrates distributed workflows" [c0e3bb531]. Its stated model is that "you define workflows as code or as JSON, write workers in any language, and let Conductor handle state persistence, retries, timeouts, and flow control," with every step durably recorded so processes survive crashes, restarts, and network partitions without losing progress [c0e3bb531]. Conductor's workflow definitions are "JSON-native," so they can be versioned in source control, diffed across releases, generated programmatically, or created and modified by LLMs at runtime [c0e3bb531]. Its workers are "polyglot," with official SDKs for Java, Python, Go, JavaScript, C#, Clojure, Ruby, and Rust [c0e3bb531]. The project states Conductor "originated at Netflix to orchestrate millions of workflows per day across hundreds of microservices" [c0e3bb531].

## Resonate

Resonate describes itself as "agent-native durable execution" and as "the durable execution engine that agents build with, deploy on, and operate" [cc4b57008]. It defines itself as "the implementation of a distributed async/await programming model: a formal, language- and transport-agnostic protocol for writing functions that survive process restarts, run for hours or months, and coordinate across many machines" [cc4b57008]. Resonate frames itself around three pillars — agent-native (SDK, docs, and operational surface "designed for agent consumption, not just human developers"), generated and optimized, and "cost-efficient by design" [cc4b57008]. The project ties that cost framing to a "serverless-native architecture" where "you pay only for active execution" [cc4b57008].

## Trigger.dev

Trigger.dev describes itself as "an open source background jobs framework that lets you write reliable workflows in plain async code" [ca8f99140]. Its stated purpose is to run long-running AI tasks, handle complex background jobs, and build AI agents with built-in queuing, automatic retries, and real-time monitoring [ca8f99140]. It provides "a CLI and SDK for writing tasks in your existing codebase," support for both regular and scheduled tasks, dashboard observability, and a Realtime API with React hooks [ca8f99140]. On hosting, the project states you can use Trigger.dev Cloud or self-host on your own infrastructure [ca8f99140].

## Vercel Workflow

Vercel Workflows describes itself as "a fully managed platform for building durable applications and AI agents in JavaScript, TypeScript, and Python" [cebbccd61]. It states it "builds on the open-source Workflow SDK for JavaScript and TypeScript, and on workflow support in the `vercel` Python SDK to let your code pause, resume, and maintain state" [cebbccd61]. Its programming model is to "write async JavaScript, TypeScript, or Python with familiar language primitives," with "no YAML or state machines," using `'use workflow'` and `'use step'` directives to write durable functions [cebbccd61]. The project states that with Workflows, Vercel manages the infrastructure — Vercel Functions execute workflow and step code, Vercel Queues enqueue and execute those routes, and managed persistence stores all state and event logs [cebbccd61].

## Cross-cutting contrasts (each engine's own terms)

- **Programming model.** Conductor is the one engine here that centers JSON-native definitions, explicitly contrasting "as code or as JSON" definitions [c0e3bb531]; Resonate centers a "distributed async/await programming model" [cc4b57008]; Trigger.dev centers "workflows in plain async code" [ca8f99140]; and Vercel Workflow centers async functions with `'use workflow'`/`'use step'` directives and "no YAML or state machines" [cebbccd61].
- **Hosting model.** Conductor and Trigger.dev present as open source [c0e3bb531][ca8f99140], Trigger.dev additionally offering Cloud-or-self-host [ca8f99140]; Vercel Workflow presents as "a fully managed platform" built on an open-source SDK [cebbccd61]; Resonate frames a "serverless-native architecture" [cc4b57008].
- **Language focus.** Conductor is polyglot across 8 worker SDK languages [c0e3bb531]; Vercel Workflow targets "JavaScript, TypeScript, and Python" [cebbccd61]; Trigger.dev frames itself language-agnostically, around writing tasks in "plain async code" in "your existing codebase" rather than naming specific languages [ca8f99140].
- **Agent framing.** Resonate ("agent-native") [cc4b57008], Conductor ("AI agent orchestration") [c0e3bb531], Trigger.dev ("build AI agents") [ca8f99140], and Vercel Workflow ("durable applications and AI agents") [cebbccd61] all foreground AI-agent use; Cadence's overview frames itself around distributed applications without agent terminology [c135ef9ee].
