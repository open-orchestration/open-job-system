[Skip to main content](https://www.rabbitmq.com/docs/consumers#__docusaurus_skipToContent_fallback)

🎉️ [**RabbitMQ 4.3** is out!](https://www.rabbitmq.com/blog/2026/04/23/rabbitmq-4.3-release) 🥳️

[![RabbitMQ](https://www.rabbitmq.com/img/rabbitmq-logo-by-tanzu.svg)](https://www.rabbitmq.com/)[Getting Started](https://www.rabbitmq.com/tutorials) [Docs](https://www.rabbitmq.com/docs) [Blog](https://www.rabbitmq.com/blog) [Support](https://www.rabbitmq.com/contact) [Commercial Features](https://www.rabbitmq.com/commercial-features)

[4.3](https://www.rabbitmq.com/docs/consumers)

- **Release series**
- [Next](https://www.rabbitmq.com/docs/next/consumers)
- [4.3](https://www.rabbitmq.com/docs/consumers)
- [4.2](https://www.rabbitmq.com/docs/4.2/consumers)
- [4.1](https://www.rabbitmq.com/docs/4.1/consumers)
- [4.0](https://www.rabbitmq.com/docs/4.0/consumers)
- [3.13](https://www.rabbitmq.com/docs/3.13/consumers)

[GitHub](https://github.com/rabbitmq/rabbitmq-website)

Search`Ctrl`  `K`

- [Introduction](https://www.rabbitmq.com/docs)
- [Release Information](https://www.rabbitmq.com/release-information)
- [Getting Started](https://www.rabbitmq.com/tutorials)
- [Install and Upgrade](https://www.rabbitmq.com/docs/download)

- [How to Use RabbitMQ](https://www.rabbitmq.com/docs/use-rabbitmq)

  - [Publishing Messages](https://www.rabbitmq.com/docs/publishers)

  - [Exchanges](https://www.rabbitmq.com/docs/exchanges)
  - [Consuming Messages](https://www.rabbitmq.com/docs/consumers)

    - [Consumer Cancellation Notifications](https://www.rabbitmq.com/docs/consumer-cancel)
    - [Consumer Prefetch](https://www.rabbitmq.com/docs/consumer-prefetch)
    - [Consumer Priorities](https://www.rabbitmq.com/docs/consumer-priority)
    - [Negative Acknowledgements](https://www.rabbitmq.com/docs/nack)
  - [Queues](https://www.rabbitmq.com/docs/queues)

  - [Streams](https://www.rabbitmq.com/docs/streams)

  - [Channels](https://www.rabbitmq.com/docs/channels)
  - [Reliability and Data Safety](https://www.rabbitmq.com/docs/reliability)
  - [Consumer Acknowledgements and Publisher Confirms](https://www.rabbitmq.com/docs/confirms)
  - [Network Distribution](https://www.rabbitmq.com/docs/distributed)
  - [Plugins](https://www.rabbitmq.com/docs/plugins)

  - [Protocols](https://www.rabbitmq.com/docs/protocols)

  - [Intercepting Messages](https://www.rabbitmq.com/docs/message-interceptors)
  - [Client Libraries](https://www.rabbitmq.com/client-libraries)
- [How to Manage RabbitMQ](https://www.rabbitmq.com/docs/manage-rabbitmq)

- [How to Monitor RabbitMQ](https://www.rabbitmq.com/docs/monitoring)


- [Home page](https://www.rabbitmq.com/)
- [How to Use RabbitMQ](https://www.rabbitmq.com/docs/use-rabbitmq)
- Consuming Messages

Version: 4.3

On this page

# Consumers

## Overview [​](https://www.rabbitmq.com/docs/consumers\#overview "Direct link to Overview")

This guide covers various topics related to consumers:

- [The basics](https://www.rabbitmq.com/docs/consumers#basics)
- [Consumer lifecycle](https://www.rabbitmq.com/docs/consumers#consumer-lifecycle)
- [How to register a consumer](https://www.rabbitmq.com/docs/consumers#subscribing) (subscribe, "push API")
- [Acknowledgement modes](https://www.rabbitmq.com/docs/consumers#acknowledgement-modes)
- [Message properties](https://www.rabbitmq.com/docs/consumers#message-properties) and delivery metadata
- [How to limit number of outstanding deliveries with prefetch](https://www.rabbitmq.com/docs/consumers#prefetch)
- [Delivery acknowledgement timeout](https://www.rabbitmq.com/docs/consumers#acknowledgement-timeout)
- [Consumer capacity](https://www.rabbitmq.com/docs/consumers#metrics-capacity) metric
- [How to cancel a consumer](https://www.rabbitmq.com/docs/consumers#unsubscribing)
- [Consumer exclusivity](https://www.rabbitmq.com/docs/consumers#exclusivity)
- [Single active consumer](https://www.rabbitmq.com/docs/consumers#single-active-consumer)
- [Consumer activity](https://www.rabbitmq.com/docs/consumers#active-consumer)
- [Consumer priority](https://www.rabbitmq.com/docs/consumers#priority)
- [Connection failure recovery](https://www.rabbitmq.com/docs/consumers#connection-recovery)
- [Exception Handling](https://www.rabbitmq.com/docs/consumers#exceptions)
- [Concurrency Consideration](https://www.rabbitmq.com/docs/consumers#concurrency)

and more.

## Terminology [​](https://www.rabbitmq.com/docs/consumers\#terminology "Direct link to Terminology")

The term "consumer" means different things in different contexts. In general, in the context of messaging
and streaming, a consumer is an application (or application instance) that consumes and [acknowledges](https://www.rabbitmq.com/docs/confirms)
messages. The same application can also publish messages and thus be a publisher at the same time.

Messaging protocols also have the concept of a lasting subscription for message delivery.
Subscription is one term commonly used to describe such entity. Consumer is another.
Messaging protocols supported by RabbitMQ use both terms but RabbitMQ documentation tends to
prefer the latter.

In this sense a consumer is a subscription for message delivery that has to be
registered before deliveries begin and can be cancelled by the application.

## The Basics [​](https://www.rabbitmq.com/docs/consumers\#basics "Direct link to The Basics")

RabbitMQ is a messaging broker. It accepts messages from publishers, routes them
and, if there were queues to route to, stores them for consumption or immediately
delivers to consumers, if any.

Consumers consume from queues. In order to consume messages there has to be a queue.
When a new consumer is added, assuming there are already messages ready in the queue,
deliveries will start immediately.

The target queue can be empty at the time of consumer registration. In that case
first deliveries will happen when new messages are enqueued.

An attempt to consume from a non-existent queue will result in a channel-level
exception with the code of `404 Not Found` and render the channel it was attempted
on to be closed.

### Consumer Tags [​](https://www.rabbitmq.com/docs/consumers\#consumer-tags "Direct link to Consumer Tags")

Every consumer has an identifier that is used by client libraries to determine
what handler to invoke for a given delivery. Their names vary from protocol to protocol.
Consumer tags and subscription IDs are two most commonly used terms. RabbitMQ documentation
tends to use the former.

Consumer tags are also used to cancel consumers.

### Consumer Lifecycle [​](https://www.rabbitmq.com/docs/consumers\#consumer-lifecycle "Direct link to Consumer Lifecycle")

Consumers are meant to be long lived: that is, throughout the lifetime of a consumer it receives
multiple deliveries. Registering a consumer to consume a single message is not optimal.

Consumers are typically registered during application
startup. They often would live as long as their connection or even application
runs.

Consumers can be more dynamic and register in reaction to a system event, unsubscribing
when they are no longer necessary. This is common with WebSocket clients
used via [Web STOMP](https://www.rabbitmq.com/docs/web-stomp) and [Web MQTT](https://www.rabbitmq.com/docs/web-mqtt) plugins, mobile clients and so on.

### Connection Recovery [​](https://www.rabbitmq.com/docs/consumers\#connection-recovery "Direct link to Connection Recovery")

Client can lose their connection to RabbitMQ. When connection loss is [detected](https://www.rabbitmq.com/docs/heartbeats),
message delivery stops.

Some client libraries offer automatic connection recovery features that involves consumer recovery.
[Java](https://www.rabbitmq.com/client-libraries/java-api-guide#recovery), [.NET](https://www.rabbitmq.com/client-libraries/dotnet-api-guide#recovery) and [Bunny](http://rubybunny.info/articles/error_handling.html)
are examples of such libraries.
While connection recovery cannot cover 100% of scenarios and workloads, it generally works very well for consuming
applications and is recommended.

With other client libraries application developers are responsible for performing connection
recovery. Usually the following recovery sequence works well:

- Recover connection
- Recover channels
- Recover queues
- Recover exchanges
- Recover bindings
- Recover consumers

In other words, consumers are usually recovered last, after their target queues and those queues'
bindings are in place.

important

Note that automatically recovering connections that use auto-delete and exclusive queues
should [make sure that these queues are server-named](https://www.rabbitmq.com/docs/queues#shared-temporary-queues).

## Registering a Consumer (Subscribing, "Push API") [​](https://www.rabbitmq.com/docs/consumers\#subscribing "Direct link to Registering a Consumer (Subscribing, \"Push API\")")

Applications can subscribe to have RabbitMQ push enqueued messages (deliveries) to them.
This is done by registering a consumer (subscription) on a queue. After a subscription
is in place, RabbitMQ will begin delivering messages. For each delivery
a user-provided handler will be invoked. Depending on the client library used
this can be a user-provided function or object that adheres to a certain interface.

A successful subscription operation returns a subscription identifier (consumer tag).
It can later be used to cancel the consumer.

### Java Client [​](https://www.rabbitmq.com/docs/consumers\#java-client "Direct link to Java Client")

See [Java client guide](https://www.rabbitmq.com/client-libraries/java-api-guide#consuming) for examples.

### .NET Client [​](https://www.rabbitmq.com/docs/consumers\#net-client "Direct link to .NET Client")

See [.NET client guide](https://www.rabbitmq.com/client-libraries/dotnet-api-guide#consuming) for examples.

## Message Properties and Delivery Metadata [​](https://www.rabbitmq.com/docs/consumers\#message-properties "Direct link to Message Properties and Delivery Metadata")

Every delivery combines message metadata and delivery information. Different client
libraries use slightly different ways of providing access to those properties. Typically
delivery handlers have access to a delivery data structure.

The following properties are delivery and routing details; they are not message properties per se
and set by RabbitMQ at routing and delivery time:

| Property | Type | Description |
| --- | --- | --- |
| Delivery tag | Positive integer | Delivery identifier, see [Confirms](https://www.rabbitmq.com/docs/confirms). |
| Redelivered | Boolean | Set to `true` if this message was previously [delivered and requeued](https://www.rabbitmq.com/docs/confirms#consumer-nacks-requeue) |
| Exchange | String | Exchange which routed this message |
| Routing key | String | Routing key used by the publisher |
| Consumer tag | String | Consumer (subscription) identifier |

The following are message properties. Most of them are optional. They are set by publishers
at the time of publishing:

| Property | Type | Description | Required? |
| --- | --- | --- | --- |
| Delivery mode | Enum (1 or 2) | 2 for "persistent", 1 for "transient". Some client libraries expose this property<br>as a boolean or enum. | Yes |
| Type | String | Application-specific message type, e.g. "orders.created" | No |
| Headers | Map (string => any) | An arbitrary map of headers with string header names | No |
| Content type | String | Content type, e.g. "application/json". Used by applications, not core RabbitMQ | No |
| Content encoding | String | Content encoding, e.g. "gzip". Used by applications, not core RabbitMQ | No |
| Message ID | String | Arbitrary message ID | No |
| Correlation ID | String | Helps correlate requests with responses, see [tutorial 6](https://www.rabbitmq.com/tutorials) | No |
| Reply To | String | Carries response queue name, see [tutorial 6](https://www.rabbitmq.com/tutorials) | No |
| Expiration | String | [Per-message TTL](https://www.rabbitmq.com/docs/ttl) | No |
| Timestamp | Timestamp | Application-provided timestamp | No |
| User ID | String | User ID, [validated](https://www.rabbitmq.com/docs/validated-user-id) if set | No |
| App ID | String | Application name | No |

### Message Types [​](https://www.rabbitmq.com/docs/consumers\#message-types "Direct link to Message Types")

The type property on messages is an arbitrary string that helps applications communicate what kind
of message that is. It is set by the publishers at the time of publishing.
The value can be any domain-specific string that publishers and consumers agree on.

RabbitMQ does not validate or use this field, it exists for applications and plugins to use
and interpret.

Message types in practice naturally fall into groups, a dot-separated naming convention is
common (but not required by RabbitMQ or clients), e.g. `orders.created` or `logs.line` or `profiles.image.changed`.

If a consumer gets a delivery of a type it cannot handle, it is highly advised to log
such events to make troubleshooting easier.

### Content Type and Encoding [​](https://www.rabbitmq.com/docs/consumers\#content-type-and-encoding "Direct link to Content Type and Encoding")

The content (MIME media) type and content encoding fields allow publishers communicate how message payload
should be deserialized and decoded by consumers.

RabbitMQ does not validate or use these fields, it exists for applications and plugins to use
and interpret.

For example, messages with JSON payload [should use `application/json`](http://www.ietf.org/rfc/rfc4627.txt).
If the payload is compressed with the LZ77 (GZip) algorithm, its content encoding should be `gzip`.

Multiple encodings can be specified by separating them with commas.

## Acknowledgement Modes [​](https://www.rabbitmq.com/docs/consumers\#acknowledgement-modes "Direct link to Acknowledgement Modes")

When registering a consumer applications can choose one of two delivery modes:

- Automatic (deliveries require no acknowledgement, a.k.a. "fire and forget")
- Manual (deliveries require client acknowledgement)

Consumer acknowledgements are a subject of a [separate documentation guide](https://www.rabbitmq.com/docs/confirms), together with
publisher confirms, a closely related concept for publishers.

## Limiting Simultaneous Deliveries with Prefetch [​](https://www.rabbitmq.com/docs/consumers\#prefetch "Direct link to Limiting Simultaneous Deliveries with Prefetch")

With manual acknowledgement mode consumers have a way of limiting how many deliveries can be "in flight" (in transit
over the network or delivered but unacknowledged). This can avoid consumer overload.

This feature, together with consumer acknowledgements are a subject of a [separate documentation guide](https://www.rabbitmq.com/docs/confirms).

## The Consumer Capacity Metric [​](https://www.rabbitmq.com/docs/consumers\#metrics-capacity "Direct link to The Consumer Capacity Metric")

RabbitMQ [management UI](https://www.rabbitmq.com/docs/management) as well as [monitoring data](https://www.rabbitmq.com/docs/monitoring) endpoints such as that for [Prometheus scraping](https://www.rabbitmq.com/docs/prometheus)
display a metric called consumer capacity (previously consumer utilisation) for individual queues.

The metric is computed as a fraction of the time that the queue is able to immediately deliver messages to consumers.
It helps the operator notice conditions where it **may** be worthwhile adding more consumers (application instances)
to the queue.

If this number is less than 100%, the queue leader replica may be able to deliver messages faster if:

- There were more consumers or
- The consumers spent less time processing deliveries or
- The consumer channels used a higher [prefetch value](https://www.rabbitmq.com/docs/consumers#prefetch)

Consumer capacity will be 0% for queues that have no consumers. For queues that have online consumers but
no message flow, the value will be 100%: the idea is that any number of consumers can sustain this
kind of delivery rate.

Note that consumer capacity is merely a hint. Consumer applications can and should collect more specific
metrics about their operations to help with sizing and any possible capacity changes.

## Cancelling a Consumer (Unsubscribing) [​](https://www.rabbitmq.com/docs/consumers\#unsubscribing "Direct link to Cancelling a Consumer (Unsubscribing)")

To cancel a consumer, its identifier (consumer tag) must be known.

After a consumer is cancelled there will be no future deliveries dispatched
to it. Note that there can still be "in flight" deliveries dispatched previously.
Cancelling a consumer will neither discard nor requeue them.

A cancelled consumer will not observe any new deliveries besides those in-flight at
the moment of processing `basic.cancel` method by RabbitMQ. All previously unconfirmed
deliveries will not be affected in any way. To re-queue in-flight deliveries, the
application must close the channel.

### Java Client [​](https://www.rabbitmq.com/docs/consumers\#java-client-1 "Direct link to Java Client")

See [Java client guide](https://www.rabbitmq.com/client-libraries/java-api-guide#consuming) for examples.

### .NET Client [​](https://www.rabbitmq.com/docs/consumers\#net-client-1 "Direct link to .NET Client")

See [.NET client guide](https://www.rabbitmq.com/client-libraries/dotnet-api-guide#consuming) for examples.

## Polling for Individual Messages ("Pull API") [​](https://www.rabbitmq.com/docs/consumers\#polling "Direct link to Polling for Individual Messages (\"Pull API\")")

danger

The mechanism described in this section is a form of polling. As any polling-based
approach in distributed systems, it is highly inefficient, in particular in cases where queues can
be empty for periods of time.

Besides integration tests, this AMQP 0-9-1 consumption mechanism is strongly recommended against.

RabbitMQ [management](https://www.rabbitmq.com/docs/management) and [Prometheus](https://www.rabbitmq.com/docs/prometheus) plugins provide several metrics that help detect
applications that use polling (`basic.get`).

tip

Use [long-lived consumers](https://www.rabbitmq.com/docs/consumers#consumer-lifecycle) instead of polling.

With AMQP 0-9-1 it is possible to fetch messages one by one using the `basic.get` protocol
method. Messages are fetched in the FIFO order. It is possible to use automatic or manual acknowledgements,
just like with consumers (subscriptions).

Fetching messages one by one is **highly discouraged** as it is **very inefficient**
compared to [regular long-lived consumers](https://www.rabbitmq.com/docs/consumers#subscribing). As with any polling-based algorithm,
it will be **extremely wasteful** in systems where message publishing is sporadic and queues
can stay empty for prolonged periods of time.

When in doubt, prefer using a regular long-lived consumer.

### Java Client [​](https://www.rabbitmq.com/docs/consumers\#java-client-2 "Direct link to Java Client")

See [Java client guide](https://www.rabbitmq.com/client-libraries/java-api-guide#getting) for examples.

### .NET Client [​](https://www.rabbitmq.com/docs/consumers\#net-client-2 "Direct link to .NET Client")

See [.NET client guide](https://www.rabbitmq.com/client-libraries/dotnet-api-guide#basic-get) for examples.

## Delivery Acknowledgement Timeout [​](https://www.rabbitmq.com/docs/consumers\#acknowledgement-timeout "Direct link to Delivery Acknowledgement Timeout")

important

Starting with RabbitMQ 4.3, delivery acknowledgement timeouts are only supported by [quorum queues](https://www.rabbitmq.com/docs/quorum-queues).

RabbitMQ enforces a timeout on consumer delivery acknowledgement.
This is a **protection mechanism** that detects when consumers do not acknowledge message deliveries.
Configuring a delivery acknowledgement timeout can help prevent on-disk data compaction
and driving nodes out of disk space.

### How it works [​](https://www.rabbitmq.com/docs/consumers\#how-it-works "Direct link to How it works")

If a consumer does not ack its delivery within the timeout value,
its channel is closed with a `PRECONDITION_FAILED` channel exception.
The message will look like this:

```text
Consumer 'consumer-tag-998754663370' on channel 1 and queue 'qq.1' in vhost '/' has timed out

waiting for a consumer acknowledgement of a delivery with delivery tag = 10. Timeout used: 180000 ms.

This timeout value can be configured, see consumers doc guide to learn more
```

The error is [logged](https://www.rabbitmq.com/docs/logging) by the node to which the consumer was connected.
All the following deliveries on that channel, from all consumers,
are then [requeued](https://www.rabbitmq.com/docs/confirms#automatic-requeueing).
To resolve a `PRECONDITION_FAILED` channel exception, reevaluate your consumer
and consider increasing the timeout value.

The default timeout value for RabbitMQ is 30 minutes.
Whether the timeout should be enforced is evaluated periodically, at one minute intervals.
Values lower than one minute are not supported, and values lower than five minutes
are not recommended.

### Per-node Configuration [​](https://www.rabbitmq.com/docs/consumers\#per-node-configuration "Direct link to Per-node Configuration")

The timeout value is configurable in [rabbitmq.conf](https://www.rabbitmq.com/docs/configure#config-file) (in milliseconds):

```ini
# 30 minutes in milliseconds

consumer_timeout = 1800000
```

```ini
# one hour in milliseconds

consumer_timeout = 3600000
```

The timeout can be deactivated using [`advanced.config`](https://www.rabbitmq.com/docs/configure#advanced-config-file). This is **not recommended**:

```erlang
%% advanced.config

[\
\
  {rabbit, [\
\
    {consumer_timeout, undefined}\
\
  ]}\
\
].
```

Instead of disabling the timeout entirely, consider using a high value (for example, a few hours).

### Per-queue Configuration [​](https://www.rabbitmq.com/docs/consumers\#per-queue-configuration "Direct link to Per-queue Configuration")

Starting with RabbitMQ 3.12, the timeout value can also be configured per-queue.

#### Per-queue Delivery Timeouts Using a Policy [​](https://www.rabbitmq.com/docs/consumers\#per-queue-delivery-timeouts-using-a-policy "Direct link to Per-queue Delivery Timeouts Using a Policy")

Set the `consumer-timeout` policy key.

The value must be in milliseconds.
Whether the timeout should be enforced is evaluated periodically, at one minute intervals.

```bash
# override consumer timeout for a group of queues using a policy

rabbitmqctl set_policy queue_consumer_timeout "with_delivery_timeout\.*" '{"consumer-timeout":3600000}' --apply-to quorum_queues
```

#### Per-queue Delivery Timeouts Using an Optional Queue Argument [​](https://www.rabbitmq.com/docs/consumers\#per-queue-delivery-timeouts-using-an-optional-queue-argument "Direct link to Per-queue Delivery Timeouts Using an Optional Queue Argument")

Set the `x-consumer-timeout` [optional queue argument](https://www.rabbitmq.com/docs/queues#optional-arguments) on a queue when the queue is declared.
The timeout is specified in milliseconds.
Whether the timeout should be enforced is evaluated periodically, at one minute intervals.

## Limiting the number of Consumers per channel [​](https://www.rabbitmq.com/docs/consumers\#limiting-the-number-of-consumers-per-channel "Direct link to Limiting the number of Consumers per channel")

In some scenarios where consumer leaks can happen it is good to limit the number of consumers that can be active on
each channel. This can be configured in [rabbitmq.conf](https://www.rabbitmq.com/docs/configure#config-file) using the setting `consumer_max_per_channel`:

```ini
consumer_max_per_channel = 100
```

## Exclusivity [​](https://www.rabbitmq.com/docs/consumers\#exclusivity "Direct link to Exclusivity")

For [Classic Queues only](https://www.rabbitmq.com/docs/quorum-queues#feature-matrix), when registering a consumer
with an AMQP 0-9-1 client, the `exclusive` flag of the `basic.consume` method can be
set to true to request the consumer to be the only one on the target queue. The call
succeeds only if there's no consumer already registered to the queue at that time.
This allows to make sure only one consumer at a time consumes from the queue.

If the exclusive consumer is cancelled or dies, this is the application
responsibility to register a new one to keep on consuming from the queue.

If exclusive consumption **and** consumption continuity are required,
use [single active consumer](https://www.rabbitmq.com/docs/consumers#single-active-consumer).

important

[Quorum queues](https://www.rabbitmq.com/docs/quorum-queues) will ignore the `exclusive` flag on the `basic.consume` frame.
With quorum queues, use [single active consumer](https://www.rabbitmq.com/docs/consumers#single-active-consumer) instead.

## Single Active Consumer [​](https://www.rabbitmq.com/docs/consumers\#single-active-consumer "Direct link to Single Active Consumer")

Single Active Consumer (SAC) makes it possible to only have one consumer
at a time consuming from a queue. If the active consumer is cancelled or
disconnects, another registered consumer takes its place. Consuming with only one consumer
is useful when messages must be consumed and processed in the same order
they arrive in the queue (see [Preserving message order](https://www.rabbitmq.com/docs/queues#preserving-message-order)).

A typical sequence of events would be the following:

- A queue is declared and some consumers register to it at roughly the
same time.
- The very first registered consumer becomes the _single active consumer_:
messages are dispatched to it and the other consumers are ignored.
- If the queue is a quorum queue, and a new consumer registers with a higher priority,
then the queue stops delivering messages to the current active consumer. When all
messages are acknowledged, the new consumer becomes the active consumer.
- When the single active consumer is cancelled for some reason or simply dies,
another consumer is selected as the active one. In other words, the queue fails over
automatically to another consumer. Refer to [SAC Behavior](https://www.rabbitmq.com/docs/consumers#initial-sac-selection) for more details
about how the new consumer is selected.

Note that without the single active consumer feature enabled, messages
would be dispatched to all consumers using round-robin.

info

This section covers the Single Active Consumer feature available to AMQP 1.0 and AMQP 0-9-1 clients on classic and quorum queues.
It is meaningfully different from the [Single Active Consumer feature for streams](https://www.rabbitmq.com/docs/streams#single-active-consumer).

An attempt to enable SAC using an AMQP 0-9-1 client on a stream **will not work**.
To use SAC on a stream, a [native RabbitMQ stream protocol client](https://rabbitmq.github.io/rabbitmq-stream-java-client/snapshot/htmlsingle/#single-active-consumer)
must be used.

### Enabling Single Active Consumer on Quorum and Classic Queues [​](https://www.rabbitmq.com/docs/consumers\#enabling-single-active-consumer-on-quorum-and-classic-queues "Direct link to Enabling Single Active Consumer on Quorum and Classic Queues")

SAC can be enabled when declaring a queue, with the
`x-single-active-consumer` argument set to `true`.

- AMQP 1.0 (Java)
- AMQP 0-9-1 (Java)

Using the [RabbitMQ AMQP 1.0 Java client](https://github.com/rabbitmq/rabbitmq-amqp-java-client):

```java
connection.management().queue()

    .name("my-queue")

    .quorum()

    .queue()

    .singleActiveConsumer(true)

    .declare();
```

```java
Channel ch = ...;

Map<String, Object> arguments = new HashMap<String, Object>();

arguments.put("x-single-active-consumer", true);

ch.queueDeclare("my-queue", false, false, false, arguments);
```

### Difference from Exclusive Consumers [​](https://www.rabbitmq.com/docs/consumers\#difference-from-exclusive-consumers "Direct link to Difference from Exclusive Consumers")

Compared to [AMQP 0-9-1 exclusive consumer](https://www.rabbitmq.com/docs/consumers#exclusivity), single active consumer puts
less pressure on the application side to maintain consumption continuity.
Consumers just need to be registered and failover is handled automatically,
there's no need to detect the active consumer failure and to register
a new consumer.

### Determining Which Consumer is Currently Active [​](https://www.rabbitmq.com/docs/consumers\#determining-which-consumer-is-currently-active "Direct link to Determining Which Consumer is Currently Active")

The [management UI](https://www.rabbitmq.com/docs/management) and the
[CLI](https://www.rabbitmq.com/docs/man/rabbitmqctl.8) can [report](https://www.rabbitmq.com/docs/consumers#active-consumer) which consumer is the current
active one on a queue where the feature is enabled.

### Consumer Activity Notification for AMQP 1.0 Clients [​](https://www.rabbitmq.com/docs/consumers\#sac-activity-notification "Direct link to Consumer Activity Notification for AMQP 1.0 Clients")

AMQP 1.0 clients consuming from a quorum queue receive a [link state property](https://www.rabbitmq.com/docs/amqp#link-state-properties) called `rabbitmq:active` in the AMQP 1.0 [flow](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-transport-v1.0-os.html#type-flow) frame.
When SAC is enabled, this property indicates whether the consumer is the active one (`true`) or inactive and waiting (`false`).
When SAC is not enabled, the value is always `true`.

Each consumer receives this property:

- After granting credit for the first time (initial status)
- Whenever its activity status changes (only relevant when SAC is enabled)

This feature is specific to AMQP 1.0 and not available for AMQP 0-9-1 clients.

The following Erlang example using the [amqp10\_client](https://github.com/rabbitmq/rabbitmq-server/tree/main/deps/amqp10_client) library demonstrates receiving activity status notifications:

```erlang
%% Attach a receiver opting in to receive notifications on link state property changes.

{ok, Receiver} = amqp10_client:attach_link(

                   Session,

                   #{name => <<"my-receiver">>,

                     role => {receiver, #{address => <<"/queues/my-queue">>}, self()},

                     snd_settle_mode => unsettled,

                     notify_when_state_properties_changed => true}),

receive {amqp10_event, {link, Receiver, attached}} -> ok

end,

ok = amqp10_client:flow_link_credit(Receiver, 10, never),

%% Wait for the initial activity status notification.

receive {amqp10_event,

            {link, Receiver,

                {state_properties, #{<<"rabbitmq:active">> := Active}}}} ->

        io:format("Consumer active: ~p~n", [Active])

end.
```

### Initial SAC Selection [​](https://www.rabbitmq.com/docs/consumers\#initial-sac-selection "Direct link to Initial SAC Selection")

When used with a classic queue, the initial active consumer is picked randomly, even if [consumer priorities](https://www.rabbitmq.com/docs/consumers#priority) are in use.

If the queue is a quorum queue, and a new consumer registers with a higher priority, then the queue stops delivering messages
to the current active consumer. When all messages are acknowledged, the new consumer becomes the active consumer.

Learn more about this behaviour [in the blog post announcing this feature](https://www.rabbitmq.com/blog/2024/08/28/quorum-queues-in-4.0#consumer-priorities-combined-with-single-active-consumer).

### SAC and Exclusive Consumers are Mutually Exclusive [​](https://www.rabbitmq.com/docs/consumers\#sac-and-exclusive-consumers-are-mutually-exclusive "Direct link to SAC and Exclusive Consumers are Mutually Exclusive")

Trying to register an exclusive consumer with SAC will result in
an error. SAC by definition assumes that there will be multiple consumers online.

### SAC Cannot Be Enabled with a Policy [​](https://www.rabbitmq.com/docs/consumers\#sac-cannot-be-enabled-with-a-policy "Direct link to SAC Cannot Be Enabled with a Policy")

The Single Active Consumer feature cannot be enabled with a [policy](https://www.rabbitmq.com/docs/policies).
Since policies in RabbitMQ are dynamic by nature, they can
come and go, enabling and disabling the features they declare. Imagine suddenly
disabling single active consumer on a queue: the broker would start sending messages to
inactive consumers and messages would be processed in parallel, exactly
the opposite of what single active consumer is trying to achieve. As the semantics
of single active consumer do not play well with the dynamic nature of policies,
this feature can be enabled only when declaring a queue, with queue arguments.

## Consumer Activity [​](https://www.rabbitmq.com/docs/consumers\#active-consumer "Direct link to Consumer Activity")

The [management UI](https://www.rabbitmq.com/docs/management) and the `list_consumers` [CLI](https://www.rabbitmq.com/docs/man/rabbitmqctl.8#list_consumers) command report an `active`
flag for consumers. The value of this flag depends on several parameters.

- for classic queues, the flag is always `true`
when [single active consumer](https://www.rabbitmq.com/docs/consumers#single-active-consumer) is not enabled.
- for quorum queues and when [single active consumer](https://www.rabbitmq.com/docs/consumers#single-active-consumer) is not enabled,
the flag is `true` by default and is set to `false` if the node
the consumer is connected to is suspected to be down.
- if [single active consumer](https://www.rabbitmq.com/docs/consumers#single-active-consumer) is enabled,
the flag is set to `true` only for the current single active consumer,
other consumers on the queue are waiting to be promoted if the active
one goes away, so their active is set to `false`.

## Priority [​](https://www.rabbitmq.com/docs/consumers\#priority "Direct link to Priority")

Normally, active consumers connected to a queue receive messages from it in a round-robin fashion.

Consumer priorities allow you to ensure that high priority consumers receive messages while they are active,
with messages only going to lower priority consumers when the high priority consumers are blocked, e.g.
by effective [prefetch](https://www.rabbitmq.com/docs/consumers#prefetch) setting.

When consumer priorities are in use, messages are delivered round-robin if multiple active consumers
exist with the same high priority.

Consumer priorities are covered in a [separate guide](https://www.rabbitmq.com/docs/consumer-priority).

## Exception Handling [​](https://www.rabbitmq.com/docs/consumers\#exceptions "Direct link to Exception Handling")

Consumers are expected to handle any exceptions that arise during handling of deliveries
or any other consumer operations. Such exceptions should be logged, collected and ignored.

If a consumer cannot process deliveries due to a dependency not being available or similar reasons
it should clearly log so and cancel itself until it is capable of processing deliveries again.
This will make the consumer's unavailability visible to RabbitMQ and [monitoring systems](https://www.rabbitmq.com/docs/monitoring).

## Concurrency Considerations [​](https://www.rabbitmq.com/docs/consumers\#concurrency "Direct link to Concurrency Considerations")

Consumer concurrency is primarily a matter of client library implementation details and application
configuration. With most client libraries (e.g. Java, .NET, Go, Erlang) deliveries are dispatched to a thread pool (or similar) that handles
all asynchronous consumer operations. The pool usually has controllable degree of concurrency.

Java and .NET clients guarantee that deliveries on a single channel will be dispatched in the same order there
were received regardless of the degree of concurrency. Note that once dispatched, concurrent
processing of deliveries will result in a natural race condition between the threads doing the processing.

Certain clients (e.g. Bunny) and frameworks might choose to limit consumer dispatch pool to a single thread (or similar)
to avoid a natural race condition when deliveries are processed concurrently. Some applications depend on strictly sequential
processing of deliveries and thus must use concurrency factor of one or handle synchronisation
in their own code. Applications that can process deliveries concurrently can use the degree of concurrency up to
the number of cores available to them.

### Queue Parallelism Considerations [​](https://www.rabbitmq.com/docs/consumers\#queue-parallelism-considerations "Direct link to Queue Parallelism Considerations")

A single RabbitMQ queue is [bounded to a single core](https://www.rabbitmq.com/docs/queues#runtime-characteristics). Use more than
one queue to improve CPU utilisation on the nodes. Plugins such as [sharding](https://github.com/rabbitmq/rabbitmq-sharding)
and [consistent hash exchange](https://github.com/rabbitmq/rabbitmq-consistent-hash-exchange) can be helpful
in increasing parallelism.

[Edit this page](https://github.com/rabbitmq/rabbitmq-website/tree/main/versioned_docs/version-4.3/consumers.md)

[Previous\\
\\
Exchanges](https://www.rabbitmq.com/docs/exchanges) [Next\\
\\
Consumer Cancellation Notifications](https://www.rabbitmq.com/docs/consumer-cancel)

- [Overview](https://www.rabbitmq.com/docs/consumers#overview)
- [Terminology](https://www.rabbitmq.com/docs/consumers#terminology)
- [The Basics](https://www.rabbitmq.com/docs/consumers#basics)
  - [Consumer Tags](https://www.rabbitmq.com/docs/consumers#consumer-tags)
  - [Consumer Lifecycle](https://www.rabbitmq.com/docs/consumers#consumer-lifecycle)
  - [Connection Recovery](https://www.rabbitmq.com/docs/consumers#connection-recovery)
- [Registering a Consumer (Subscribing, "Push API")](https://www.rabbitmq.com/docs/consumers#subscribing)
  - [Java Client](https://www.rabbitmq.com/docs/consumers#java-client)
  - [.NET Client](https://www.rabbitmq.com/docs/consumers#net-client)
- [Message Properties and Delivery Metadata](https://www.rabbitmq.com/docs/consumers#message-properties)
  - [Message Types](https://www.rabbitmq.com/docs/consumers#message-types)
  - [Content Type and Encoding](https://www.rabbitmq.com/docs/consumers#content-type-and-encoding)
- [Acknowledgement Modes](https://www.rabbitmq.com/docs/consumers#acknowledgement-modes)
- [Limiting Simultaneous Deliveries with Prefetch](https://www.rabbitmq.com/docs/consumers#prefetch)
- [The Consumer Capacity Metric](https://www.rabbitmq.com/docs/consumers#metrics-capacity)
- [Cancelling a Consumer (Unsubscribing)](https://www.rabbitmq.com/docs/consumers#unsubscribing)
  - [Java Client](https://www.rabbitmq.com/docs/consumers#java-client-1)
  - [.NET Client](https://www.rabbitmq.com/docs/consumers#net-client-1)
- [Polling for Individual Messages ("Pull API")](https://www.rabbitmq.com/docs/consumers#polling)
  - [Java Client](https://www.rabbitmq.com/docs/consumers#java-client-2)
  - [.NET Client](https://www.rabbitmq.com/docs/consumers#net-client-2)
- [Delivery Acknowledgement Timeout](https://www.rabbitmq.com/docs/consumers#acknowledgement-timeout)
  - [How it works](https://www.rabbitmq.com/docs/consumers#how-it-works)
  - [Per-node Configuration](https://www.rabbitmq.com/docs/consumers#per-node-configuration)
  - [Per-queue Configuration](https://www.rabbitmq.com/docs/consumers#per-queue-configuration)
- [Limiting the number of Consumers per channel](https://www.rabbitmq.com/docs/consumers#limiting-the-number-of-consumers-per-channel)
- [Exclusivity](https://www.rabbitmq.com/docs/consumers#exclusivity)
- [Single Active Consumer](https://www.rabbitmq.com/docs/consumers#single-active-consumer)
  - [Enabling Single Active Consumer on Quorum and Classic Queues](https://www.rabbitmq.com/docs/consumers#enabling-single-active-consumer-on-quorum-and-classic-queues)
  - [Difference from Exclusive Consumers](https://www.rabbitmq.com/docs/consumers#difference-from-exclusive-consumers)
  - [Determining Which Consumer is Currently Active](https://www.rabbitmq.com/docs/consumers#determining-which-consumer-is-currently-active)
  - [Consumer Activity Notification for AMQP 1.0 Clients](https://www.rabbitmq.com/docs/consumers#sac-activity-notification)
  - [Initial SAC Selection](https://www.rabbitmq.com/docs/consumers#initial-sac-selection)
  - [SAC and Exclusive Consumers are Mutually Exclusive](https://www.rabbitmq.com/docs/consumers#sac-and-exclusive-consumers-are-mutually-exclusive)
  - [SAC Cannot Be Enabled with a Policy](https://www.rabbitmq.com/docs/consumers#sac-cannot-be-enabled-with-a-policy)
- [Consumer Activity](https://www.rabbitmq.com/docs/consumers#active-consumer)
- [Priority](https://www.rabbitmq.com/docs/consumers#priority)
- [Exception Handling](https://www.rabbitmq.com/docs/consumers#exceptions)
- [Concurrency Considerations](https://www.rabbitmq.com/docs/consumers#concurrency)
  - [Queue Parallelism Considerations](https://www.rabbitmq.com/docs/consumers#queue-parallelism-considerations)

Learn about RabbitMQ

- [Getting Started](https://www.rabbitmq.com/tutorials)
- [Documentation](https://www.rabbitmq.com/docs)
- [Blog](https://www.rabbitmq.com/blog)

Reach out to the RabbitMQ team

- [GitHub](https://github.com/rabbitmq)
- [GitHub Discussions](https://github.com/rabbitmq/rabbitmq-server/discussions)
- [Long Term Commercial Support](https://www.rabbitmq.com/contact?utm_source=rmq_release-information_tableheader&utm_medium=rmq_website&utm_campaign=tanzu)
- [Contact Us](https://www.rabbitmq.com/contact)
- [Discord](https://www.rabbitmq.com/discord)

Broadcom

- [VMware Tanzu](https://tanzu.vmware.com/)
- [Terms of Use](https://www.vmware.com/help/legal.html)
- [Privacy](https://www.vmware.com/help/privacy.html)
- [Trademark Guidelines](https://www.rabbitmq.com/trademark-guidelines)
- [Your California Privacy Rights](https://www.vmware.com/help/privacy/california-privacy-rights.html)
- Cookie Settings

Copyright © 2005-2026 Broadcom. All Rights Reserved. The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.