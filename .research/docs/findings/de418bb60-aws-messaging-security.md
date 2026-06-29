---
id: de418bb60
topic: gap-fill
title: "AWS messaging security and large-payload handling: SQS encryption, S3 extended client, SNS data protection"
status: draft
shape: synthesis
---

# AWS messaging security and large-payload handling: SQS encryption, S3 extended client, SNS data protection

Three AWS messaging concerns sit adjacent to queue throughput and delivery: protecting message contents at rest, working around the per-message size ceiling, and governing sensitive payload content in motion. SQS server-side encryption and the S3-backed Extended Client Library address the first two on the queue side; SNS Message Data Protection addresses the third on the topic side.

## SQS encryption at rest (SSE)

Server-side encryption (SSE) lets you transmit sensitive data in encrypted queues, protecting the contents of messages using SQS-managed encryption keys (SSE-SQS) or keys managed in the AWS Key Management Service (SSE-KMS) [c267065f9]. SSE encrypts messages as soon as Amazon SQS receives them, the messages are stored in encrypted form, and Amazon SQS decrypts messages only when they are sent to an authorized consumer [c267065f9]. All requests to queues with SSE enabled must use HTTPS and Signature Version 4 [c267065f9].

The encryption scope is narrow: SSE encrypts the body of a message in an Amazon SQS queue [c267065f9]. SSE does not encrypt queue metadata (queue name and attributes), message metadata (message ID, timestamp, and attributes), or per-queue metrics [c267065f9]. With SSE enabled, anonymous `SendMessage` and `ReceiveMessage` requests to the encrypted queue will be rejected [c267065f9]. A message is encrypted only if it is sent after the encryption of a queue is enabled, and Amazon SQS does not encrypt backlogged messages [c267065f9]. Any encrypted message remains encrypted even if the encryption of its queue is disabled [c267065f9]. Moving a message to a dead-letter queue does not affect its encryption: a message moved from an encrypted source queue to an unencrypted dead-letter queue remains encrypted, and a message moved from an unencrypted source queue to an encrypted dead-letter queue remains unencrypted [c267065f9].

When you use Amazon SQS with AWS KMS, the data keys that encrypt your message data are also encrypted and stored with the data they protect [c267065f9]. Several key terms govern SSE behavior. The data key (DEK) is the key responsible for encrypting the contents of Amazon SQS messages [c267065f9]. The data key reuse period is the length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again, an integer between 60 seconds (1 minute) and 86,400 seconds (24 hours), with a default of 300 (5 minutes) [c267065f9]. In the unlikely event of being unable to reach AWS KMS, Amazon SQS continues to use the cached data key until a connection is reestablished [c267065f9]. The KMS key ID is the alias, alias ARN, key ID, or key ARN of an AWS managed KMS key or a custom KMS key; while the alias of the AWS managed KMS key for Amazon SQS is always `alias/aws/sqs`, the alias of a custom KMS key can be, for example, `alias/MyAlias` [c267065f9]. If you do not specify a custom KMS key, Amazon SQS uses the AWS managed KMS key for Amazon SQS [c267065f9]. Amazon SQS uses the KMS key to encrypt the data key, and the encrypted data key is then stored with the encrypted message, a practice known as envelope encryption [c267065f9].

## Large messages: storing payloads in Amazon S3 via the Extended Client Library

You can use the Amazon SQS Extended Client Library for Java with Amazon S3 to manage large Amazon SQS messages, particularly for payloads ranging from 256 KB to 2 GB [cbdefa73b]. The library stores the message payload in an Amazon S3 bucket and sends a message containing a reference to the stored object in the Amazon SQS queue [cbdefa73b]. With the library, you can specify whether messages are always stored in Amazon S3 or only when the size of a message exceeds 256 KB [cbdefa73b]. You can also send a message that references a single message object stored in an S3 bucket, retrieve the message object from an Amazon S3 bucket, and delete the message object from an Amazon S3 bucket [cbdefa73b]. In the AWS SDK for Java 2.x example, a random message is stored in an Amazon S3 bucket because it is more than 256 KB, the standard maximum message size [cbdefa73b].

This capability is limited to the AWS SDK for Java: you can use the Amazon SQS Extended Client Library for Java to manage Amazon SQS messages using Amazon S3 only with the AWS SDK for Java, and you cannot do this with the AWS CLI, the Amazon SQS console, the Amazon SQS HTTP API, or any of the other AWS SDKs [cbdefa73b]. The SDK for Java and Amazon SQS Extended Client Library for Java require the J2SE Development Kit 8.0 or later [cbdefa73b].

## SNS Message Data Protection

Message Data Protection is a feature in Amazon SNS used to define your own rules and policies to audit and control the content for data in motion, as opposed to data at rest [c37c4c489]. It provides governance, compliance, and auditing services for enterprise applications that are message-centric, so data ingress and egress can be controlled by the Amazon SNS topic owner, and content flows can be tracked and logged [c37c4c489]. You can write payload-based governance rules to stop unauthorized payload content from entering your message streams [c37c4c489]. You can grant different content-access permissions to individual subscribers, and audit the entire content-flow process [c37c4c489]. Amazon SNS message data protection is no longer available to new customers [c37c4c489].
