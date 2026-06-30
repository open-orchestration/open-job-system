---
id: dc0381db4
topic: throughput
title: "Celery and Sidekiq Throughput: Benchmark-Reported Figures"
status: draft
shape: survey
---

# Celery and Sidekiq Throughput: Benchmark-Reported Figures

Two third-party blogs report on Celery and Sidekiq throughput; their claims are surveyed separately below and never cross-attributed.

## Celery

A third-party blog (codelessgenie) describes `CELERYD_PREFETCH_MULTIPLIER` — renamed `worker_prefetch_multiplier` in Celery 4.0+ — as the setting controlling how many tasks a worker prefetches per unit of concurrency, with default 4 [caad21db4]. The blog states total prefetch per worker process is `worker_prefetch_multiplier * worker_concurrency`, e.g. concurrency 4 and multiplier 2 yields 8 prefetched tasks [caad21db4]. The blog describes the mechanism as preloading a batch of tasks into memory to reduce worker-broker round-trips, minimizing idle time and improving throughput [caad21db4]. Per the blog, a low multiplier (e.g. 1) makes workers fetch one task at a time and, for short tasks, can leave them waiting on the broker and raise latency, while a high multiplier (e.g. 10) reduces round-trips so short tasks start faster — but for long tasks a high multiplier risks head-of-line blocking [caad21db4]. The blog's tuning guidance is a multiplier of 5–10 for short/fast tasks, 1–2 (or 0, which disables prefetching) for long-running tasks, and per-queue multipliers for mixed workloads [caad21db4]. The blog also notes RabbitMQ enforces prefetch via `basic.qos` while Redis lacks native `basic.qos`, so very high multipliers are less safe on Redis [caad21db4]. The blog provides prefetch-tuning guidance only and reports no hard tasks-per-second throughput figures for Celery [caad21db4].

## Sidekiq

A third-party blog (Gradual Notes) reports Sidekiq throughput figures it attributes to Sidekiq's own `bin/sidekiqload` benchmark, which the blog describes as creating 500,000 no-op jobs and processing them as fast as possible assuming 1ms Redis network latency — an I/O-bound benchmark measuring coordination overhead rather than job execution time [ce0c329d8]. Under those stated conditions, all at 30 threads, the blog reports: Sidekiq 7.0 with YJIT at ~23,500 jobs/sec (its maximum observed throughput); Sidekiq 7.0 on Ruby 3.2 without YJIT at ~21,300 jobs/sec; ActiveJob 7.0 with YJIT at ~14,700 jobs/sec (which it calls 37% slower); and ActiveJob 7.0 on Ruby 3.2 at ~10,700 jobs/sec (which it calls 50% slower than the native API) [ce0c329d8]. The blog states the 30-thread concurrency was determined experimentally to maximize one CPU without saturation, and that most of the overhead is Redis network I/O rather than Ruby execution [ce0c329d8]. The blog further reports that at 1ms RTT a single thread can process ~500 jobs/sec (2ms per job), dropping to ~10 jobs/sec at 50ms RTT [ce0c329d8]. The blog attributes ActiveJob's ~50% overhead to argument deserialization from GlobalID, job-object instantiation, `before_perform`/`after_perform` callbacks, exception-handler wrapping, and result serialization [ce0c329d8].

## Provenance caveat

Both the Celery prefetch guidance and the Sidekiq `bin/sidekiqload` figures are third-party-blog-reported, not official vendor benchmarks and not independently verified here; the Sidekiq numbers carry the blog's stated benchmark conditions (500,000 no-op jobs, 30 threads, 1ms Redis latency) and the Celery source reports no tasks-per-second figures at all.

## Dropped sources

None — both sources anchored to body prose.
