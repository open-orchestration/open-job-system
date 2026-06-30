---
id: d228fe3f9
topic: task-queues
title: "Job-queue libraries across backends: Machinery and JobRunr"
status: draft
shape: survey
---

# Job-queue libraries across backends: Machinery and JobRunr

This survey states what each of two job-queue libraries is, in its own
project's wording, along with the runtime it targets, the backend/transport it
relies on, and the one mechanism that most distinguishes its model. Each
library is described only from its own captured source. (A third candidate,
pg-boss `c2890f63d`, was dropped: its captured page is a GitHub 404 with no
definitional content and needs re-capturing.)

## Machinery (Go)

Machinery describes itself as "an asynchronous task queue/job queue based on
distributed message passing." [ccb48ac57] Its README is published from the
`RichardKnop/machinery` Go repository, and installation is done with
`go get github.com/RichardKnop/machinery/v2` (the recommended v2 release) or
`go get github.com/RichardKnop/machinery` for the legacy v1 version. [ccb48ac57]

Machinery's defining structural choice is a split between a message *broker*
and a result *backend*. The project recommends v2 "in order to avoid having to
import all dependencies for brokers and backends you are not using," and in v2
"you will need to inject broker and backend objects to the server
constructor." [ccb48ac57] The broker is documented as "A message broker," whose
"Currently supported brokers" are AMQP, Redis, AWS SQS, and GCP Pub/Sub.
[ccb48ac57] The result backend is separately documented as the "Result backend
to use for keeping task states and results," whose "Currently supported
backends" are Redis, Memcache, AMQP, MongoDB, and DynamoDB. [ccb48ac57]
Machinery "encodes tasks to JSON before sending them to the broker," and "Task
results are also stored in the backend as JSON encoded strings," so "only types
with native JSON representation can be supported." [ccb48ac57] Work is consumed
by workers: "In order to consume tasks, you need to have one or more workers
running," and "All you need to run a worker is a `Server` instance with
registered tasks." [ccb48ac57]

## JobRunr (Java / JVM)

JobRunr describes itself as "an easy way to perform fire-and-forget, delayed
and recurring asynchronous tasks on the JVM, using only Java 8 lambdas, with
distributed execution across multiple instances." [cc53ad95f] Its
documentation summarizes it as a way to "Run background jobs on the JVM with
ease with persistence, automatic retries, and monitoring," and states plainly
that "JobRunr is a library, not a service." [cc53ad95f] In JobRunr's own
description of how it works, when you enqueue a job "JobRunr serializes the
lambda to JSON, stores it in your existing database, and returns to the caller
immediately — a `BackgroundJobServer` picks it up and executes it, whether on
the same JVM or across a cluster." [cc53ad95f]

JobRunr's distinguishing mechanism is the `StorageProvider`. The documentation
defines it as "a place where JobRunr keeps all the information related to
background job processing," where "All the details like types, method names,
arguments, etc. are serialized to JSON and placed into storage, no data is kept
in a process' memory." [cc53ad95f] The `StorageProvider` "is abstracted in
JobRunr well enough to be implemented for both RDBMS and NoSQL solutions," and
JobRunr "stores jobs in the same SQL or NoSQL database your application already
uses (PostgreSQL, MySQL, MongoDB, and more)." [cc53ad95f] Execution is the job
of the `BackgroundJobServer`, which "runs inside your application process and
is responsible for executing jobs," polling "the `StorageProvider` for work" and
claiming "jobs atomically so the same job is never processed twice." [cc53ad95f]
