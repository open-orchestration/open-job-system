---
id: d71fe93d4
topic: throughput
title: 'BullMQ throughput: maintainer-measured jobs/sec and the scope that bounds it'
status: draft
shape: single-entity
---

# BullMQ throughput: maintainer-measured jobs/sec and the scope that bounds it

**Scope.** This finding fills the BullMQ throughput cell that the comparison finding
[[d7c5d5a95]] left abstained. The only throughput source that survived filtering is a
benchmark published by BullMQ's own maintainer (Manuel Astudillo, `@manast`), so every
number here is a **maintainer/vendor measurement, not a neutral third-party one** — it
is reported as such, with its self-disclosed scope attached to each figure rather than
generalized into a headline "BullMQ does N jobs/sec."

## What was measured

The benchmark adds and processes jobs against a local Redis instance and reports
jobs/sec for five standard BullMQ operations [c6dd75a7d]. Its disclosed configuration is
50,000 jobs per test, worker concurrency 100, Redis running as a local Docker instance,
and results taken as the best of 5 runs [c6dd75a7d]. The host is the author's own
machine — a MacBook Pro with M2 Pro and 16 GB RAM running Node.js v24 — which the author
explicitly flags as "not an ideal benchmark environment" [c6dd75a7d].

The benchmark also isolates queue-management overhead rather than end-to-end work: it
notes that in real deployments a dedicated fleet of workers does the heavy processing,
so these figures measure "what overhead results from the queue management itself," not
how fast real jobs complete [c6dd75a7d].

## The numbers (Node.js v24, 50,000-job run)

On the Node.js runtime — the relevant baseline for BullMQ-on-Node — the maintainer's
best-of-5 figures are [c6dd75a7d]:

| Operation | Jobs/sec |
| --- | --- |
| Individual job addition (`Queue.add`, 1,000 parallel batches) | 54,113 |
| Bulk addition (`Queue.addBulk`) | 45,290 |
| Job processing (worker concurrency 100) | 30,102 |
| Processing with CPU work (recursive Fibonacci) | 11,116 |
| Flow producer (parent + 2 children) | 26,163 |

## Scale sensitivity is real, and the caveat is load-bearing

The same operations were re-run at 100,000 jobs, and one Node.js figure moved sharply:
individual job addition dropped from 54,113/sec to 36,765/sec at the larger scale, which
the author attributes (tentatively) to V8 garbage-collection pressure under ~100K
concurrent promises and job objects [c6dd75a7d]. Job *processing*, by contrast, was
essentially unchanged (30,102/sec → 34,176/sec) and the author notes processing is
fundamentally I/O-bound on Redis round-trips, so runtime differences wash out as the run
lengthens [c6dd75a7d]. The takeaway is that a single "jobs/sec" number is misleading for
BullMQ: addition throughput is sensitive to scale and runtime GC behaviour, while
processing throughput is gated by Redis I/O.

## How to read these figures

These are synthetic, single-machine numbers with Redis co-located on the same host over
Docker; the author cautions that a production environment with network latency to Redis
and dedicated workers "may play a bigger role" and explicitly frames the results as
illustrative rather than capacity-planning guidance [c6dd75a7d]. They establish an
**order-of-magnitude** for BullMQ queue overhead — tens of thousands of jobs/sec for
add/process on commodity hardware — but should not be quoted as a guaranteed production
ceiling. Consistent with [[d7c5d5a95]], the architecture matters more than the headline:
BullMQ's throughput ceiling is set by Redis (the in-memory job store and its round-trip
latency) and by the Node.js event loop, not by a fixed per-second rating.
