[Resonate](https://www.resonatehq.io/) [Docs](https://docs.resonatehq.io/)

[Pricing](https://www.resonatehq.io/pricing) [Ask Echo](https://echo.resonatehq.io/) [Discord](https://www.resonatehq.io/discord) Jump to... `⌘K` [GitHub](https://github.com/resonatehq) [Get started](https://docs.resonatehq.io/get-started)

[Home](https://docs.resonatehq.io/)

[Evaluate](https://docs.resonatehq.io/evaluate)

[Get started](https://docs.resonatehq.io/get-started)

[Develop](https://docs.resonatehq.io/develop)

[Debug](https://docs.resonatehq.io/debug)

[Deploy](https://docs.resonatehq.io/deploy)

[Reference](https://docs.resonatehq.io/reference)

[Specification](https://docs.resonatehq.io/spec)

# Resonate documentation

Resonate — agent-native durable execution. Generated, optimized, cost-efficient by design.

![Resonate](https://docs.resonatehq.io/images/home-hero-dark.png)![Resonate](https://docs.resonatehq.io/images/home-hero-light.png)

**Resonate is the durable execution engine that agents build with, deploy on, and operate.** It is the implementation of a distributed async/await programming model: a formal, language- and transport-agnostic protocol for writing functions that survive process restarts, run for hours or months, and coordinate across many machines.

Resonate is built on three pillars:

- **Agent-native** — The SDK, docs, tool definitions, and operational surface are designed for agent consumption, not just human developers. CLIs over dashboards. Skill files over screenshots. Agents are the new developers, and Resonate is the platform they reach for.
- **Generated & optimized** — Open-source pluggable components plus stack-specific generated servers. AI constrained by formal specs and protocols — not slop, but highly optimized software. Exactly what your stack needs, nothing more.
- **Cost-efficient by design** — Serverless-native architecture means you pay only for active execution. Workloads that cost ~$80K/year on hosted alternatives can run for under $100/year on Resonate. Orders of magnitude, not percentages.

Build agents, workflows, pipelines, and services without thinking about retries or recovery — in a few lines of code.

agent.tsrecursive sub-agent loop·typescript

```
function* agent(context: Context, prompt: string) {
  const messages = [{ role: "user", content: prompt }];
  // The agent loop
  while (true) {
    const response = yield* context.run(think, messages);
    messages.push(response);

    if (response.subprompts) {
      // Spawn concurrent subagents
      const futures = [];
      for (const subprompt of response.subprompts) {
        futures.push(yield* context.beginRpc(agent, subprompt));
      }
      // Collect results
      for (const future of futures) {
        messages.push({ role: "tool", content: yield* future });
      }
    } else {
      return response.content;
    }
  }
}
```

[**Evaluate Resonate** \\
\\
Capabilities, comparisons, and the case for durable execution.](https://docs.resonatehq.io/evaluate) [**Get started** \\
\\
From scratch or migrating — start here.](https://docs.resonatehq.io/get-started) [**Examples** \\
\\
Runnable repos: durable sleep, human-in-the-loop, agents, and more.](https://docs.resonatehq.io/get-started/examples) [**Developer reference** \\
\\
APIs and features by SDK.](https://docs.resonatehq.io/develop) [**Operational guidance** \\
\\
Monitoring, scaling, and troubleshooting in production.](https://docs.resonatehq.io/deploy)

[Edit this page on GitHub](https://github.com/resonatehq/docs.resonatehq.io/edit/main/content/index.mdx)

[Evaluate Resonate](https://docs.resonatehq.io/evaluate)

resonate

Durable execution. Dead simple.

### Product

- [Documentation](https://docs.resonatehq.io/)
- [Get Started](https://docs.resonatehq.io/get-started)
- [Pricing](https://www.resonatehq.io/pricing)
- [Examples](https://docs.resonatehq.io/get-started/examples)

### Community

- [Discord](https://resonatehq.io/discord)
- [GitHub](https://github.com/resonatehq)
- [Journal](https://journal.resonatehq.io/)
- [RSVP](https://resonatehq.io/rsvp)
- [X / Twitter](https://x.com/resonatehqio)
- [LinkedIn](https://www.linkedin.com/company/resonatehqio)

### Company

- [Home](https://www.resonatehq.io/)
- [Privacy Policy](https://www.resonatehq.io/privacy-policy)
- [Terms](https://www.resonatehq.io/terms-and-conditions)

© 2026 ResonateHQ, Inc.

[GitHub](https://github.com/resonatehq)