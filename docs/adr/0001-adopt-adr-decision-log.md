---
status: accepted
date: 2026-06-29
---

# 0001 — Adopt a split ADR decision log under docs/adr/

## Context and Problem Statement

Architectural decisions for this project lived in a single `docs/DECISIONS.md` MADR 4.0
log. Aligning the repository with the Open Research System canonical layout — which keeps
one decision plus its rationale per file under `docs/adr/`, numbered `NNNN-kebab-title.md`
— makes each decision independently linkable from findings and synthesis, and matches the
structure the research engine itself dogfoods.

## Decision

Maintain the decision log as a directory of MADR-lite records under `docs/adr/`, one file
per decision, numbered `NNNN-kebab-title.md`, with YAML frontmatter (`status`, `date`) over
Context and Problem Statement → Decision → Consequences. The existing `docs/DECISIONS.md`
log remains the consolidated source of the substantive ADR-NNN records until each is split
into its own file here; both are kept in agreement during the migration.

## Consequences

- Decisions become first-class, individually linkable artifacts from `SYNTHESIS.md` and findings.
- Each future decision costs one short record; reversal is recorded by setting
  `status: superseded by ADR-NNNN`, never by deleting history.
- During migration, `docs/DECISIONS.md` and this directory must not diverge; the single-file
  log is authoritative for any record not yet split out.
