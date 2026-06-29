---
id: d6a62b548
topic: brokers
title: 'How RabbitMQ delivery guarantees underpin reliable job delivery'
status: draft
shape: single-entity
---

# How RabbitMQ delivery guarantees underpin reliable job delivery

Job frameworks such as Celery, Sidekiq, and BullMQ delegate durability to a broker. RabbitMQ's reliability model shows what that broker layer must provide: end-to-end delivery guarantees built from two symmetric acknowledgement mechanisms.

## Acknowledgements and confirms

RabbitMQ distinguishes consumer-to-broker confirmations, called acknowledgements, from broker-to-publisher confirmations, a protocol extension called publisher confirms [ca1b52a3b]. Both are described as essential for data safety and reliable delivery [ca1b52a3b]. The reliability guide states the resulting guarantee plainly: use of acknowledgements guarantees at least once delivery, and without them only at most once delivery is guaranteed [cba5dcf86].

On the consumer side, manual acknowledgement uses `basic.ack` for positive acknowledgements, `basic.nack` (a RabbitMQ extension to AMQP 0-9-1), and `basic.reject` for negative ones [ca1b52a3b]. Automatic acknowledgement mode ("fire-and-forget") is considered unsafe because if the consumer's TCP connection or channel closes before successful delivery, the message is lost [ca1b52a3b]. Any delivery not acked is automatically requeued when its channel or connection closes [ca1b52a3b], and redeliveries carry a `redelivered` flag, so consumers should be idempotent [cba5dcf86].

On the publisher side, sending `confirm.select` puts a channel into confirm mode, after which the broker confirms each message with a `basic.ack` carrying its sequence number [ca1b52a3b]. For persistent messages routed to durable queues this means persisting to disk; for quorum queues it means a quorum of replicas have accepted and confirmed the message to the elected leader [ca1b52a3b].

## Durable, quorum, and stream storage

Durable queues are recovered on node boot including messages published as persistent, while transient messages are discarded during recovery [c1b49f029]; data safety therefore requires durable queues and publishers marking messages persistent [cba5dcf86]. Quorum queues are a durable, replicated queue type based on the Raft consensus algorithm, are always durable, and issue publisher confirms only once a message is replicated to a quorum of members [ca2a2c636].

## Failed messages and streams

Dead letter exchanges (DLXs) re-publish messages that are rejected/nacked with `requeue` false, that expire via TTL, that exceed a length limit, or that exceed a quorum queue's `delivery-limit` [ce2406bb0]. By default dead-lettering happens without publisher confirms and is not guaranteed safe, but quorum queues support at-least-once dead-lettering with confirms turned on internally [ce2406bb0]. Streams differ from queues as an append-only log with non-destructive consumer semantics, always persistent and replicated, where any number of consumers can re-read the same messages, and confirms are issued only once data is replicated to a quorum of stream replicas [cbe0826f3].
