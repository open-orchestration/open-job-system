[Skip to main content](https://www.rabbitmq.com/docs/streams#__docusaurus_skipToContent_fallback)

🎉️ [**RabbitMQ 4.3** is out!](https://www.rabbitmq.com/blog/2026/04/23/rabbitmq-4.3-release) 🥳️

[![RabbitMQ](https://www.rabbitmq.com/img/rabbitmq-logo-by-tanzu.svg)](https://www.rabbitmq.com/)[Getting Started](https://www.rabbitmq.com/tutorials) [Docs](https://www.rabbitmq.com/docs) [Blog](https://www.rabbitmq.com/blog) [Support](https://www.rabbitmq.com/contact) [Commercial Features](https://www.rabbitmq.com/commercial-features)

[4.3](https://www.rabbitmq.com/docs/streams)

- **Release series**
- [Next](https://www.rabbitmq.com/docs/next/streams)
- [4.3](https://www.rabbitmq.com/docs/streams)
- [4.2](https://www.rabbitmq.com/docs/4.2/streams)
- [4.1](https://www.rabbitmq.com/docs/4.1/streams)
- [4.0](https://www.rabbitmq.com/docs/4.0/streams)
- [3.13](https://www.rabbitmq.com/docs/3.13/streams)

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

  - [Streams](https://www.rabbitmq.com/docs/streams)

    - [Stream Plugin](https://www.rabbitmq.com/docs/stream)
    - [Stream Connections](https://www.rabbitmq.com/docs/stream-connections)
    - [Stream Core and Plugin](https://www.rabbitmq.com/docs/stream-core-plugin-comparison)
    - [Stream Filtering](https://www.rabbitmq.com/docs/stream-filtering)
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
- Streams

Version: 4.3

On this page

# Streams and Superstreams (Partitioned Streams)

## What is a Stream [​](https://www.rabbitmq.com/docs/streams\#overview "Direct link to What is a Stream")

RabbitMQ Streams is a persistent replicated data structure that can complete the same tasks as queues: they buffer messages from producers that are read by consumers.
However, streams differ from queues in two important ways: how messages are stored and consumed.

Streams model an append-only log of messages that can be repeatedly read until they expire.
Streams are always persistent and replicated. A more technical description of this stream behavior is “non-destructive consumer semantics”.

To read messages from a stream in RabbitMQ, one or more consumers subscribe to it and read the same messages as many times as they want.

Data in a stream can be used via a RabbitMQ client library or through a
[dedicated binary protocol](https://github.com/rabbitmq/rabbitmq-server/blob/main/deps/rabbitmq_stream/docs/PROTOCOL.adoc) plugin and associated client(s).
The latter option is **highly recommended** as it provides access to all stream-specific features and offers best possible throughput (performance).

A companion guide, [Stream Client Connections](https://www.rabbitmq.com/docs/stream-connections), explains
how stream protocol clients should connect to the cluster node for the best
data locality and efficiency (throughput, latency).

info

In addition to streams, RabbitMQ supports partitioned streams called [super streams](https://www.rabbitmq.com/docs/streams#super-streams). They are covered
in more details further in this guide.

Now, you might be asking the following questions:

- Do streams replace queues then?
- Should I move away from using queues?

To answer these questions, streams were not introduced to replace queues but to complement them. Streams open up many opportunities for new RabbitMQ use cases which are described in [Use Cases for Using Streams](https://www.rabbitmq.com/docs/streams#use-cases).

The following information details streams usage, and the administration and maintenance operations for streams.

You should also review the [stream plugin](https://www.rabbitmq.com/docs/stream) information to learn more about the usage of streams with the binary RabbitMQ Stream protocol and the [RabbitMQ core and stream plugin comparison page](https://www.rabbitmq.com/docs/stream-core-plugin-comparison) for the feature matrix.

### Use Cases for Using Streams [​](https://www.rabbitmq.com/docs/streams\#use-cases "Direct link to Use Cases for Using Streams")

Streams were developed to initially cover 4 messaging use-cases that
existing queue types either can not provide or provide with downsides:

1. Large fan-outs

When wanting to deliver the same message to multiple subscribers users currently
have to bind a dedicated queue for each consumer. If the number of consumers is
large this becomes potentially inefficient, especially when wanting persistence
and/or replication. Streams will allow any number of consumers to consume
the same messages from the same queue in a non-destructive manner, negating the need
to bind multiple queues. Stream consumers will also be able to read from replicas
allowing read load to be spread across the cluster.

2. Replay (Time-travelling)

As all current RabbitMQ queue types have destructive consume behaviour, i.e. messages
are deleted from the queue when a consumer is finished with them, it is not
possible to re-read messages that have been consumed. Streams will allow
consumers to attach at any point in the log and read from there.

3. Throughput Performance

No persistent queue types are able to deliver throughput that can compete with
any of the existing log based messaging systems. Streams have been designed
with performance as a major goal.

4. Large backlogs

Most RabbitMQ queues are designed to converge towards the empty state and are
optimised as such and can perform worse when there are millions of messages on a
given queue. Streams are designed to store larger amounts of data in an
efficient manner with minimal in-memory overhead.


## How to Use RabbitMQ Streams [​](https://www.rabbitmq.com/docs/streams\#usage "Direct link to How to Use RabbitMQ Streams")

An AMQP 0.9.1 client library that can specify [optional queue and consumer arguments](https://www.rabbitmq.com/docs/queues#optional-arguments)
will be able to use streams as regular AMQP 0.9.1 queues.

Just like queues, streams have to be declared first.

### Declaring a RabbitMQ Stream [​](https://www.rabbitmq.com/docs/streams\#declaring "Direct link to Declaring a RabbitMQ Stream")

To declare a stream, set the `x-queue-type` queue argument to `stream`
(the default is `classic`). This argument must be provided by a client
at declaration time; it cannot be set or changed using a [policy](https://www.rabbitmq.com/docs/policies).
This is because policy definition or applicable policy can be changed dynamically but
queue type cannot. It must be specified at the time of declaration.

The following snippet shows how to create a stream with the [AMQP 0.9.1 Java client](https://www.rabbitmq.com/client-libraries/java-api-guide):

```java
ConnectionFactory factory = new ConnectionFactory();

Connection connection = factory.newConnection();

Channel channel = connection.createChannel();

channel.queueDeclare(

  "my-stream",

  true,         // durable

  false, false, // not exclusive, not auto-delete

  Collections.singletonMap("x-queue-type", "stream")

);
```

Declaring a queue with an `x-queue-type` argument set to `stream` will create a stream
with a replica on each configured RabbitMQ node. Streams are quorum systems
so uneven cluster sizes is strongly recommended.

A stream remains an AMQP 0.9.1 queue, so it can be bound to any exchange after its creation,
just as any other RabbitMQ queue.

If declaring using [management UI](https://www.rabbitmq.com/docs/management), the `stream` type must be specified using
the queue type drop down menu.

Streams support additional [queue arguments](https://www.rabbitmq.com/docs/queues#optional-arguments)
that also can be configured using a [policy](https://www.rabbitmq.com/docs/policies)

- `x-max-length-bytes`

Sets the maximum size of the stream in bytes. See [retention](https://www.rabbitmq.com/docs/streams#retention). Default: not set.

- `x-max-age`

Sets the maximum age of the stream. See [retention](https://www.rabbitmq.com/docs/streams#retention). Default: not set.

- `x-stream-max-segment-size-bytes`

A stream is divided up into fixed size segment files on disk.
This setting controls the size in bytes of these.
Default: 500000000 bytes.

- `x-stream-filter-size-bytes`

The size in bytes of the Bloom filter used for [filtering](https://www.rabbitmq.com/docs/stream-filtering).
The value must be between 16 and 255.
Default: 16 bytes.

While the `x-stream-max-segment-size-bytes` and `x-stream-filter-size-bytes` arguments can be configured via a policy, they will _only_ be applied to the stream if the policy is set (exists) at stream declaration time.
If these arguments are changed for a matching but pre-existing stream they **will not be changed** even if the effective policy of the queue record may indicate it is.

Hence it is best to only configure these via queue arguments.

The following example in Java demonstrates how the argument can be set
at stream declaration time in application code:

```java
Map<String, Object> arguments = new HashMap<>();

arguments.put("x-queue-type", "stream");

// maximum stream size: 20 GB

arguments.put("x-max-length-bytes", 20_000_000_000);

// size of segment files: 100 MB

arguments.put("x-stream-max-segment-size-bytes", 100_000_000);

// size of stream bloom filter: 32

arguments.put("x-stream-filter-size-bytes", 32);

channel.queueDeclare(

  "my-stream",

  true,         // durable

  false, false, // not exclusive, not auto-delete

  arguments

);
```

### Client Operations [​](https://www.rabbitmq.com/docs/streams\#client-operations "Direct link to Client Operations")

#### Consuming [​](https://www.rabbitmq.com/docs/streams\#consuming "Direct link to Consuming")

As streams never delete any messages, any consumer can start reading/consuming
from any point in the log. This is controlled by the `x-stream-offset` consumer argument.
If it is unspecified the consumer will start reading from the next offset written
to the log after the consumer starts. The following values are supported:

- `first` \- start from the first available message in the log
- `last` \- this starts reading from the last written "chunk" of messages _(a chunk_
_is the storage and transportation unit used in streams, put simply it is a batch_
_of messages made of several to a few thousands of messages, depending on the ingress)_
- `next` \- same as not specifying any offset
- Offset - a numerical value specifying an exact offset to attach to the log at.
If this offset does not exist it will clamp to either the start or end of the log respectively.
- Timestamp: a timestamp value specifying the point in the stream to attach at, based on message arrival time (not application-provided timestamps).
It will clamp to the closest offset, if the timestamp is out of range for the stream it will clamp either the start or end of the log respectively.
With AMQP 0.9.1, the timestamp used is POSIX time with an accuracy of one second, that is the number of seconds since 00:00:00 UTC, 1970-01-01.
Since streams are segmented into chunks that share a single timestamp, consumers attach at a chunk boundary and can receive messages published shortly before the specified timestamp.
- Interval - a string value specifying the time interval relative to current time to attach the log at. Uses the same specification as `x-max-age` (see [Retention](https://www.rabbitmq.com/docs/streams#retention))

The following snippet shows how to use the `first` offset specification:

```java
channel.basicQos(100); // QoS must be specified

channel.basicConsume(

  "my-stream",

  false,

  Collections.singletonMap("x-stream-offset", "first"), // "first" offset specification

  (consumerTag, message) -> {

    // message processing

    // ...

   channel.basicAck(message.getEnvelope().getDeliveryTag(), false); // ack is required

  },

  consumerTag -> { });
```

The following snippet shows how to specify a specific offset to consume from:

```java
channel.basicQos(100); // QoS must be specified

channel.basicConsume(

  "my-stream",

  false,

  Collections.singletonMap("x-stream-offset", 5000), // offset value

  (consumerTag, message) -> {

    // message processing

    // ...

   channel.basicAck(message.getEnvelope().getDeliveryTag(), false); // ack is required

  },

  consumerTag -> { });
```

The following snippet shows how to specify a specific timestamp to consume from:

```java
// an hour ago

Date timestamp = new Date(System.currentTimeMillis() - 60 * 60 * 1_000)

channel.basicQos(100); // QoS must be specified

channel.basicConsume(

  "my-stream",

  false,

  Collections.singletonMap("x-stream-offset", timestamp), // timestamp offset

  (consumerTag, message) -> {

    // message processing

    // ...

   channel.basicAck(message.getEnvelope().getDeliveryTag(), false); // ack is required

  },

  consumerTag -> { });
```

#### Other Stream Operations [​](https://www.rabbitmq.com/docs/streams\#other-stream-operations "Direct link to Other Stream Operations")

The following operations can be used in a similar way to classic and quorum queues
but some have some queue specific behaviour.

- [Declaration](https://www.rabbitmq.com/docs/streams#declaring)
- Queue deletion
- [Publisher confirms](https://www.rabbitmq.com/docs/confirms#publisher-confirms)
- [Consumption](https://www.rabbitmq.com/docs/consumers) (subscription): consumption requires QoS
prefetch to be set. The acks works as a credit mechanism to advance the current
offset of the consumer.
- Setting [QoS prefetch](https://www.rabbitmq.com/docs/streams#global-qos) for consumers
- [Consumer acknowledgements](https://www.rabbitmq.com/docs/confirms) (keep [QoS Prefetch Limitations](https://www.rabbitmq.com/docs/streams#global-qos) in mind)
- Cancellation of consumers

### Single Active Consumer Feature for Streams [​](https://www.rabbitmq.com/docs/streams\#single-active-consumer "Direct link to Single Active Consumer Feature for Streams")

Single active consumer for streams is a feature available in RabbitMQ 3.11 and more.
It provides _exclusive consumption_ and _consumption continuity_ on a stream.
When several consumer instances sharing the same stream and name enable single active consumer, only one of these instances will be active at a time and so will receive messages.
The other instances will be idle.

The single active consumer feature provides 2 benefits:

- Messages are processed in order: there is only one consumer at a time.
- Consumption continuity is maintained: a consumer from the group will take over if the active one stops or crashes.

A [blog post](https://www.rabbitmq.com/blog/2022/07/05/rabbitmq-3-11-feature-preview-single-active-consumer-for-streams) provides more details on single active consumer for streams.

### Super Streams [​](https://www.rabbitmq.com/docs/streams\#super-streams "Direct link to Super Streams")

Super streams are a way to scale out by partitioning a large stream into smaller streams.
They integrate with [single active consumer](https://www.rabbitmq.com/docs/streams#single-active-consumer) to preserve message order within a partition.
Super streams are available starting with RabbitMQ 3.11.

A super stream is a logical stream made of individual, regular streams.
It is a way to scale out publishing and consuming with RabbitMQ Streams: a large logical stream is divided into partition streams, splitting up the storage and the traffic on several cluster nodes.

A super stream remains a logical entity: applications see it as one “large” stream, thanks to the smartness of client libraries.
The topology of a super stream is based on the [AMQP 0.9.1 model](https://www.rabbitmq.com/tutorials/amqp-concepts), that is exchange, queues, and bindings between them.

It is possible to create the topology of a super stream with any AMQP 0.9.1 library or with the [management plugin](https://www.rabbitmq.com/docs/management), it requires to create a direct exchange, the "partition" streams, and bind them together.
It may be easier to use the `rabbitmq-streams add_super_stream` command though.
Here is how to use it to create an `invoices` super stream with 3 partitions:

```bash
rabbitmq-streams add_super_stream invoices --partitions 3
```

Use `rabbitmq-streams add_super_stream --help` to learn more about the command.

Super streams add complexity compared to individual streams, so they should not be considered the default solution for all use cases involving streams.
Consider using super streams only if you are sure you reached the limits of individual streams.

A [blog post](https://www.rabbitmq.com/blog/2022/07/13/rabbitmq-3-11-feature-preview-super-streams) provides an overview of super streams.

## Feature Comparison: Regular Queues versus Streams [​](https://www.rabbitmq.com/docs/streams\#feature-comparison "Direct link to Feature Comparison: Regular Queues versus Streams")

Streams are not really queues in the traditional sense and thus do not
align very closely with AMQP 0.9.1 queue semantics. Many features that other queue types
support are not supported and will never be due to the nature of the queue type.

An AMQP 0.9.1 client library that can use [regular queues](https://www.rabbitmq.com/docs/queues) will be able to use streams
as long as it uses consumer acknowledgements.

Many features will never be supported by streams due to their non-destructive
read semantics.

### Feature Matrix [​](https://www.rabbitmq.com/docs/streams\#feature-matrix "Direct link to Feature Matrix")

| Feature | Classic | Stream |
| --- | --- | --- |
| [Non-durable queues](https://www.rabbitmq.com/docs/queues) | yes | no |
| [Exclusivity](https://www.rabbitmq.com/docs/queues) | yes | no |
| Per message persistence | per message | always |
| Membership changes | no | manual |
| [TTL](https://www.rabbitmq.com/docs/ttl) | yes | no (but see [Retention](https://www.rabbitmq.com/docs/streams#retention)) |
| [Queue length limits](https://www.rabbitmq.com/docs/maxlength) | yes | no (but see [Retention](https://www.rabbitmq.com/docs/streams#retention)) |
| Keeps messages in memory | see [Classic Queues](https://www.rabbitmq.com/docs/classic-queues#memory) | never |
| [Message priority](https://www.rabbitmq.com/docs/priority) | yes | no |
| [Consumer priority](https://www.rabbitmq.com/docs/consumer-priority) | yes | no |
| [Dead letter exchanges](https://www.rabbitmq.com/docs/dlx) | yes | no |
| Adheres to [policies](https://www.rabbitmq.com/docs/policies) | yes | yes (see [Retention](https://www.rabbitmq.com/docs/streams#retention)) |
| Reacts to [memory alarms](https://www.rabbitmq.com/docs/alarms) | yes | no (uses minimal RAM) |
| Poison message handling | no | no |

#### Non-durable Queues [​](https://www.rabbitmq.com/docs/streams\#non-durable-queues "Direct link to Non-durable Queues")

Streams are always durable per their assumed [use cases](https://www.rabbitmq.com/docs/streams#use-cases),
they cannot be [non-durable](https://www.rabbitmq.com/docs/queues#properties) like regular queues.

#### Exclusivity [​](https://www.rabbitmq.com/docs/streams\#exclusivity "Direct link to Exclusivity")

Streams are always durable per their assumed [use cases](https://www.rabbitmq.com/docs/streams#use-cases), they cannot be
[exclusive](https://www.rabbitmq.com/docs/queues#exclusive-queues) like regular queues.
They are not meant to be used as [temporary queues](https://www.rabbitmq.com/docs/queues#temporary-queues).

#### Global QoS [​](https://www.rabbitmq.com/docs/streams\#global-qos "Direct link to Global QoS")

Streams do not support global [QoS prefetch](https://www.rabbitmq.com/docs/confirms#channel-qos-prefetch) where a channel sets a single
prefetch limit for all consumers using that channel. If an attempt
is made to consume from a stream from a channel with global QoS enabled
a channel error will be returned.

Use [per-consumer QoS prefetch](https://www.rabbitmq.com/docs/consumer-prefetch), which is the default in several popular clients.

## Data Retention [​](https://www.rabbitmq.com/docs/streams\#retention "Direct link to Data Retention")

Streams are implemented as an immutable append-only disk log. This means that
the log will grow indefinitely until the disk runs out. To avoid this undesirable
scenario it is possible to set a retention configuration per stream which will
discard the oldest data in the log based on total log data size and/or age.

There are two parameters that control the retention of a stream.
These can be combined.
These are either set at declaration time using a queue argument or as a policy which can be dynamically updated.
The policy takes precedence over queue arguments.

- `max-age`:

valid units: Y, M, D, h, m, s

e.g. `7D` for a week

- `max-length-bytes`:

the max total size in bytes


NB: retention is evaluated on per segment basis so there is one more parameter
that comes into effect and that is the segment size of the stream. The stream will
always leave at least one segment in place as long as the segment contains at least
one message.
When using broker-provided [offset-tracking](https://www.rabbitmq.com/docs/streams#offset-tracking), offsets for each consumer
are persisted in the stream itself as non-message data.

## Performance Characteristics [​](https://www.rabbitmq.com/docs/streams\#performance "Direct link to Performance Characteristics")

As streams persist all data to disks before doing anything it is recommended
to use the fastest disks possible.

Due to the disk I/O-heavy nature of streams, their throughput decreases
as message sizes increase.

Just like quorum queues, streams are also affected by cluster sizes.
The more replicas a stream has, the lower its throughput generally will
be since more work has to be done to replicate data and achieve consensus.

### Controlling the Initial Replication Factor [​](https://www.rabbitmq.com/docs/streams\#replication-factor "Direct link to Controlling the Initial Replication Factor")

The `x-initial-cluster-size` queue argument controls how many rabbit nodes the initial
stream cluster should span.

### Managing Stream Replicas [​](https://www.rabbitmq.com/docs/streams\#member-management "Direct link to Managing Stream Replicas")

Replicas of a stream are explicitly managed by the operator. When a new node is added
to the cluster, it will host no stream replicas unless the operator explicitly adds it
to a replica set of a stream.

When a node has to be decommissioned (permanently removed from the cluster), it must be explicitly
removed from the replica list of all streams it currently hosts replicas for.

Two [CLI commands](https://www.rabbitmq.com/docs/cli) are provided to perform the above operations,
`rabbitmq-streams add_replica` and `rabbitmq-streams delete_replica`:

```bash
rabbitmq-streams add_replica [-p <vhost>] <stream-name> <node>
```

```bash
rabbitmq-streams delete_replica [-p <vhost>] <stream-name> <node>
```

To successfully add and remove replicas the stream coordinator must be
available in the cluster.

Care needs to be taken not to accidentally make a stream unavailable by losing
the quorum whilst performing maintenance operations that involve membership changes.

Because the stream membership isn't embedded in the stream itself adding a replica
cannot be made entirely safe at the current time. Hence if there at any time is an
out of sync replica another replica cannot be added and an error will be returned.

When replacing a cluster node, it is safer to first add a new node, wait for it
to become in-sync and then de-commission the node it replaces.

The replication status of a stream can be queried using the following command:

```bash
rabbitmq-streams stream_status [-p <vhost>] <stream-name>
```

In addition streams can be restarted using:

```bash
rabbitmq-streams restart_stream [-p <vhost>] <stream-name>
```

## Stream Behaviour [​](https://www.rabbitmq.com/docs/streams\#behaviour "Direct link to Stream Behaviour")

Every stream has a primary writer (the leader) and zero or more replicas.

### Leader Election and Failure Handling [​](https://www.rabbitmq.com/docs/streams\#leader-election "Direct link to Leader Election and Failure Handling")

When a new stream is declared, the set of nodes that will host its
replicas is randomly picked, but will always include the node the client that declares the stream is connected to.

Which replica becomes the initial leader is controlled in three ways,
namely, using the `x-queue-leader-locator` [optional queue argument](https://www.rabbitmq.com/docs/queues#optional-arguments), setting the `queue-leader-locator`
policy key or by defining the `queue_leader_locator`
key in [the configuration file](https://www.rabbitmq.com/docs/configure#configuration-files). Here are the possible values:

- `client-local`: Pick the node the client that declares the stream is connected to. This is the default value.
- `balanced`: If there are overall less than 1000 queues (classic queues, quorum queues, and streams),
pick the node hosting the minimum number of stream leaders.
If there are overall more than 1000 queues, pick a random node.

A stream requires a quorum of the declared nodes to be available
to function. When a RabbitMQ node hosting a stream's
_leader_ fails or is stopped another node hosting one of that
stream's _replica_ will be elected leader and resume
operations.

Failed and rejoining replicas will re-synchronise ("catch up") with the leader.
Similarly to quorum queues queues, a temporary replica failure
does not require a full re-synchronization from the currently elected leader. Only the delta
will be transferred if a re-joining replica is behind the leader. This "catching up" process
does not affect leader availability.

Replicas must be explicitly added.
When a new replica is [added](https://www.rabbitmq.com/docs/streams#member-management), it will synchronise the entire stream state
from the leader, similarly to newly added quorum queue replicas.

### Fault Tolerance and Minimum Number of Replicas Online [​](https://www.rabbitmq.com/docs/streams\#quorum-requirements "Direct link to Fault Tolerance and Minimum Number of Replicas Online")

Consensus systems can provide certain guarantees with regard to data safety.
These guarantees do mean that certain conditions need to be met before they
become relevant such as requiring a minimum of three cluster nodes to provide
fault tolerance and requiring more than half of members to be available to
work at all.

Failure tolerance characteristics of clusters of various size can be described
in a table:

| Cluster node count | Tolerated number of node failures | Tolerant to a network partition |
| --- | --- | --- |
| 1 | 0 | not applicable |
| 2 | 0 | no |
| 3 | 1 | yes |
| 4 | 1 | yes if a majority exists on one side |
| 5 | 2 | yes |
| 6 | 2 | yes if a majority exists on one side |
| 7 | 3 | yes |
| 8 | 3 | yes if a majority exists on one side |
| 9 | 4 | yes |

### Data Safety when using Streams [​](https://www.rabbitmq.com/docs/streams\#data-safety "Direct link to Data Safety when using Streams")

Streams replicate data across multiple nodes and publisher confirms are only
issued once the data has been replicated to a quorum of stream replicas.

Streams always store data on disk, however, they do not explicitly flush (fsync)
the data from the operating system page cache to the underlying storage
medium, instead they rely on the operating system to do as and when required.
This means that an uncontrolled shutdown of a server could result in data loss
for replicas hosted on that node. Although theoretically this opens up the possibility
of confirmed data loss, the chances of this happening during normal operation is
very small and the loss of data on a single node would typically just be re-replicated
from the other nodes in the system.

If more data safety is required then consider using quorum queues instead as no
publisher confirms are issued until at least a quorum of nodes have both written _and_
flushed the data to disk.

_No guarantees are provided for messages that have not been confirmed using_
_the publisher confirm mechanism_. Such messages could be lost "mid-way", in an operating
system buffer or otherwise fail to reach the stream leader.

### Stream Availability [​](https://www.rabbitmq.com/docs/streams\#availability "Direct link to Stream Availability")

A stream should be able to tolerate a minority of stream replicas becoming unavailable
with no or little effect on availability.

Note that depending on the [partition handling strategy](https://www.rabbitmq.com/docs/partitions)
used RabbitMQ may restart itself during recovery and reset the node but as long as that
does not happen, this availability guarantee should hold true.

For example, a stream with three replicas can tolerate one node failure without losing availability.
A stream with five replicas can tolerate two, and so on.

If a quorum of nodes cannot be recovered (say if 2 out of 3 RabbitMQ nodes are
permanently lost) the queue is permanently unavailable and
will most likely need operator involvement to be recovered.

## Configuring Streams [​](https://www.rabbitmq.com/docs/streams\#configuration "Direct link to Configuring Streams")

For stream protocol port, TLS and other configuration, see the [Stream plugin guide](https://www.rabbitmq.com/docs/stream).
For required stream replication ports see the [Networking guide](https://www.rabbitmq.com/docs/networking#ports).

## How Streams Use Resources [​](https://www.rabbitmq.com/docs/streams\#resource-use "Direct link to How Streams Use Resources")

Streams usually will have lower CPU and memory footprint than quorum queues.

All data is stored on disk with only unwritten data stored in memory.

Since streams are disk I/O heavy, they will heavily use the [kernel page cache](https://www.rabbitmq.com/docs/memory-use#page-cache), which has important implications for [memory monitoring in containerized deployments](https://www.rabbitmq.com/docs/memory-use#containers).

## Offset Tracking when using Streams [​](https://www.rabbitmq.com/docs/streams\#offset-tracking "Direct link to Offset Tracking when using Streams")

When using the broker provided offset tracking features (currently only available
when using the [Stream plugin](https://www.rabbitmq.com/docs/stream)) offsets are persisted in the stream
itself as non-message data. This means that as offset persistence is requested the
stream will grow on disk by some small amount per offset persistence request.

## Deduplication of Published Messages [​](https://www.rabbitmq.com/docs/streams\#deduplication-published-messages "Direct link to Deduplication of Published Messages")

RabbitMQ Stream can detect and filter out duplicated published messages, based on 2 client-side elements: the _producer name_ and the _message publishing ID_.

A client application chooses to activate deduplication for a given producer.
Usage of deduplication depends on the client library used, this section covers the basics.
See the documentation of the client library you are using for the API specifics.
Deduplication is not activated by default in the stream client libraries the RabbitMQ team maintains.

### Producer Name [​](https://www.rabbitmq.com/docs/streams\#producer-name "Direct link to Producer Name")

The producer name must be unique for a given stream.
There should be only one producer with a given name on a given stream at a time, as deduplication does not support concurrent publishing (publishing IDs can intertwine with concurrent producer instances).
A producer name should be stable between application restarts and clear to a human reader.
Names like `online-shop-order` or `online-shop-invoice` are better names than a random sequence like `3d235e79-047a-46a6-8c80-9d159d3e1b05`.

### Publishing ID [​](https://www.rabbitmq.com/docs/streams\#publishing-id "Direct link to Publishing ID")

The publishing ID is a strictly increasing sequence.
The publishing application must increment it for each outbound message.
Here are rules for the publishing ID sequence: it must be strictly increasing, it can have gaps in the sequence (e.g. 0, 1, 2, 3, 6, 7, 9, 10, etc), it does not have to start at 0.

### How Deduplication Works [​](https://www.rabbitmq.com/docs/streams\#how-deduplication-works "Direct link to How Deduplication Works")

The broker keeps track of the highest publishing ID sent for a given named producer on a given stream (the "limit").
The broker will filter out any outbound message with a publishing ID less than or equal to this limit.
It will send a confirmation though, telling the producer the message has been taking into account and should not be sent again.

A message with a greater value than the current limit will be stored, confirmed, and will establish the new limit.

When creating a named producer, a client application can query the broker for the last publishing ID for it.
The application can then resume the publishing where it left off.

A good mental model of the way a named producer with deduplication activated should work is seeing the producer going through the lines of a file.
Each line is a message and the publishing ID is the line number.

### Examples [​](https://www.rabbitmq.com/docs/streams\#examples "Direct link to Examples")

Let's see some examples to understand the way deduplication works.
In the examples, publishing e.g. "message 2" means publishing a message with an arbitrary content and using 2 for the publishing ID.

#### Publishing and Restarting [​](https://www.rabbitmq.com/docs/streams\#publishing-and-restarting "Direct link to Publishing and Restarting")

A client application does the following:

- declares a producer with a name to activate deduplication
- publishes message 1, message 2, message 3
- receives asynchronous confirmations from the broker for each message
- publishes message 4
- crashes

We assume the broker received message 4 and sent a confirmation, but the application crashed before receiving the confirmation.

The application restarts:

- declares the publisher with the same name
- queries the broker for the last publishing ID
- receives publishing ID 4 from the broker
- "scrolls" to message 4 (see the file analogy above)
- publishes message 4 again
- gets a confirmation for message 4 (the broker filtered out the message, but sent the confirmation)
- publishes message 5, etc

The application could have published message 5 right away, as the broker returned 4 as the last publishing ID it received.
But the application chose to republish message 4, as it had never received a confirmation for it.
The broker filtered out message 4 anyway and sent a confirmation, telling the application message 4 is safely stored and it can move on to the next message.

#### Misusing Deduplication [​](https://www.rabbitmq.com/docs/streams\#misusing-deduplication "Direct link to Misusing Deduplication")

A client application does the following:

- declares a producer with a name to activate deduplication
- publishes message 1, message 2, message 3
- receives asynchronous confirmations from the broker for each message
- publishes message 10
- receives asynchronous confirmation for message 10
- publishes message 4
- receives asynchronous confirmation for message 4

The application receives a confirmation for message 4, but the broker filtered out this message, because the limit was 10 at this time.
The broker keeps only track of the highest publishing ID, not of each individual publishing ID.
Message 4 has a smaller publishing ID than the current limit, which is 10, set by message 10, so message 4 is filtered out, even if it has not been published or stored before.

One can think the broker is misleading the application, but the application is misusing the deduplication feature.
It used 10, then 4 for publishing ID, violating the requirement of a strictly-increasing sequence.
If we use the file analogy from above, the application scrolled down to line 10 and then back to 4.
Deduplication does not cover this case.

### Going Further [​](https://www.rabbitmq.com/docs/streams\#going-further "Direct link to Going Further")

See your favorite [stream client library](https://www.rabbitmq.com/docs/stream) documentation for more information on deduplication.

See also the [deduplication blog post](https://www.rabbitmq.com/blog/2021/07/28/rabbitmq-streams-message-deduplication) for a step-by-step example.

## Limitations [​](https://www.rabbitmq.com/docs/streams\#limitations "Direct link to Limitations")

### Message Encoding [​](https://www.rabbitmq.com/docs/streams\#limitations-message-encoding "Direct link to Message Encoding")

Streams internally store their messages as AMQP 1.0 encoded data. This means when
publishing using AMQP 0.9.1 a conversion takes place. Although the AMQP 1.0 data
model is mostly capable of containing all of AMQP 0.9.1's data model there are some
limitations. If an AMQP 0.9.1 message contains header entries with complex values
such as arrays or tables these headers will not be converted.
That is because headers are stored as application properties inside the AMQP 1.0 message and these can only
contain values of simple types, such as strings and numbers.

### UI Metric Accuracy [​](https://www.rabbitmq.com/docs/streams\#limitations-ui-metrics "Direct link to UI Metric Accuracy")

Management UI can show a message count that slightly exceeds the actual count in the stream.
Due to the way stream storage is implemented, offset tracking information is also counted as messages, making the message count artificially larger than it is.
This should make no practical difference in most systems.

[Edit this page](https://github.com/rabbitmq/rabbitmq-website/tree/main/versioned_docs/version-4.3/streams.md)

[Previous\\
\\
Priority Queues](https://www.rabbitmq.com/docs/priority) [Next\\
\\
Stream Plugin](https://www.rabbitmq.com/docs/stream)

- [What is a Stream](https://www.rabbitmq.com/docs/streams#overview)
  - [Use Cases for Using Streams](https://www.rabbitmq.com/docs/streams#use-cases)
- [How to Use RabbitMQ Streams](https://www.rabbitmq.com/docs/streams#usage)
  - [Declaring a RabbitMQ Stream](https://www.rabbitmq.com/docs/streams#declaring)
  - [Client Operations](https://www.rabbitmq.com/docs/streams#client-operations)
  - [Single Active Consumer Feature for Streams](https://www.rabbitmq.com/docs/streams#single-active-consumer)
  - [Super Streams](https://www.rabbitmq.com/docs/streams#super-streams)
- [Feature Comparison: Regular Queues versus Streams](https://www.rabbitmq.com/docs/streams#feature-comparison)
  - [Feature Matrix](https://www.rabbitmq.com/docs/streams#feature-matrix)
- [Data Retention](https://www.rabbitmq.com/docs/streams#retention)
- [Performance Characteristics](https://www.rabbitmq.com/docs/streams#performance)
  - [Controlling the Initial Replication Factor](https://www.rabbitmq.com/docs/streams#replication-factor)
  - [Managing Stream Replicas](https://www.rabbitmq.com/docs/streams#member-management)
- [Stream Behaviour](https://www.rabbitmq.com/docs/streams#behaviour)
  - [Leader Election and Failure Handling](https://www.rabbitmq.com/docs/streams#leader-election)
  - [Fault Tolerance and Minimum Number of Replicas Online](https://www.rabbitmq.com/docs/streams#quorum-requirements)
  - [Data Safety when using Streams](https://www.rabbitmq.com/docs/streams#data-safety)
  - [Stream Availability](https://www.rabbitmq.com/docs/streams#availability)
- [Configuring Streams](https://www.rabbitmq.com/docs/streams#configuration)
- [How Streams Use Resources](https://www.rabbitmq.com/docs/streams#resource-use)
- [Offset Tracking when using Streams](https://www.rabbitmq.com/docs/streams#offset-tracking)
- [Deduplication of Published Messages](https://www.rabbitmq.com/docs/streams#deduplication-published-messages)
  - [Producer Name](https://www.rabbitmq.com/docs/streams#producer-name)
  - [Publishing ID](https://www.rabbitmq.com/docs/streams#publishing-id)
  - [How Deduplication Works](https://www.rabbitmq.com/docs/streams#how-deduplication-works)
  - [Examples](https://www.rabbitmq.com/docs/streams#examples)
  - [Going Further](https://www.rabbitmq.com/docs/streams#going-further)
- [Limitations](https://www.rabbitmq.com/docs/streams#limitations)
  - [Message Encoding](https://www.rabbitmq.com/docs/streams#limitations-message-encoding)
  - [UI Metric Accuracy](https://www.rabbitmq.com/docs/streams#limitations-ui-metrics)

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