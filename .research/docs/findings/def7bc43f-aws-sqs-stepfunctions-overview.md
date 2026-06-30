---
id: def7bc43f
topic: ui-monitoring
title: "AWS SQS and Step Functions: Service Overviews"
status: draft
shape: survey
---

# AWS SQS and Step Functions: Service Overviews

Two AWS managed services that recur in job-system designs present their service definitions and observability models on their respective overview pages. This survey records each strictly from its own overview body, with no cross-attribution.

## Amazon SQS — hosted message queue

Amazon Simple Queue Service (Amazon SQS) offers a secure, durable, and available hosted queue that lets you integrate and decouple distributed software systems and components [c653cda54]. Amazon SQS offers common constructs such as dead-letter queues and cost allocation tags [c653cda54]. It provides a generic web services API that you can access using any programming language that the AWS SDK supports [c653cda54].

The durability claim rests on replication and queue type: for the safety of your messages, Amazon SQS stores them on multiple servers [c653cda54]. Standard queues support at-least-once message delivery, and FIFO queues support exactly-once message processing and high-throughput mode [c653cda54]. For availability, Amazon SQS uses redundant infrastructure to provide highly-concurrent access to messages and high availability for producing and consuming messages [c653cda54]. Amazon SQS can process each buffered request independently, scaling transparently to handle any load increases or spikes without any provisioning instructions [c653cda54], and it locks your messages during processing, so that multiple producers can send and multiple consumers can receive messages at the same time [c653cda54].

Architecturally, there are three main parts in a distributed messaging system: the components of your distributed system, your queue (distributed on Amazon SQS servers), and the messages in the queue [c653cda54]. A system has several producers (components that send messages to the queue) and consumers (components that receive messages from the queue) [c653cda54]. While a message is being processed, it remains in the queue and isn't returned to subsequent receive requests for the duration of the visibility timeout [c653cda54]; the consumer then deletes the message from the queue to prevent it from being received and processed again when the visibility timeout expires [c653cda54]. Amazon SQS automatically deletes messages that have been in a queue for more than the maximum message retention period, with a default message retention period of 4 days, settable from 60 seconds to 1,209,600 seconds (14 days) using the `SetQueueAttributes` action [c653cda54].

## AWS Step Functions — serverless workflow orchestration

With AWS Step Functions, you can create workflows, also called state machines, to build distributed applications, automate processes, orchestrate microservices, and create data and machine learning pipelines [cc5e4a0a5]. Step Functions is based on state machines and tasks [cc5e4a0a5]. In Step Functions, state machines are called workflows, which are a series of event-driven steps [cc5e4a0a5]. Each step in a workflow is called a state [cc5e4a0a5]. For example, a Task state represents a unit of work that another AWS service performs, such as calling another AWS service or API [cc5e4a0a5]. Instances of running workflows performing tasks are called executions in Step Functions [cc5e4a0a5]. The work in state machine tasks can also be done using Activities, which are workers that exist outside of Step Functions [cc5e4a0a5].

The observability model is the console. In the Step Functions' console, you can visualize, edit, and debug your application's workflow [cc5e4a0a5]. You can examine the state of each step in your workflow to make sure that your application runs in order and as expected [cc5e4a0a5].

Step Functions has two workflow types [cc5e4a0a5]. Standard workflows are ideal for long-running, auditable workflows, as they show execution history and visual debugging [cc5e4a0a5]. Standard workflows have exactly-once workflow execution and can run for up to one year, meaning each step in a Standard workflow will execute exactly once [cc5e4a0a5]. Express workflows are ideal for high-event-rate workloads, such as streaming data processing and IoT data ingestion [cc5e4a0a5]. Express workflows have at-least-once workflow execution and can run for up to five minutes, meaning one or more steps in an Express Workflow can potentially run more than once, while each step in the workflow executes at least once [cc5e4a0a5]. On observability the two types diverge: Standard shows execution history and visual debugging, while Express shows execution history and visual debugging based on log level [cc5e4a0a5]. Standard workflows let you see execution history in Step Functions, whereas Express workflows send execution history to CloudWatch [cc5e4a0a5].

## Dropped sources

None — both source bodies contain usable definitional prose.
