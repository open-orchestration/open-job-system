---
id: d78b56460
topic: brokers
title: "ZeroMQ brokerless messaging patterns"
status: draft
shape: mechanism
---

# ZeroMQ brokerless messaging patterns

## What ZeroMQ is

The guide opens by describing ZeroMQ as "sockets on steroids" — "smaller, simpler, but still looks familiar" than the connected-code alternatives [c19cb8573]. Its stated purpose is to solve "the general problem of 'how to connect any code to any code, anywhere'" and to "wrap that up in the simplest possible building blocks that people could understand and use _easily_" [c19cb8573]. The chapter defines ZeroMQ concretely as "an efficient, embeddable library that solves most of the problems an application needs to become nicely elastic across a network, without much cost" [c19cb8573]. It is meant to be "a library which you just link, without any other dependencies", with "[n]o additional moving pieces, so no additional risk", running "on any OS and work[ing] with any programming language" [c19cb8573].

## Why it is brokerless

The chapter contrasts ZeroMQ with broker-based messaging: most messaging projects "solve this long list of problems in a reusable way" by "inventing a new concept, the 'broker', that does addressing, routing, and queuing" [c19cb8573]. The guide acknowledges brokers are "an excellent thing in reducing the complexity of large networks", but argues a broker "rapidly becomes a bottleneck and a new risk to manage" and adds "a new single point of failure" [c19cb8573]. A broker-centric setup "needs its own operations team" and "is only worth doing for large applications with many moving pieces, built by several teams of people over several years" [c19cb8573]. ZeroMQ instead embeds in the application as a linked library rather than running a central broker process [c19cb8573].

## The core socket-pair patterns (Chapter 1)

Chapter 1 introduces three patterns, each in its own worked example.

**Request-reply (`REQ`/`REP`).** The Hello World example has the server "bind[] its REP (reply) socket to port 5555", then "wait[] for a request in a loop, and respond[] each time with a reply", while "[t]he client sends a request and reads the reply back from the server" [c19cb8573]. The guide names this "the request-reply pattern, probably the simplest way to use ZeroMQ", and states it "maps to RPC and the classic client/server model" [c19cb8573].

**Publish-subscribe (`PUB`/`SUB`).** The second pattern is described as "one-way data distribution, in which a server pushes updates to a set of clients", illustrated with a weather-update server on port 5556 [c19cb8573]. The guide warns that with a `SUB` socket "you **must** set a subscription using" `zmq_setsockopt()` and SUBSCRIBE, otherwise "you won't get any messages" [c19cb8573]. The pair is asynchronous: "Trying to send a message to a SUB socket will cause an error", and the service "must not do" `zmq_recv()` on a `PUB` socket [c19cb8573]. The chapter documents the "slow joiner" symptom — "the subscriber will always miss the first messages that the publisher sends" because connection setup takes non-zero time — and notes that "[i]f a publisher has no connected subscribers, then it will simply drop all messages" [c19cb8573].

**Pipeline (`PUSH`/`PULL`).** The "Divide and Conquer" example builds a parallel pipeline of "[a] ventilator that produces tasks", "[a] set of workers that process tasks", and "[a] sink that collects results back from the worker processes" [c19cb8573]. In it, "[t]he ventilator's PUSH socket distributes tasks to workers ... evenly", which the guide calls "_load balancing_", while "[t]he sink's PULL socket collects results from workers evenly", which it calls "_fair-queuing_" [c19cb8573]. Because workers connect upstream to the ventilator and downstream to the sink, "you can add workers arbitrarily" [c19cb8573].

## Message framing

The guide states that "ZeroMQ doesn't know anything about the data you send except its size in bytes", leaving the application responsible for formatting [c19cb8573]. It establishes the rule that "ZeroMQ strings are length-specified and are sent on the wire _without_ a trailing null", and that such a string "maps neatly to a ZeroMQ message frame ... a length and some bytes" [c19cb8573]. ZeroMQ "delivers whole messages exactly as they were sent, using a simple framing on the wire": "[i]f you write a 10k message, you will receive a 10k message" [c19cb8573]. It "does not impose any format on messages", which "are blobs from zero to gigabytes large" [c19cb8573].

## High-level philosophy: transports and nodes

ZeroMQ "lets your applications talk to each other over arbitrary transports: TCP, multicast, in-process, inter-process", and "[y]ou don't need to change your code to use a different transport" [c19cb8573]. Underneath, "[i]t handles I/O asynchronously, in background threads" using "lock-free data structures, so concurrent ZeroMQ applications need no locks, semaphores, or other wait states" [c19cb8573]. Components "can come and go dynamically and ZeroMQ will automatically reconnect", so components can start "in any order" [c19cb8573]. The same model spans scales: "Two nodes in one process (node is a thread), two nodes on one box (node is a process), or two nodes on one network (node is a box)–it's all the same, with no application code changes" [c19cb8573]. Superficially it is "a socket-inspired API on which you do" `zmq_recv()` and `zmq_send()`, but "message processing rapidly becomes the central loop" and the application "breaks down into a set of message processing tasks" [c19cb8573].
