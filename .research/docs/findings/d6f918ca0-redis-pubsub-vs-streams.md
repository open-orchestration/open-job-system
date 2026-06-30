---
id: d6f918ca0
topic: brokers
title: "Redis messaging: Pub/Sub versus Streams"
status: draft
shape: comparison
---

# Redis messaging: Pub/Sub versus Streams

Redis ships two distinct messaging primitives. Pub/Sub is a fire-and-forget
broadcast channel; Streams are a persistent, replayable log with consumer-group
semantics. The official docs frame them as complementary, explicitly pointing
Pub/Sub users who need stronger guarantees toward Streams [c91aefe71].

## Redis Pub/Sub — ephemeral broadcast

`SUBSCRIBE`, `UNSUBSCRIBE` and `PUBLISH` implement the Publish/Subscribe
messaging paradigm, where senders (publishers) are not programmed to send their
messages to specific receivers (subscribers) [c91aefe71]. Published messages are
categorized into channels, without knowledge of what (if any) subscribers there
may be, and subscribers express interest in one or more channels and only
receive messages that are of interest [c91aefe71]. Messages sent by other clients
to these channels are pushed by Redis to all the subscribed clients, and
subscribers receive the messages in the order that the messages are published
[c91aefe71].

### Delivery semantics: at-most-once, no history

Redis' Pub/Sub exhibits _at-most-once_ message delivery semantics, meaning a
message will be delivered once if at all [c91aefe71]. Once the message is sent by
the Redis server, there's no chance of it being sent again, and if the subscriber
is unable to handle the message (for example, due to an error or a network
disconnect) the message is forever lost [c91aefe71]. The docs note that if your
application requires stronger delivery guarantees, you may want to learn about
Redis Streams, whose messages are persisted and support both _at-most-once_ as
well as _at-least-once_ delivery semantics [c91aefe71]. There is no stored
history or replay: a message reaches only the clients connected and subscribed
at publish time [c91aefe71].

### Format of pushed messages

A pushed message is an array-reply with three elements [c91aefe71]. The first
element is the kind of message: `subscribe` confirms a successful subscription,
`unsubscribe` confirms unsubscription, and `message` is a message received as a
result of a `PUBLISH` command issued by another client [c91aefe71]. For a
`message`, the second element is the name of the originating channel and the
third argument is the actual message payload [c91aefe71].

### Channels, patterns, and scoping

The Pub/Sub implementation supports pattern matching: clients may subscribe to
glob-style patterns with `PSUBSCRIBE` to receive all the messages sent to channel
names matching a given pattern [c91aefe71]. Messages received as a result of
pattern matching arrive in a different format, with type `pmessage`, where the
second element is the original pattern matched and the third element is the name
of the originating channel [c91aefe71]. Pub/Sub has no relation to the key space
and was made to not interfere with it on any level, including database numbers,
so publishing on db 10 will be heard by a subscriber on db 1 [c91aefe71]. If you
need scoping of some kind, the docs recommend prefixing the channels with the
name of the environment (test, staging, production) [c91aefe71]. From Redis 7.0,
sharded Pub/Sub is introduced, in which shard channels are assigned to slots and
`SSUBSCRIBE`, `SUNSUBSCRIBE` and `SPUBLISH` are used to implement it, restricting
message propagation to within the shard of a cluster [c91aefe71].

## Redis Streams — a persistent, replayable log

A Redis stream is a data structure that acts like an append-only log but also
implements several operations to overcome some of the limits of a typical
append-only log, including random access in O(1) time and complex consumption
strategies such as consumer groups [ca65bc95e]. Streams are an append-only data
structure whose fundamental write command, `XADD`, appends a new entry to the
specified stream [ca65bc95e]. Each stream entry consists of one or more
field-value pairs, somewhat like a dictionary or a Redis hash [ca65bc95e].

### Entry IDs

