---
id: d8e19f3eb
topic: cloud-aws
title: SQS architecture and choosing among SQS, SNS, and Amazon MQ
status: draft
shape: comparison
---

# SQS architecture and choosing among SQS, SNS, and Amazon MQ

## Basic SQS architecture: distributed queues

The basic Amazon SQS architecture is described in terms of the components of a distributed messaging system and the lifecycle of a message [c4865634c]. There are three main parts in a distributed messaging system: the components of your distributed system, your queue (distributed on Amazon SQS servers), and the messages in the queue [c4865634c]. In a typical scenario, your system has several *producers* (components that send messages to the queue) and *consumers* (components that receive messages from the queue) [c4865634c]. The queue, which holds messages such as A through E, redundantly stores the messages across multiple Amazon SQS servers [c4865634c].

## Message lifecycle: produce, receive (in-flight), delete

The lifecycle of an Amazon SQS message in a queue runs from creation to deletion [c4865634c]. First, a producer (Component 1) sends a message to a queue, and the message is distributed across the Amazon SQS servers redundantly [c4865634c]. Next, when a consumer (Component 2) is ready to process messages, it consumes messages from the queue and the message is returned [c4865634c]. While that message is being processed, it remains in the queue and isn't returned to subsequent receive requests for the duration of the visibility timeout [c4865634c]. Finally, the consumer (Component 2) deletes the message from the queue to prevent the message from being received and processed again when the visibility timeout expires [c4865634c].

Amazon SQS automatically deletes messages that have been in a queue for more than the maximum message retention period [c4865634c]. The default message retention period is 4 days [c4865634c]. However, you can set the message retention period to a value from 60 seconds to 1,209,600 seconds (14 days) using the `SetQueueAttributes` action [c4865634c].

## Differences between Amazon SQS, Amazon SNS, and Amazon MQ

Amazon SQS, Amazon SNS, and Amazon MQ offer highly scalable and easy-to-use managed messaging services, each designed for specific roles within distributed systems [c4865634c].

**Amazon SQS** decouples and scales distributed software systems and components as a queue service [c4865634c]. It processes messages through a single subscriber typically, ideal for workflows where order and loss prevention are critical [c4865634c]. For wider distribution, integrating Amazon SQS with Amazon SNS enables a fanout messaging pattern, effectively pushing messages to multiple subscribers at once [c4865634c].

**Amazon SNS** allows publishers to send messages to multiple subscribers through topics, which serve as communication channels [c4865634c]. Subscribers receive published messages using a supported endpoint type, such as Amazon Data Firehose, Amazon SQS, Lambda, HTTP, email, mobile push notifications, and mobile text messages (SMS) [c4865634c]. This service is ideal for scenarios requiring immediate notifications, such as real-time user engagement or alarm systems [c4865634c]. To prevent message loss when subscribers are offline, integrating Amazon SNS with Amazon SQS queue messages ensures consistent delivery [c4865634c].

**Amazon MQ** fits best with enterprises looking to migrate from traditional message brokers, supporting standard messaging protocols like AMQP and MQTT, along with Apache ActiveMQ and RabbitMQ [c4865634c]. It offers compatibility with legacy systems needing stable, reliable messaging without significant reconfiguration [c4865634c].

### Resource type overview

The documented overview of each service's resource type is as follows [c4865634c]:

| Resource type | Amazon SNS | Amazon SQS | Amazon MQ |
| --- | --- | --- | --- |
| Synchronous | No | No | Yes |
| Asynchronous | Yes | Yes | Yes |
| Queues | No | Yes | Yes |
| Publisher-subscriber messaging | Yes | No | Yes |
| Message brokers | No | No | Yes |

[c4865634c]

### When AWS recommends each

Both Amazon SQS and Amazon SNS are recommended for new applications that can benefit from nearly unlimited scalability and simple APIs [c4865634c]. They generally offer more cost-effective solutions for high-volume applications with their pay-as-you-go pricing [c4865634c]. AWS recommends Amazon MQ for migrating applications from existing message brokers that rely on compatibility with APIs such as JMS or protocols such as Advanced Message Queuing Protocol (AMQP), MQTT, OpenWire, and Simple Text Oriented Message Protocol (STOMP) [c4865634c].
