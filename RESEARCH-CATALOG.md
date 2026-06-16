# Jobs System — Research Catalog

Goal: definitive, hardened, scalable, **generic** job orchestration + monitoring architecture. Re-usable across Local / AWS / Azure / Firebase and Java / Python / TypeScript.

This file = master list of things to research. **No deep-dives yet** — just identify, group, prioritize later.

Legend: ⭐ = likely high-signal / canonical reference.

---

## 1. Distributed Task Queue Libraries (worker + broker model)

| Item | Ecosystem | Notes |
|---|---|---|
| ⭐ Celery | Python | Canonical task queue. Broker-agnostic (Redis/RabbitMQ). Study its design + failure modes. |
| RQ (Redis Queue) | Python | Simpler Celery alternative. |
| Dramatiq | Python | Modern Celery competitor, better defaults. |
| Huey | Python | Lightweight. |
| arq | Python | asyncio-native. |
| ⭐ Sidekiq | Ruby | Battle-tested Redis job processing; reliability patterns worth stealing. |
| Resque | Ruby | Sidekiq predecessor. |
| ⭐ BullMQ | Node/TS | De-facto TS/Node queue on Redis. Flows, rate-limiting, repeatable jobs. |
| Bee-Queue | Node | Lightweight Redis. |
| Bull (v3) | Node | BullMQ predecessor. |
| Agenda | Node | MongoDB-backed. |
| pg-boss | Node/Postgres | Postgres-as-queue. |
| Graphile Worker | Node/Postgres | Postgres LISTEN/NOTIFY job runner. |
| ⭐ JobRunr | Java | Distributed background jobs, dashboard. |
| Spring Batch | Java | Enterprise batch processing framework. |
| Quartz Scheduler | Java | Classic scheduling library. |
| db-scheduler | Java | Postgres-backed scheduler. |
| Machinery | Go | Celery-like for Go. |
| Asynq | Go | Redis-backed, good docs. |
| River | Go/Postgres | Modern Postgres queue. |
| faktory | polyglot | Language-agnostic job server (Sidekiq author). |

## 2. Workflow Orchestration Engines (DAG / pipeline)

| Item | Notes |
|---|---|
| ⭐ Apache Airflow | Canonical DAG orchestrator. Scheduler/executor/worker split. |
| Prefect | Modern Pythonic, dynamic flows, hybrid cloud. |
| Dagster | Asset-oriented, strong typing + observability. |
| Luigi | Spotify, older but instructive. |
| Apache DolphinScheduler | Visual DAG, distributed. |
| Argo Workflows | K8s-native container DAGs. |
| Flyte | K8s-native, ML/data, typed. |
| Kubeflow Pipelines | ML workflows on K8s. |
| Metaflow | Netflix, data-science workflows. |
| Mage | Modern data pipeline tool. |
| Kestra | Declarative YAML orchestrator. |
| Windmill | Scripts→workflows, self-hostable. |
| n8n / Node-RED | Low-code workflow automation (integration angle). |

## 3. Durable Execution / Workflow-as-Code (long-running, crash-safe)

| Item | Notes |
|---|---|
| ⭐ Temporal | Gold standard durable execution. Event-sourced state, deterministic replay. Java/Go/TS/Python SDKs. **Study deeply.** |
| Cadence | Uber, Temporal predecessor. |
| ⭐ AWS Step Functions | Managed state machine / saga. ASL spec. |
| Azure Durable Functions | Durable orchestration on Functions. |
| ⭐ Vercel Workflow (WDK) | Durable workflows, step-based, retries — relevant to TS path. |
| Restate | Durable execution, lightweight. |
| Inngest | Event-driven durable steps, serverless-friendly. |
| Trigger.dev | TS-native background jobs + durable runs. |
| DBOS | Durable execution on Postgres. |
| Resonate / Golem | Newer durable-execution entrants. |
| Orkes Conductor | Netflix Conductor commercial; microservice orchestration. |
| Netflix Conductor (OSS) | Microservice workflow orchestration. |

## 4. Cloud Managed Job / Batch / Scheduler Services

### AWS
- ⭐ Step Functions — orchestration / state machine
- SQS — queue (+ FIFO, DLQ, visibility timeout patterns)
- SNS / EventBridge — pub/sub, event bus, scheduled rules
- EventBridge Scheduler — managed cron at scale
- AWS Batch — managed batch compute
- ECS/Fargate scheduled tasks
- Lambda (+ async invoke, destinations, DLQ)
- AWS Glue — ETL jobs
- MWAA — managed Airflow
- SWF — (legacy, Temporal/SF ancestor)

