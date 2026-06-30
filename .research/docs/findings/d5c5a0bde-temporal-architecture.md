---
id: d5c5a0bde
topic: durable-execution
title: "Temporal architecture: Cluster, Workers, and SDKs"
status: draft
shape: mechanism
---

# Temporal architecture: Cluster, Workers, and SDKs

Temporal splits a durable-execution system into three cooperating parts: a
**Temporal Service** that orchestrates and persists state, **Workers** that run
your code, and **SDKs** that let you write that code as ordinary functions. The
guarantee is that a Workflow Execution survives process crashes, machine
failures, and long suspensions because its progress is recorded and can be
replayed.

## 1. The durable-execution model

A Temporal Workflow Execution is described as having three durability
properties: "a Temporal Workflow Execution is both resumable and recoverable,
and it can react to external events." [cdd95b319] These are defined as —
Resumable: "The ability of a process to resume execution after suspending on an
_awaitable_"; Recoverable: "The ability of a process to resume execution after
suspending due to a _failure_"; Reactive: "The ability of a process to respond
to external events." [cdd95b319] The consequence is that "a Temporal Application
can run for seconds or years in the presence of arbitrary load and failures."
[cdd95b319]

The mechanism behind this is automatic state persistence: "the state of the
Workflow is automatically persisted so if a failure does occur, it resumes right
where it left off." [cdd95b319] More precisely, "The Temporal Service persists
Workflow Execution Event History, so that if there is a failure, the SDK Worker
is able to Replay the execution and resume where it left off." [cdd95b319]
Replay is the SDKs' "ability to replay Workflow Executions, a complex operation
that contributes significantly to the Platform's promised reliability"
[cdd95b319] — it lets the SDKs "automatically continue a process from the point
of interruption, should a failure occur," a capability that "stems from the
SDK's ability to persist each step the program takes." [cdd95b319] Because the
program is reconstructed by replaying recorded events, "the deterministic
constraints of the Workflow code comes into play, requiring the use of
Activities to create side effects and interact with the outside world."
[cdd95b319]

## 2. The Temporal Cluster / Service

The Temporal Cluster has been renamed: "We now refer to the Temporal Cluster as
the Temporal Service." [ca75d348d] A Temporal Service is defined as "the group
of services, known as the Temporal Server, combined with Persistence and
Visibility stores, that together act as a component of the Temporal Platform."
[ca75d348d] The component diagram for it is captioned "A Temporal Service
(Server + persistence)." [ca75d348d]

> Note: this source (ca75d348d) names only three building blocks of a Temporal
> Service — the Temporal Server, a Persistence store, and a Visibility store. It
> does not enumerate the internal Frontend / History / Matching / Worker
> services, so those are not claimed here.

## 3. Workers — where your code runs

Workers, not the Service, run user code. "A Worker Process is responsible for
polling a Task Queue, dequeueing a Task, executing your code in response to a
Task, and responding to the Temporal Service with the results." [c71a7776f] A
Worker Entity is "the individual Worker within a Worker Process that listens to a
specific Task Queue" [c71a7776f], it "listens and polls on a single Task Queue"
[c71a7776f], and it "contains a Workflow Worker and/or an Activity Worker, which
makes progress on Workflow Executions and Activity Executions, respectively."
[c71a7776f] Workers are stateless: "Workers are stateless, so any Workflow
Execution in a blocked state can be safely removed from a Worker." [c71a7776f]

Crucially, the Service does not run your code. "Worker Processes are external to
a Temporal Service." [c71a7776f] The documentation states that "the Temporal
Service (including the Temporal Cloud) doesn't execute any of your code (Workflow
and Activity Definitions) on Temporal Service machines" and that "The Temporal
Service is solely responsible for orchestrating State Transitions and providing
Tasks to the next available Worker Entity." [c71a7776f] Responsibility for the
code therefore sits with the developer: "Temporal Application developers are
responsible for developing Worker Programs and operating Worker Processes."
[c71a7776f] A Worker Program itself is "the static code that defines the
constraints of the Worker Process, developed using the APIs of a Temporal SDK."
[c71a7776f]

## 4. SDKs — write Workflows as code

"Temporal SDKs (software development kits) are an open source collection of
tools, libraries, and APIs that enable Temporal Application development."
[cdd95b319] An SDK provides three major components: "A Temporal Client to
communicate with a Temporal Service", "APIs to develop application code
(Workflows & Activities)", and "APIs to configure and run Workers." [cdd95b319]
Stated another way, the SDKs "offer a Temporal Client to interact with the
Temporal Service, APIs to develop your Temporal Application, and APIs to run
horizontally scalable Workers." [cdd95b319]

Each SDK is language-specific: "Each Temporal SDK targets a specific programming
language" [cdd95b319], and the officially supported SDKs listed are Go, Java,
Python, TypeScript, .NET, Ruby, and PHP. [cdd95b319] The SDK is what steps
through the user's code reliably: "The SDK's internal implementation, working in
collaboration with the Temporal Service, steps through that code, guaranteeing
execution progression during application runtime." [cdd95b319]

The SDK ties the Worker and Service together through an event-sourced loop. "The
Worker polls on the specified Task Queue, processing those Tasks, and reporting
the results back to the Temporal Service." [cdd95b319] When a Workflow asks to
run an Activity, "the Worker sends a Command back to the Temporal Service. The
Temporal Service creates Activity Tasks in response which the same or a
different Worker can then pick up and begin executing." [cdd95b319] The Service
"functions more as a choreographer than a conductor. Rather than directly
assigning tasks to Workers, the Temporal Service arranges the Tasks into a Task
Queue while Workers poll the Task Queue." [cdd95b319] Each Task transition is
recorded: "Scheduled means that the Temporal Service has added a Task to the
Task Queue", "Started means that the Worker has dequeued the Task", and
"Completed means that the Worker finished executing the Task by responding to
the Temporal Service." [cdd95b319] This is the same Event History the Worker
later replays, which is what makes the whole system durable. [cdd95b319]
