[Skip to main content](https://www.rabbitmq.com/docs/queues#__docusaurus_skipToContent_fallback)

🎉️ [**RabbitMQ 4.3** is out!](https://www.rabbitmq.com/blog/2026/04/23/rabbitmq-4.3-release) 🥳️

[![RabbitMQ](https://www.rabbitmq.com/img/rabbitmq-logo-by-tanzu.svg)](https://www.rabbitmq.com/)[Getting Started](https://www.rabbitmq.com/tutorials) [Docs](https://www.rabbitmq.com/docs) [Blog](https://www.rabbitmq.com/blog) [Support](https://www.rabbitmq.com/contact) [Commercial Features](https://www.rabbitmq.com/commercial-features)

[4.3](https://www.rabbitmq.com/docs/queues)

- **Release series**
- [Next](https://www.rabbitmq.com/docs/next/queues)
- [4.3](https://www.rabbitmq.com/docs/queues)
- [4.2](https://www.rabbitmq.com/docs/4.2/queues)
- [4.1](https://www.rabbitmq.com/docs/4.1/queues)
- [4.0](https://www.rabbitmq.com/docs/4.0/queues)
- [3.13](https://www.rabbitmq.com/docs/3.13/queues)

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

  - [Queues](https://www.rabbitmq.com/docs/queues)

    - [Quorum Queues](https://www.rabbitmq.com/docs/quorum-queues)
    - [Classic Queues](https://www.rabbitmq.com/docs/classic-queues)
    - [Time-to-Live and Expiration](https://www.rabbitmq.com/docs/ttl)
    - [Queue Length](https://www.rabbitmq.com/docs/maxlength)
    - [Lazy Queues](https://www.rabbitmq.com/docs/lazy-queues)
    - [Dead Lettering](https://www.rabbitmq.com/docs/dlx)
    - [Priority Queues](https://www.rabbitmq.com/docs/priority)
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
- Queues

Version: 4.3

On this page

# Queues

## What is a Queue? [​](https://www.rabbitmq.com/docs/queues\#what-is-a-queue "Direct link to What is a Queue?")

A queue in RabbitMQ is an ordered collection of messages. Messages are enqueued and dequeued (delivered to consumers) in a ( [FIFO ("first in, first out")](https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)) manner.

To define a [queue](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)) in generic terms, it is a sequential data structure with two primary operations: an item can be **enqueued** (added) at the tail and **dequeued** (consumed) from the head.

Queues play a major role in the messaging technology space. Many messaging protocols and tools assume that [publishers](https://www.rabbitmq.com/docs/publishers) and [consumers](https://www.rabbitmq.com/docs/consumers) communicate using a queue-like storage mechanism.

Many features in a messaging system are related to queues. Some RabbitMQ queue features such as priorities and [requeueing](https://www.rabbitmq.com/docs/confirms) by consumers can affect the ordering as observed by consumers.

The information in this topic includes an overview of queues in RabbitMQ and also links out to other topics so you can learn more about using queues in RabbitMQ.

info

In addition to queues, modern RabbitMQ versions support two alternative data structures
called [streams and super streams](https://www.rabbitmq.com/docs/streams).

This guide primarily covers queues in the context of the [AMQP 0-9-1](https://www.rabbitmq.com/tutorials/amqp-concepts) protocol, however, much of the content is applicable to other supported protocols.

Some protocols (for example: STOMP and MQTT) are based around the idea of topics.
For these protocols, queues act as a data accumulation buffer for consumers.
However, it is still important to understand the role queues play
because many features still operate at the queue level, even for those protocols.

[Streams](https://www.rabbitmq.com/docs/streams) is an alternative messaging data structure available in RabbitMQ. Streams provide different features from queues.

The information about RabbitMQ queues covered in this topic includes:

- [Queue Names](https://www.rabbitmq.com/docs/queues#names)
- [Queue Properties](https://www.rabbitmq.com/docs/queues#properties)
- [Message Ordering](https://www.rabbitmq.com/docs/queues#message-ordering) in a queue
- [Queue Durability](https://www.rabbitmq.com/docs/queues#durability) and how it relates to message persistence
- [Replicated Queue Types](https://www.rabbitmq.com/docs/queues#distributed)
- [Transparent Operation Routing](https://www.rabbitmq.com/docs/queues#transparent-operation-routing) for clients
- [Temporary](https://www.rabbitmq.com/docs/queues#temporary-queues) and [exclusive](https://www.rabbitmq.com/docs/queues#exclusive-queues) queues
- [Runtime Resource](https://www.rabbitmq.com/docs/queues#runtime-characteristics) usage by queue replicas
- [Optional Queue Arguments](https://www.rabbitmq.com/docs/queues#optional-arguments) ("x-arguments")
- Declaration and [Property Equivalence](https://www.rabbitmq.com/docs/queues#property-equivalence)
- [Queue Metrics](https://www.rabbitmq.com/docs/queues#metrics)
- [TTL](https://www.rabbitmq.com/docs/queues#ttl-and-limits) and length limits
- [Priority Queues](https://www.rabbitmq.com/docs/queues#priorities)

For topics related to consumers, see the [Consumers guide](https://www.rabbitmq.com/docs/consumers).
[Classic queues](https://www.rabbitmq.com/docs/classic-queues), [quorum queues](https://www.rabbitmq.com/docs/quorum-queues)
and [streams](https://www.rabbitmq.com/docs/streams) also have dedicated guides.

## Queue Names [​](https://www.rabbitmq.com/docs/queues\#names "Direct link to Queue Names")

Queues have names so that applications can reference them.

Applications may pick queue names or ask the broker to [generate a name](https://www.rabbitmq.com/docs/queues#server-named-queues)
for them. Queue names may be up to 255 bytes of UTF-8 characters.

Queue names starting with "amq." are reserved for internal
use by the broker. Attempts to declare a queue with a name that
violates this rule will result in a [channel-level exception](https://www.rabbitmq.com/docs/channels)
with reply code 403 (`ACCESS_REFUSED`).

### Server-named Queues [​](https://www.rabbitmq.com/docs/queues\#server-named-queues "Direct link to Server-named Queues")

In AMQP 0-9-1, the broker can generate a unique queue name on behalf of
an app. To use this feature, pass an empty string as the queue name
argument: the same generated name may be obtained by subsequent
methods in the same channel by using the empty string where a queue
name is expected. This works because the channel remembers the last
server-generated queue name.

Server-named queues are meant to be used for state that is transient
in nature and specific to a particular consumer (application instance).
Applications can share such names in message metadata to let other applications respond
to them (as demonstrated in [tutorial six](https://www.rabbitmq.com/tutorials)).
Otherwise, the names of server-named queues should be known and used only by the
declaring application instance. The instance should also set up appropriate
bindings (routing) for the queue, so that publishers can use well-known
[exchanges](https://www.rabbitmq.com/docs/exchanges) instead of the server-generated queue name directly.

## Queue Properties [​](https://www.rabbitmq.com/docs/queues\#properties "Direct link to Queue Properties")

Queues have properties that define how they behave. There is a set
of mandatory properties and a map of optional ones:

- Name
- Durable (the queue will survive a broker restart)
- Exclusive (used by only one connection and the queue will be deleted when that connection closes)
- Auto-delete (queue that has had at least one consumer is deleted when last consumer unsubscribes)
- Arguments (optional; used by plugins and broker-specific features such as message TTL, queue length limit, etc)

important

Note that **not all property combination make sense**. For example,
exclusive queues should almost always be [server-named](https://www.rabbitmq.com/docs/queues#server-named-queues).

Such queues are supposed to be used for client-specific or connection (session)-specific data.

When exclusive queues use well-known (static) names, in case of client disconnection
and immediate reconnection there will be a natural race condition between RabbitMQ nodes
that will delete such queues and recovering clients that will try to re-declare them.
This can result in client-side connection recovery failure or exceptions, and create unnecessary confusion
or affect application availability.

### Declaration and Property Equivalence [​](https://www.rabbitmq.com/docs/queues\#property-equivalence "Direct link to Declaration and Property Equivalence")

tip

Specifically for the queue type property, the property equivalence
check can be relaxed. Alternatively, a default queue type (DQT) can be configured.

Before a queue can be used it has to be declared. Declaring
a queue will cause it to be created if it does not already
exist. The declaration will have no effect if the queue does
already exist and its attributes are the same as those in the
declaration. When the existing queue attributes are not the
same as those in the declaration a channel-level exception
with code 406 (`PRECONDITION_FAILED`) will be raised.

Specifically for the queue type property, the property equivalence
checks can be relaxed or configured to use a default.

See the [Virtual Hosts guide](https://www.rabbitmq.com/docs/vhosts#default-queue-type) to learn more.

### Optional Arguments [​](https://www.rabbitmq.com/docs/queues\#optional-arguments "Direct link to Optional Arguments")

Optional queue arguments, also known as "x-arguments" because of their
field name in the AMQP 0-9-1 protocol, is a map (dictionary) of arbitrary key/value
pairs that can be provided by clients when a queue is declared.

The map is used by various features and plugins such as

- Queue type (e.g. [quorum](https://www.rabbitmq.com/docs/quorum-queues) or [classic](https://www.rabbitmq.com/docs/classic-queues))
- [Message and queue TTL](https://www.rabbitmq.com/docs/ttl)
- [Queue length limit](https://www.rabbitmq.com/docs/maxlength)
- Quorum queue [redelivery limit](https://www.rabbitmq.com/docs/quorum-queues#poison-message-handling)
- Max number of [priorities](https://www.rabbitmq.com/docs/priority) of a classic queue

and so on.

The same idea is also used with other protocol operations, for example, when
registering a consumer:

- [Consumer priorities](https://www.rabbitmq.com/docs/consumer-priority)

Some optional arguments are set at queue declaration time and remain immutable over the entire
lifetime of the queue. Others can be dynamically changed after queue declaration via [policies](https://www.rabbitmq.com/docs/policies).

tip

For keys that can be set via [policies](https://www.rabbitmq.com/docs/policies), always first
consider using a policy instead of setting these values in application code

For example, [queue type](https://www.rabbitmq.com/docs/quorum-queues) (`x-queue-type`) and max number
of [queue priorities](https://www.rabbitmq.com/docs/priority) (`x-max-priority`) must be set at queue declaration time
and cannot be changed after that.

Optional queue arguments can be set differently:

- To groups of queues using [policies](https://www.rabbitmq.com/docs/policies) (recommended)
- On a per-queue basis when a queue is declared by a client
- For the `x-queue-type` argument, [using a default queue type](https://www.rabbitmq.com/docs/vhosts#default-queue-type)

The former option is more flexible, non-intrusive, does not require application
modifications and redeployments. Therefore it is highly recommended for most users.
Note that some optional arguments such as queue type or max number of priorities can
only be provided by clients because they cannot be dynamically changed and must be known
at declaration time.

The way optional arguments are provided by clients varies from client library
to client library but is usually an argument next to the `durable`,
`auto_delete` and other arguments of the function (method) that
declares queues.

### Optional Arguments and Policy-Defined Key Precedence [​](https://www.rabbitmq.com/docs/queues\#optional-arguments-precedence "Direct link to Optional Arguments and Policy-Defined Key Precedence")

When the same key is provided by both client-provided `x-arguments` and by a [policy](https://www.rabbitmq.com/docs/policies),
the former take precedence.

However, if an [operator policy](https://www.rabbitmq.com/docs/policies#operator-policies) is also used, that will take precedence over the client-provided
arguments, too. Operator policies are a protection mechanism and override client-provided values
and user policy values.

For numerical values such as [maximum queue length](https://www.rabbitmq.com/docs/maxlength) or [TTL](https://www.rabbitmq.com/docs/ttl),
the lower value of the two will be used. If an application needs or chooses to use a lower value,
that will be allowed by an operator policy. A value higher than that defined in the operator policy,
however, cannot be used.

Use operator policies to introduce guardrails for application-controlled parameters related
to resource use (e.g. peak disk space usage).

## Message ordering [​](https://www.rabbitmq.com/docs/queues\#message-ordering "Direct link to Message ordering")

Message ordering matters when there are causal dependencies between messages.
RabbitMQ tries to preserve the order of messages.

A queue is an ordered collection of messages providing [FIFO](https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)) semantics.
When publishing on a single [channel](https://www.rabbitmq.com/docs/channels), messages are enqueued in publishing order in every queue they are routed to.
When publishing happens on multiple connections or channels, their sequences of messages will be routed concurrently and interleaved.
Delivery from a queue to consumers proceeds in enqueue order (unless below events occur).

### When messages can be reordered [​](https://www.rabbitmq.com/docs/queues\#when-messages-can-be-reordered "Direct link to When messages can be reordered")

Even if RabbitMQ aims to preserve order, the following will change effective delivery order:

1. **Message [priorities](https://www.rabbitmq.com/docs/priority)**:
higher-priority messages may be delivered before lower-priority messages.
2. **Multiple active consumers on the same queue**:
the broker still dequeues in FIFO, but any redelivery can change order.
Redelivery happens when consumers [negatively acknowledge](https://www.rabbitmq.com/docs/confirms#consumer-nacks-requeue) with requeue or a channel/session closes with unacked messages.
Redelivered messages are flagged (AMQP 1.0: `first-acquirer=false`, AMQP 0-9-1: `redelivered=true`).

### Preserving message order [​](https://www.rabbitmq.com/docs/queues\#preserving-message-order "Direct link to Preserving message order")

To preserve message order in RabbitMQ you have two options.

#### **1.) Use a [stream](https://www.rabbitmq.com/docs/streams)** [​](https://www.rabbitmq.com/docs/queues\#1-use-a-stream "Direct link to 1-use-a-stream")

A stream is an immutable append-only log. Each message gets its offset assigned at publish-time. This offset never changes.

Multiple consumers can process messages from the same stream concurrently without affecting ordering.
With [stream filtering](https://www.rabbitmq.com/docs/stream-filtering), you can split work so that different consumers process disjoint subsets of the stream while preserving order within each subset.

#### **2.) Use a queue with a single active consumer** [​](https://www.rabbitmq.com/docs/queues\#2-use-a-queue-with-a-single-active-consumer "Direct link to 2-use-a-queue-with-a-single-active-consumer")

To keep order with queues:

- Enable [Single Active Consumer](https://www.rabbitmq.com/docs/consumers#single-active-consumer) so only one consumer receives messages at a time.
(Alternatively, run one consumer per queue.)
- If your consumers return messages to the queue, make sure they return those messages in the order they received them.
- For quorum queues, set a [delivery limit](https://www.rabbitmq.com/docs/quorum-queues#poison-message-handling).
This ensures messages are requeued at the front of the queue.
- AMQP 0-9-1: don’t use `basic.get`. When stopping a consumer, prefer closing the [channel](https://www.rabbitmq.com/docs/channels) over `basic.cancel`.
- If you need to process messages concurrently while preserving order for each domain entity (e.g. per order ID), you can use the
[`x-modulus-hash` exchange](https://www.rabbitmq.com/docs/modulus-hash-exchange) to partition messages across multiple queues, each with a single active consumer.

## Durability [​](https://www.rabbitmq.com/docs/queues\#durability "Direct link to Durability")

Queues can be durable or transient (non-durable). Metadata of a durable queue is stored on disk,
while metadata of a transient queue is stored in memory when possible.
The same distinction is made for [messages at publishing time](https://www.rabbitmq.com/docs/publishers#message-properties)
in some protocols, e.g. AMQP 0-9-1 and MQTT.

In environments and use cases where durability is important, applications
must use durable queues _and_ make sure that [publishers](https://www.rabbitmq.com/docs/publishers) mark published messages as persisted.

Durable queues will be recovered on node boot, including messages in them published as persistent.
Messages published as transient will be **discarded** during recovery, even if they were stored
in durable queues.

Transient queues will be deleted on node boot. They therefore will not survive a node restart,
by design. Messages in transient queues will also be discarded.

warning

Transient (non-durable) non-exclusive classic queues are [deprecated](https://www.rabbitmq.com/release-information/deprecated-features-list)
and cannot be declared by default starting with RabbitMQ `4.3.0`.

Please use one of the following:

- [durable queues](https://www.rabbitmq.com/docs/queues#durability)
- [non-durable exclusive queues](https://www.rabbitmq.com/docs/queues#exclusive-queues)
- durable queues [with a queue TTL](https://www.rabbitmq.com/docs/ttl#queue-ttl) (a reasonably close equivalent to non-exclusive transient queues)

To explicitly allow transient non-exclusive queues, add the following
line to `rabbitmq.conf`:

```ini
# Enables deprecated non-durable (transient) non-exclusive queues

# (disabled by default as of RabbitMQ `4.3.0`, will be removed in a later version)

deprecated_features.permit.transient_nonexcl_queues = true
```

### How to Choose [​](https://www.rabbitmq.com/docs/queues\#how-to-choose "Direct link to How to Choose")

In most other cases, durable queues are the recommended option. For [replicated queues](https://www.rabbitmq.com/docs/queues#distributed),
the only reasonable option is to use durable queues.

Throughput and latency of a queue is **not affected** by whether a queue is durable or not
in most cases. Only environments with very high queue or binding churn — that is, where queues are deleted
and re-declared hundreds or more times a second — will see latency improvements for
some operations, namely on bindings. The choice between durable and transient queues
therefore comes down to the semantics of the use case.

Temporary queues can be a reasonable choice for workloads with transient clients, for example,
temporary WebSocket connections in user interfaces, mobile applications and devices
that are expected to go offline or use switch identities. Such clients usually have
inherently transient state that should be replaced when the client reconnects.

Some queue types do not support transient queues. [Quorum queues](https://www.rabbitmq.com/docs/quorum-queues) must
be durable due to the assumptions and requirements of the underlying replication protocol,
for example.

## Temporary Queues [​](https://www.rabbitmq.com/docs/queues\#temporary-queues "Direct link to Temporary Queues")

With some workloads queues are supposed to be short lived. While clients can
delete the queues they declare before disconnection, this is not always convenient.
On top of that, client connections can fail, potentially leaving unused
resources (queues) behind.

RabbitMQ supports a number of queue properties that make sense for the data that is
transient or client-specific in nature. Some of these settings can be applied to
durable queues but not every combination makes sense.

tip

Consider using [server-generated names](https://www.rabbitmq.com/docs/queues#names) for exclusive temporary queues. Since such queues
are not meant to be shared between N consumers, using unique names makes sense.

There are three ways to make queue deleted automatically:

- Exclusive queues (covered below)
- TTLs (also covered below)
- Auto-delete queues

An auto-delete queue will be deleted when its last consumer
is cancelled (e.g. using the `basic.cancel` in AMQP 0-9-1)
or gone (closed channel or connection, or lost TCP connection with the server).

If a queue never had any consumers, for instance, when all consumption happens
[using polling](https://www.rabbitmq.com/docs/consumers#polling), it won't be automatically
deleted. For such cases, use exclusive queues or queue TTL.

warning

Transient (non-durable) non-exclusive classic queues are [deprecated](https://www.rabbitmq.com/release-information/deprecated-features-list)
and cannot be declared by default starting with RabbitMQ `4.3.0`.

Please use one of the following:

- [durable queues](https://www.rabbitmq.com/docs/queues#durability)
- [non-durable exclusive queues](https://www.rabbitmq.com/docs/queues#exclusive-queues)
- durable queues [with a queue TTL](https://www.rabbitmq.com/docs/ttl#queue-ttl) (a reasonably close equivalent to non-exclusive transient queues)

To explicitly allow transient non-exclusive queues, add the following
line to `rabbitmq.conf`:

```ini
# Enables deprecated non-durable (transient) non-exclusive queues

# (disabled by default as of RabbitMQ `4.3.0`, will be removed in a later version)

deprecated_features.permit.transient_nonexcl_queues = true
```

[Queue TTL](https://www.rabbitmq.com/docs/ttl#queue-ttl) can be used for cleanup of unused durable queues.

When RabbitMQ detects a non-durable and non-exclusive queue, it will display a deprecation
warning in the management UI.

## Exclusive (Client Connection-Specific) Queues [​](https://www.rabbitmq.com/docs/queues\#exclusive-queues "Direct link to Exclusive (Client Connection-Specific) Queues")

An exclusive queue can only be used (consumed from, purged, deleted, etc)
by its declaring connection. Such queues are by definition [temporary](https://www.rabbitmq.com/docs/queues#temporary-queues) in nature,
setting the `exclusive` property on a durable queue does not make logical sense
since such queue cannot outlive its declaring connection, and thus cannot satisfy its durability
property in case of a node restart.

Queues declared as exclusive will always be declared as classic queues: exclusive [quorum queues](https://www.rabbitmq.com/docs/quorum-queues)
and [streams](https://www.rabbitmq.com/docs/streams) do not make logical sense as their lifetimes would be bound to the lifetime
of a specific client connection and thus a single node (or application instance).

tip

Consider using [server-generated names](https://www.rabbitmq.com/docs/queues#names) for exclusive queues. Since such queues
cannot be shared between N consumers, using server-generated names makes most sense.

An attempt to use an exclusive queue from
a different connection will result in a channel-level exception
`RESOURCE_LOCKED` with an error message that says
`cannot obtain exclusive access to locked queue`.

Exclusive queues are deleted when their declaring connection is closed
or gone (e.g. due to underlying TCP connection loss). They therefore
are only suitable for client-specific transient state.

It is common to make exclusive queues server-named.

Exclusive queues are declared on the "client-local" node (the node that the client declaring
the queue is connected to), regardless of the `queue_leader_locator` value.

## Replicated and Distributed Queues [​](https://www.rabbitmq.com/docs/queues\#distributed "Direct link to Replicated and Distributed Queues")

[Quorum queues](https://www.rabbitmq.com/docs/quorum-queues) is replicated, data safety and consistency-oriented queue type.
Classic queues historically supported replication but this feature was **removed** for RabbitMQ 4.x.

Any client [connection](https://www.rabbitmq.com/docs/connections) can use any queue, whether it is replicated or not,
regardless of the node the queue replica is hosted on or the node the client is connected to.
RabbitMQ will route the operations to the appropriate node transparently for clients.

For example, in a cluster with nodes A, B and C, a client connected to node A can consume
from a queue Q hosted on B, while a client connected to node C can publish in a way that routes
messages to queue Q.

Client libraries or applications **may** choose to connect to the node that hosts the current leader replica of a specific queue
for improved data locality.

This general rule applies to all messaging data types supported by RabbitMQ except for one.
[Streams](https://www.rabbitmq.com/docs/streams) are an exception to this rule, and require clients, regardless of the protocol they use, to connect to a node
that hosts a replica (a leader of rollower) of the target stream.
Consequently, RabbitMQ Stream protocol clients will [connect to multiple nodes in parallel](https://www.rabbitmq.com/docs/stream-connections).

Queues can also be [federated](https://www.rabbitmq.com/docs/federated-queues)
across loosely coupled nodes or clusters.

Note that intra-cluster replication and federation
are orthogonal features and should not be considered direct alternatives.

[Streams](https://www.rabbitmq.com/docs/streams) is another replicated data structure supported by RabbitMQ, with a different
set of supported operations and features.

## Non-Replicated Queues and Client Operations [​](https://www.rabbitmq.com/docs/queues\#transparent-operation-routing "Direct link to Non-Replicated Queues and Client Operations")

Any client [connection](https://www.rabbitmq.com/docs/connections) can use any queue, including non-replicated (single replica) queues,
regardless of the node the queue replica is hosted on or the node the client is connected to.
RabbitMQ will route the operations to the appropriate node transparently for clients.

For example, in a cluster with nodes A, B and C, a client connected to node A can consume
from a queue Q hosted on B, while a client connected to node C can publish in a way that routes
messages to queue Q.

Client libraries or applications **may** choose to connect to the node that hosts the current leader replica of a specific queue
for improved data locality.

This general rule applies to all messaging data types supported by RabbitMQ except for one.
[Streams](https://www.rabbitmq.com/docs/streams) are an exception to this rule, and require clients, regardless of the protocol they use, to connect to a node
that hosts a replica (a leader of rollower) of the target stream.
Consequently, RabbitMQ Stream protocol clients will [connect to multiple nodes in parallel](https://www.rabbitmq.com/docs/stream-connections).

## Time-to-Live and Length Limit [​](https://www.rabbitmq.com/docs/queues\#ttl-and-limits "Direct link to Time-to-Live and Length Limit")

Queues can have their length [limited](https://www.rabbitmq.com/docs/maxlength).
Queues and messages can have a [TTL](https://www.rabbitmq.com/docs/ttl).

Both features can be used for data expiration and as a way of limiting
how many resources (RAM, disk space) a queue can use at most, e.g.
when consumers go offline or their throughput falls behind publishers.

## In Durable and In-Memory Storage [​](https://www.rabbitmq.com/docs/queues\#storage "Direct link to In Durable and In-Memory Storage")

In modern RabbitMQ versions, quorum queues and classic queues v2 alike actively move data to disk and only keep a relatively
small working set in memory.

In some protocols (e.g. AMQP 0-9-1) clients can publish messages as persistent or transient. Transient
messages will still be stored on disk but will be discarded during the next node restart.

In AMQP 0-9-1, this is done
via a message property (`delivery_mode` or, in some clients, `persistent`).

Other relevant guides on the topic are [Quorum Queues](https://www.rabbitmq.com/docs/quorum-queues#resource-use), [Streams](https://www.rabbitmq.com/docs/streams#feature-comparison),
[Reasoning About Memory Usage](https://www.rabbitmq.com/docs/memory-use), [Alarms](https://www.rabbitmq.com/docs/alarms), [Memory Alarms](https://www.rabbitmq.com/docs/memory), [Free Disk Space Alarms](https://www.rabbitmq.com/docs/disk-alarms),
[Deployment Guidelines](https://www.rabbitmq.com/docs/production-checklist), and [Message Store Configuration](https://www.rabbitmq.com/docs/persistence-conf).

## Priorities [​](https://www.rabbitmq.com/docs/queues\#priorities "Direct link to Priorities")

Queues can have 0 or more [priorities](https://www.rabbitmq.com/docs/priority). This feature is opt-in:
only queues that have maximum number of priorities configured via an optional argument
(see above) will do prioritisation.

Publishers specify message priority using the `priority` field
in message properties.

If priority queues are desired, we recommend using between 1 and 10.
Currently using more priorities will consume more resources (Erlang processes).

## CPU Utilisation and Parallelism Considerations [​](https://www.rabbitmq.com/docs/queues\#runtime-characteristics "Direct link to CPU Utilisation and Parallelism Considerations")

Currently a single queue replica (whether leader or follower) is limited to a single CPU core
on its hot code path. This design therefore assumes that most systems
use multiple queues in practice.

danger

A single queue is generally considered to be an anti-pattern, and not just for resource utilisation
reasons.

For workloads that push queue throughput to the limits, consider using [streams or partitioned streams](https://www.rabbitmq.com/docs/streams)
with a [RabbitMQ Stream Protocol client](https://www.rabbitmq.com/client-libraries/devtools).

## Metrics and Monitoring [​](https://www.rabbitmq.com/docs/queues\#metrics "Direct link to Metrics and Monitoring")

RabbitMQ collects multiple metrics about queues. Most of them are available
via [RabbitMQ HTTP API and management UI](https://www.rabbitmq.com/docs/management), which is designed for monitoring.
This includes queue length, ingress and egress rates, number of consumers, number of
messages in various states (e.g. ready for delivery or [unacknowledged](https://www.rabbitmq.com/docs/confirms)),
number of messages in RAM vs. on disk, and so on.

[rabbitmqctl](https://www.rabbitmq.com/docs/man/rabbitmqctl.8) can list queues and some basic metrics.

Runtime metrics such as VM scheduler usage, queue (Erlang) process GC activity, amount of
RAM used by the queue process, queue process mailbox length can be accessed
using the [rabbitmq-top](https://github.com/rabbitmq/rabbitmq-server/tree/main/deps/rabbitmq_top) plugin and
individual queue pages in the management UI.

## Consumers and Acknowledgements [​](https://www.rabbitmq.com/docs/queues\#consumer-acknowledgement "Direct link to Consumers and Acknowledgements")

Messages can be consumed by registering a consumer (subscription),
which means RabbitMQ will push messages to the client, or fetched
individually for protocols that support this (e.g. the `basic.get` AMQP 0-9-1 method),
similarly to HTTP GET.

Delivered messages can be [acknowledged by consumer](https://www.rabbitmq.com/docs/confirms) explicitly
or automatically as soon as a delivery is written to connection socket.

Automatic acknowledgement mode generally will provide higher throughput
rate and uses less network bandwidth. However, it offers the least number
of guarantees when it comes to [failures](https://www.rabbitmq.com/docs/reliability). As a rule of
thumb, consider using manual acknowledgement mode first.

### Prefetch and Consumer Overload [​](https://www.rabbitmq.com/docs/queues\#prefetch-consumer-overload "Direct link to Prefetch and Consumer Overload")

Automatic acknowledgement mode can also overwhelm
consumers which cannot process messages as quickly as they are delivered.
This can result in permanently growing memory usage and/or
OS swapping for the consumer process.

Manual acknowledgement mode provides a way to [set a limit on the number\\
of outstanding (unconfirmed) deliveries](https://www.rabbitmq.com/docs/confirms): channel QoS (prefetch).

Consumers using higher (several thousands or more) prefetch levels can experience
the same overload problem as consumers using automatic acknowledgements.

High number of unacknowledged messages will lead to higher memory usage by
the broker.

### Message States [​](https://www.rabbitmq.com/docs/queues\#message-states "Direct link to Message States")

Enqueued messages therefore can be in one of two states:

- Ready for delivery
- Delivered but not yet [acknowledged by consumer](https://www.rabbitmq.com/docs/confirms)

Message breakdown by state can be found in the management UI.

## Determining Queue Length [​](https://www.rabbitmq.com/docs/queues\#queue-length "Direct link to Determining Queue Length")

It is possible to determine queue length in a number of ways:

- With AMQP 0-9-1, using a property on the `queue.declare` method response
(`queue.declare-ok`). The field name is `message_count`. How it is accessed
varies from client library to client library.
- Using [RabbitMQ HTTP API](https://www.rabbitmq.com/docs/management).
- Using the [rabbitmqctl](https://www.rabbitmq.com/docs/man/rabbitmqctl.8)`list_queues` command.

Queue length is defined as the number of messages ready for delivery.

## Avoid Temporary Queues with Well-Known Names [​](https://www.rabbitmq.com/docs/queues\#shared-temporary-queues "Direct link to Avoid Temporary Queues with Well-Known Names")

A [temporary queue](https://www.rabbitmq.com/docs/queues#temporary-queues) that is not exclusive can be client named and shared
between multiple consumers. This, however, is not recommended and can lead to a race condition
between RabbitMQ node operations and client recovery.

Consider the following scenario:

- A consumer uses an auto-delete queue with a well-known names
- Client's connection fails
- Client detects it and initiates connection recovery

As the failed connection which had the only consumer on an auto-delete queue,
the queue must be deleted by RabbitMQ. This operation will take some time,
during which the consumer may recover.

Then depending on the timing of operations, the queue can be

1. Declared by the recovering client and then deleted
2. Deleted and then re-declared

In the first case, the client will try to re-register its consumer on a queue that's
been concurrently deleted, which will lead to a channel exception.

There are two solutions to this fundamental race condition:

1. Introduce a connection recovery delay. For example, several RabbitMQ client libraries
use a connection recovery delay of 5 seconds by default
2. Use server-named queues, which side steps the problem entirely since the new client connection
will use a different queue name from its predecessor

[Edit this page](https://github.com/rabbitmq/rabbitmq-website/tree/main/versioned_docs/version-4.3/queues.md)

[Previous\\
\\
Negative Acknowledgements](https://www.rabbitmq.com/docs/nack) [Next\\
\\
Quorum Queues](https://www.rabbitmq.com/docs/quorum-queues)

- [What is a Queue?](https://www.rabbitmq.com/docs/queues#what-is-a-queue)
- [Queue Names](https://www.rabbitmq.com/docs/queues#names)
  - [Server-named Queues](https://www.rabbitmq.com/docs/queues#server-named-queues)
- [Queue Properties](https://www.rabbitmq.com/docs/queues#properties)
  - [Declaration and Property Equivalence](https://www.rabbitmq.com/docs/queues#property-equivalence)
  - [Optional Arguments](https://www.rabbitmq.com/docs/queues#optional-arguments)
  - [Optional Arguments and Policy-Defined Key Precedence](https://www.rabbitmq.com/docs/queues#optional-arguments-precedence)
- [Message ordering](https://www.rabbitmq.com/docs/queues#message-ordering)
  - [When messages can be reordered](https://www.rabbitmq.com/docs/queues#when-messages-can-be-reordered)
  - [Preserving message order](https://www.rabbitmq.com/docs/queues#preserving-message-order)
- [Durability](https://www.rabbitmq.com/docs/queues#durability)
  - [How to Choose](https://www.rabbitmq.com/docs/queues#how-to-choose)
- [Temporary Queues](https://www.rabbitmq.com/docs/queues#temporary-queues)
- [Exclusive (Client Connection-Specific) Queues](https://www.rabbitmq.com/docs/queues#exclusive-queues)
- [Replicated and Distributed Queues](https://www.rabbitmq.com/docs/queues#distributed)
- [Non-Replicated Queues and Client Operations](https://www.rabbitmq.com/docs/queues#transparent-operation-routing)
- [Time-to-Live and Length Limit](https://www.rabbitmq.com/docs/queues#ttl-and-limits)
- [In Durable and In-Memory Storage](https://www.rabbitmq.com/docs/queues#storage)
- [Priorities](https://www.rabbitmq.com/docs/queues#priorities)
- [CPU Utilisation and Parallelism Considerations](https://www.rabbitmq.com/docs/queues#runtime-characteristics)
- [Metrics and Monitoring](https://www.rabbitmq.com/docs/queues#metrics)
- [Consumers and Acknowledgements](https://www.rabbitmq.com/docs/queues#consumer-acknowledgement)
  - [Prefetch and Consumer Overload](https://www.rabbitmq.com/docs/queues#prefetch-consumer-overload)
  - [Message States](https://www.rabbitmq.com/docs/queues#message-states)
- [Determining Queue Length](https://www.rabbitmq.com/docs/queues#queue-length)
- [Avoid Temporary Queues with Well-Known Names](https://www.rabbitmq.com/docs/queues#shared-temporary-queues)

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