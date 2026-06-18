# Design — Dedicated Decision Log & Decision Process

**Date:** 2026-06-17
**Status:** Approved (design)
**Topic:** Relocate Architecture Decision Records into a dedicated `docs/DECISIONS.md`, upgrade each record to Full MADR format, and define a repeatable decision process.

---

## 1. Goal

Today the project's architectural decisions live as terse one-line entries in `docs/ARCHITECTURE.md` → *Appendix A — Architecture Decision Records* (ADR-001…011). Each entry is a `Why / Rejected / §ref` triple with no status, no date, and no superseding mechanism.

Two problems this creates:

- **No lifecycle.** Decisions cannot be marked Proposed/Accepted/Superseded; there is no honest way to evolve or reverse a decision while preserving its history.
- **No process.** There is no documented procedure for *when* a decision warrants a record, *how* it is written, or *how* it is superseded — so the next decision is made ad hoc.

This design fixes both: a dedicated, normative decision log plus an embedded "how we decide" procedure. Locking the decision process down is a prerequisite for making the build process repeatable.

## 2. Non-Goals

- No change to any architectural decision itself. This is a relocation + reformat + process definition. The substance of ADR-001…011 is preserved (and expanded, not altered).
- No broader "full build playbook" (research→spec→plan→implement methodology). Scope is decision-making only.
- No tooling/automation (no ADR-generator CLI). Manual authoring against a template.

## 3. Deliverables

1. **`docs/DECISIONS.md`** — new normative decision log (sole source of truth for decisions).
2. **`docs/ARCHITECTURE.md`** — Appendix A replaced with a one-line pointer to `DECISIONS.md`; inline `(ADR-NNN)` cross-reference tags throughout the body are retained.
3. This spec, committed by the user (per org policy AI does not commit).

## 4. `docs/DECISIONS.md` structure

```
# Jobs System — Decision Log
<header: purpose, normativity, links to GLOSSARY + ARCHITECTURE>

## How We Decide   (the process — see §6)
- When to write an ADR
- Status lifecycle
- Numbering & superseding
- Authoring loop

## Index
<table: ID | Title | Status | Date | Supersedes | Superseded-by>

## Records
## ADR-001: ...
## ADR-002: ...
...
## ADR-011: ...
```

The index table gives a one-screen scan; records are ascending by ID.

## 5. Record format (Full MADR 4.0)

Each record carries:

- `## ADR-NNN: <title>` — zero-padded, existing IDs preserved.
- `Status: <state> | Date: YYYY-MM-DD` — plus `Supersedes: ADR-XXX` / `Superseded by: ADR-YYY` lines when applicable.
- **Context and Problem Statement** — the forces that required a decision.
- **Decision Drivers** — the criteria that mattered (e.g. portability, auditability, crash-safety).
- **Considered Options** — numbered list of the real alternatives.
- **Decision Outcome** — the chosen option and the "because".
- **Pros and Cons of the Options** — per option.
- **Confirmation** — how a conforming implementation is verified to honor the decision (ties to `ARCHITECTURE.md` §13 Testing where applicable).
- **Refs** — back-links to `ARCHITECTURE.md` sections.

**Source mining:** Drivers / Pros-Cons / Confirmation are thin or absent in the current one-line ADRs. These fields are reconstructed from the rationale already present in the `ARCHITECTURE.md` body (e.g. §6.1, §6.3, §7.1, §14) and the existing Appendix A "Why/Rejected" text. No new architectural reasoning is invented; where the source is silent on Confirmation, the field states the observable invariant an adapter test would assert.

## 6. The decision process ("How We Decide")

Embedded at the top of `DECISIONS.md`:

**When to write an ADR.** Write one for any choice that is hard to reverse, changes a port or contract, or selects one pattern over a viable alternative. Do *not* write one for naming, formatting, or anything `GLOSSARY.md` already governs.

**Status lifecycle.**
`Proposed → Accepted → Superseded`, plus:
- `Rejected` — a proposal we evaluated and declined.
- `Deprecated` — an accepted decision aged out with no direct replacement.

**Numbering & superseding.**
- Monotonic `ADR-NNN`, zero-padded, never reused.
- Superseding a decision creates a *new* record with a new number; the two link both ways (`Supersedes` / `Superseded by`).
- Superseded records are never deleted — they are marked and kept for history.

**Authoring loop.**
research → draft a `Proposed` ADR → review → mark `Accepted` → update the matching inline `(ADR-NNN)` tag in `ARCHITECTURE.md`. One decision per record.

## 7. Source-doc reconciliation

- `ARCHITECTURE.md` *Appendix A* body is replaced with a single pointer line: decisions now live in `docs/DECISIONS.md`. The Appendix heading and its Table-of-Contents entry remain so existing links do not dangle.
- Inline `(ADR-NNN)` tags in the `ARCHITECTURE.md` body are retained verbatim — they are cross-references and now resolve to `DECISIONS.md`.
- `DECISIONS.md` becomes the single source of truth for decisions; on any conflict with `ARCHITECTURE.md` prose, the decision log wins (mirroring how `GLOSSARY.md` wins on terminology).

## 8. Initial data

All eleven existing records (ADR-001…011) are migrated as `Status: Accepted | Date: 2026-06-16` (the date `ARCHITECTURE.md` and its Appendix A were authored, per the project work log). No record is initially Proposed, Rejected, Superseded, or Deprecated.

## 9. Verification

- Every `(ADR-NNN)` tag referenced in `ARCHITECTURE.md` resolves to a record in `DECISIONS.md` (no dangling refs).
- All 11 records present, ascending, each with the full MADR field set populated (no empty fields, no "TBD").
- The decision substance of each record matches the original Appendix A "Why/Rejected" (no altered decisions).
- Index table row count == record count == 11.
- `ARCHITECTURE.md` Appendix A contains only the pointer; no duplicated decision content remains.

## 10. Out-of-scope follow-ups (not in this change)

- A broader build-process playbook.
- Any ADR-authoring automation.
