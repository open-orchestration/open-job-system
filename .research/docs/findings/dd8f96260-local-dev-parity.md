---
id: dd8f96260
topic: local-dev
title: Local parity via cloud emulators and Testcontainers
status: draft
shape: survey
---

# Local parity via cloud emulators and Testcontainers

**Scope.** How to run/test a job system locally without the cloud, from the catalog's
local-dev sources. Covers Testcontainers and the three cloud-service emulators (LocalStack,
Azurite, Firebase Local Emulator Suite).

## Key claims (cited)

- **Testcontainers (real services in Docker).** A **library providing easy, lightweight APIs
  for bootstrapping local development and test dependencies with real services wrapped in
  Docker containers**, so tests depend on the **same services used in production without mocks
  or in-memory services** [cb229b574].
- **LocalStack (AWS).** Emulates the **AWS services** it supports **in your development
  environment**, enabling local cloud development [cdc1bee4c].
- **Azurite (Azure).** A **lightweight storage emulator** (written in JavaScript, runs on
  Node.js) that **simulates the Azure Storage service for local development**, supporting the
  **Blob, Queue, and Table** storage services [cc5e4e34b].
- **Firebase Local Emulator Suite.** A **set of tools to build and test apps locally** using
  Cloud Firestore, Realtime Database, Cloud Storage, Authentication, Hosting, Cloud Functions
  (beta), Pub/Sub (beta), and Firebase Extensions (beta) [ca0f3688c].

## Convergent vs contested

- **Convergent:** Local parity is achieved two ways — **emulate the cloud's managed services**
  (LocalStack/Azurite/Firebase) or **run the real service in a container** (Testcontainers).
  Both let the job system run and be tested offline against the same interfaces it uses in
  production.
- **Contested / coverage:** Emulators are **per-provider and partial** (Azurite covers
  Storage's Blob/Queue/Table only; LocalStack/Firebase cover their own service sets), whereas
  Testcontainers runs the *actual* OSS service (Redis/RabbitMQ/Postgres) but not proprietary
  managed cloud services. Fidelity vs breadth is the tradeoff.

## Implications for the system

- The provider-adapter is **testable end-to-end locally**: bind to LocalStack/Azurite/Firebase
  for the managed-cloud adapters and to Testcontainers (real Redis/RabbitMQ/Postgres) for the
  OSS-broker adapters — closing the "Local" target in the project's cross-environment goal.
- Prefer **Testcontainers for the OSS substrate** (production-identical) and **emulators for
  managed-cloud bindings**, accepting that emulator fidelity is partial.

## Gaps found → re-scan
- Postgres/SQLite as embedded queue (LISTEN/NOTIFY, SKIP LOCKED) and Docker Compose dev stacks — named in catalog, not in this corpus slice.
- Emulator fidelity gaps vs real cloud (behavioral differences that pass locally but fail in prod).
- In-memory adapters for unit tests vs container-based integration tests.
