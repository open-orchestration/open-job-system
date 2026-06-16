# Jobs System — Provider Reference (Companion)

**Status:** Non-normative companion to `ARCHITECTURE.md`.
**Purpose:** Map the abstract, product-free architecture onto concrete commercial products, managed services, and open-source projects. Nothing here is a requirement; the architecture defines the contracts, this document records *which real tools satisfy them* and *how they map onto the ports*.

Read `ARCHITECTURE.md` first. Every reference below points back at a port (§3.2 there) or a section it concretizes. Product names appear **only** in this file, never in the core architecture.

**Terminology:** our-model terms follow `GLOSSARY.md` (gold standard). Where a product's own term differs (e.g. a vendor calls a `WorkflowRun` an "execution", or a `Step` a "task"), that product term is used only inside its own row/description, never as our canonical vocabulary.

---

## 1. Port → Product Adapter Mappings

One core (the ports), many backends. Each row is a port from `ARCHITECTURE.md` §3.2; each column is a concrete service that satisfies it. "Leak" flags where the mapping is imperfect and the adapter must compensate.

| Port | AWS | Azure | GCP / Firebase | Local | Leak notes |
|---|---|---|---|---|---|
| **Queue** | SQS (+FIFO, DLQ, visibility timeout) | Service Bus (queues/topics, sessions, DLQ) | Cloud Tasks (HTTP push) | Redis Streams / Postgres `SKIP LOCKED` | Cloud Tasks is *push*, not lease/pull — adapter inverts the model (handler is an endpoint, ack = HTTP 2xx). |
| **DurableEngine** | Step Functions (ASL) | Durable Functions | Cloud Workflows | Temporal (self-host) | ASL & Cloud Workflows are declarative DSLs; Durable Functions & Temporal are code. The port hides the split; saga compensation must be expressible in all four. |
| **Scheduler / Clock** | EventBridge Scheduler | Container Apps Jobs / Logic Apps timers | Cloud Scheduler | systemd timer / Quartz / in-proc time-wheel | Cron dialects differ; normalize to one canonical grammar in the core. |
| **Store** | DynamoDB / RDS | Cosmos DB / Azure SQL | Firestore / Cloud SQL | Postgres / SQLite | Document stores lack multi-row transactions → the outbox (§6.2) needs a single-document or conditional-write strategy. |
| **EventSink** | CloudWatch + X-Ray | Application Insights | Cloud Monitoring + Cloud Trace | OpenTelemetry Collector → Prometheus / Grafana / Jaeger | All speak OpenTelemetry; backends differ only in exporter config. |
| **Compute substrate** | Lambda / Fargate / Batch | Container Apps / Azure Batch | Cloud Run Jobs / Functions | Docker Compose / Kubernetes Jobs | Cold-start & max-runtime caps differ (§4 below); long workflows checkpoint, never hold a process. |

**Local parity is a first-class target**, not a stub: Postgres-as-queue, a self-hosted durable engine, and an OpenTelemetry collector give full-fidelity local development. Emulators (LocalStack / Azurite / Firebase Emulator Suite) cover backend-specific adapter testing and chaos (§5 below).

---

## 2. Positioning — this model vs the systems it learned from

Where the abstract model sits relative to existing systems. It is **not** a new engine; it is a portable abstraction *over* engines like these.

| System | What the model borrows | Where it differs |
|---|---|---|
| **Temporal / Cadence** | The durable-tier mental model: event-sourced history, deterministic replay, activities, saga, signals/timers. | Treated as one `DurableEngine` adapter, not the whole system; the lower queue tier and the neutral contract sit outside it. |
| **AWS Step Functions** | State-machine orchestration, managed saga, IAM-scoped security. | ASL is provider-specific; here it's one adapter behind the `DurableEngine` port, swappable for other engines. |
| **Azure Durable Functions** | Code-based orchestrator/activity/entity model; replay-safe logging. | Bound to one runtime; abstracted here behind the same port as declarative engines. |
| **GCP Cloud Workflows** | Declarative serverless orchestration. | YAML DSL is provider-specific; one adapter among several. |
| **Celery / Sidekiq / BullMQ** | The lower tier: broker + worker, leasing, retries, DLQ, concurrency, rate limits. | Single-language, single-broker; the contract here is language- and broker-neutral (CloudEvents wire format vs library-native payloads). |
| **Apache Airflow** | DAG scheduling, scheduler/executor/worker split, rich operator UI. | Centers batch DAGs on a schedule; this model centers durable per-job execution and treats DAGs as one workflow shape. |
| **Cloud Tasks / SQS / Service Bus** | At-least-once delivery, visibility timeout, DLQ, scheduling primitives. | Raw transports with no orchestration tier or portable contract; consumed here as `Queue` adapters. |

The defining bet: most teams pick **one** engine and inherit its lock-in. This architecture makes the *engine* a configuration choice by standing a thin, well-specified contract (ports + CloudEvents) in front of it.

---

## 3. Security — concrete mechanisms (maps to ARCHITECTURE §9)

| Architecture requirement (§9) | Concrete mechanism / product |
|---|---|
| Mutual auth, internal + external channels separable (§9.1) | Temporal self-hosted mTLS with separate `internode` and `frontend` TLS config; cloud equivalents use IAM-signed requests / managed identities. |
| Workflow-level authz / tenant boundary (§9.1) | Temporal namespaces + authorization plugins (ClaimMapper / Authorizer); Step Functions IAM policies. |
| Encryption in transit (§9.2) | TLS across SQS, Service Bus, Step Functions, Temporal `frontend`. |
| Encryption at rest (§9.2) | SQS SSE/KMS; Step Functions at-rest encryption; managed-key store encryption. |
| Payload-level / end-to-end (§9.2) | Temporal Data Converter + custom Payload Codec — encodes/encrypts payloads so the server only sees ciphertext. |
| Message-level data protection (§9.2) | SNS message data-protection policies. |
| Least privilege, no wildcards (§9.3) | Kubernetes RBAC (specific resources/verbs; wildcard grants auto-widen as resources are added); AWS IAM scoped per queue/topic/state-machine ARN. |
| Claim-check for large/sensitive payloads (§9.2) | Out-of-band object store + reference in the message (Enterprise Integration Patterns claim-check). |

