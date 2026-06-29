---
id: d88e13383
topic: gap-fill
title: "OpenTelemetry messaging semantic conventions: spans and metrics"
status: draft
shape: reference
---

# OpenTelemetry messaging semantic conventions: spans and metrics

Both the messaging spans and messaging client metrics conventions carry **Status: Development** in Semantic Conventions 1.42.0 [cca20d4f3][cff54f8f9].

## The span model

### Roles: producer, consumer, intermediary

The "producer" is a specific instance, process, or device that creates and sends a message, where "sending" is the process of transmitting a message or batch of messages to the intermediary or consumer [cca20d4f3]. A "consumer" receives the message and acts upon it, performing three sub-steps: "receiving" (obtaining a message from the intermediary), "processing" (acting on the information a message contains), and "settling" (notifying an intermediary that a message was processed successfully) [cca20d4f3]. An "intermediary" receives a message to forward it to the next receiver, which might be another intermediary or a consumer [cca20d4f3]. A message can be delivered to 0, 1, or multiple consumers depending on the dispatching semantic of the protocol [cca20d4f3].

A destination represents the entity within a messaging system where messages are sent to and consumed from, usually uniquely identified by its name within the messaging system instance; typical examples are Kafka topics and RabbitMQ queues and topics [cca20d4f3].

### Operation types and span kind

Five operation types are defined: `create`, `send`, `receive`, `process`, and `settle` [cca20d4f3]. A `create` span refers to a single message and provides a unique creation context for messages in batch-sending scenarios; a `send` span covers one or more messages provided for sending to an intermediary, and if a single message is sent the "Send" span's context can serve as the creation context with no "Create" span needed; `receive` refers to pull-based scenarios where consumers explicitly call SDK methods to receive messages; `process` covers one or more messages being processed by a consumer; and `settle` covers one or more messages being settled [cca20d4f3].

Span kind is set from the operation type: `create` → `PRODUCER`; `send` → `PRODUCER` if the "Send" span's context is used as the creation context, otherwise `CLIENT`; `receive` → `CLIENT`; `process` → `CONSUMER`; `settle` → `CLIENT` [cca20d4f3]. Setting span kinds this way lets analysis tools interpret spans and their relationships without additional semantic hints [cca20d4f3].

### Span name

The span name SHOULD be `{messaging.operation.name} {destination}` [cca20d4f3]. The `{destination}` placeholder SHOULD adhere to one of, in order: `messaging.destination.template` when available; `messaging.destination.name` when the destination is known to be neither temporary nor anonymous; or `server.address:server.port` only for operations not targeting any specific destination [cca20d4f3]. Examples include `publish shop.orders`, `send shop.orders`, `subscribe shop.orders`, and `ack shop.orders` [cca20d4f3].

### How producer and consumer spans relate

A message *creation context* allows correlating producers with consumers of a message regardless of the underlying transport mechanism; it is created by the producer and should be propagated to the consumer(s), and consumer traces cannot be directly correlated with producer traces if it is not attached and propagated [cca20d4f3]. A producer SHOULD attach a message creation context to each message, ideally in a way intermediaries cannot change [cca20d4f3].

If a "Create" span exists for a message, its context SHOULD be injected into the message; if no "Create" span exists and no custom creation context is injected, the context of the related "Send" span SHOULD be injected instead [cca20d4f3]. The "Send" span SHOULD always link to the creation context that was injected into a message [cca20d4f3].

On the consumer side, "Receive" spans SHOULD be created for pull-based operations initiated by application code, while "Process" spans SHOULD be created for push-based operations not initiated by application code (typically a callback or handler) [cca20d4f3]. A single "Process" or "Receive" span can account for a single message, a batch, or no message at all, and for each message it accounts for it SHOULD link to the message's creation context [cca20d4f3]. These conventions use span links as the default correlation mechanism because it is the only consistent trace structure guaranteeable across messaging models, the only option in batch scenarios (a span can have only one parent), and the only option when consumption happens within another ambient context such as an HTTP server span [cca20d4f3].

Exclusively for single-message scenarios, a "Process" span MAY use the message's creation context as its parent, achieving a direct parent-child relationship between producer and consumer [cca20d4f3]. It is NOT RECOMMENDED to do this by default when processing happens in the scope of another span; if instrumentation does so within another valid ambient context, it SHOULD add that ambient context as a link on the "Process" span [cca20d4f3].

### Key span attributes

