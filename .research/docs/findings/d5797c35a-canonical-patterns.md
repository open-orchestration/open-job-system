---
id: d5797c35a
topic: education
title: The canonical patterns the catalog's tools instantiate
status: draft
shape: survey
---

# The canonical patterns the catalog's tools instantiate

**Scope.** The first-principles vocabulary behind the job-system tooling, from the catalog's
canonical sources (Enterprise Integration Patterns, Patterns of Distributed Systems, the
Raft paper, and the Google SRE book). These are the textbook primitives the rest of the
catalog implements.

## Key claims (cited)

- **Guaranteed Delivery (EIP).** Make messages **persistent so they are not lost even if the
  messaging system crashes** [c4d464333].
- **Competing Consumers (EIP).** Create **multiple competing consumers on a single channel**
  so they **process multiple messages concurrently** — the throughput/worker-pool pattern
  [c42eb4828].
- **Write-Ahead Log (Patterns of Distributed Systems).** Provide a durability guarantee by
  **persisting every state change as a command to an append-only log** (aka commit log)
  [ce9e256be].
- **Consensus / Raft (paper).** Raft is a **consensus algorithm for managing a replicated
  log** that lets a collection of machines **survive the failures of some of its members** —
  the basis for leader election and replicated state [c99d04f40].
- **Service Level Objective (SRE).** An SLO is a **target value or range for a service level
  measured by an SLI** (structure: `SLI ≤ target`) — how reliability is made measurable
  [cc3c2b729].

## Convergent vs contested

- **Convergent:** The catalog's concrete tools are **instantiations of these canonical
  patterns**, not novel inventions. Guaranteed Delivery → RabbitMQ persistent/quorum queues;
  Competing Consumers → every worker pool (Celery/Sidekiq/BullMQ); Write-Ahead Log → Kafka's
  log and durable-execution event history (Temporal); Raft → RabbitMQ quorum queues' replicated
  FIFO; SLO → the observability layer's reliability targets.
- **Contested / nothing here — this is the bedrock:** these are primary/canonical sources
  (peer-reviewed paper, standard pattern catalogs, the SRE book), so the patterns are settled;
  what varies is which tool implements which subset and how well.

## Implications for the system

- Design the job core in this vocabulary directly: **WAL/event-log for durable state**,
  **Raft/consensus for HA and leader election**, **Guaranteed Delivery for the persistence
  contract**, **Competing Consumers for worker scaling**, and **SLOs** to define what
  "reliable" means for async work.
- Choosing a tool then reduces to "which canonical patterns does it implement faithfully?" —
  a principled selection criterion grounded in these sources.

## Gaps found → re-scan
- Saga/outbox, idempotent receiver, lease, heartbeat, leader-follower — in-corpus (EIP + Patterns), not yet synthesized into the core vocabulary.
- The Borg paper (cluster scheduling) and Uber Cadence write-ups — not synthesized.
- Kleppmann (DDIA) delivery-semantics chapters — referenced in the catalog, not in this corpus slice.
