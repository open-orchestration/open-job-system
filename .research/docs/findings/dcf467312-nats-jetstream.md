---
id: dcf467312
topic: brokers
title: "NATS JetStream: streams and consumers"
status: draft
shape: mechanism
---

# NATS JetStream: streams and consumers

JetStream splits durable messaging into two cooperating primitives: a **stream** that stores messages, and a **consumer** that tracks who has read and acknowledged them. Streams are responsible for storing the published messages, while the consumer is responsible for tracking the delivery and acknowledgments [c5724ce29].

## Streams — the message store

Streams are message stores; each stream defines how messages are stored and what the limits (duration, size, interest) of the retention are [c4566170e]. Streams consume normal NATS subjects, and any message published on those subjects will be captured in the defined storage system [c4566170e]. You can do a normal publish to the subject for unacknowledged delivery, though it is better to use the JetStream publish calls instead, as the JetStream server will reply with an acknowledgement that the message was successfully stored [c4566170e]. A single stream can consume many subjects [c4566170e].

### Retention and discard

Streams support various retention policies which define when messages can be automatically deleted, such as when stream limits are hit (max count, size, or age), plus interest-based retention or work-queue semantics layered on top of the limits [c4566170e]. The `RetentionPolicy` options are [c4566170e]:

- `LimitsPolicy` (default) — retention based on the limits `MaxMsgs`, `MaxBytes`, `MaxAge`, and `MaxMsgsPerSubject`; whichever limit is hit first causes automatic deletion [c4566170e].
- `WorkQueuePolicy` — FIFO-queue behavior where each message can be consumed only once, enforced by allowing only one consumer per subject (subject filters must not overlap); once a message is ack'ed it is deleted from the stream [c4566170e].
- `InterestPolicy` — retention based on consumer interest; with zero consumers, published messages are immediately deleted, so consumers must be bound to the stream ahead of publishing, and a message is deleted once it is ack'ed by all consumers filtering on the subject [c4566170e].

Even under `InterestPolicy` or `WorkQueuePolicy`, any defined limits are still enforced [c4566170e]. `WorkQueuePolicy` streams only delete messages when enforced by limits or when a message has been successfully ack'd by its consumer; messages that exhausted `MaxDeliver` attempts remain in the stream and must be manually deleted via the JetStream API [c4566170e].

Upon reaching message limits, the server discards messages according to the `DiscardPolicy`: `DiscardOld` (default) removes the oldest messages to make room for new ones, while `DiscardNew` refuses to store new messages that would exceed a limit [c4566170e]. The discard behavior applies only to streams that have at least one limit defined [c4566170e].

### Storage, replicas, and subjects

The `StorageType` is `File` (default, file-based) or `Memory` (memory-based) [c4566170e]. `Replicas` sets how many replicas to keep for each message in a clustered JetStream, to a maximum of 5 [c4566170e]. `Subjects` is a list of subjects to bind, and wildcards are supported [c4566170e]; if no explicit subject is specified, the default subject is the same name as the stream, and multiple subjects can be specified and edited over time [c4566170e]. Streams also support deduplication using a `Nats-Msg-Id` header and a sliding window within which duplicate messages are tracked [c4566170e].

### Placement via tags

`Placement` declares where the stream should be placed via tags and/or an explicit cluster name [c4566170e]. Without explicit placement, the stream is created within the cluster the client is connected to, assuming sufficient storage is available [c4566170e]. Each server can have its own set of tags, and tags are often used together with the `jetstream.unique_tag` config option to ensure that replicas are placed on servers having different values for the tag [c4566170e]. A given stream, including all replicas (not mirrors), is bound to a single cluster [c4566170e].

## Consumers — the stateful cursor