Redis generates a unique ID for each stream entry, and you can use these IDs to
retrieve their associated entries later or to read and process all subsequent
entries in the stream [ca65bc95e]. The entry ID returned by `XADD`, which
identifies univocally each entry inside a given stream, is composed of two parts
in the form `<millisecondsTime>-<sequenceNumber>` [ca65bc95e]. The milliseconds
time part is the local time in the Redis node generating the ID, and if the
current time is smaller than the previous entry time the previous time is used
instead, so the monotonically incrementing ID property still holds even if a
clock jumps backward; the sequence number distinguishes entries created in the
same millisecond [ca65bc95e]. Because the ID is related to the time the entry is
generated, Redis streams support range queries by ID, giving the ability to query
for time ranges basically for free via the `XRANGE` command [ca65bc95e].

### Reading new items with XREAD

When you want to subscribe to new items arriving in the stream, the command is
`XREAD`, and the docs spell out the fundamental differences from Pub/Sub
[ca65bc95e]. A stream can have multiple clients (consumers) waiting for data, and
every new item by default will be delivered to every consumer that is waiting for
data in a given stream, an ability to fan out that is similar to Pub/Sub
[ca65bc95e]. Critically, while in Pub/Sub messages are fire and forget and are
never stored, streams work in a fundamentally different way: all the messages are
appended in the stream indefinitely (unless the user explicitly asks to delete
entries), and different consumers know what is a new message from their point of
view by remembering the ID of the last message received [ca65bc95e].

### Consumer groups, acknowledgement, and pending entries

Streams Consumer Groups provide a level of control that Pub/Sub or blocking lists
cannot achieve, with different groups for the same stream, explicit
acknowledgment of processed items, the ability to inspect the pending items,
claiming of unprocessed messages, and coherent history visibility for each client
[ca65bc95e]. A consumer group lets you provide a different subset of messages from
the same stream to many clients, which allows scaling message processing by
routing different messages to different workers [ca65bc95e]. Within a group, each
message is served to a different consumer so that the same message will not be
delivered to multiple consumers, and consumers are identified within a group by a
case-sensitive name, so that even after a disconnect the group retains all the
state when the client claims again to be the same consumer [ca65bc95e].

Consuming a message requires an explicit acknowledgment using `XACK`, which Redis
interprets as: this message was correctly processed, so it can be evicted from the
consumer group [ca65bc95e]. Messages are read via `XREADGROUP`; the special ID `>`
is only valid in the context of consumer groups and means messages never
delivered to other consumers so far, whereas specifying a real ID such as `0`
returns the history of pending messages instead of new ones [ca65bc95e]. A
consumer group tracks all the messages that are currently pending — delivered to
some consumer but yet to be acknowledged — and once a message is acknowledged it
will no longer be part of the pending messages history [ca65bc95e].

### Redelivery: claiming and the delivery counter

Because consumers may permanently fail and never recover, Redis consumer groups
offer a feature to claim the pending messages of a given consumer so that those
messages change ownership and are re-assigned to a different consumer [ca65bc95e].
The `XPENDING` command provides observability of pending entries in the consumer
group, reporting for each message the ID, the consumer name, the idle time in
milliseconds since the message was last delivered, and the number of times that a
given message was delivered [ca65bc95e]. A consumer inspects the pending list and
then claims specific messages with `XCLAIM` (or automatic claiming), otherwise the
server leaves the messages pending forever and assigned to the old consumer
[ca65bc95e]. On restart a consumer typically re-reads its own pending messages
before switching to the `>` ID for new ones, which means a message may be
processed more than once under consumer failures [ca65bc95e].

### Retention and trimming

Redis streams support several trimming strategies to prevent streams from growing
unbounded [ca65bc95e]. Many applications do not want to collect data into a stream
forever, so the `XADD` command provides a `MAXLEN` option to cap a stream at a
maximum number of items, and `XTRIM` deletes messages from the beginning of a
stream [ca65bc95e].

## The key difference

Pub/Sub is ephemeral: messages are fire-and-forget, never stored, delivered
at-most-once to whatever clients are connected at publish time, and forever lost
if a subscriber misses them [c91aefe71]. Streams are a persistent, append-only log
whose entries are stored indefinitely until explicitly deleted or trimmed, are
addressable by time-ordered IDs and replayable via range queries, and — through
consumer groups — support load-balanced delivery across workers, explicit
`XACK` acknowledgement, a pending-entries list, and redelivery of unacknowledged
messages [ca65bc95e]. The Pub/Sub docs themselves direct applications needing
stronger-than-at-most-once guarantees to Streams [c91aefe71].
