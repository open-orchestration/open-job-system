---
id: df270589c
topic: brokers
title: "RabbitMQ consumers: acknowledgements, prefetch, and consumer timeout"
status: draft
shape: mechanism
---

# RabbitMQ consumers: acknowledgements, prefetch, and consumer timeout

In RabbitMQ a consumer is an application (or application instance) that consumes and acknowledges messages, and is a lasting subscription for message delivery that must be registered before deliveries begin and can be cancelled by the application [c95827d78]. Consumers consume from queues, and when a new consumer is added — assuming there are already messages ready in the queue — deliveries start immediately [c95827d78]. Consumers are meant to be long lived, receiving multiple deliveries throughout their lifetime, so registering a consumer to consume a single message is not optimal [c95827d78].

## How consumers receive messages: push vs. poll

The primary mechanism is a push API: applications subscribe to have RabbitMQ push enqueued messages (deliveries) to them by registering a consumer (subscription) on a queue, after which RabbitMQ begins delivering messages and invokes a user-provided handler for each delivery [c95827d78]. A successful subscription returns a subscription identifier (consumer tag) that can later be used to cancel the consumer [c95827d78].

The alternative is a pull API based on polling: with AMQP 0-9-1 it is possible to fetch messages one by one using the `basic.get` protocol method, with messages fetched in FIFO order and using either automatic or manual acknowledgements [c95827d78]. The documentation marks this as a "danger": fetching messages one by one is highly discouraged because it is very inefficient compared to regular long-lived consumers, and it is extremely wasteful in systems where publishing is sporadic and queues can stay empty for prolonged periods [c95827d78]. The guidance is to use long-lived consumers instead of polling [c95827d78].

## Acknowledgement modes

When registering a consumer, applications choose one of two delivery (acknowledgement) modes: automatic, where deliveries require no acknowledgement (a.k.a. "fire and forget"), or manual, where deliveries require client acknowledgement [c95827d78]. Consumer acknowledgements, together with publisher confirms, are the subject of a separate documentation guide [c95827d78].

## Negative acknowledgement and requeueing

Each delivery carries a Redelivered boolean that is set to `true` if the message was previously delivered and requeued [c95827d78]. Cancelling a consumer neither discards nor requeues in-flight deliveries; to re-queue in-flight deliveries the application must close the channel [c95827d78].

## Prefetch: limiting outstanding deliveries

With manual acknowledgement mode, consumers have a way of limiting how many deliveries can be "in flight" — in transit over the network or delivered but unacknowledged — which can avoid consumer overload [c95827d78]. Prefetch interacts with throughput: the consumer capacity metric (previously consumer utilisation) is computed as the fraction of time a queue is able to immediately deliver messages to consumers, and when it is below 100% the queue leader replica may be able to deliver faster if there were more consumers, if consumers spent less time processing deliveries, or if the consumer channels used a higher prefetch value [c95827d78]. Prefetch, together with consumer acknowledgements, is covered in a separate documentation guide [c95827d78].

## Delivery acknowledgement timeout

RabbitMQ enforces a timeout on consumer delivery acknowledgement as a protection mechanism that detects when consumers do not acknowledge deliveries, which can help prevent on-disk data compaction from driving nodes out of disk space [c95827d78]. Starting with RabbitMQ 4.3, delivery acknowledgement timeouts are only supported by quorum queues [c95827d78]. If a consumer does not ack its delivery within the timeout value, its channel is closed with a `PRECONDITION_FAILED` channel exception, the error is logged by the node the consumer was connected to, and all following deliveries on that channel from all consumers are then requeued [c95827d78]. To resolve a `PRECONDITION_FAILED` channel exception, the documentation advises reevaluating the consumer and considering increasing the timeout value [c95827d78].

The default timeout value for RabbitMQ is 30 minutes [c95827d78]. Whether the timeout should be enforced is evaluated periodically, at one minute intervals; values lower than one minute are not supported, and values lower than five minutes are not recommended [c95827d78].

The timeout is configurable per node in `rabbitmq.conf` in milliseconds — `consumer_timeout = 1800000` is given as "30 minutes in milliseconds" and `consumer_timeout = 3600000` as "one hour in milliseconds" [c95827d78]. The timeout can be deactivated via `advanced.config` by setting `consumer_timeout` to `undefined`, but this is not recommended; instead the guidance is to use a high value such as a few hours [c95827d78]. Since RabbitMQ 3.12 the timeout can also be configured per queue, either by setting the `consumer-timeout` policy key (value in milliseconds) or by setting the `x-consumer-timeout` optional queue argument when the queue is declared [c95827d78].

## Scope note

The source body describes acknowledgement modes, prefetch, and the timeout at the level above; the detailed mechanics of consumer acknowledgements, negative acknowledgements, and prefetch are deferred by the source to separate guides and are not restated here [c95827d78].
