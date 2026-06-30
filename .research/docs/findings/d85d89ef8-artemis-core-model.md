---
id: d85d89ef8
topic: brokers
title: "ActiveMQ Artemis core model: addresses, queues, routing types, and journal persistence"
status: draft
shape: mechanism
---

# ActiveMQ Artemis core model: addresses, queues, routing types, and journal persistence

ActiveMQ Artemis presents one underlying broker model to every supported
protocol. Each supported messaging protocol and API defines a different set of
messaging resources — JMS uses queues and topics, STOMP uses generic
destinations, MQTT uses topics, and AMQP uses generic nodes [c56a4eecc]. To
deal with the unique semantics and use-cases for each of these the broker has a
flexible and powerful address model based on a core set of resources: address,
queue, and routing type [c56a4eecc].

## 1. The address model: address, queue, routing type

Messages are sent to an address, and an address is given a unique name, a
routing type, and zero or more queues [c56a4eecc]. Messages are consumed from a
queue, and a queue is bound to an address with its own unique name and routing
type [c56a4eecc]. There can be zero or more queues bound to one address, and
when a message is sent to an address it is routed to one or more of its queues
based on the configured routing type [c56a4eecc]. The name of the queue must be
globally unique — for example, you cannot have a queue named `q1` on address
`a1` and also a queue named `q1` on address `a2` [c56a4eecc].

A routing type determines how messages are routed from an address to the
queue(s) bound to that address, and two different routing types are supported:
**anycast** and **multicast** [c56a4eecc]. To route messages to a single queue
on the address you use anycast; to route them to every queue on the address you
use multicast [c56a4eecc]. It is possible to define queues with a different
routing type for the same address, but this typically results in an
anti-pattern and is therefore not recommended [c56a4eecc].

### Anycast maps to point-to-point

The most common use-case for anycast semantics, sometimes referred to as
point-to-point, involves applications following a "competing consumer" pattern
to receive messages from a shared queue, where the more consumers receiving
messages the greater the overall message throughput [c56a4eecc]. Multiple Java
applications sharing a JMS queue is a classic example of this use-case
[c56a4eecc]. In this use-case the broker is configured with an address, for
example `address.foo`, using the anycast routing type with just one queue `q1`;
when a producer sends a message to `address.foo` it is routed to `q1` and
finally dispatched to one of the consumers [c56a4eecc].

### Multicast maps to publish/subscribe

The most common use-case for multicast semantics, sometimes referred to as
publish/subscribe or "pub/sub", involves each application receiving every
message sent to an address [c56a4eecc]. Multiple applications consuming from a
JMS topic is a classic example, and MQTT subscriptions are another supported
example of multicast semantics [c56a4eecc]. With an address `address.foo` using
the multicast routing type and two queues `q1` and `q2`, when a producer sends a
message to `address.foo` it is routed to both `q1` and `q2` so that ultimately
both consumers receive the same messages [c56a4eecc]. Because in a normal pub/sub
use-case the number of subscribers is not known ahead of time, the recommended
configuration is `<multicast/>` with no queues, in which case the broker will
automatically create queues for each subscription when consumers connect — these
are often referred to as subscription queues [c56a4eecc].

By default the broker will automatically create addresses and queues to support
the semantics of whatever protocol you are using, so that in most cases no
manual configuration is required [c56a4eecc]. Automatic creation and deletion is
configured on a per-address basis and is controlled by `address-setting`
elements such as `auto-create-addresses`, `auto-delete-addresses`,
`default-address-routing-type`, `auto-create-queues`, `auto-delete-queues`, and
`default-queue-routing-type` [c56a4eecc].

## 2. Core messaging concepts (the Core API)

Core is a messaging system with its own API, called the Core API [c66cb18d0]. If
you do not want to use the JMS API or any of the other supported protocols you
can use the Core API directly; it provides all the functionality of JMS but
without much of the complexity, and also provides features that are not
available using JMS [c66cb18d0]. In general the Core API is simpler than the JMS
API because it removes the distinctions between queues, topics, and
subscriptions [c66cb18d0].

A message is the unit of data which is sent between clients and servers, and it
has a body which is a buffer containing convenient methods for reading and
writing data into it [c66cb18d0]. A message has a set of properties which are
key-value pairs, where each property key is a string and property values can be
of type integer, long, short, byte, byte[], String, double, float, or boolean
[c66cb18d0]. A message has an address it is being sent to, and when the message
arrives on the server it is routed to any queues that are bound to the address,
with the routing semantics (anycast or multicast) determined by the routing type
of the address and queue [c66cb18d0]. Messages can be either durable or non
durable: durable messages in a durable queue will survive a server crash or
restart, while non durable messages will never survive a server crash or restart
[c66cb18d0]. Very large messages — much larger than can fit in available RAM at
any one time — can be sent and consumed [c66cb18d0].

