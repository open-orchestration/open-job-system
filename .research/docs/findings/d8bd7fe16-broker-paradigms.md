---
id: d8bd7fe16
topic: brokers
title: "Message brokers: the queue vs log/stream paradigm split"
status: draft
shape: survey
---

# Message brokers: the queue vs log/stream paradigm split

**Scope.** The transport layer beneath a job system and its two paradigms, from the
catalog's broker sources. Drawn from RabbitMQ, Apache Kafka, NATS JetStream, and Apache
Pulsar; the corpus also holds Redis Streams and ActiveMQ/Artemis (not synthesized here).

## Key claims (cited)

- **RabbitMQ (queue paradigm).** The RabbitMQ **quorum queue** is a modern queue type
  implementing a **durable, replicated queue based on the Raft consensus algorithm**, and is
  the default choice when a replicated, highly available queue is needed [ca2a2c636].
- **Kafka (log paradigm).** Kafka is a **partitioned system** — topics are split into a
  pre-defined number of **partitions**, each partition **replicated** across servers, so no
  single server holds the complete data set [cd0d8b284].
- **NATS (ephemeral core + optional persistence).** NATS has a built-in persistence engine
  called **JetStream** that lets messages be **stored and replayed at a later time**, unlike
  *NATS Core*, which requires an active subscription to process messages as they happen
  [c736c9e2c].
- **Pulsar (unified messaging + streaming).** Apache Pulsar is an open-source, **distributed
  messaging and streaming platform built for the cloud** — a multi-tenant, high-performance
  solution for server-to-server messaging [c1ec5fac0].

## Convergent vs contested

- **Convergent:** Every broker decouples producers from consumers and offers durability +
  replication for high availability — the reliable transport substrate a job system rides on.
- **Contested / the core split:** Two paradigms. The **queue** model (RabbitMQ) holds
  messages that are consumed and acknowledged, with replicated durable queues. The
  **log/stream** model (Kafka's partitioned, replicated log; Pulsar's unified
  messaging+streaming; NATS JetStream's store-and-replay over an otherwise ephemeral core)
  **retains** messages so they can be replayed by position. Queue = consume-and-delete;
  log = retain-and-replay. The split is a spectrum, not a wall — JetStream and Pulsar each
  also offer queue-style consumption (work-queue retention; shared subscriptions) — so a
  broker's *configured* mode, not just its family, determines the semantics.

## Implications for the system

- Choose the broker by access pattern, not brand: **queue** brokers (RabbitMQ) for
  work-distribution where each message is processed once and dropped; **log** brokers
  (Kafka/Pulsar) when multiple consumers, replay, or event-sourcing matter.
- For a generic core, the broker is a **pluggable transport adapter** — but the queue-vs-log
  paradigm leaks into semantics (replay, ordering, retention), so the abstraction must expose
  which paradigm a binding provides.

## Gaps found → re-scan
- Delivery guarantees per broker (RabbitMQ acks/confirms, Kafka exactly-once, Pulsar) — in-corpus (confirms, dlx) not synthesized.
- Redis Streams and ActiveMQ/Artemis — not synthesized.
- Ordering, partitioning, and consumer-group mechanics (Kafka/Pulsar) vs RabbitMQ routing.
