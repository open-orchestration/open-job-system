---
id: da41bf2a7
topic: gap-fill
title: "Cross-cutting concerns: ports-and-adapters, idempotency, chaos, OTel conventions"
status: draft
shape: survey
---

# Cross-cutting concerns: ports-and-adapters, idempotency, chaos, OTel conventions

**Scope.** The gap-fill topic is the cross-cutting overflow — concerns that span every other
topic rather than belonging to one. From its sources, four threads tie the catalog together:
the target architecture, the delivery-contract reality, resilience testing, and
instrumentation standards. (The corpus also holds AWS security/encryption and Step Functions
detail pages, not synthesized here.)

## Key claims (cited)

- **Architecture north star — hexagonal / ports-and-adapters.** Allow an application to be
  **equally driven by users, programs, automated tests, or batch scripts, and to be developed
  and tested in isolation from its eventual run-time devices and databases** [c573f2c4a].
- **Delivery reality — at-least-once implies idempotency.** At-least-once delivery guarantees
  a broker delivers a message **even if errors occur**, with the side-effect that the
  **consumer can be invoked repeatedly for the same message** — so consumers must be
  idempotent [cee234102].
- **Resilience — chaos engineering.** Build more resilient systems by **deliberately
  introducing controlled disruptions** and simulating failures early in development
  [cfbd279fd].
- **Instrumentation standards — OpenTelemetry semantic conventions.** OTel **defines semantic
  conventions** for metrics (and traces/logs) across domains including messaging, so telemetry
  is named consistently [cbe579382].

## Convergent vs contested

- **Convergent:** These four close the loop on the whole catalog. **Ports-and-adapters** is
  the theoretical justification for the provider-adapter core (one model, swap
  AWS/Azure/Firebase/local — testable in isolation). **At-least-once + idempotency** is the
  delivery contract that recurred across every cloud scheduler and broker. **Chaos
  engineering** is how the system's reliability is *verified*, and **OTel semantic
  conventions** are how its telemetry stays portable — both extending the observability finding.
- **Contested / none new here:** this topic adds discipline, not controversy — it reinforces
  decisions the per-topic findings already reached.

## Implications for the system

- Adopt **hexagonal architecture** as the core's structure: define ports for queue/store/
  orchestrator/scheduler, with provider adapters behind them — exactly the catalog's stated
  "provider-adapter, one core" north star, now grounded in Cockburn.
- Make **idempotent consumers a non-negotiable default** (every managed primitive is
  at-least-once), **verify with chaos experiments**, and **instrument to OTel semantic
  conventions** so the system is portable, resilient, and observable by construction.

## Gaps found → re-scan
- Security/encryption (SSE, SNS data protection, authorization) and Step Functions action detail — in-corpus, not synthesized.
- Concrete idempotency-key implementation patterns (dedup store, transactional outbox).
- A chaos-experiment catalog for job systems (broker down, worker crash, clock skew).
