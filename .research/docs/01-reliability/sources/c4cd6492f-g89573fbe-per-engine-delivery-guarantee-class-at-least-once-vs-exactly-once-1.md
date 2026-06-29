[Skip to main content](https://streamkap.com/resources-and-guides/exactly-once-vs-at-least-once#main-content)
🎥 See Streamkap live in our next demo session[Save your seat→](https://riverside.com/webinar/registration/eyJldmVudElkIjoiNmEzMTVhOWY2ZGE0NGVmN2NkZTQ0OWQxIiwic2x1ZyI6InBhdWwtZHVkbGV5cy1zdHVkaW8ifQ==)
×
[ ](https://streamkap.com/)
Product
#### Products
  * [ AI Agent Platform Real-time data for AI agents ](https://streamkap.com/agents/)
  * [ Streamkap Cloud Fully managed real-time data platform ](https://streamkap.com/platform/)
  * [ BYOC Deploy in your own AWS, GCP, or Azure ](https://streamkap.com/byoc/)
  * [ Snowflake Marketplace Native Snowflake integration ](https://streamkap.com/snowflake-marketplace/)


#### Capabilities
  * [ Change Data Capture Capture database changes in real-time ](https://streamkap.com/capabilities/cdc/)
  * [ Stream Processing Transform data as it flows ](https://streamkap.com/capabilities/stream-processing/)
  * [ Monitoring Real-time observability & alerts ](https://streamkap.com/capabilities/monitoring/)
  * [ Support 24/7 expert support & proactive monitoring ](https://streamkap.com/capabilities/support/)
  * [ Connectors 60+ source and destination connectors ](https://streamkap.com/connectors/)
  * [ Governance Schema registry, lineage & compliance ](https://streamkap.com/capabilities/governance/)


#### Streamkap for...
  * [ Data Engineers Build reliable data pipelines faster ](https://streamkap.com/for/data-engineers/)
  * [ Platform Teams Self-service data infrastructure ](https://streamkap.com/for/platform-teams/)
  * [ AI/ML Engineers Fresh data for training and inference ](https://streamkap.com/for/ai-ml-engineers/)
  * [ Developers Event-driven apps made simple ](https://streamkap.com/for/developers/)


Solutions
#### Use Cases
  * [ AI Agents Real-time data for agent decisions ](https://streamkap.com/agents/)
  * [ CDC Event Streaming Stream changes as Kafka events ](https://streamkap.com/solutions/data-replication/)
  * [ Event-Driven Apps Build reactive applications ](https://streamkap.com/solutions/event-driven/)
  * [ Operational Applications Sync search, cache & customer apps ](https://streamkap.com/solutions/operational-applications/)
  * [ AI/ML Pipelines Fresh data for ML training ](https://streamkap.com/solutions/ai-ml-pipelines/)
  * [ Real-time Analytics Power dashboards with live data ](https://streamkap.com/solutions/real-time-analytics/)


#### By Destination
  * [ Snowflake Real-time CDC to Snowflake ](https://streamkap.com/solutions/snowflake/)
  * [ Databricks Stream to Delta Lake ](https://streamkap.com/solutions/databricks/)
  * [ BigQuery Real-time data for BigQuery ](https://streamkap.com/solutions/bigquery/)
  * [ ClickHouse Sub-second analytics with ClickHouse ](https://streamkap.com/solutions/clickhouse/)
  * [ Apache Iceberg Open lakehouse with time travel ](https://streamkap.com/solutions/iceberg/)
  * [ Kafka Stream events to Kafka topics ](https://streamkap.com/solutions/kafka/)


#### Compare
  * [ Streamkap vs Fivetran True real-time CDC, not micro-batching ](https://streamkap.com/compare/fivetran/)
  * [ Streamkap vs Airbyte Sub-second latency vs batch extracts ](https://streamkap.com/compare/airbyte/)
  * [ Streamkap vs Debezium Fully managed, zero infrastructure ](https://streamkap.com/compare/debezium/)
  * [ Streamkap vs Confluent CDC-optimized, simpler to operate ](https://streamkap.com/compare/streamkap-vs-confluent/)
  * [ Streamkap vs Redpanda End-to-end CDC, not just Kafka ](https://streamkap.com/compare/streamkap-vs-redpanda/)


Resources
#### Learn
  * [ Documentation Technical docs and guides ](https://docs.streamkap.com)
  * [ Blog Articles and tutorials ](https://streamkap.com/blog/)
  * [ Case Studies How customers use Streamkap ](https://streamkap.com/customers/)


#### Company
  * [ About Us Our mission and team ](https://streamkap.com/about/)
  * [ Contact Get in touch ](https://streamkap.com/contact-us/)


[ Pricing ](https://streamkap.com/pricing/)
[Sign in](https://app.streamkap.com/account/login)
[Get Started](https://app.streamkap.com/account/sign-up)
[ ](https://streamkap.substack.com/)[ ](https://www.linkedin.com/company/streamkap/)[ ](https://x.com/Streamkap)
  1. [Home](https://streamkap.com/)
  2. / [Resources & Guides](https://streamkap.com/resources-and-guides)
  3. / Exactly-Once vs At-Least-Once: Choosing Delivery Guarantees


[ Engineering ](https://streamkap.com/resources-and-guides/?category=Engineering) February 25, 2026
10 min read
# Exactly-Once vs At-Least-Once: Choosing Delivery Guarantees
A practical comparison of exactly-once and at-least-once processing guarantees in stream processing. When each one matters, how they work, and what they actually cost.
**TL;DR:** • At-least-once guarantees every event is processed but may produce duplicates on failure recovery. • Exactly-once guarantees each event affects the output exactly once, even during failures. • Exactly-once requires coordination between source, processor, and sink - adding latency and complexity. • Many use cases work fine with at-least-once plus idempotent sinks, avoiding the exactly-once overhead.
Every stream processing system makes a promise about what happens when things go wrong. That promise is its delivery guarantee, and it determines whether your pipeline loses data, duplicates data, or handles failures cleanly. If you’ve spent time evaluating tools like Apache Kafka, Apache Flink, or managed platforms like Streamkap, you’ve likely run into the terms “at-most-once,” “at-least-once,” and “exactly-once.” These are not just theoretical labels. They shape how you design your pipelines, what failure modes you accept, and how much operational overhead you take on.
This article breaks down all three guarantees, explains how exactly-once actually works under the hood, and gives you a practical framework for deciding which one your pipeline needs.
## The Three Delivery Guarantees
Before comparing exactly-once and at-least-once in detail, it helps to understand the full spectrum. There are three delivery semantics in stream processing, and each one makes a different trade-off between data loss, duplication, and system complexity.
### At-Most-Once
At-most-once is the simplest guarantee. The system commits the consumer offset _before_ processing the event. If the processor crashes after committing but before finishing its work, that event is gone. It will never be retried.
This is sometimes called “fire and forget.” It is the fastest option because it requires zero coordination between processing and offset management. But it accepts data loss as a normal failure mode.
When does this make sense? Almost never in a data pipeline. But it has a narrow role in high-volume, low-value streams - think application-level metrics or debug logs where losing a few events is acceptable and the volume makes retry overhead impractical.
### At-Least-Once
At-least-once flips the order. The system processes the event first, then commits the offset. If the processor crashes after processing but before committing, the event will be replayed on recovery. The data is never lost, but it may be processed more than once.
This is the default behavior in most Kafka consumer configurations. It is also what Flink provides when checkpointing is enabled but the sink does not support two-phase commits. At-least-once guarantees are simpler to implement, impose less coordination overhead, and work well with a wide range of sinks.
The cost is duplicates. On failure recovery, the system replays events from the last committed offset, and some of those events were already processed successfully. Your sink sees them again.
### Exactly-Once
Exactly-once means that even when failures occur, the end-to-end effect on the output is as if each event was processed one time and one time only. No data loss, no duplicates in the output.
This sounds like it should be the obvious choice. But achieving it requires tight coordination between the source, the processor, and the sink. That coordination has real costs in terms of latency, throughput, and operational complexity.
## How Exactly-Once Actually Works
There is a common misconception that exactly-once means each event is literally processed only once inside the system. That is not what happens. During failure recovery, events _are_ replayed. The processor _does_ see them again. The guarantee is about the observable output, not the internal execution.
The two primary mechanisms that make exactly-once possible in Apache Flink are distributed snapshots (checkpointing) and two-phase commit protocols on the sink.
### Flink’s Checkpoint Mechanism
Flink uses a variant of the Chandy-Lamport algorithm to take consistent snapshots of the entire pipeline state. Here is how it works:
  1. The JobManager periodically injects checkpoint barriers into the source streams.
  2. These barriers flow through the dataflow graph alongside regular events.
  3. When an operator receives barriers from all its input channels, it snapshots its local state to durable storage (typically a distributed filesystem or object store like S3).
  4. Once all operators have completed their snapshots, the checkpoint is considered complete.


If a failure occurs, Flink restores all operators to their most recent completed checkpoint. The source rewinds to the offsets captured in that checkpoint, and processing resumes. Events between the last checkpoint and the failure are replayed, but since the operator state was also restored to the checkpoint, the replayed processing produces the same output as the original run.
This gives you exactly-once _within_ the Flink pipeline. But the output is a different story.
### Two-Phase Commits for End-to-End Guarantees
The checkpoint mechanism alone does not prevent duplicates in external sinks. If Flink wrote results to a database before a failure and then replayed those events after recovery, the database would see duplicates.
To solve this, Flink uses a two-phase commit (2PC) protocol with sinks that support transactions:
  1. **Pre-commit phase:** During normal processing, Flink writes output to the sink inside an open transaction. The data is written but not yet visible to downstream consumers.
  2. **Commit phase:** When a checkpoint completes successfully, Flink commits the transaction. Only then does the output become visible.
  3. **Abort on failure:** If a checkpoint fails, the uncommitted transaction is rolled back. No duplicate data reaches the sink.


This is how Flink achieves exactly-once with Kafka as a sink. The Kafka producer uses transactional writes, and consumers configured with `isolation.level=read_committed` only see committed data. The same pattern works with other transactional sinks.
The catch: your sink must support transactions. Not all do. And even when they do, the two-phase commit adds latency because output is not visible until the next checkpoint completes.
## The End-to-End Picture: Kafka + Flink
A common production topology is Kafka as the source, Flink as the processor, and Kafka (or a database) as the sink. Here is how delivery guarantees play out across this stack:
**Source side (Kafka to Flink):** Flink stores Kafka consumer offsets as part of its checkpoint state. On recovery, it rewinds the consumer to the checkpointed offsets. This means the source side naturally supports exactly-once - the offset and the processing state are atomically consistent.
**Processing (inside Flink):** Checkpointing ensures that operator state and position in the stream are always consistent. Replayed events produce identical results because the state was rolled back to match.
**Sink side (Flink to Kafka):** Flink’s Kafka producer uses transactions. Events are written to Kafka inside a transaction that is committed only when the checkpoint completes. Downstream consumers using `read_committed` isolation see each event exactly once.
**Sink side (Flink to a database):** If the database supports transactions and the Flink sink implements the `TwoPhaseCommitSinkFunction`, you get end-to-end exactly-once. If the database does not support transactions, you fall back to at-least-once.
This is important: exactly-once is a property of the _entire_ pipeline, not just one component. A single link in the chain that does not support it breaks the guarantee for the whole path.
## The Performance Trade-Off
Exactly-once is not free. The coordination required for checkpointing and two-phase commits has measurable effects on latency and throughput.
### Checkpointing Overhead
Checkpoints require snapshotting operator state to durable storage. For operators with large state (like windowed aggregations or joins), this can produce periodic latency spikes. The size of these spikes depends on state size, storage backend speed, and whether you use incremental checkpoints.
Typical checkpoint intervals range from 1 second to several minutes. Shorter intervals give faster recovery (less data to replay) but increase the frequency of state snapshots. Longer intervals reduce overhead but mean more data must be replayed after a failure.
### Output Latency
With two-phase commits, output is not visible to downstream consumers until the checkpoint completes. If your checkpoint interval is 10 seconds, your output latency has a floor of 10 seconds - even if the actual processing takes milliseconds. This is a hard constraint that many teams overlook when evaluating exactly-once.
With at-least-once, output can be emitted immediately. There is no need to wait for a checkpoint boundary. For latency-sensitive applications, this difference matters.
### Throughput Impact
Checkpointing and transactional writes both consume resources - CPU for serialization, network bandwidth for state transfer, disk I/O on the storage backend. In high-throughput pipelines, this overhead can reduce effective throughput by 10-30% compared to at-least-once processing, depending on state size and checkpoint frequency.
## Idempotent Sinks: The Practical Alternative
Here is where the conversation gets interesting. Many teams default to exactly-once because it sounds like the “correct” option, without considering whether their sink already handles duplicates naturally.
An idempotent operation produces the same result whether you execute it once or multiple times. If your sink is idempotent, at-least-once delivery gives you the same end result as exactly-once - without the coordination overhead.
### Common Idempotent Patterns
  * **Database upserts with a primary key:** Writing `UPDATE users SET email = 'x' WHERE id = 123` twice produces the same result as writing it once. The second write simply overwrites with the same value.
  * **Key-value stores with deterministic keys:** Putting the same key-value pair into Redis or DynamoDB twice leaves the store in the same state.
  * **Overwrites to object storage:** Writing a file to S3 with the same key replaces the previous version. If the content is the same, the result is identical.


### Non-Idempotent Patterns
  * **Append-only logs:** Inserting a row into a table without deduplication creates a duplicate.
  * **Counters and accumulators:** Incrementing a counter twice when you meant to increment it once gives the wrong total.
  * **Sending emails or push notifications:** You cannot un-send a message. Duplicates here mean duplicate notifications to users.


If your sink falls into the idempotent category, at-least-once with idempotent writes is often the better engineering choice. You get simpler operations, lower latency, higher throughput, and equivalent correctness.
Streamkap uses this pattern in its managed CDC pipelines. By combining at-least-once delivery with idempotent sink writes (like upserts keyed on primary keys), Streamkap delivers correct results without requiring the full coordination overhead of two-phase commits. This approach keeps latency low while still ensuring data accuracy in the destination.
## A Decision Framework
When you are choosing a delivery guarantee for a new pipeline, work through these questions:
**1. Can your sink tolerate duplicates?** If your sink supports upserts or is naturally idempotent, at-least-once is likely sufficient. You get lower latency and simpler operations.
**2. Is your output append-only?** If you are appending events to a log, a data lake, or a table without natural deduplication, duplicates will accumulate. You need either exactly-once or a deduplication layer between the processor and the sink.
**3. What is your latency budget?** If you need sub-second output visibility, two-phase commits will be a bottleneck. At-least-once with idempotent sinks gives you faster output.
**4. How large is your operator state?** Large state means expensive checkpoints. If your pipeline maintains gigabytes of state for windowed joins, checkpoint overhead is significant. Weigh the cost of exactly-once against the cost of handling occasional duplicates downstream.
**5. Does your entire sink chain support transactions?** Exactly-once requires every sink in the pipeline to participate in the two-phase commit. If even one sink does not support transactions, you have at-least-once to that sink regardless of what the rest of the pipeline does.
**6. What is the business cost of a duplicate vs. a delay?** For financial transactions, duplicates can mean double charges - exactly-once is worth the latency. For analytics dashboards, a temporary duplicate row that gets corrected on the next upsert is harmless.
## Common Misconceptions
**“Exactly-once means each event is processed exactly once.”** No. Events may be processed multiple times during recovery. The guarantee is that the _effect on the output_ is as if each event was processed once. Internal retries happen; they are just invisible to the outside world.
**“At-least-once always produces duplicates.”** Not during normal operation. Duplicates only appear during failure recovery, when the system replays events from the last checkpoint. If your pipeline runs without failures (which is most of the time), at-least-once produces no duplicates at all.
**“You should always choose exactly-once to be safe.”** This is like saying you should always use serializable isolation in your database. It is the strongest guarantee, but it comes with real performance costs. Many production pipelines run at-least-once with idempotent sinks and produce perfectly correct results.
**“Kafka alone provides exactly-once.”** Kafka’s transactional producer and consumer give you exactly-once between Kafka topics. But if your pipeline reads from Kafka, processes data, and writes to an external database, you need the processor (like Flink) to coordinate the exactly-once guarantee end to end. Kafka’s built-in guarantee covers the Kafka-to-Kafka path, not the full pipeline.
## Putting It Into Practice
The delivery guarantee you choose should match the actual requirements of your use case, not an abstract ideal. Start by understanding your sink. If it is idempotent, at-least-once with proper key design gives you correctness with minimal overhead. If it is not idempotent and duplicates have real business consequences, invest in exactly-once and accept the latency and complexity trade-off.
For teams building CDC pipelines or real-time data integration, platforms like Streamkap handle this complexity internally - choosing the right delivery strategy based on the source and destination characteristics so you do not have to manage checkpoint tuning and transactional sinks yourself.
The best delivery guarantee is the one that gives you correct results at the latency and operational cost your team can sustain. Sometimes that is exactly-once. Often, it is at-least-once with a well-designed sink.
![Photo of Ricky Thomas](https://cdn.prod.website-files.com/695d0ad60418eec963d5f049/695d0ad60418eec963d5f0f0_6347b3260bd8e7e630a5b410_ricky%20headshot.jpg)
Ricky Thomas
Ricky has 20+ years experience in data, devops, databases and startups.
[ LinkedIn ](https://www.linkedin.com/in/rickythomas/)
## Related resources
Engineering February 26, 2026
### [Kafka Consumer Lag: Causes, Debugging, and Fixes ](https://streamkap.com/resources-and-guides/kafka-consumer-lag/)
Consumer lag is the most common Kafka operational issue. Learn what causes it, how to measure it, and practical strategies to bring it under control.
[Read more about Kafka Consumer Lag: Causes, Debugging, and Fixes](https://streamkap.com/resources-and-guides/kafka-consumer-lag/)
Engineering February 26, 2026
### [Kafka on Kubernetes: Real-World Lessons ](https://streamkap.com/resources-and-guides/kafka-on-kubernetes/)
Running Kafka on Kubernetes sounds like a good idea until you hit storage, networking, and operational challenges. Here's what teams learn the hard way and how to avoid the common pitfalls.
[Read more about Kafka on Kubernetes: Real-World Lessons](https://streamkap.com/resources-and-guides/kafka-on-kubernetes/)
Engineering February 25, 2026
### [Backpressure in Stream Processing: What It Is and How to Handle It ](https://streamkap.com/resources-and-guides/backpressure-stream-processing/)
Learn what backpressure means in streaming pipelines, how to detect it, and practical strategies for handling it in Kafka, Flink, and CDC pipelines without losing data.
[Read more about Backpressure in Stream Processing: What It Is and How to Handle It](https://streamkap.com/resources-and-guides/backpressure-stream-processing/)
[ ![Streamkap logo](https://streamkap.com/images/streamkap-logo-white.svg) ](https://streamkap.com/)
Zero Ops Data Streaming
[ Start Free Trial ](https://app.streamkap.com/account/sign-up)
[ ](https://streamkap.substack.com/)[ ](https://www.linkedin.com/company/streamkap/)[ ](https://x.com/Streamkap)
### Products
  * [ Streamkap Cloud ](https://streamkap.com/platform/)
  * [ BYOC ](https://streamkap.com/byoc/)
  * [ Snowflake Marketplace ](https://streamkap.com/snowflake-marketplace/)
  * [ AI Agent Platform ](https://streamkap.com/agents/)
  * [ Pricing ](https://streamkap.com/pricing/)


### Capabilities
  * [ Change Data Capture ](https://streamkap.com/capabilities/cdc/)
  * [ Stream Processing ](https://streamkap.com/capabilities/stream-processing/)
  * [ Connectors ](https://streamkap.com/connectors/)
  * [ Monitoring ](https://streamkap.com/capabilities/monitoring/)
  * [ Security ](https://streamkap.com/security/)


### Solutions
  * [ Snowflake ](https://streamkap.com/solutions/snowflake/)
  * [ Databricks ](https://streamkap.com/solutions/databricks/)
  * [ BigQuery ](https://streamkap.com/solutions/bigquery/)
  * [ ClickHouse ](https://streamkap.com/solutions/clickhouse/)
  * [ Kafka ](https://streamkap.com/solutions/kafka/)


### Resources
  * [ Documentation ](https://docs.streamkap.com)
  * [ Blog ](https://streamkap.com/blog/)
  * [ Resources & Guides ](https://streamkap.com/resources-and-guides/)


### Customers
  * [ Nala Money ](https://streamkap.com/blog/streamkap-empowers-nala-money-to-optimize-real-time-money-transfers-to-africa)
  * [ Limble ](https://streamkap.com/blog/streaming-400-000-tables-with-streamkap)
  * [ InHire ](https://streamkap.com/blog/case-study-inhire-powers-real-time-ai-recruitment-with-streamkap)
  * [ SpotOn ](https://streamkap.com/blog/spoton-case-study)
  * [ Fleetio ](https://streamkap.com/blog/fleetio-case-study)
  * [ Niche.com ](https://streamkap.com/blog/how-streamkap-reduced-niche-coms-data-latency-from-24-hours-to-near-real-time)
  * [ All case studies ](https://streamkap.com/blog/?tag=Case%20Study)


### Company
  * [ About ](https://streamkap.com/about/)
  * [ Contact ](https://streamkap.com/contact-us/)
  * [ Careers ](https://www.linkedin.com/company/streamkap/jobs/)
  * [ Trust Center ](https://trust.streamkap.com)
  * [ Status ](https://status.streamkap.com)


### Legal
  * [ Terms of Use ](https://streamkap.com/terms/)
  * [ Privacy Policy ](https://streamkap.com/privacy/)
  * [ Cookie Policy ](https://streamkap.com/cookies/)
  * [ DPA ](https://streamkap.com/dpa/)
  * [ GDPR ](https://streamkap.com/gdpr/)


![SOC 2](https://streamkap.com/images/aicpa.png) ![HIPAA](https://streamkap.com/images/HIPAA-1.svg) ![GDPR](https://streamkap.com/images/gdpr.png) ![Snowflake Select Partner](https://streamkap.com/images/Technology_Partner_Select_Badge.png) ![PCI Security Standards Council](https://streamkap.com/images/pci-logo.png)
© 2026 Streamkap, Inc. All rights reserved
## Tell us where you're headed
Two quick details and we'll get you set up.
Loading…
Having trouble loading the form? [Skip ahead and book a time](https://meetings-na2.hubspot.com/paul1673/in-app-demo-link). 
Trusted by data teams at SpotOn, ShipMonk, Fleetio and more.
## Book a discussion with our team
After booking you will get access to your trial account
Loading calendar…
Having trouble loading the calendar? [Open the booking page in a new tab](https://meetings-na2.hubspot.com/paul1673/in-app-demo-link). 
## You're booked.
Redirecting you to signup…
[Continue to signup](https://app.streamkap.com/account/sign-up)

