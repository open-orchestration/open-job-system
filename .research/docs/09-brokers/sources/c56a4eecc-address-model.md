# Address Model

[User Manual for 2.54.0](https://artemis.apache.org/components/artemis/documentation/latest/index.html)

- [1\. Address](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#address)
- [2\. Queue](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#queue)
- [3\. Routing Type](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#routing-type)
- [4\. Automatic Configuration](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#automatic-configuration)
- [5\. Basic Manual Configuration](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#basic-manual-configuration)
  - [5.1. Anycast](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#anycast)
  - [5.2. Multicast](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#multicast)
- [6\. Advanced Manual Configuration](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#advanced-manual-configuration)
  - [6.1. Fully Qualified Queue Names](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#fully-qualified-queue-names)
  - [6.2. Disabled Queue](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#disabled-queue)
  - [6.3. UUID Resources](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#uuid-resources)
  - [6.4. Other Advanced Configurations](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#other-advanced-configurations)
- [7\. How to filter messages](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#how-to-filter-messages)
  - [7.1. Queue Filter](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#queue-filter)
  - [7.2. Consumer Filters](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#consumer-filters)
- [8\. Alternate Ways to Determine Routing Type](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#alternate-ways-to-determine-routing-type)
  - [8.1. Using a Prefix to Determine Routing Type](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#using-a-prefix-to-determine-routing-type)
  - [8.2. Using a Message Property to Determine Routing Type](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#using-a-message-property-to-determine-routing-type)

Every supported messaging protocol and API defines a different set of messaging resources.

- JMS uses _queues_ and _topics_

- STOMP uses generic _destinations_

- MQTT uses _topics_

- AMQP uses generic _nodes_


In order to deal the the unique semantics and use-cases for each of these the broker has a flexible and powerful address model based on the following _core_ set of resources:

- **address**

- **queue**

- **routing type**


## [1\. Address](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#address)

Messages are _sent_ to an address.
An address is given a unique name, a routing type, and zero or more queues.

## [2\. Queue](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#queue)

Messages are _consumed_ from a queue.
A queue is bound to an address.
It is given a unique name and a routing type.
There can be zero or more queues bound to one address.
When a message is sent to an address it is routed to one or more of its queues based on the configured routing type.

The name of the queue must be _globally_ unique.
For example, you can’t have a queue named `q1` on address `a1` and also a queue named `q1` address `a2`.

## [3\. Routing Type](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#routing-type)

A routing type determines how messages are routed from an address to the queue(s) bound to that address.
Two different routing types are supported, **anycast** and **multicast**.

| If you want your messages routed to…​ | Use this routing type…​ |
| --- | --- |
| a single queue on the address | anycast |
| every queue on the address | multicast |

|     |     |
| --- | --- |
|  | It is possible to define queues with a different routing type for the same address, but this typically results in an anti-pattern and is therefore not recommended. |

## [4\. Automatic Configuration](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#automatic-configuration)

By default, the broker will automatically create addresses and queues to support the semantics of whatever protocol you’re using.
The broker understands how to support each protocol’s functionality with the core resources so that in most cases no manual configuration is required.
This saves you from having to preconfigure each address and queue before a client can connect to it.

The broker can optionally be configured to automatically delete addresses and queues when they are no longer in use.

Automatic creation and deletion is configured on a per address basis and is controlled by the following [`address-setting`](https://artemis.apache.org/components/artemis/documentation/latest/address-settings.html#address-settings) elements:

- `auto-create-addresses`

- `auto-delete-addresses`

- `default-address-routing-type`

- `auto-create-queues`

- `auto-delete-queues`

- `default-queue-routing-type`


|     |     |
| --- | --- |
|  | Automatic queue creation is for queues that _would not otherwise be created during normal operation_.<br>For example, when a remote application creates a consumer on a JMS topic then a queue will be created representing that subscription as described in the [JMS-to-core mapping chapter](https://artemis.apache.org/components/artemis/documentation/latest/jms-core-mapping.html).<br>This queue will be created regardless of how `auto-create-queues` is configured because it is required for _normal operation_. |

See [the documentation on address settings](https://artemis.apache.org/components/artemis/documentation/latest/address-settings.html#address-settings) for more details on these elements.

Of course, automatic configuration can be disabled and everything can be configured manually.
Read on for more details about manual configuration.

## [5\. Basic Manual Configuration](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#basic-manual-configuration)

The following examples show how to configure resources for basic anycast and multicast use-cases.

|     |     |
| --- | --- |
|  | Many of the details of these use-cases are protocol agnostic.<br>The goal here is to demonstrate and explain the basic configuration elements and how the address model works fundamentally. |

### [5.1. Anycast](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#anycast)

The most common use-case for anycast semantics, sometimes referred to as [point-to-point](https://artemis.apache.org/components/artemis/documentation/latest/messaging-concepts.html#point-to-point), involves applications following a "competing consumer" pattern to receive messages from a shared queue.
The more consumers receiving messages the greater the overall message throughput.
Multiple Java applications sharing a JMS queue is a classic example of this use-case.

In this use-case the broker is configured, for example, with an address, `address.foo` using the `anycast` routing type with just one queue, `q1`.
When a producer sends a message to `address.foo` it is then routed to `q1` and finally dispatched to one of the consumers.

![Anycast](https://artemis.apache.org/components/artemis/documentation/latest/images/anycast.png) Figure 1.
Anycast

This is what the configuration for this use-case would look like in `etc/broker.xml`:

```
<addresses>
   <address name="address.foo">
      <anycast>
         <queue name="q1"/>
      </anycast>
   </address>
</addresses>
```

For most protocols and APIs which support this kind of use-case (e.g. JMS, AMQP, etc.) it is customary to use the _same name_ when sending and consuming messages.
In that case you’d use a configuration like this:

```
<addresses>
   <address name="orderQueue">
      <anycast>
         <queue name="orderQueue"/>
      </anycast>
   </address>
</addresses>
```

### [5.2. Multicast](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#multicast)

The most common use-case for multicast semantics, sometimes referred to as [publish/subscribe](https://artemis.apache.org/components/artemis/documentation/latest/messaging-concepts.html#publish-subscribe) or "pub/sub", involves each application receiving every message sent to an address.
Multiple applications consuming from a JMS topic is a classic example of this use-case.
MQTT subscriptions is another supported example of multicast semantics.

In this use-case the broker is configured with an address, `address.foo` using the `multicast` routing type with two queues, `q1` & `q2`.
When a producer sends a message to `address.foo` it is then routed to _both_`q1` & `q2` so that ultimately both consumers receive the same messages.

![Multicast](https://artemis.apache.org/components/artemis/documentation/latest/images/multicast.png) Figure 2.
Multicast

This is what the configuration for this use-case would look like in `etc/broker.xml`:

```
<addresses>
   <address name="address.foo">
      <multicast>
         <queue name="q1"/>
         <queue name="q2"/>
      </multicast>
   </address>
</addresses>
```

This basic configuration is simple and straight-forward, but there’s a problem.
In a normal pub/sub use-case like with a JMS topic or with MQTT the number of subscribers _isn’t known ahead of time_.
In that case, this is the recommended configuration:

```
<addresses>
   <address name="address.foo">
      <multicast/>
   </address>
</addresses>
```

Define `<multicast/>` with no queues and the broker will automatically create queues for each subscription when the consumers connect to `address.foo`.
Then when a message is sent to `address.foo` it will be routed to each queue for each subscriber and therefore each subscriber will get every message.
These queues are often referred to as _subscription queues_ for obvious reasons.

These subscription queues are typically named based on the semantics of the protocol used to create them.
For example, JMS supports durable and non-durable subscriptions.
The queue for a non-durable subscription is named with a [UUID](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#uuid-formats), but the queue used for a durable subscription is named according to the JMS "client ID" and "subscription name." Similar conventions are used for AMQP, MQTT, STOMP, etc.

## [6\. Advanced Manual Configuration](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#advanced-manual-configuration)

### [6.1. Fully Qualified Queue Names](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#fully-qualified-queue-names)

In most cases it’s not necessary or desirable to statically configure the aforementioned subscription queues.
However, there are scenarios where a user may want to statically configure a subscription queue and later connect to that queue directly using a **Fully Qualified Queue Name** (FQQN).

An FQQN uses a special syntax to specify _both_ the address and the queue so that applications using protocols and APIs which don’t natively understand the address/queue separation (e.g. AMQP, JMS, etc.) can send messages or subscribe _directly_ to a queue rather than being limited to the address.
Applications simply need to use the address name and the queue name separated by `::` (e.g. `address::queue`).

In this example, the address `a1` is configured with two queues: `q1`, `q2` as shown in the configuration below.

```
<addresses>
   <address name="a1">
      <multicast>
         <queue name="q1" />
         <queue name="q2" />
      </multicast>
   </address>
</addresses>
```

Here’s a snippet of Java code using JMS which demonstrates the FQQN syntax:

```
Queue q1 session.createQueue("a1::q1");
MessageConsumer consumer = session.createConsumer(q1);
```

|     |     |
| --- | --- |
|  | The string `::` should only be used for FQQN and not in any other context in address or queue names. |

The examples below show how to use broker side configuration to statically configure a queue with publish subscribe behavior for shared, non-shared, durable and non-durable subscription behavior.

#### [6.1.1. Shared, Durable Subscription Queue using `max-consumers`](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#shared-durable-subscription-queue-using-max-consumers)

The default behavior for queues is to not limit the number connected queue consumers.
The `max-consumers` parameter of the queue element can be used to limit the number of connected consumers allowed at any one time.

Open the file `etc/broker.xml` for editing.

```
<addresses>
   <address name="durable.foo">
      <multicast>
         <!-- pre-configured shared durable subscription queue -->
         <queue name="q1" max-consumers="10">
            <durable>true</durable>
         </queue>
      </multicast>
   </address>
</addresses>
```

#### [6.1.2. Non-shared, Durable Subscription Queue](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#non-shared-durable-subscription-queue)

The broker can be configured to prevent more than one consumer from connecting to a queue at any one time.
The subscriptions to queues configured this way are therefore "non-shared".
To do this simply set the `max-consumers` parameter to `1`:

```
<addresses>
   <address name="durable.foo">
      <multicast>
         <!-- pre-configured non shared durable subscription queue -->
         <queue name="q1" max-consumers="1">
            <durable>true</durable>
         </queue>
      </multicast>
   </address>
</addresses>
```

#### [6.1.3. Non-durable Subscription Queue](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#non-durable-subscription-queue)

Non-durable subscriptions are again usually managed by the relevant protocol manager, by creating and deleting temporary queues.

If a user requires to pre-create a queue that behaves like a non-durable subscription queue the `purge-on-no-consumers` flag can be enabled on the queue.
When `purge-on-no-consumers` is set to `true`.
The queue will not start receiving messages until a consumer is attached.
When the last consumer is detached from the queue.
The queue is purged (its messages are removed) and will not receive any more messages until a new consumer is attached.

Open the file `etc/broker.xml` for editing.

```
<addresses>
   <address name="non.shared.durable.foo">
      <multicast>
         <queue name="orders1" purge-on-no-consumers="true"/>
      </multicast>
   </address>
</addresses>
```

### [6.2. Disabled Queue](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#disabled-queue)

If a user requires to statically configure a queue and disable routing to it, for example where a queue needs to be defined so a consumer can bind, but you want to disable message routing to it for the time being.

Or you need to stop message flow to the queue to allow investigation keeping the consumer bound, but don’t wish to have further messages routed to the queue to avoid message build up.

When `enabled` is set to `true` the queue will have messages routed to it.
(default)

When `enabled` is set to `false` the queue will NOT have messages routed to it.

Open the file `etc/broker.xml` for editing.

```
<addresses>
   <address name="foo.bar">
      <multicast>
         <queue name="orders1" enabled="false"/>
      </multicast>
   </address>
</addresses>
```

|     |     |
| --- | --- |
|  | Disabling all the queues on an address means that any message sent to that address will be silently dropped. |

### [6.3. UUID Resources](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#uuid-resources)

Some protocols and APIs support creating anonymous (i.e. unnamed) resources (e.g. a JMS queue created via [`createTemporaryQueue`](https://docs.oracle.com/javaee/7/api/javax/jms/Session.html#createTemporaryQueue--) or a JMS topic created via [`createTemporaryTopic`](https://docs.oracle.com/javaee/7/api/javax/jms/Session.html#createTemporaryTopic--)).
These resources are ultimately created using a UUID (i.e universally unique identifier) as the name for both the address and the queue (as necessary).
However, since the name is a UUID it is impossible to create an `address-setting` or `security-setting` for it whose `match` is anything but `#`.

To enable more specific configurations one can specify the `uuid-namespace` in `broker.xml` and then create an `address-setting` or `security-setting` whose `match` value corresponds to the configured `uuid-namespace`, e.g.:

```
<uuid-namespace>uuid</uuid-namespace>

<address-settings>
   <address-setting match="uuid.#">
      <enable-metrics>false</enable-metrics>
   </address-setting>
</address-settings>
```

Any resource named using a UUID will have metrics disabled using this configuration. The default `uuid-namespace` is empty.

|     |     |
| --- | --- |
|  | This setting does _not_ change the actual name of the resource.<br>It only changes the name used to _lookup_ address-settings or security-settings. |

#### [6.3.1. UUID Formats](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#uuid-formats)

The broker supports two different UUID formats - Core and OpenWire

##### [Core UUID](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#core-uuid)

A Core UUID is a 36-character string that follows the pattern `X-X-X-X-X` where:

- The first group consists of 8 hex characters.

- The second, third, and fourth groups consist of 4 hex characters each.

- The fifth group consists of 12 hex characters.

- A hyphen separates each group of hex characters.

- A "hex character" is one of the following: `abcdef0123456789`.


Here’s an example: `c7ef2580-210f-11f0-bef5-3ce1a1d12939`.

##### [OpenWire UUID](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#openwire-uuid)

An OpenWire UUID is a variable length string that follows the pattern `X-X-X-X:X:X` where:

- The first group is a prefix of arbitrary content and length. The default prefix is `ID:` plus hostname.

- The second, third, and fourth groups consist of digits separated from each other by a `-` character.

- The fifth and sixth group consists of digits separated from each previous group by a `:` character.


Here’s an example: `ID:localhost-45187-1745501083698-10000:1:10001`.

### [6.4. Other Advanced Configurations](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#other-advanced-configurations)

Each of the following advanced configurations have their own chapter so their details are not repeated here:

- [Exclusive queues](https://artemis.apache.org/components/artemis/documentation/latest/exclusive-queues.html#exclusive-queues)

- [Last Value queues](https://artemis.apache.org/components/artemis/documentation/latest/last-value-queues.html#last-value-queues)

- [Non-Destructive queues](https://artemis.apache.org/components/artemis/documentation/latest/non-destructive-queues.html#non-destructive-queues)

- [Ring queues](https://artemis.apache.org/components/artemis/documentation/latest/ring-queues.html#ring-queue)

- [Retroactive addresses](https://artemis.apache.org/components/artemis/documentation/latest/retroactive-addresses.html#retroactive-addresses)


## [7\. How to filter messages](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#how-to-filter-messages)

Messages can be filtered using [Filter Expressions](https://artemis.apache.org/components/artemis/documentation/latest/filter-expressions.html#filter-expressions).

Filters can be applied in two places - on a queue and on a consumer.

Filtering messages on a queue increases performance vs.
filtering on the consumer because the messages don’t need to be scanned.
However, a queue filter is often not as flexible.

### [7.1. Queue Filter](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#queue-filter)

When a filter is applied to a queue, messages are filtered _before_ they are routed to the queue.
To add a filter use the `filter` element when configuring a queue, e.g.:

```
<addresses>
   <address name="filter">
      <anycast>
         <queue name="filter">
            <filter string="color='red'"/>
         </queue>
      </anycast>
   </address>
</addresses>
```

The filter defined above ensures that only messages with an attribute `"color='red'"` is sent to this queue.

### [7.2. Consumer Filters](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#consumer-filters)

Consumer filters are applied _after_ messages have routed to the queue and are defined using the appropriate client APIs.
The following JMS example shows how consumer filters work.

Define an address with a single queue, with no filter applied in `etc/broker.xml`.

```
<addresses>
   <address name="filter">
      <anycast>
         <queue name="filter"/>
      </anycast>
   </address>
</addresses>
```

Then send some messages to the queue.

```
...
// Send some messages
for (int i = 0; i < 3; i ++) {
  TextMessage redMessage = senderSession.createTextMessage("Red");
  redMessage.setStringProperty("color", "red");
  producer.send(redMessage)

  TextMessage greenMessage = senderSession.createTextMessage("Green");
  greenMessage.setStringProperty("color", "green");
  producer.send(greenMessage)
}
```

At this point the queue would have 6 messages: red, green, red, green, red, green.

Create a consumer with the filter `color='red'`.

```
MessageConsumer redConsumer = redSession.createConsumer(queue, "color='red'");
```

The `redConsumer` has a filter that only matches "red" messages.
The `redConsumer` will receive 3 messages.

```
red, red, red
```

The resulting queue would now be

```
green, green, green
```

## [8\. Alternate Ways to Determine Routing Type](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#alternate-ways-to-determine-routing-type)

Typically the routing type is determined either by the static XML configuration or by the `default-address-routing-type` and `default-queue-routing-type``address-setting` elements used for [automatic address and queue creation](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html#automatic-configuration).
However, there are two other ways to specify routing type:

- a configurable prefix which client applications can use when sending messages or creating consumers

- a property client applications can set on the messages they send


### [8.1. Using a Prefix to Determine Routing Type](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#using-a-prefix-to-determine-routing-type)

These prefixes are configured using the `anycastPrefix` and `multicastPrefix` parameters within the URL of the `acceptor` which the client is using.
When multiple values are needed, these can be separated by a comma.

#### [8.1.1. Configuring an Anycast Prefix](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#configuring-an-anycast-prefix)

In `etc/broker.xml`, add the `anycastPrefix` to the URL of the desired `acceptor`.
In the example below, the acceptor is configured to use `queue/` for the `anycastPrefix`.
Client code can specify `queue/foo/` if the client wants anycast routing.

```
<acceptor name="artemis">tcp://0.0.0.0:61616?protocols=AMQP;anycastPrefix=queue/</acceptor>
```

Consider, for example, a STOMP client that wants to send a message using anycast semantics to a queue that doesn’t exist.
Consider also that the broker is configured to auto-create addresses and queues, but the `default-address-routing-type` and `default-queue-routing-type` are both `MULTICAST`.
Since the `anycastPrefix` is `queue/` it can just send a message to `queue/foo` and the broker will automatically create an address named `foo` with an anycast queue also named `foo`.

#### [8.1.2. Configuring a Multicast Prefix](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#configuring-a-multicast-prefix)

In `etc/broker.xml`, add the `multicastPrefix` to the URL of the desired `acceptor`.
In the example below, the acceptor is configured to use `topic/` for the `multicastPrefix`.
Client code can specify `topic/foo/` if the client wants multicast routing.

```
<acceptor name="artemis">tcp://0.0.0.0:61616?protocols=AMQP;multicastPrefix=topic/</acceptor>
```

Consider, for example, a STOMP client that wants to create a subscription with multicast semantics on an address that doesn’t exist.
Consider also that the broker is configured to auto-create addresses and queues, but the `default-address-routing-type` and `default-queue-routing-type` are both `ANYCAST`.
Since the `multicastPrefix` is `topic/` it can just subscribe to `topic/foo` and the broker will automatically create an address named `foo` with a multicast queue for the subscription.
Any messages sent to `foo` will then be routed to the subscription queue.

### [8.2. Using a Message Property to Determine Routing Type](https://artemis.apache.org/components/artemis/documentation/latest/address-model.html\#using-a-message-property-to-determine-routing-type)

The `AMQ_ROUTING_TYPE` _property represents a `byte` value which will be used by the broker to determine the routing type when a message is \_sent_.
Use `0` for anycast routing or `1` for multicast routing.

|     |     |
| --- | --- |
|  | A message will **only** be routed to queues which match its `_AMQ_ROUTING_TYPE` property value (if any).<br>For example, if a message with an `_AMQ_ROUTING_TYPE` value of `1` (i.e. multicast) is sent to an address that only has anycast queues then the message won’t actually be routed to any of the queues since the routing types don’t match.<br>If no `_AMQ_ROUTING_TYPE` is set then the message will be routed to all the queues on the address according to the queues' routing semantics. |