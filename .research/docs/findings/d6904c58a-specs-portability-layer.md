---
id: d6904c58a
topic: specs
title: Vendor-neutral specs as the portability layer for a generic job system
status: draft
shape: survey
---

# Vendor-neutral specs as the portability layer for a generic job system

**Scope.** The interop/standards layer that lets a job system stay provider-agnostic, from
the catalog's spec sources. Covers CloudEvents, OpenAPI, and Serverless Workflow — the three
whose definitions are stated in their official spec text. AsyncAPI, JSON Schema, and Amazon
States Language / BPMN are in the catalog but not synthesized here (AsyncAPI's fetched page
carried no usable definition).

## Key claims (cited)

- **Event envelope — CloudEvents.** A **vendor-neutral specification for defining the format
  of event data**, giving events a common shape across systems [c8b3b5427].
- **Sync control plane — OpenAPI.** The OpenAPI Specification (OAS) **defines a standard,
  programming language-agnostic interface description for HTTP APIs**, letting humans and
  computers **discover and understand a service's capabilities** without access to source or
  docs [c7e1e1696].
- **Workflow DSL — Serverless Workflow.** A **vendor-neutral, open-source, community-driven**
  ecosystem for **defining and executing DSL-based workflows** [ce5e8348b].

## Convergent vs contested

- **Convergent:** Each spec standardizes one layer of the contract — the event payload
  (CloudEvents), the sync control API (OpenAPI), and the workflow definition (Serverless
  Workflow). CloudEvents and Serverless Workflow are **explicitly vendor-neutral**; OpenAPI is
  **language-agnostic** (its stated property). Together they form a portability substrate:
  define the interface in a neutral spec, bind it to any provider.
- **Contested / role boundaries:** Serverless Workflow's DSL overlaps with vendor workflow
  languages (e.g. Amazon States Language). The open question is which neutral spec becomes the
  system's canonical job-message format and workflow DSL.

## Implications for the system

- **CloudEvents is the strongest candidate for the generic job-message envelope** — a
  vendor-neutral event format is exactly what a provider-adapter needs so the same job message
  flows across SQS/Service Bus/Cloud Tasks/Redis.
- Pair it with **OpenAPI** for the sync control-plane API and **Serverless Workflow** for a
  neutral workflow DSL, so the abstract model — not a vendor — owns the contract.

## Gaps found → re-scan
- AsyncAPI (async/event-driven API description) — re-fetch a page with a usable definition.
- JSON Schema (payload validation) and Amazon States Language / BPMN (workflow DSLs) — not synthesized.
- CloudEvents bindings (HTTP, Kafka) and JSON format — in-corpus, not detailed.
- Whether Serverless Workflow DSL is mature enough to be the canonical workflow format vs vendor DSLs.
