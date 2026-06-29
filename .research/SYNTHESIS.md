# Synthesis — Job & Queue System Selection (grounded)

What the **verified evidence** supports about choosing and operating job/queue systems.
Every claim here links to a *promoted* finding — one that passed citation, faithfulness,
and independent-reviewer gates. Claims the catalog gestures at but that no promoted
finding yet backs are quarantined under [Not yet grounded](#not-yet-grounded) rather
than stated as fact.

Grounding status: **1 promoted finding** (certainty: low), covering the `reliability`
dimension for BullMQ, Sidekiq, and Celery, from run `r9283649c` (a 200k smoke-test
budget that did not fully converge). The `throughput` and `operational complexity`
dimensions, and the Temporal and River entities, are not yet grounded.

## What the evidence supports

### Reliability is a configuration exercise, not a default — and the broker sets the floor
The backing store bounds delivery guarantees: Celery on a Redis broker needs
`visibility_timeout` tuning to avoid duplicate or lost tasks, whereas RabbitMQ supplies
durable queues and acknowledgements out of the box; the same Redis-vs-ack contrast frames
BullMQ against RabbitMQ. Sidekiq's default client does no push error-handling (Pro adds a
bounded "reliable push" buffer), and Celery offers exponential-backoff retries plus
soft/hard task timeouts — but across all three, out-of-the-box behavior is not
production-grade
([Reliability and delivery guarantees across BullMQ, Sidekiq, and Celery](docs/findings/d8564cbd0-reliability-delivery-guarantees.md)).

## Not yet grounded

These were planned or asserted but have no promoted finding yet:

- **BullMQ quantitative reliability** (retry-recovery rate, Redis Cluster failover) — the only benchmark found was promotional and was excluded by the review gate.
- **Temporal** durable-execution guarantees — the fetched source was off-target; abstained.
- **River** (Postgres-backed) transactional enqueue reliability — not fetched.
- **`throughput`** dimension across all entities — planned, not sourced under the smoke budget.
- **`operational complexity`** dimension across all entities — planned, not sourced.
- **Per-engine delivery-guarantee class** (at-least-once vs exactly-once) — open question.

## How this was produced

This synthesis is the published view of the Open Research System run captured under
`.research/` (state, run log, corpus). Findings enter canon only after the three gates;
the rejected first draft of the reliability finding is retained under
`docs/findings/_drafts/` for the audit trail.