A consumer is a stateful **view** of a stream; it acts as an interface for clients to consume a subset of messages stored in a stream and keeps track of which messages were delivered and acknowledged by clients [c5724ce29]. Unlike Core NATS, which provides an at-most-once delivery guarantee, a JetStream consumer can provide an at-least-once delivery guarantee [c5724ce29]. This tracking ensures that if a message is not acknowledged (un-acked or 'nacked'), the consumer will automatically attempt to re-deliver it, and if a message is not acknowledged within a user-specified number of delivery attempts, an advisory notification is emitted [c5724ce29].

### Acknowledgement policies

The `AckPolicy` requirement for client acknowledgments is one of `AckExplicit`, `AckNone`, `AckAll`, or `AckFlowControl` (2.14) [c5724ce29]:

- `AckExplicit` — the default; each individual message must be acknowledged [c5724ce29].
- `AckNone` — no acknowledgment needed; the server assumes acknowledgment on delivery [c5724ce29].
- `AckAll` — acknowledge only the last message in a series, automatically acknowledging all previous messages [c5724ce29].
- `AckFlowControl` — (2.14) messages acknowledged based on flow control, primarily for stream sourcing/mirroring using a durable consumer [c5724ce29].

If an acknowledgment is required but not received within the `AckWait` window, the message will be redelivered [c5724ce29]. `AckWait` is the duration the server waits for an acknowledgment for any individual message once it has been delivered, and it is only effective when `BackOff` is not configured [c5724ce29]. `MaxDeliver` caps the number of delivery attempts for a message (default -1, redeliver until acknowledged); messages that reach the maximum delivery count stay in the stream [c5724ce29].

### Redelivery delay and the `nak` exception

`Backoff` is a sequence of delays controlling the re-delivery of messages on acknowledgment timeout — but **not** on `nak` [c5724ce29]. The sequence length must be less than or equal to `MaxDeliver`, and if backoff is not set a timeout results in immediate re-delivery [c5724ce29]. For example, `MaxDeliver=5` with `backoff=[5s, 30s, 300s, 3600s, 84000s]` re-delivers a message 5 times over one day, and when `MaxDeliver` is larger than the backoff list the last delay applies for the remaining deliveries [c5724ce29]. A `nak` results in immediate re-delivery unless `nakWithDelay` is used to set the re-delivery delay explicitly; when `BackOff` is set it overrides `AckWait` entirely, and the first value in the BackOff determines the `AckWait` value [c5724ce29].

`MaxAckPending` defines the maximum number of messages without acknowledgment that can be outstanding before message delivery is suspended; this limit applies across all of the consumer's bound subscriptions, a value of -1 means no flow control, and the default is 1000 [c5724ce29].

### Push vs. pull dispatch

Consumers can be **push**-based, where messages are delivered to a specified subject, or **pull**-based, which allows clients to request batches of messages on demand [c5724ce29]. A pull consumer suits processing messages in an application-controlled manner and scaling horizontally, while a regular push consumer suits load balancing or acknowledging messages individually [c5724ce29]. The docs recommend pull consumers for new projects, particularly when scalability, detailed flow control, or error handling are a concern [c5724ce29]. For push consumers, the `DeliverSubject` field decides whether the consumer is push or pull-based: with a deliver subject, the server pushes messages to clients subscribed to that subject [c5724ce29].

### Durable vs. ephemeral

A consumer can be **ephemeral** or **durable** [c5724ce29]. A consumer is considered durable when an explicit name is set on the `Durable` field at creation, or when `InactiveThreshold` is set [c5724ce29]. Durables and ephemerals have the same message delivery semantics, but an ephemeral consumer has no persisted state or fault tolerance (server memory only) and is automatically cleaned up after a period of inactivity when no subscriptions are bound to it [c5724ce29]. By default consumers have the same replication factor as the stream they consume and remain even during periods of inactivity, and consumers can recover from server and client failure [c5724ce29]. Ordered consumers are a convenient default type of push and pull consumers, and they are always ephemeral with no acknowledgements — if a gap is detected, the consumer is recreated [c5724ce29].
