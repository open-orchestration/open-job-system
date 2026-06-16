[Skip to main content](https://www.rabbitmq.com/docs/dlx#__docusaurus_skipToContent_fallback)

🎉️ [**RabbitMQ 4.3** is out!](https://www.rabbitmq.com/blog/2026/04/23/rabbitmq-4.3-release) 🥳️

[![RabbitMQ](https://www.rabbitmq.com/img/rabbitmq-logo-by-tanzu.svg)](https://www.rabbitmq.com/)[Getting Started](https://www.rabbitmq.com/tutorials) [Docs](https://www.rabbitmq.com/docs) [Blog](https://www.rabbitmq.com/blog) [Support](https://www.rabbitmq.com/contact) [Commercial Features](https://www.rabbitmq.com/commercial-features)

[4.3](https://www.rabbitmq.com/docs/dlx)

- **Release series**
- [Next](https://www.rabbitmq.com/docs/next/dlx)
- [4.3](https://www.rabbitmq.com/docs/dlx)
- [4.2](https://www.rabbitmq.com/docs/4.2/dlx)
- [4.1](https://www.rabbitmq.com/docs/4.1/dlx)
- [4.0](https://www.rabbitmq.com/docs/4.0/dlx)
- [3.13](https://www.rabbitmq.com/docs/3.13/dlx)

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
- [Queues](https://www.rabbitmq.com/docs/queues)
- Dead Lettering

Version: 4.3

On this page

# Dead Letter Exchanges

## What is a Dead Letter Exchange [​](https://www.rabbitmq.com/docs/dlx\#overview "Direct link to What is a Dead Letter Exchange")

Messages from a queue can be "dead-lettered", which means these messages are republished to an exchange when any of the following four events occur.

1. The message is [negatively acknowledged](https://www.rabbitmq.com/docs/confirms) by an AMQP 1.0 receiver using the [`rejected`](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-messaging-v1.0-os.html#type-rejected)
outcome or by an AMQP 0.9.1 consumer using `basic.reject` or `basic.nack` with `requeue` parameter set to `false`, or
2. The message expires due to [per-message TTL](https://www.rabbitmq.com/docs/ttl), or
3. The message is dropped because its queue exceeded a [length limit](https://www.rabbitmq.com/docs/maxlength), or
4. The message is returned more times to a quorum queue than the [delivery-limit](https://www.rabbitmq.com/docs/quorum-queues#poison-message-handling).

If an entire [queue expires](https://www.rabbitmq.com/docs/ttl#queue-ttl), the messages in the queue are **not** dead-lettered.

Dead letter exchanges (DLXs) are normal exchanges. They can be
any of the usual types and are declared as normal.

## How Dead Lettering is Configured [​](https://www.rabbitmq.com/docs/dlx\#how-dead-lettering-is-configured "Direct link to How Dead Lettering is Configured")

For any given queue, a DLX can be defined by clients using [policies](https://www.rabbitmq.com/docs/policies). There
are several DLX-related policy keys, including some [only supported by quorum queues](https://www.rabbitmq.com/docs/quorum-queues) but the two key ones are

- `dead-letter-exchange`: The name of the DLX to use
- `dead-letter-routing-key`: The routing key to use when dead-lettering messages

important

Policy keys also can be set by applications at queue declaration time via the [optional arguments](https://www.rabbitmq.com/docs/queues#optional-arguments).

Hardcoded `x-arguments` are strongly recommended against since they
[cannot be updated without redeploying applications](https://www.rabbitmq.com/docs/queues#optional-arguments),
while policies can be updated at any moment.

In the case where both policy and arguments specify a DLX, the one
specified in arguments overrules the one specified in policy.

In addition to the target DLX name, a routing key to use when the messages are being
dead-lettered. If the routing key is not set, the
message's own routing keys are used.

When a dead letter exchange is specified, in addition to
the usual configure permissions on the declared queue, the user
must have read permissions on that queue and write
permissions on the dead letter exchange. Permissions are
verified at the time the queue is declared.

### Configuring a Dead Letter Exchange using a Policy [​](https://www.rabbitmq.com/docs/dlx\#using-policies "Direct link to Configuring a Dead Letter Exchange using a Policy")

To specify a DLX using policy, add the key "dead-letter-exchange"
to a policy definition:

- rabbitmqctl with bash
- rabbitmqctl with PowerShell
- rabbitmqadmin with bash
- rabbitmqadmin with PowerShell
- HTTP API
- Management UI

```bash
rabbitmqctl set_policy DLX ".*" '{"dead-letter-exchange":"my-dlx"}' --apply-to queues --priority 7
```

```powershell
rabbitmqctl set_policy DLX ".*" "{""dead-letter-exchange"":""my-dlx""}" --apply-to queues --priority 7
```

```bash
rabbitmqadmin policies declare \

    --name "DLX" \

    --pattern ".*" \

    --definition '{"dead-letter-exchange":"my-dlx"}' \

    --apply-to "queues" \

    --priority 7
```

```powershell
rabbitmqadmin.exe policies declare ^

    --name "DLX" ^

    --pattern ".*" ^

    --definition "{""dead-letter-exchange"":""my-dlx""}" ^

    --apply-to "queues" ^

    --priority 7
```

```ini
PUT /api/policies/%2f/DLX

    {"pattern": ".*",

     "definition": {"dead-letter-exchange":"my-dlx"},

     "priority": 7,

     "apply-to": "queues"}
```

1. Navigate to `Admin` \> `Policies` \> `Add / update a     policy`.

2. Enter a policy name (such as "DLX") next to Name, a pattern (in this example, ".\*") next to
Pattern, and select what kind of entities (all queues in this example) the policy should apply to using the `Apply to`
drop down.

3. Enter "dead-letter-exchange" for the key and "my-dlx" for its value in the first line next to
`Policy`.

4. Click `Add policy`.


The previous example declares a policy called "DLX" that applies to all queues (regardless of the type) and configures
an exchange named "my-dlx" as the dead lettering targets. This is just an example, in practice
it is common to see multiple policies that apply to a subset of queues each.

Similarly, an explicit routing key can be specified by adding
the key "dead-letter-routing-key" to the policy:

- rabbitmqctl with bash
- rabbitmqctl with PowerShell
- rabbitmqadmin with bash
- HTTP API
- Management UI

```bash
rabbitmqctl set_policy DLX ".*" '{"dead-letter-exchange":"my-dlx", "dead-letter-routing-key":"my-routing-key"}' --apply-to queues --priority 7
```

```powershell
rabbitmqctl set_policy DLX ".*" "{""dead-letter-exchange"":""my-dlx"", ""dead-letter-routing-key"":""my-routing-key""}" --apply-to queues --priority 7
```

```bash
rabbitmqadmin policies declare --name=DLX --pattern=".*" --definition='{"dead-letter-exchange":"my-dlx", "dead-letter-routing-key":"my-routing-key"}' --apply-to=queues --priority=7
```

```ini
PUT /api/policies/%2f/DLX

    {"pattern": ".*",

     "definition": {"dead-letter-exchange":"my-dlx"},

     "priority": 7,

     "apply-to": "queues"}
```

1. Navigate to `Admin` \> `Policies` \> `Add / update a     policy`.

2. Enter a policy name (such as "DLX") next to Name, a pattern (in this example, ".\*") next to
Pattern, and select what kind of entities (all queues in this example) the policy should apply to using the `Apply to`
drop down.

3. Enter "dead-letter-exchange" for the key and "my-dlx" for its value in the first line next to
`Policy`.

4. Click `Add policy`.


### Configuring a Dead Letter Exchange using Optional Queue Arguments [​](https://www.rabbitmq.com/docs/dlx\#using-optional-queue-arguments "Direct link to Configuring a Dead Letter Exchange using Optional Queue Arguments")

warning

Hardcoded `x-arguments` are strongly recommended against since they
[cannot be updated without redeploying applications and deleting the queue before it can be redeclared](https://www.rabbitmq.com/docs/queues#optional-arguments),
while policies can be updated at any moment.

To set the DLX for a queue, specify
the optional `x-dead-letter-exchange` argument when
declaring the queue. The value must be an exchange name in
the same virtual host:

```java
channel.exchangeDeclare("some.exchange.name", "direct");

// Important: prefer using policies over hardcoded x-arguments

Map<String, Object> args = new HashMap<String, Object>();

args.put("x-dead-letter-exchange", "some.exchange.name");

channel.queueDeclare("myqueue", false, false, false, args);
```

The above code declares a new exchange called
`some.exchange.name` and sets this new exchange
as the dead letter exchange for a newly created queue.
Note, the exchange does not have to be declared when
the queue is declared but it should exist by the time
messages need to be dead-lettered. If it is missing then,
the messages are silently dropped.

In addition to the target DLX name, a routing key to use when the messages are being
dead-lettered. If the routing key is not set, the
message's own routing keys are used.

```java
// Important: prefer using policies over hardcoded x-arguments.

Map<String, Object> args = new HashMap<String, Object>();

args.put("x-dead-letter-exchange", "some.exchange.name");

args.put("x-dead-letter-routing-key", "some-routing-key");
```

When a dead letter exchange is specified, in addition to
the usual configure permissions on the declared queue, the user
must have read permissions on that queue and write
permissions on the dead letter exchange. Permissions are
verified at the time the queue is declared.

## Routing Dead-Lettered Messages [​](https://www.rabbitmq.com/docs/dlx\#routing "Direct link to Routing Dead-Lettered Messages")

Dead-lettered messages are routed to their dead letter
exchange either:

- with the routing key specified for the queue they
were on; or, _if this was not set_,
- with the same routing keys they were originally
published with

For example, if you publish a message to an exchange with a `foo`
routing key, and that message is
dead-lettered, it is published to its dead letter
exchange with the `foo` routing key. If the queue
the message originally landed on is declared with
`x-dead-letter-routing-key` set to
`bar`, then the message is published to
its dead letter exchange with the `bar` routing key.

Note, if a specific routing key was not set for the
queue, messages on it are dead-lettered with _all_
their original routing keys. This includes routing keys
added by the `CC` and `BCC` headers
(refer to [Sender-selected distribution](https://www.rabbitmq.com/docs/sender-selected) for details about these two headers).

### Dead-letter cycle [​](https://www.rabbitmq.com/docs/dlx\#dead-letter-cycle "Direct link to Dead-letter cycle")

It is possible to form a cycle of message dead-lettering where the same message reaches the same queue twice.
For example, this can happen when a queue "dead-letters" messages to the default exchange without specifying a dead-letter routing key.
To prevent automatic infinite message looping within RabbitMQ, RabbitMQ will detect a cycle and drop the message _if there was no rejection in the entire cycle_.

## Safety [​](https://www.rabbitmq.com/docs/dlx\#safety "Direct link to Safety")

Dead-lettering is a form of message publishing, and as any form of publishing,
it can fail in certain scenarios. For example, if dead lettering is
configured to use a quorum queue that does not have an online quorum,
the publishing will fail, and the node perfoming dead lettering will log
a message similar to the following:

```text
Cannot forward any dead-letter messages from source quorum queue 'qq.input' in vhost 'my-vhost'

with configured dead-letter-exchange exchange 'amq.topic' in vhost 'my-vhost'

and configured dead-letter-routing-key 'my-app.events.type.abc'
```

### Re-Publishing with Publisher Confirms [​](https://www.rabbitmq.com/docs/dlx\#re-publishing-with-publisher-confirms "Direct link to Re-Publishing with Publisher Confirms")

By default, dead-lettered messages are re-published _without_ publisher
[confirms](https://www.rabbitmq.com/docs/confirms) turned on internally. Therefore using DLX in a clustered
RabbitMQ environment is not guaranteed to be safe. Messages are removed from the
original queue immediately after publishing to the DLX target queue. This ensures
that there is no chance of excessive message build up that could exhaust broker
resources. However, messages can be lost if the target queue is not available to accept messages.

Quorum queues support [at-least-once dead-lettering](https://www.rabbitmq.com/docs/quorum-queues#dead-lettering)
where messages are re-published with publisher confirms turned on internally.

## Dead-Lettered Effects on Messages [​](https://www.rabbitmq.com/docs/dlx\#effects "Direct link to Dead-Lettered Effects on Messages")

Dead-lettering a message modifies its headers:

- the exchange name is replaced with that of the latest dead-letter exchange
- the routing key may be replaced with that specified in a queue performing dead lettering (i.e. configured `dead-letter-routing-key`),
- if the above happens, the `CC` header will also be removed, and
- the `BCC` header will be removed as per [Sender-selected distribution](https://www.rabbitmq.com/docs/sender-selected)

A single message can be dead lettered multiple times.
Each time a message is dead lettered, this event will be recorded within the message header.
To prevent the header from growing unboundedly, the dead letter event history is compressed by the `{Queue, Reason}` pair.

An AMQP 1.0 message will contain a [message annotation](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-messaging-v1.0-os.html#type-message-annotations)
with a symbolic key `x-opt-deaths` and the value being an [array](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-types-v1.0-os.html#type-array)
of [map](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-types-v1.0-os.html#type-map) s.
An AMQP 0.9.1 message will contain an `x-death` header with the value being an array.
The array in both AMQP 1.0 and AMQP 0.9.1 is ordered by recency, that is the most recent dead-lettering event is recorded in the first array element.

The following table describes the AMQP 1.0 map key value pairs and the AMQP 0.9.1 table of the array elements.
All AMQP 1.0 keys are of type `symbol`. AMQP 1.0 clients must not depend on the order of the map's key-value pairs.

| AMQP 1.0 key | AMQP 1.0 value type | AMQP 0.9.1 key | AMQP 0.9.1 value type | Description |
| --- | --- | --- | --- | --- |
| queue | string | queue | longstr | The name of the queue this message was dead lettered from. |
| reason | symbol | reason | longstr | Why this message was dead lettered (described below). |
| count | ulong | count | long | How many times this message was dead lettered from this queue for this reason. |
| first-time | [timestamp](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-types-v1.0-os.html#type-timestamp) |  |  | When this message was dead lettered the first time from this queue for this reason. |
| last-time | [timestamp](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-types-v1.0-os.html#type-timestamp) |  |  | When this message was dead lettered the last time from this queue for this reason. |
|  |  | time | timestamp | When this message was dead lettered the first time from this queue for this reason. |
| exchange | string | exchange | longstr | The exchange this message was published to before this message got dead lettered for the first time from this queue for this reason. |
| routing-keys | array of string | routing-keys | array of longstr | The routing keys (including `CC` but excluding `BCC`) of this message before it got dead lettered for the first time from this queue for this reason. |
| ttl | uint |  |  | AMQP 1.0 [header](https://docs.oasis-open.org/amqp/core/v1.0/os/amqp-core-messaging-v1.0-os.html#type-header)'s `ttl` (time to live in milliseconds) before this message got dead lettered for the first time from this queue for this reason. |
|  |  | original-expiration | longstr | The original `expiration` property of this message before it got dead lettered for the first time from this queue for this reason. |

AMQP 1.0 `ttl` and AMQP 0.9.1 `original-expiration` are optional and recorded because the original message's TTL is removed from the message on dead-lettering to prevent it from expiring again in any queues it is routed to.

The `reason` is a name describing why the
message was dead-lettered and is one of the following:

- `rejected`: the message was rejected
- `expired`: the [message TTL](https://www.rabbitmq.com/docs/ttl) has expired
- `maxlen`: the [maximum allowed queue length](https://www.rabbitmq.com/docs/maxlength) was exceeded
- `delivery_limit`: the message is returned more times than the limit (set by policy argument [delivery-limit](https://www.rabbitmq.com/docs/quorum-queues#poison-message-handling) of quorum queues).

In addition, the following six AMQP 1.0 message annotations or AMQP 0.9.1 headers are added for the very first dead-lettering event:

1. `x-first-death-queue`: The first queue this message was dead lettered from.
2. `x-first-death-reason`: Why this message was dead lettered for the first time.
3. `x-first-death-exchange`: The exchange this message was published to before this message got dead lettered for the first time.
4. `x-last-death-queue`: The last queue this message was dead lettered from.
5. `x-last-death-reason`: Why this message was dead lettered for the last time.
6. `x-last-death-exchange`: The exchange this message was published to before this message got dead lettered the last time.

The `x-first-*` annotations are never modified.
Whenever a message is dead lettered subsequently, the `x-last-*` annotations are updated.

[Edit this page](https://github.com/rabbitmq/rabbitmq-website/tree/main/versioned_docs/version-4.3/dlx.md)

[Previous\\
\\
Lazy Queues](https://www.rabbitmq.com/docs/lazy-queues) [Next\\
\\
Priority Queues](https://www.rabbitmq.com/docs/priority)

- [What is a Dead Letter Exchange](https://www.rabbitmq.com/docs/dlx#overview)
- [How Dead Lettering is Configured](https://www.rabbitmq.com/docs/dlx#how-dead-lettering-is-configured)
  - [Configuring a Dead Letter Exchange using a Policy](https://www.rabbitmq.com/docs/dlx#using-policies)
  - [Configuring a Dead Letter Exchange using Optional Queue Arguments](https://www.rabbitmq.com/docs/dlx#using-optional-queue-arguments)
- [Routing Dead-Lettered Messages](https://www.rabbitmq.com/docs/dlx#routing)
  - [Dead-letter cycle](https://www.rabbitmq.com/docs/dlx#dead-letter-cycle)
- [Safety](https://www.rabbitmq.com/docs/dlx#safety)
  - [Re-Publishing with Publisher Confirms](https://www.rabbitmq.com/docs/dlx#re-publishing-with-publisher-confirms)
- [Dead-Lettered Effects on Messages](https://www.rabbitmq.com/docs/dlx#effects)

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