### Azure
- ⭐ Durable Functions
- Azure Logic Apps — workflow integration
- Service Bus — queues/topics, sessions, DLQ
- Storage Queues
- Azure Batch
- Container Apps Jobs — scheduled/event/manual jobs
- Data Factory — ETL/orchestration
- Event Grid — eventing

### GCP / Firebase
- ⭐ Cloud Tasks — HTTP task queue (the Firebase-adjacent answer)
- Cloud Scheduler — managed cron
- Pub/Sub — messaging
- Cloud Workflows — serverless orchestration
- Cloud Run Jobs — run-to-completion containers
- Firebase Cloud Functions (scheduled, task-queue, pub/sub triggers)
- Firebase Extensions
- Cloud Composer — managed Airflow
- Dataflow — stream/batch (Apache Beam)

## 5. Message Brokers / Streaming Backbones (the transport layer)

| Item | Notes |
|---|---|
| ⭐ RabbitMQ | AMQP, acks, DLX, quorum queues. |
| ⭐ Apache Kafka | Log-based streaming; exactly-once, consumer groups. |
| Redis (Streams, Pub/Sub, Lists) | Common queue substrate. |
| NATS / JetStream | Lightweight, durable streams. |
| Apache Pulsar | Multi-tenant, tiered storage. |
| ZeroMQ | Brokerless messaging primitives. |
| ActiveMQ / Artemis | JMS broker. |
| AMQP 1.0 / MQTT / STOMP | Protocols to know. |

## 6. Container / Batch Orchestration (compute substrate)

| Item | Notes |
|---|---|
| ⭐ Kubernetes Jobs & CronJobs | Native batch primitives. |
| KEDA | Event-driven autoscaling of workers. |
| Volcano / Kueue | K8s batch scheduling, queueing, fair-share. |
| Nomad (HashiCorp) | Batch + service scheduler. |
| Apache Mesos / Marathon | (legacy but instructive). |
| HTCondor / Slurm | HPC batch scheduling — mature queue theory. |
| Ray | Distributed Python compute + tasks/actors. |
| Dask | Parallel Python task graphs. |

## 7. Data Pipeline / ETL / Stream Processing

- Apache Beam (unified batch/stream model)
- Apache Spark (jobs, stages, DAG scheduler — study internals)
- Apache Flink (stateful stream processing, checkpointing)
- dbt (transformation DAGs)
- Apache NiFi (dataflow)
- Debezium / CDC patterns

## 8. CI/CD Job Systems (job graph + executor patterns to mine)

- GitHub Actions (jobs, matrix, reusable workflows, runners)
- GitLab CI (stages, DAG needs)
- Jenkins (pipelines, agents, queue)
- Argo CD / Tekton (K8s-native CI/CD, Tasks/Pipelines)
- Buildkite (agent model)
- CircleCI / Drone

## 9. Scheduling — Cron, Timers, Delayed/Recurring

- cron / anacron / systemd timers (fundamentals)
- Quartz cron semantics
- Distributed cron (one-shot leader election, dedupe)
- Delayed jobs / visibility timeout / leasing
- Time-wheel / hashed timer wheel algorithms

## 10. Core Patterns, Concepts & Algorithms (the design vocabulary)

- ⭐ Idempotency keys / exactly-once vs at-least-once vs at-most-once
- ⭐ Saga pattern (orchestration vs choreography)
- ⭐ Outbox / Inbox pattern (transactional messaging)
- Dead Letter Queue (DLQ) + poison-message handling
- Retry with exponential backoff + jitter
- Circuit breaker, bulkhead, rate limiting, backpressure
- Visibility timeout / lease / heartbeat / lock renewal
- Leader election (Raft, lease-based, Redlock debate)
- At-least-once delivery + dedup → effectively-once
- State machine modeling (job lifecycle: queued→running→...→done/failed/dead)
- Event sourcing + CQRS (durable execution foundation)
- Workflow determinism / replay
- Priority queues, fairness, weighted scheduling
- Fan-out/fan-in, scatter-gather, map-reduce
- Compensation / rollback semantics
- Two-phase commit vs eventual consistency
- Cancellation / timeout propagation
- Job dependencies / DAG topological execution
- Concurrency limits / throttling / token bucket

## 11. Observability & Monitoring for Jobs

