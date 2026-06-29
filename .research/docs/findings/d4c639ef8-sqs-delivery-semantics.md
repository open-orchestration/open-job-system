---
id: d4c639ef8
topic: cloud-aws
title: SQS delivery semantics: visibility timeout, DLQ, and FIFO deduplication
status: draft
shape: mechanism
---

# SQS delivery semantics: visibility timeout, DLQ, and FIFO deduplication

Amazon SQS offers a hosted queue that lets you integrate and decouple distributed software systems and components [cb96f3ced]. The mechanisms below — visibility timeout, dead-letter queues, and FIFO deduplication — together determine how often and in what order a consumer sees each message.

## Visibility timeout

When you receive a message from an SQS queue, it remains in the queue but becomes temporarily invisible to other consumers, and this invisibility is controlled by the visibility timeout, which ensures that other consumers cannot process the same message while you are working on it [cbd1c78b2]. The visibility timeout starts as soon as a message is delivered to you, and during this period you are expected to process and delete the message [cbd1c78b2]. The default visibility timeout for a queue is 30 seconds, but you can adjust this to match the time your application needs to process and delete a message [cbd1c78b2]. You can also set a specific visibility timeout for individual messages without changing the queue's overall setting, and use the `ChangeMessageVisibility` action to programmatically extend or shorten the timeout as needed [cbd1c78b2].

The visibility timeout has a maximum limit of 12 hours from when the message is first received, and extending the timeout doesn't reset this 12-hour limit [cbd1c78b2]. If you decide not to process a received message, you can terminate its visibility timeout by setting the `VisibilityTimeout` to 0 seconds through the `ChangeMessageVisibility` action, which immediately makes the message available for other consumers to process [cbd1c78b2].

If you don't delete a message before the timeout expires — due to application errors, crashes, or connectivity problems — the message becomes visible again in the queue and can then be retrieved by the same or a different consumer for another processing attempt, which ensures that messages aren't lost even if the initial processing fails [cbd1c78b2]. SQS locks your messages during processing, so that multiple producers can send and multiple consumers can receive messages at the same time [cb96f3ced].

## In-flight messages

In-flight messages are messages that have been received by a consumer but not yet deleted [cbd1c78b2]. For standard queues, there is a limit of approximately 120,000 in-flight messages, depending on queue traffic and message backlog, and if you reach this limit Amazon SQS returns an `OverLimit` error indicating that no additional messages can be received until some in-flight messages are deleted [cbd1c78b2]. For FIFO queues, limits depend on active message groups [cbd1c78b2]. When using long polling, Amazon SQS does not return an error when the in-flight message limit is reached; instead, it will not return any new messages until the number of in-flight messages drops below the limit [cbd1c78b2].

## Dead-letter queues

Amazon SQS supports dead-letter queues (DLQs), which source queues can target for messages that are not processed successfully, and DLQs are useful for debugging because you can isolate unconsumed messages to determine why processing did not succeed [c565f7ab3]. You use a redrive policy to specify the `maxReceiveCount`, which is the number of times a consumer can receive a message from a source queue before it is moved to a dead-letter queue [c565f7ab3]. For example, if the `maxReceiveCount` is set to a low value such as 1, one failure to receive a message would cause the message to move to the dead-letter queue, so to ensure that your system is resilient against errors you should set the `maxReceiveCount` high enough to allow for sufficient retries [c565f7ab3]. To manage messages that fail multiple processing attempts, configuring a DLQ ensures that messages that can't be processed after several retries are captured separately, preventing them from repeatedly circulating in the main queue [cbd1c78b2].

The redrive allow policy specifies which source queues can access the dead-letter queue, letting you allow all source queues, allow specific source queues, or deny all source queues use of the dead-letter queue [c565f7ab3]. The default allows all source queues to use the dead-letter queue; with the `byQueue` option you can specify up to 10 source queues using the source queue Amazon Resource Name (ARN), and if you specify `denyAll` the queue cannot be used as a dead-letter queue [c565f7ab3]. You must first create a new queue before configuring it as a dead-letter queue [c565f7ab3]. AWS advises not using a dead-letter queue with a FIFO queue if you don't want to break the exact order of messages or operations [c565f7ab3].

## FIFO deduplication and exactly-once processing

`MessageDeduplicationId` is a token used only in Amazon SQS FIFO queues to prevent duplicate message delivery [c13277e4b]. It ensures that within a 5-minute deduplication window, only one instance of a message with the same deduplication ID is processed and delivered [c13277e4b]. If Amazon SQS has already accepted a message with a specific deduplication ID, any subsequent messages with the same ID will be acknowledged but not delivered to consumers [c13277e4b]. Amazon SQS continues tracking the deduplication ID even after the message has been received and deleted [c13277e4b].

## Standard versus FIFO delivery guarantees

Standard queues support at-least-once message delivery, and FIFO queues support exactly-once message processing and high-throughput mode [cb96f3ced]. In both standard and FIFO queues, the visibility timeout helps prevent multiple consumers from processing the same message simultaneously; however, due to the at-least-once delivery model of Amazon SQS, there is no absolute guarantee that a message won't be delivered more than once during the visibility timeout period [cbd1c78b2]. For FIFO queues, messages with the same message group ID are processed in a strict sequence, and when a message with a message group ID is in-flight, subsequent messages in that group are not made available until the in-flight message is either deleted or the visibility timeout expires [cbd1c78b2]. This does not lock the group indefinitely — each message is processed in sequence, and only when each message is deleted or becomes visible again will the next message in that group be available to consumers, ensuring ordered processing within the group without unnecessarily locking the group from delivering messages [cbd1c78b2].

## Retention

Amazon SQS automatically deletes messages that have been in a queue for more than the maximum message retention period; the default message retention period is 4 days, but you can set the message retention period to a value from 60 seconds to 1,209,600 seconds (14 days) using the `SetQueueAttributes` action [cb96f3ced].
