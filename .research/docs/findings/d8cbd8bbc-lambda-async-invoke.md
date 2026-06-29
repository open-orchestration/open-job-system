---
id: d8cbd8bbc
topic: cloud-aws
title: "Lambda asynchronous invocation: internal queue and immediate response"
status: draft
shape: mechanism
---

# Lambda asynchronous invocation: internal queue and immediate response

## How asynchronous invocation works

Several AWS services, such as Amazon S3 and Amazon SNS, "invoke functions asynchronously to process events," and a function can also be invoked asynchronously using the AWS CLI or one of the AWS SDKs [c4fcc4e49]. When you invoke a function asynchronously, "you don't wait for a response from the function code"; instead you "hand off the event to Lambda and Lambda handles the rest" [c4fcc4e49].

The mechanism is an internal queue: "Lambda queues the events before sending them to the function" [c4fcc4e49]. More precisely, "For asynchronous invocation, Lambda places the event in a queue and returns a success response without additional information," and "A separate process reads events from the queue and sends them to your function" [c4fcc4e49].

## How to request it, and the immediate response

To invoke a Lambda function asynchronously using the AWS CLI or an AWS SDK, you "set the `InvocationType` parameter to `Event`" [c4fcc4e49]. The success response is a status code only — the documented output is `{ "StatusCode": 202 }` [c4fcc4e49]. The output file (`response.json`) "doesn't contain any information, but is still created when you run this command" [c4fcc4e49]. If Lambda "isn't able to add the event to the queue, the error message appears in the command output" [c4fcc4e49].

## Error handling and downstream records

This page states that "You can configure how Lambda handles errors," and that you can "send invocation records to a downstream resource such as Amazon Simple Queue Service (Amazon SQS) or Amazon EventBridge (EventBridge) to chain together components of your application" [c4fcc4e49].

## Scope note

The body of this source page does not itself specify the number of retries on function error, the delays between retries, the maximum event age / how events age out, or the dead-letter-queue versus on-failure-destination configuration details; it points to separate "Error handling" and "Configuration" topics for those, which are outside this source's body [c4fcc4e49].

## How this differs from synchronous invocation

Under asynchronous invocation the caller does not wait for a response from the function code and receives only a success acknowledgement (status code `202`) with no function output, because Lambda queues the event and a separate process delivers it to the function later [c4fcc4e49].