- OpenTelemetry (traces/metrics/logs — distributed tracing across job hops)
- Prometheus + Grafana (queue depth, latency, throughput, failure rate)
- Structured logging + correlation IDs
- SLO/SLI for async work (queue latency, processing time, success rate)
- Dashboards: Flower (Celery), Bull Board, JobRunr dashboard, Temporal Web UI, Sidekiq web
- Alerting on queue backlog, DLQ growth, stuck/zombie jobs
- Audit trail / job history / replayability

## 12. Textbooks & Long-Form References

| Item | Why |
|---|---|
| ⭐ *Designing Data-Intensive Applications* — Kleppmann | The bible: delivery semantics, consensus, replication, stream processing. |
| ⭐ *Enterprise Integration Patterns* — Hohpe & Woolf | Canonical messaging/queue pattern catalog. |
| *Release It!* — Nygard | Stability patterns: circuit breaker, bulkhead, timeouts. |
| *Site Reliability Engineering* (Google) | Toil, SLOs, distributed system ops. |
| *Building Microservices* — Newman | Saga, service decomposition, async comms. |
| *Microservices Patterns* — Richardson | Saga/outbox/CQRS in depth (microservices.io). |
| *Distributed Systems* — van Steen & Tanenbaum | Theory foundation. |
| *Streaming Systems* — Akidau et al. | Beam model, watermarks, exactly-once. |
| *Patterns of Distributed Systems* — Joshi (Fowler/Martin signature) | Lease, HLC, write-ahead log, etc. |

## 13. Papers & Canonical Engineering Write-ups

- ⭐ Temporal / Cadence design docs & papers (event-sourced workflow)
- AWS builder library — "Avoiding insurmountable queue backlogs", "Timeouts/retries/backoff with jitter"
- Google "The Tail at Scale"
- Kafka exactly-once semantics design doc
- Raft paper (consensus for leader election / replicated state)
- Borg / Omega / Kubernetes papers (Google cluster scheduling)
- microservices.io pattern pages (saga, outbox, transactional messaging)
- "Idempotency" — Stripe engineering blog
- Uber Cadence / Cherami engineering blogs
- Netflix Conductor blog posts

## 14. Specs / Standards / Schemas (interop layer)

- CloudEvents (event envelope spec — strong candidate for generic job message format)
- AsyncAPI (describe async/event-driven APIs)
- OpenAPI (sync control-plane API)
- Amazon States Language (ASL — Step Functions DSL)
- BPMN / Workflow definition languages
- Serverless Workflow spec (CNCF, vendor-neutral workflow DSL) ⭐
- JSON Schema (job payload validation)

## 15. Local / Single-Machine / Dev Experience

- SQLite / Postgres as embedded queue (LISTEN/NOTIFY, SKIP LOCKED)
- File-based / embedded brokers for local parity
- Docker Compose dev stacks (Redis/Rabbit/Postgres locally)
- LocalStack (emulate AWS locally) / Azurite / Firebase Emulator Suite ⭐
- Testcontainers (integration testing brokers)
- In-memory adapter for unit tests

## 16. Language-Specific SDK / Idiom Considerations

- **Java**: Temporal Java SDK, Spring Batch/Integration, JobRunr, Quartz, virtual threads (Loom) for workers.
- **Python**: Temporal Python SDK, Celery/Dramatiq, asyncio worker model, Prefect/Dagster.
- **TypeScript/Node**: Temporal TS SDK, BullMQ, Inngest/Trigger.dev, Vercel Workflow, pg-boss.
- Cross-language contract: shared message schema (CloudEvents) + per-language thin client.

## 17. Architecture Reference Models to Study

- Control plane vs data plane separation
- Scheduler ↔ Queue ↔ Worker ↔ Store decomposition (Airflow/Celery/Temporal all variations)
- Pluggable broker / pluggable store abstraction (how Celery/JobRunr stay backend-agnostic)
- Provider-adapter pattern (one core, swap AWS/Azure/Firebase/local backends) — **this is our north star**
- Hexagonal / ports-and-adapters for the orchestration core

---

## Suggested Research Phases (later)

1. **Durable execution tier** — Temporal vs Step Functions vs Durable Functions vs Cloud Workflows (this likely defines the core model).
2. **Generic message contract** — CloudEvents + AsyncAPI as the portable interface.
3. **Provider adapters** — map one abstract model onto SQS/Service Bus/Cloud Tasks/Redis.
4. **Patterns deep-dive** — idempotency, saga, outbox, DLQ, retry/backoff (Kleppmann + EIP + AWS builder lib).
5. **Observability contract** — OpenTelemetry spans across job lifecycle.
6. **Reference impls** — read Celery, BullMQ, JobRunr, Temporal source for the abstractions that survived contact with production.
