---
id: dd681af26
topic: durable-execution
title: "Durable execution: the persist-and-resume model and its delivery shapes"
status: draft
shape: survey
---

# Durable execution: the persist-and-resume model and its delivery shapes

**Scope.** What durable-execution engines share and how their delivery shapes differ, from
the catalog's sources. Drawn from Temporal, DBOS, Restate, and Inngest; the corpus also
holds Cadence, Conductor, Trigger.dev, Resonate, and Vercel Workflow (not yet synthesized).

## Key claims (cited)

- Temporal is a scalable, reliable runtime for **durable function executions** (Workflow
  Executions); it guarantees Durable Execution so you "develop as if failures don't even
  exist," running reliably through network outages or server crashes that would be
  catastrophic for a typical application [ca15813ee]. A Workflow defines a sequence of steps
  **as code** — the Workflow Definition — and running that code is a Workflow Execution
  [cdda82b92].
- Temporal's reliability rests on a **declarative Retry Policy**: by default it automatically
  retries a failed Activity (so transient failures need no action), and you specify desired
  behavior rather than implement retry logic yourself [cb475b04f].
- DBOS takes the **library** shape: a library for building reliable programs where you add a
  few annotations to **durably execute** application code and make it resilient to any
  failure, across Python/TypeScript/Go/Java [c5ec3f59d].
- Restate is a lightweight runtime turning services and workflows into durable processes:
  code automatically stores completed steps and **resumes from where it left off** on
  recovery, with built-in state and reliable communication offering **exactly-once**
  semantics [c44c8dc25].
- Inngest is an **event-driven durable execution platform** that runs code without managing
  queues, infra, or state — functions in TypeScript/Python/Go with **steps built in**, while
  it handles queueing, scaling, concurrency, throttling, rate limiting, and observability
  [c53dcb818].

## Convergent vs contested

- **Convergent:** Every engine implements the same guarantee — persist each completed step,
  then resume from the last completed step after a crash, so the developer writes ordinary
  code and the runtime handles failure recovery — with retries as a built-in policy.
- **Contested / differentiating:** The **delivery shape** splits the field: a self-hosted
  runtime/cluster executing code-as-workflow (Temporal), a library of annotations embedded in
  your app (DBOS), and a managed event-driven platform (Inngest). Restate adds explicit
  exactly-once communication. These trade operational ownership against integration depth.

## Implications for the system

- Durable execution is the strongest candidate for the **core model** — it subsumes
  retry/backoff, timeouts, and state recovery that queues bolt on. Pick the shape by
  ownership appetite: Temporal (run the cluster), DBOS (embed a library, Postgres-backed),
  Inngest (managed, event-driven).
- Whatever the shape, the contract is the same: steps are persisted and replayed, so model
  job logic as deterministic, resumable steps.

## Gaps found → re-scan
- Deterministic replay + event history + workflow versioning mechanics (Temporal) — the how, not just the what.
- Uncited engines: Cadence, Netflix Conductor, Trigger.dev, Resonate, Vercel Workflow.
- Relationship to managed durable services (AWS Step Functions, Azure Durable Functions) in the cloud topics.
- Per-engine delivery-guarantee class and the cost of the "exactly-once" claim (Restate).
