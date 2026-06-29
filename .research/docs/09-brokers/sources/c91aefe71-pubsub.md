{"categories":\["docs","develop","stack","oss","rs","rc","oss","kubernetes","clients"\],"description":"How to use pub/sub channels in Redis","duplicateOf":"head:data-ai-metadata","location":"body","title":"Redis Pub/sub","tableOfContents":{"sections":\[{"id":"delivery-semantics","title":"Delivery semantics"},{"id":"format-of-pushed-messages","title":"Format of pushed messages"},{"id":"database--scoping","title":"Database & Scoping"},{"id":"wire-protocol-example","title":"Wire protocol example"},{"id":"pattern-matching-subscriptions","title":"Pattern-matching subscriptions"},{"id":"messages-matching-both-a-pattern-and-a-channel-subscription","title":"Messages matching both a pattern and a channel subscription"},{"id":"the-meaning-of-the-subscription-count-with-pattern-matching","title":"The meaning of the subscription count with pattern matching"},{"id":"sharded-pubsub","title":"Sharded Pub/Sub"},{"id":"programming-example","title":"Programming example"},{"id":"client-library-implementation-hints","title":"Client library implementation hints"}\]},"codeExamples":\[\]}

[AI agent builder](https://redis.io/docs/latest/develop/ai/agent-builder/)

[Redis install](https://redis.io/docs/latest/operate/oss_and_stack/install/install-stack/) [Data types](https://redis.io/docs/latest/develop/data-types/)

[Tools](https://redis.io/docs/latest/develop/tools/) [Community](https://redis.io/docs/latest/operate/oss_and_stack/) [Docs](https://redis.io/docs/)


Search
[Login](https://cloud.redis.io/) [Sign up](https://redis.io/try-free/)Open searchOpen main menu

- [AI agent builder](https://redis.io/docs/latest/develop/ai/agent-builder/)

- [Redis install](https://redis.io/docs/latest/operate/oss_and_stack/install/install-stack/)

- [Data types](https://redis.io/docs/latest/develop/data-types/)

- [Tools](https://redis.io/docs/latest/develop/tools/)

- [Community](https://redis.io/docs/latest/operate/oss_and_stack/)

- [Docs](https://redis.io/docs/)


- [Sign up](https://redis.io/try-free/)
- [Login](https://cloud.redis.io/)

[Develop with Redis](https://redis.io/docs/latest/develop)

- [What's new?](https://redis.io/docs/latest/develop/whats-new/)
- [Quick starts](https://redis.io/docs/latest/develop/get-started/)
- [Client tools](https://redis.io/docs/latest/develop/tools/)
- [Client APIs](https://redis.io/docs/latest/develop/clients/)
- [Using commands](https://redis.io/docs/latest/develop/using-commands/)
- [Data types](https://redis.io/docs/latest/develop/data-types/)
- [Redis for AI and search](https://redis.io/docs/latest/develop/ai/)
- [Programmability](https://redis.io/docs/latest/develop/programmability/)
- [Use cases](https://redis.io/docs/latest/develop/use-cases/)
- [Pub/sub](https://redis.io/docs/latest/develop/pubsub/)  - [Keyspace notifications](https://redis.io/docs/latest/develop/pubsub/keyspace-notifications/)
  - [Subkey notifications](https://redis.io/docs/latest/develop/pubsub/subkeyspace-notifications/)
- [Reference](https://redis.io/docs/latest/develop/reference/)

[Libraries and tools](https://redis.io/docs/latest/integrate) [Redis products](https://redis.io/docs/latest/operate)

[Commands](https://redis.io/docs/latest/commands)

1. [DocsDocs](https://redis.io/docs/latest/)
2. → [Develop with Redis](https://redis.io/docs/latest/develop/)
3. → [Redis Pub/sub](https://redis.io/docs/latest/develop/pubsub/)

# Redis Pub/sub

How to use pub/sub channels in Redis

[`SUBSCRIBE`](https://redis.io/docs/latest/commands/subscribe/), [`UNSUBSCRIBE`](https://redis.io/docs/latest/commands/unsubscribe/) and [`PUBLISH`](https://redis.io/docs/latest/commands/publish/) implement the [Publish/Subscribe messaging paradigm](http://en.wikipedia.org/wiki/Publish/subscribe) where (citing Wikipedia) senders (publishers) are not programmed to send their messages to specific receivers (subscribers).
Rather, published messages are categorized into channels, without knowledge of what (if any) subscribers there may be.
Subscribers express interest in one or more channels and only receive messages that are of interest, without knowledge of what (if any) publishers there are.
This decoupling of publishers and subscribers allows for greater scalability and a more dynamic network topology.

For instance, to subscribe to channels "channel11" and "ch:00" the client issues a [`SUBSCRIBE`](https://redis.io/docs/latest/commands/subscribe/) providing the names of the channels:

```bash
SUBSCRIBE channel11 ch:00
```

Copied!

Messages sent by other clients to these channels will be pushed by Redis to all the subscribed clients.
Subscribers receive the messages in the order that the messages are published.

A client subscribed to one or more channels shouldn't issue commands, although it can [`SUBSCRIBE`](https://redis.io/docs/latest/commands/subscribe/) and [`UNSUBSCRIBE`](https://redis.io/docs/latest/commands/unsubscribe/) to and from other channels.
The replies to subscription and unsubscribing operations are sent in the form of messages so that the client can just read a coherent stream of messages where the first element indicates the type of message.
The commands that are allowed in the context of a subscribed RESP2 client are:

- [`PING`](https://redis.io/docs/latest/commands/ping/)
- [`PSUBSCRIBE`](https://redis.io/docs/latest/commands/psubscribe/)
- [`PUNSUBSCRIBE`](https://redis.io/docs/latest/commands/punsubscribe/)
- [`QUIT`](https://redis.io/docs/latest/commands/quit/)
- [`RESET`](https://redis.io/docs/latest/commands/reset/)
- [`SSUBSCRIBE`](https://redis.io/docs/latest/commands/ssubscribe/)
- [`SUBSCRIBE`](https://redis.io/docs/latest/commands/subscribe/)
- [`SUNSUBSCRIBE`](https://redis.io/docs/latest/commands/sunsubscribe/)
- [`UNSUBSCRIBE`](https://redis.io/docs/latest/commands/unsubscribe/)

However, if RESP3 is used (see [`HELLO`](https://redis.io/docs/latest/commands/hello/)), a client can issue any commands while in the subscribed state.

Please note that when using `redis-cli`, in subscribed mode commands such as [`UNSUBSCRIBE`](https://redis.io/docs/latest/commands/unsubscribe/) and [`PUNSUBSCRIBE`](https://redis.io/docs/latest/commands/punsubscribe/) cannot be used because `redis-cli` will not accept any commands and can only quit the mode with `Ctrl-C`.

## Delivery semantics  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#delivery-semantics "Copy link to clipboard")

Redis' Pub/Sub exhibits _at-most-once_ message delivery semantics.
As the name suggests, it means that a message will be delivered once if at all.
Once the message is sent by the Redis server, there's no chance of it being sent again.
If the subscriber is unable to handle the message (for example, due to an error or a network disconnect) the message is forever lost.

If your application requires stronger delivery guarantees, you may want to learn about [Redis Streams](https://redis.io/docs/latest/develop/data-types/streams/).
Messages in streams are persisted, and support both _at-most-once_ as well as _at-least-once_ delivery semantics.

## Format of pushed messages  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#format-of-pushed-messages "Copy link to clipboard")

A message is an [array-reply](https://redis.io/docs/latest/develop/reference/protocol-spec/#array-reply) with three elements.

The first element is the kind of message:

- `subscribe`: means that we successfully subscribed to the channel given as the second element in the reply.
The third argument represents the number of channels we are currently subscribed to.

- `unsubscribe`: means that we successfully unsubscribed from the channel given as second element in the reply.
The third argument represents the number of channels we are currently subscribed to.
When the last argument is zero, we are no longer subscribed to any channel, and the client can issue any kind of Redis command as we are outside the Pub/Sub state.

- `message`: it is a message received as a result of a [`PUBLISH`](https://redis.io/docs/latest/commands/publish/) command issued by another client.
The second element is the name of the originating channel, and the third argument is the actual message payload.


## Database & Scoping  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#database--scoping "Copy link to clipboard")

Pub/Sub has no relation to the key space.
It was made to not interfere with it on any level, including database numbers.

Publishing on db 10, will be heard by a subscriber on db 1.

If you need scoping of some kind, prefix the channels with the name of the environment (test, staging, production...).

## Wire protocol example  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#wire-protocol-example "Copy link to clipboard")

```
SUBSCRIBE first second
*3
$9
subscribe
$5
first
:1
*3
$9
subscribe
$6
second
:2
```

At this point, from another client we issue a [`PUBLISH`](https://redis.io/docs/latest/commands/publish/) operation against the channel named `second`:

```
> PUBLISH second Hello
```

This is what the first client receives:

```
*3
$7
message
$6
second
$5
Hello
```

Now the client unsubscribes itself from all the channels using the [`UNSUBSCRIBE`](https://redis.io/docs/latest/commands/unsubscribe/) command without additional arguments:

```
UNSUBSCRIBE
*3
$11
unsubscribe
$6
second
:1
*3
$11
unsubscribe
$5
first
:0
```

## Pattern-matching subscriptions  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#pattern-matching-subscriptions "Copy link to clipboard")

The Redis Pub/Sub implementation supports pattern matching.
Clients may subscribe to glob-style patterns to receive all the messages sent to channel names matching a given pattern.

For instance:

```
PSUBSCRIBE news.*
```

Will receive all the messages sent to the channel `news.art.figurative`, `news.music.jazz`, etc.
All the glob-style patterns are valid, so multiple wildcards are supported.

```
PUNSUBSCRIBE news.*
```

Will then unsubscribe the client from that pattern.
No other subscriptions will be affected by this call.

Messages received as a result of pattern matching are sent in a different format:

- The type of the message is `pmessage`: it is a message received as a result from a [`PUBLISH`](https://redis.io/docs/latest/commands/publish/) command issued by another client, matching a pattern-matching subscription.
The second element is the original pattern matched, the third element is the name of the originating channel, and the last element is the actual message payload.

Similarly to [`SUBSCRIBE`](https://redis.io/docs/latest/commands/subscribe/) and [`UNSUBSCRIBE`](https://redis.io/docs/latest/commands/unsubscribe/), [`PSUBSCRIBE`](https://redis.io/docs/latest/commands/psubscribe/) and [`PUNSUBSCRIBE`](https://redis.io/docs/latest/commands/punsubscribe/) commands are acknowledged by the system sending a message of type `psubscribe` and `punsubscribe` using the same format as the `subscribe` and `unsubscribe` message format.

## Messages matching both a pattern and a channel subscription  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#messages-matching-both-a-pattern-and-a-channel-subscription "Copy link to clipboard")

A client may receive a single message multiple times if it's subscribed to multiple patterns matching a published message, or if it is subscribed to both patterns and channels matching the message.
This is shown by the following example:

```
SUBSCRIBE foo
PSUBSCRIBE f*
```

In the above example, if a message is sent to channel `foo`, the client will receive two messages: one of type `message` and one of type `pmessage`.

## The meaning of the subscription count with pattern matching  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#the-meaning-of-the-subscription-count-with-pattern-matching "Copy link to clipboard")

In `subscribe`, `unsubscribe`, `psubscribe` and `punsubscribe` message types, the last argument is the count of subscriptions still active.
This number is the total number of channels and patterns the client is still subscribed to.
So the client will exit the Pub/Sub state only when this count drops to zero as a result of unsubscribing from all the channels and patterns.

## Sharded Pub/Sub  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#sharded-pubsub "Copy link to clipboard")

From Redis 7.0, sharded Pub/Sub is introduced in which shard channels are assigned to slots by the same algorithm used to assign keys to slots.
A shard message must be sent to a node that owns the slot the shard channel is hashed to.
The cluster makes sure the published shard messages are forwarded to all nodes in the shard, so clients can subscribe to a shard channel by connecting to either the master responsible for the slot, or to any of its replicas.
[`SSUBSCRIBE`](https://redis.io/docs/latest/commands/ssubscribe/), [`SUNSUBSCRIBE`](https://redis.io/docs/latest/commands/sunsubscribe/) and [`SPUBLISH`](https://redis.io/docs/latest/commands/spublish/) are used to implement sharded Pub/Sub.

Sharded Pub/Sub helps to scale the usage of Pub/Sub in cluster mode.
It restricts the propagation of messages to be within the shard of a cluster.
Hence, the amount of data passing through the cluster bus is limited in comparison to global Pub/Sub where each message propagates to each node in the cluster.
This allows users to horizontally scale the Pub/Sub usage by adding more shards.

## Programming example  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#programming-example "Copy link to clipboard")

Pieter Noordhuis provided a great example using EventMachine and Redis to create [a multi user high performance web chat](https://gist.github.com/pietern/348262).

## Client library implementation hints  [Copy link to clipboard](https://redis.io/docs/latest/develop/pubsub/\#client-library-implementation-hints "Copy link to clipboard")

Because all the messages received contain the original subscription causing the message delivery (the channel in the case of message type, and the original pattern in the case of pmessage type) client libraries may bind the original subscription to callbacks (that can be anonymous functions, blocks, function pointers), using a hash table.

When a message is received an O(1) lookup can be done to deliver the message to the registered callback.

RATE THIS PAGE

★★★★★

[Back to top ↑](https://redis.io/docs/latest/develop/pubsub/#)

Checking your Browser…

Verifying...

Stuck? [Troubleshoot](https://challenges.cloudflare.com/cdn-cgi/challenge-platform/h/g/turnstile/f/ov2/av0/rch/vl4t7/0x4AAAAAABpkO-YRJzl4qTBW/auto/fbE/new/normal?lang=auto#refresh)

Success!

Verification failed

[Troubleshoot](https://challenges.cloudflare.com/cdn-cgi/challenge-platform/h/g/turnstile/f/ov2/av0/rch/vl4t7/0x4AAAAAABpkO-YRJzl4qTBW/auto/fbE/new/normal?lang=auto#refresh)

Verification expired

[Refresh](https://challenges.cloudflare.com/cdn-cgi/challenge-platform/h/g/turnstile/f/ov2/av0/rch/vl4t7/0x4AAAAAABpkO-YRJzl4qTBW/auto/fbE/new/normal?lang=auto#refresh)

Verification expired

[Refresh](https://challenges.cloudflare.com/cdn-cgi/challenge-platform/h/g/turnstile/f/ov2/av0/rch/vl4t7/0x4AAAAAABpkO-YRJzl4qTBW/auto/fbE/new/normal?lang=auto#refresh)

[Troubleshoot](https://challenges.cloudflare.com/cdn-cgi/challenge-platform/h/g/turnstile/f/ov2/av0/rch/vl4t7/0x4AAAAAABpkO-YRJzl4qTBW/auto/fbE/new/normal?lang=auto#refresh)

[Privacy](https://www.cloudflare.com/privacypolicy/) • [Help](https://challenges.cloudflare.com/cdn-cgi/challenge-platform/help)

Submit


[Edit this page](https://github.com/redis/docs/edit/main/content/develop/pubsub/_index.md) [Create an issue](https://github.com/redis/docs/issues/new?title=Feedback:%20Redis%20Pub/sub&body=Page%20https://redis.io/docs/latest/develop/pubsub/) [Download Markdown](https://redis.io/docs/latest/develop/pubsub/#)

## On this page

- [Delivery semantics](https://redis.io/docs/latest/develop/pubsub/#delivery-semantics)
- [Format of pushed messages](https://redis.io/docs/latest/develop/pubsub/#format-of-pushed-messages)
- [Database & Scoping](https://redis.io/docs/latest/develop/pubsub/#database--scoping)
- [Wire protocol example](https://redis.io/docs/latest/develop/pubsub/#wire-protocol-example)
- [Pattern-matching subscriptions](https://redis.io/docs/latest/develop/pubsub/#pattern-matching-subscriptions)
- [Messages matching both a pattern and a channel subscription](https://redis.io/docs/latest/develop/pubsub/#messages-matching-both-a-pattern-and-a-channel-subscription)
- [The meaning of the subscription count with pattern matching](https://redis.io/docs/latest/develop/pubsub/#the-meaning-of-the-subscription-count-with-pattern-matching)
- [Sharded Pub/Sub](https://redis.io/docs/latest/develop/pubsub/#sharded-pubsub)
- [Programming example](https://redis.io/docs/latest/develop/pubsub/#programming-example)
- [Client library implementation hints](https://redis.io/docs/latest/develop/pubsub/#client-library-implementation-hints)

[Trust](https://trust.redis.io/) [Privacy](https://redis.io/legal/privacy-policy/) [Terms of use](https://redis.io/legal/redis-website-terms-of-use/) [Legal notices](https://redis.io/legal/)

### Compare

[Redis vs Elasticache](https://redis.io/compare/elasticache/) [Redis vs Memcached](https://redis.io/compare/memcached/) [Redis vs Memory Store](https://redis.io/compare/memorystore/) [Redis vs. Open Source](https://redis.io/compare/open-source)

### Company

[Mission & values](https://redis.io/company/) [Leadership](https://redis.io/company/team/) [Careers](https://redis.io/careers/)

### Partners

[Amazon Web Services](https://redis.io/cloud-partners/aws/) [Google Cloud](https://redis.io/cloud-partners/google/) [Microsoft Azure](https://redis.io/cloud-partners/azure/) [All partners](https://redis.io/partners/)

### Support

[Professional\\
services](https://redis.io/services/professional-services/) [Support](https://redis.io/support/)

[Trust](https://trust.redis.io/) [Privacy](https://redis.io/legal/privacy-policy/) [Terms of use](https://redis.io/legal/redis-website-terms-of-use/) [Legal notices](https://redis.io/legal/)

All productsRedis SoftwareRedis CloudRedis Open SourceRedis InsightRedis Enterprise for K8sRedis Data IntegrationClient Libraries
ESC