Messaging attributes are organized into namespaces: `messaging.message` (individual messages), `messaging.destination` (the logical entity messages are sent to), `messaging.batch` (batch operations), and `messaging.consumer` (the consuming application instance) [cca20d4f3]. System-specific attributes MUST be defined in the corresponding `messaging.{system}` namespace [cca20d4f3].

On span attributes, `messaging.operation.name` (the system-specific operation name) and `messaging.system` (the messaging system as identified by the client instrumentation) are both `Required` [cca20d4f3]. `messaging.operation.type` (a string identifying the type of the messaging operation, e.g. `create`/`send`/`receive`) and `messaging.destination.name` (the message destination name, e.g. `MyQueue`/`MyTopic`) are `Conditionally Required` [cca20d4f3]. `messaging.batch.message_count` is `Conditionally Required` when the span describes an operation on a batch and SHOULD NOT be set on single-message spans [cca20d4f3]. `error.type` is `Conditionally Required` if and only if the messaging operation has failed [cca20d4f3].

## Client metrics

The metrics document defines three required histograms/counters plus a process-duration histogram across common, producer, and consumer groupings [cff54f8f9].

### messaging.client.operation.duration (common)

`messaging.client.operation.duration` is a `Histogram` with unit `s` (seconds) describing the "Duration of messaging operation initiated by a producer or consumer client" [cff54f8f9]. It is a `required` metric and SHOULD be specified with the `ExplicitBucketBoundaries` advisory parameter `[ 0.005, 0.01, 0.025, 0.05, 0.075, 0.1, 0.25, 0.5, 0.75, 1, 2.5, 5, 7.5, 10 ]` [cff54f8f9]. When reported alongside a messaging span, its value SHOULD equal the corresponding span duration; it SHOULD NOT be used to report processing duration, which is reported in `messaging.process.duration` instead [cff54f8f9]. Its `Required` attributes are `messaging.operation.name` and `messaging.system` [cff54f8f9].

### messaging.client.sent.messages (producer)

`messaging.client.sent.messages` is a `Counter` with unit `{message}` describing the "Number of messages producer attempted to send to the broker" [cff54f8f9]. It is a `required` metric, and it MUST NOT count messages that were created but haven't yet been sent [cff54f8f9]. Its `Required` attributes are `messaging.operation.name` (example values `send`, `schedule`, `enqueue`) and `messaging.system` [cff54f8f9].

### messaging.client.consumed.messages (consumer)

`messaging.client.consumed.messages` is a `Counter` with unit `{message}` describing the "Number of messages that were delivered to the application" [cff54f8f9]. It is a `required` metric that records messages pulled from the broker or dispatched to the application in push-based scenarios, and SHOULD be reported once per message delivery — e.g. if receiving and processing are both instrumented for a single delivery, the counter is incremented on receive and not on process [cff54f8f9]. Its `Required` attributes are `messaging.operation.name` (example values `receive`, `peek`, `poll`, `consume`) and `messaging.system` [cff54f8f9].

### messaging.process.duration (consumer)

`messaging.process.duration` is a `Histogram` with unit `s` describing the "Duration of processing operation" [cff54f8f9]. It is `required` for push-based message delivery and `recommended` for processing operations instrumented for pull-based scenarios, and SHOULD use the same `ExplicitBucketBoundaries` advisory parameter as `messaging.client.operation.duration` [cff54f8f9]. It MUST be reported for operations whose `messaging.operation.type` matches `process`, and when reported alongside a process span its value SHOULD equal the corresponding span duration [cff54f8f9]. Its `Required` attributes are `messaging.operation.name` (example values `process`, `consume`, `handle`) and `messaging.system` [cff54f8f9].

### Shared metric attributes

Across these metrics, `error.type` is `Conditionally Required` if and only if the operation has failed and carries the single well-known value `_OTHER` (a fallback when the instrumentation doesn't define a custom value) [cff54f8f9]. `messaging.system` has well-known values including `activemq`, `aws.sns`, `aws_sqs`, `eventgrid`, `eventhubs`, `gcp_pubsub`, `jms`, `kafka`, `pulsar`, `rabbitmq`, `rocketmq`, and `servicebus` [cff54f8f9]. Destination attributes (`messaging.destination.name`, `messaging.destination.template`, `messaging.destination.subscription.name`), `messaging.consumer.group.name`, and `server.address` are `Conditionally Required`, while `messaging.destination.partition.id` and `server.port` are `Recommended` [cff54f8f9].
