## [Gradual Notes](https://hype08.github.io/gradual-notes/)
Search
Search
Dark modeLight mode
Reader mode
### Recent Writing
  * ### [Revisited](https://hype08.github.io/gradual-notes/posts/Revisited)
Aug 03, 2025
  * ### [Space is Not Barrenness](https://hype08.github.io/gradual-notes/posts/Space-is-Not-Barrenness)
Aug 01, 2025
  * ### [Study the Canon](https://hype08.github.io/gradual-notes/posts/Study-the-Canon)
Jul 21, 2025


### Recent Notes
  * ### [Folding Context](https://hype08.github.io/gradual-notes/thoughts/Folding-Context)
Feb 28, 2026
  * ### [Mode Collapse](https://hype08.github.io/gradual-notes/thoughts/Mode-Collapse)
Feb 25, 2026
  * ### [Reentrant Code](https://hype08.github.io/gradual-notes/thoughts/Reentrant-Code)
Nov 18, 2025
  * ### [Zeigarnik Effect](https://hype08.github.io/gradual-notes/thoughts/Zeigarnik-Effect)
Oct 23, 2025


# Sidekiq Performance Analysis
Oct 15, 20255 min read
  * [implementation](https://hype08.github.io/gradual-notes/tags/implementation)
  * [system-design](https://hype08.github.io/gradual-notes/tags/system-design)


> Abstraction Tax at Scale 
> ActiveJob’s framework convenience costs exactly half your throughput—10,700 vs 21,300 jobs/sec—proving that architectural beauty and performance optimization often demand opposite trade-offs.
Sidekiq’s architecture delivers impressive performance through careful optimization of the hot path—the code executed for every single job. Understanding these performance characteristics helps make informed decisions about workload design and infrastructure sizing.
## Throughput Benchmarks[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#throughput-benchmarks)
Sidekiq’s `bin/sidekiqload` benchmark creates 500,000 no-op jobs and processes them as fast as possible, assuming 1ms Redis network latency. This is an I/O-bound benchmark measuring coordination overhead rather than job execution time.  
| Configuration  | Throughput  | Notes  |  
| --- | --- | --- |  
| Sidekiq 7.0 + YJIT + 30 threads  | 23,500 jobs/sec  | Maximum observed throughput  |  
| Sidekiq 7.0 + Ruby 3.2 + 30 threads  | 21,300 jobs/sec  | Without YJIT optimization  |  
| ActiveJob 7.0 + YJIT + 30 threads  | 14,700 jobs/sec  | 37% slower due to overhead  |  
| ActiveJob 7.0 + Ruby 3.2 + 30 threads  | 10,700 jobs/sec  | 50% slower than native API  |  
**Key insight** : Most of Sidekiq’s overhead is Redis network I/O, not Ruby execution. The 30-thread concurrency was determined experimentally to maximize one CPU without saturation. Real-world applications rarely need more than 10-15 threads due to GIL contention.
## ActiveJob Overhead[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#activejob-overhead)
ActiveJob adds ~50% overhead through argument deserialization and callback execution. For every job, ActiveJob:
  1. Deserializes arguments from GlobalID format
  2. Instantiates the job object
  3. Runs `before_perform` and `after_perform` callbacks
  4. Wraps execution in exception handlers
  5. Serializes results back to the queue


```
# Native Sidekiq: ~21,300 jobs/sec
class FastJob
  include Sidekiq::Job
  def perform(user_id)
    # Direct execution
  end
end
 
# ActiveJob: ~10,700 jobs/sec
class SlowJob < ApplicationJob
  def perform(user)
    # Extra deserialization and callbacks
  end
end
```

For high-throughput systems (>10,000 jobs/sec), using Sidekiq’s native API provides 2x better performance. For typical workloads (<1,000 jobs/sec), ActiveJob’s convenience outweighs its overhead.
## Memory Footprint[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#memory-footprint)
Sidekiq’s memory usage follows a predictable pattern:
  * **Base process** : 50-80MB (Ruby interpreter + Sidekiq code)
  * **Per job class** : 1-2MB (loaded code + dependencies)
  * **Per thread** : <1MB (thread stack + local variables)
  * **Redis connections** : Negligible (connection metadata only)


A typical process with 10 threads, 50 job classes, processes ~125MB RSS. Compare to process-based workers:
  * **Resque** : 75MB × 10 processes = 750MB for same concurrency
  * **Delayed::Job** : 100MB × 10 processes = 1GB for same concurrency


The 6-8x memory advantage compounds at scale. Running 100 concurrent jobs:
  * **Sidekiq** : 10 processes × 125MB = 1.25GB
  * **Resque** : 100 processes × 75MB = 7.5GB


## Latency Characteristics[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#latency-characteristics)
**Immediate jobs** (enqueued to default queue):
  * Enqueue latency: <1ms (single Redis LPUSH)
  * Fetch latency: <2ms (BRPOP blocks for 2sec max)
  * Total time-to-execution: <10ms in healthy systems


**Scheduled jobs** (enqueued for future execution):
  * Enqueue latency: <1ms (single Redis ZADD to sorted set)
  * Polling check: Every 5-15 seconds (scaled by cluster size)
  * Time precision: ±5-15 seconds depending on cluster


The Poller’s interval self-adjusts based on cluster size. With 30 Sidekiq processes, each polls every 450 seconds on average (30 × 15sec). This prevents thundering herd while ensuring timely execution.
## Network Latency Impact[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#network-latency-impact)
Redis network latency is the primary bottleneck. Sidekiq logs warnings if round-trip time exceeds 50ms:

```
WARN: Your Redis network RTT is 127ms. Move your Redis closer!

```

Each job requires minimum 2 Redis operations:
  1. **BRPOP** : Fetch job from queue (~1 RTT)
  2. **Job execution** : May require additional Redis ops
  3. **Cleanup** : Heartbeat updates, metrics (amortized across jobs)


At 1ms RTT, a single thread can process ~500 jobs/sec (2ms per job). At 50ms RTT, throughput drops to ~10 jobs/sec. Co-locating Sidekiq and Redis in the same datacenter/availability zone is critical.
## YJIT Performance Gains[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#yjit-performance-gains)
Ruby 3.1+ with YJIT enabled provides 10-20% throughput improvement:

```
RUBY_YJIT_ENABLE=1 bundle exec sidekiq
```

YJIT (Yet Another Just-In-Time compiler) optimizes hot code paths through type specialization. For Sidekiq’s job processing loop, this translates to fewer CPU cycles per job.
However, YJIT increases memory usage by 15-30MB per process. For memory-constrained environments or low-throughput systems, the trade-off may not be worth it.
## Concurrency Tuning[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#concurrency-tuning)
Optimal thread count depends on workload characteristics:  
| Workload Type  | Recommended Threads  | Reasoning  |  
| --- | --- | --- |  
| Pure I/O (HTTP APIs)  | 20-30  | GIL released during I/O  |  
| Mixed I/O and CPU  | 10-15  | Balance GIL contention  |  
| CPU-bound  | 5-10  | GIL contention dominates  |  
| Database-heavy  | 10-15  | Limited by DB conn pool  |  
Setting concurrency too high creates [GVL queuing](https://hype08.github.io/gradual-notes/thoughts/Thread-Contention-is-GVL-Queuing-in-Ruby)—threads spend time waiting to acquire the GIL rather than doing work. Monitor CPU usage: sustained 100% with high wait times indicates GIL saturation.
## Monitoring Critical Metrics[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#monitoring-critical-metrics)
**Queue latency** : Time between enqueue and execution start

```
# Check via Web UI or API
queue = Sidekiq::Queue.new("default")
queue.latency  # Seconds until oldest job executes
```

High latency indicates insufficient processing capacity. Scale horizontally (more processes) or optimize job execution time.
**Process busy threads** : Percentage of threads actively executing jobs

```
# Healthy: 60-80% busy during peak
# Low (<30%): Work starvation, increase queues/jobs
# High (>90%): Potential GIL saturation
```

**Redis round-trip time** : Network latency between Sidekiq and Redis

```
# Logged in heartbeat, accessible via Web UI
# Target: <5ms same AZ, <50ms different AZ
# Warning: >50ms significantly impacts throughput
```

## Optimization Strategies[](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#optimization-strategies)
  1. **Batch operations** : Use `push_bulk` for enqueueing multiple jobs (reduces Redis RTT)
  2. **Pipeline Redis commands** : Group multiple commands to save network round trips
  3. **Minimize middleware** : Each middleware adds function call overhead
  4. **Use native API for hot paths** : Skip ActiveJob overhead for high-throughput jobs
  5. **Keep jobs small** : Break large jobs into smaller chunks for better distribution
  6. **Optimize serialization** : Avoid large argument sizes, use references when possible


For systems pushing Sidekiq’s limits (>10,000 jobs/sec), profile the hot path and optimize accordingly. For typical systems, focus on horizontal scaling—add more processes rather than over-optimizing.
See [Sidekiq Architecture](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Architecture) for how these performance characteristics emerge from architectural decisions.
* * *
### Recent Writing
  * ### [Revisited](https://hype08.github.io/gradual-notes/posts/Revisited)
Aug 03, 2025
  * ### [Space is Not Barrenness](https://hype08.github.io/gradual-notes/posts/Space-is-Not-Barrenness)
Aug 01, 2025
  * ### [Study the Canon](https://hype08.github.io/gradual-notes/posts/Study-the-Canon)
Jul 21, 2025


### Recent Notes
  * ### [Folding Context](https://hype08.github.io/gradual-notes/thoughts/Folding-Context)
Feb 28, 2026
  * ### [The Creative Act](https://hype08.github.io/gradual-notes/books/The-Creative-Act)
Feb 25, 2026
  * ### [Mode Collapse](https://hype08.github.io/gradual-notes/thoughts/Mode-Collapse)
Feb 25, 2026
  * ### [Reentrant Code](https://hype08.github.io/gradual-notes/thoughts/Reentrant-Code)
Nov 18, 2025
  * ### [Zeigarnik Effect](https://hype08.github.io/gradual-notes/thoughts/Zeigarnik-Effect)
Oct 23, 2025


### Graph View
### Table of Contents
  * [Throughput Benchmarks](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#throughput-benchmarks)
  * [ActiveJob Overhead](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#activejob-overhead)
  * [Memory Footprint](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#memory-footprint)
  * [Latency Characteristics](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#latency-characteristics)
  * [Network Latency Impact](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#network-latency-impact)
  * [YJIT Performance Gains](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#yjit-performance-gains)
  * [Concurrency Tuning](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#concurrency-tuning)
  * [Monitoring Critical Metrics](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#monitoring-critical-metrics)
  * [Optimization Strategies](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Performance-Analysis#optimization-strategies)


### Backlinks
  * [Sidekiq Architecture](https://hype08.github.io/gradual-notes/thoughts/Sidekiq-Architecture)


Gradual Notes © 2026

