# open-job-system

Definitive source-of-truth for a **generic, hardened, scalable job orchestration +
monitoring architecture** — reusable across Local / AWS / Azure / Firebase and
Java / Python / TypeScript.

## Layout
- `docs/` — **official guides and documentation** (authored): `ARCHITECTURE.md`,
  `DATA-STRATEGY.md`, `DECISIONS.md`, `GLOSSARY.md`, `PROCESS-GAP-AUDIT.md`,
  `PROVIDER-REFERENCE.md`, the `adr/` decision log, `diagrams/`, and design specs under
  `superpowers/specs/`.
- `.research/` — **new research** produced by the Open Research System plugin: run state,
  run log, corpus, cited findings (`docs/findings/`), and `SYNTHESIS.md`. All new research
  lives here.
- `.research-old/` — **legacy research corpus** from the prior scraped-catalog setup
  (`RESEARCH-CATALOG.md`, the 17 `NN-*` topic dirs, `patterns/`, scrape manifests/logs,
  and the old `graphify-out/` graph). Source material to re-research through ORS until the
  new corpus reaches parity; not extended further.

## Research workflow
All research runs through the `open-research-system` plugin, from the repo root:

    /ors:research "Compare BullMQ, Sidekiq, Celery, Temporal, and River on reliability, throughput, and operational complexity."

The run bootstraps a plan, gathers + ingests sources (drawing on `.research-old/` until
parity), drafts findings, and gates each through citation resolution, an atomic
faithfulness self-check, and an independent reviewer that assigns a GRADE certainty. Only
promoted findings are linked from `.research/SYNTHESIS.md`. Generate the narrative report
with `/ors:report`.

Findings graduate into `docs/` only when an authored, official guide is written from the
promoted research.
