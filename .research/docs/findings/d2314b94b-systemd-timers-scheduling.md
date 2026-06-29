---
id: d2314b94b
topic: scheduling
title: "systemd timers as a scheduling primitive: design lessons"
status: draft
shape: survey
---

# systemd timers as a scheduling primitive: design lessons

**Scope.** Scheduling design lessons from the one source in this topic's corpus — the
`systemd.timer` manual. Single-source by necessity; cron, Quartz, distributed cron, and
timer-wheel algorithms (named in the catalog) are not yet sourced.

## Key claims (cited)

- **Timer is decoupled from the work it triggers.** A `.timer` unit activates a separate
  matching unit when it elapses — `foo.timer` activates `foo.service` by default (overridable
  with `Unit=`) [c19760f77].
- **Two timer models.** Monotonic timers (`OnActiveSec=`, `OnBootSec=`, `OnStartupSec=`,
  `OnUnitActiveSec=`, `OnUnitInactiveSec=`) fire **relative to a starting point**, while
  `OnCalendar=` defines **realtime (wallclock) timers** with calendar event expressions
  [c19760f77].
- **Missed-run catch-up via persistence.** With `Persistent=` true, the last-trigger time is
  **stored on disk**, and when the timer is activated the unit is **triggered immediately** if
  it would have fired while the system was down [c19760f77].
- **Jitter to flatten load spikes.** `RandomizedDelaySec=` adds a random value to the next
  elapse time to **stretch timer events over a longer period and reduce workload spikes**
  [c19760f77].

## Convergent vs contested

- **Convergent (within this source):** A robust scheduler separates *when* (the timer) from
  *what* (the activated unit), supports both relative and wall-clock schedules, survives
  downtime by recording the last run, and spreads firings to avoid thundering-herd spikes.
- **Contested / unknown:** With only systemd in scope, cross-tool comparison is impossible —
  cron's syntax, Quartz's misfire policies, and **distributed** scheduling (leader election,
  dedup so a job fires once across N nodes) are entirely unsourced here.

## Implications for the system

- The four systemd mechanisms map directly to requirements for the job system's scheduler:
  **(1)** timer→job decoupling, **(2)** both monotonic and calendar schedules, **(3)** a
  durable last-fired record for **catch-up after downtime**, and **(4)** randomized delay to
  avoid synchronized stampedes.
- These are single-node semantics; the distributed-cron problem (exactly-one firing across a
  cluster) is the gap a generic scheduler must close on top of them.

## Gaps found → re-scan
- cron / anacron semantics and Quartz cron + misfire handling — not in corpus.
- Distributed cron: leader election / lease + dedup so a scheduled job fires once cluster-wide.
- Hashed/time-wheel timer algorithms for large numbers of delayed jobs.