The Core API exposes a small set of client objects for attaching producers and
consumers. Clients use `ServerLocator` instances to create
`ClientSessionFactory` instances, and `ServerLocator` instances are used to
locate servers and create connections to them [c66cb18d0]. Clients use
`ClientSessionFactory` instances to create `ClientSession` instances, and a
`ClientSessionFactory` is basically the connection to a server [c66cb18d0]. A
client uses a `ClientSession` for consuming and producing messages and for
grouping them in transactions, and `ClientSession` instances group
`ClientConsumer` and `ClientProducer` instances [c66cb18d0]. Clients use
`ClientConsumer` instances to consume messages from a queue, and Core messaging
supports both synchronous and asynchronous message consumption semantics
[c66cb18d0]. Clients create `ClientProducer` instances on `ClientSession`
instances so they can send messages, and a `ClientProducer` can specify an
address to which all sent messages are routed, or it can have no specified
address with the address specified at send time for the message [c66cb18d0].
`ClientSession`, `ClientProducer`, and `ClientConsumer` instances are designed to
be re-used, and it is an anti-pattern to create new instances for each message
you produce or consume [c66cb18d0].

## 3. Persistence: the file journal

Apache Artemis ships with two persistence options: the file journal, which is
highly optimized for the messaging use case and gives great performance, and the
JDBC Store, which uses JDBC to connect to a database of your choice [ca846c6c1].
The file journal is the default [ca846c6c1].

### Append-only design

The file journal is an append-only journal that consists of a set of files on
disk, where each file is pre-created to a fixed size and initially filled with
padding [ca846c6c1]. As operations are performed on the server — for example add
message, update message, delete message — records are appended to the journal,
and when one journal file is full the broker moves to the next one [ca846c6c1].
Because records are only appended (added to the end of the journal), disk head
movement is minimised, minimising the random access operations that are
typically the slowest operation on a disk [ca846c6c1]. As delete records are
added, a file garbage collection algorithm determines whether a particular
journal file is needed any more (whether all its data has been deleted), and if
so the file can be reclaimed and re-used [ca846c6c1]. A compaction algorithm
occasionally removes dead space from the journal and compresses up the data so
it takes up fewer files on disk [ca846c6c1]. The journal also fully supports
transactional operation if required, supporting both local and XA transactions
[ca846c6c1].

### Pluggable file-system implementations: NIO, AIO, Memory Mapped

The majority of the journal is written in Java, but interaction with the actual
file system is abstracted out to allow different pluggable implementations, and
Apache Artemis ships with three: NIO, AIO, and Memory Mapped [ca846c6c1]. The
first implementation uses standard Java NIO to interface with the file system,
providing extremely good performance and running on any platform where there is
a Java 6+ runtime [ca846c6c1]. The second implementation uses a thin native code
wrapper to talk to the Linux asynchronous IO library (AIO), where the broker
will be called back when the data has made it to disk; this avoids explicit
syncs altogether and allows the broker to simply send back confirmation of
completion when AIO informs it that the data has been persisted [ca846c6c1].
Using AIO will typically provide even better performance than using Java NIO
[ca846c6c1]. The AIO journal option is only available when running Linux kernel
2.6 or later and after having installed libaio, and AIO will only work with the
ext2, ext3, ext4, jfs, xfs, and NFSv4 file systems [ca846c6c1].

### What the journal stores

The broker uses two instances of the journal [ca846c6c1]. The bindings journal
is used to store bindings related data, including the set of queues that are
deployed on the server and their attributes, and data such as id sequence
counters; it is always a NIO journal as it is typically low throughput compared
to the message journal, with files prefixed `activemq-bindings` [ca846c6c1]. The
message journal stores all message related data, including the messages
themselves and also duplicate-id caches, with files prefixed `activemq-data` and
an `amq` extension [ca846c6c1]. By default the broker will try to use an AIO
journal for messages, and if AIO is not available — for example the platform is
not Linux with the correct kernel version, or AIO has not been installed — it
will automatically fall back to using Java NIO, which is available on any Java
platform [ca846c6c1]. Large messages are persisted outside the message journal
[ca846c6c1]. The `journal-type` attribute accepts the values `NIO`, `ASYNCIO`,
or `MAPPED`, selecting the Java NIO journal, the Linux asynchronous IO journal,
or the Java Memory Mapped journal respectively [ca846c6c1].