---

## 4. Capacity & Scaling — concrete mechanisms (maps to ARCHITECTURE §10)

| Architecture requirement (§10) | Concrete mechanism / product |
|---|---|
| Autoscale workers on queue depth, scale to zero (§10.1) | KEDA `ScaledObject` scales a deployment from queue length and scales to zero between bursts; `autoscaling.keda.sh/paused` + `paused-replicas` annotations pause scaling for maintenance. |
| Serverless concurrency on the same signal (§10.1) | Lambda Application Auto Scaling target-tracking on provisioned concurrency. |
| Cold-start mitigation (§10.4) | Lambda provisioned concurrency runs init at allocation time (not per-invocation); a warm floor for latency-critical paths. |
| Sustained-burst reaction lag (§10.4) | Lambda Application Auto Scaling requires the burst load sustained **at least 3 minutes** before provisioning more environments — concrete instance of the "react only after sustained load" caveat. |
| Hard max-runtime cap (§10.4) | Lambda function timeout (and equivalent caps on other serverless runtimes); long work must checkpoint via the durable tier rather than hold a process. |
| Insurmountable-backlog risk (§10.2) | AWS Builder Library, "Avoiding insurmountable queue backlogs" — unbounded queues create backlogs the system cannot drain; mandates backpressure + DLQ + poison isolation. |

---

## 5. Testing & Verification — concrete tools (maps to ARCHITECTURE §13)

| Architecture requirement (§13) | Concrete tool / mechanism |
|---|---|
| Replay tests for non-determinism (§13.2) | Temporal `WorkflowReplayer` against downloaded event histories in CI. |
| Time-skipping test harness (§13.2) | Temporal time-skipping test server — fast-forwards timers/sleeps (except during activity execution) so multi-day workflows test in milliseconds. |
| Chaos / fault injection (§13.3) | LocalStack AWS Fault Injection Service (errors/latency) + Chaos API (failover/resilience); kill-worker / drop-store / throttle-queue experiments. |
| Local-parity integration (§13.4) | Full local stack (Postgres + self-hosted durable engine + OpenTelemetry collector); LocalStack / Azurite / Firebase Emulator Suite for backend-specific behavior. |

---

## 6. Observability — concrete backends & dashboards (maps to ARCHITECTURE §11)

- **Tracing backends:** AWS X-Ray, Azure Application Insights, GCP Cloud Trace, Jaeger (all consume OpenTelemetry spans).
- **Metrics backends:** CloudWatch, Azure Monitor, GCP Cloud Monitoring, Prometheus + Grafana.
- **Operator dashboards realizing the 6-screen reference (§11.4):** Temporal Web UI, Apache Airflow UI, Flower (Celery), Bull Board (BullMQ), JobRunr dashboard, Sidekiq Web, Argo Workflows UI, Step Functions console, Durable Functions diagnostics. Studied in `docs/15-ui-monitoring/*`; synthesis in `docs/15-ui-monitoring/_SYNTHESIS.md`.

---

## 7. Reference Implementations to Study (validation backlog)

Before committing the abstractions in a buildable spec, read these engines' internals to confirm each port's contract survives production:

- **Lower tier:** Celery, Sidekiq, BullMQ, pg-boss, Graphile Worker, River, JobRunr.
- **Upper tier / durable:** Temporal, Cadence, Step Functions (ASL), Durable Functions, Cloud Workflows.
- **Schedulers:** Quartz, db-scheduler, EventBridge Scheduler, Cloud Scheduler.
- **Brokers:** RabbitMQ, Apache Kafka, NATS/JetStream, Apache Pulsar, Redis Streams.

---

## 8. Vendor Source Map

Product-specific evidence in the corpus (the neutral-standard sources stay in `ARCHITECTURE.md` Appendix C).

| Topic | `docs/` |
|---|---|
| Queue products | `docs/01-task-queues/{celery,sidekiq,bullmq,bee-queue,graphile-worker,...}`, `docs/07-brokers` |
| Workflow / DAG products | `docs/02-workflow-orchestration/{airflow,...}` |
| Durable engines | `docs/03-durable-execution/temporal`, `docs/05-cloud-azure/durable-functions`, `docs/06-cloud-gcp-firebase/workflows`, `docs/04-cloud-aws/step-functions` |
| AWS services | `docs/04-cloud-aws/{sqs,step-functions,eventbridge-scheduler,glue,...}` |
| Azure services | `docs/05-cloud-azure/{service-bus,durable-functions,...}` |
| GCP / Firebase services | `docs/06-cloud-gcp-firebase/{cloud-tasks,cloud-scheduler,workflows,...}` |
| Security (products) | `docs/17-gap-fill/{temporal-security,temporal-encryption,sqs-encryption,sns-data-protection,aws-iam,k8s-rbac}` |
| Scaling (products) | `docs/17-gap-fill/{keda-scaling,lambda-scaling}`, `docs/08-container-batch`, `docs/patterns/aws-builder-library` |
| Testing (products) | `docs/17-gap-fill/{temporal-testing,localstack-chaos}`, `docs/14-local-dev` |
| Dashboards | `docs/15-ui-monitoring/*` |

Knowledge graph: `.graphify/GRAPH_REPORT.md` · interactive: `graphify-out/graph.html`.
