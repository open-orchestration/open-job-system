---
id: d8e9f8182
topic: durable-execution
title: "Temporal programming model: child workflows and message passing"
status: draft
shape: mechanism
---

# Temporal programming model: child workflows and message passing

Temporal's programming model gives a running Workflow two structural tools beyond plain Activities: it can spawn other Workflows as children, and it can receive external messages while running. Child Workflows decompose a problem into independently-executed sub-Workflows; message passing (Signals, Queries, Updates) lets clients communicate with a Workflow that is already in flight.

## Child Workflows

A Child Workflow Execution is a Workflow Execution that is spawned from within another Workflow in the same Namespace [ce9306d1f]. Because any Workflow can spawn another Workflow, a single Workflow Execution can be both a Parent and a Child Workflow Execution [ce9306d1f].

### The parent/child relationship

A Parent Workflow Execution must await on the Child Workflow Execution to spawn, and the Parent can optionally await on the result of the Child Workflow Execution [ce9306d1f]. If the Parent does not await on the result of the Child — which includes any use of Continue-As-New by the Parent — you should consider the Child's Parent Close Policy [ce9306d1f].

Child Workflows do not carry over when the Parent uses Continue-As-New; if a Parent Workflow Execution uses Continue-As-New, any ongoing Child Workflow Executions will not be retained in the new continued instance of the Parent [ce9306d1f]. Conversely, if a Child Workflow Execution uses Continue-As-New, from the Parent Workflow Execution's perspective the entire chain of Runs is treated as a single execution [ce9306d1f].

A Parent and Child do not share any local state, because a Child Workflow Execution can be processed by a completely separate set of Workers than the Parent Workflow Execution [ce9306d1f]. As all Workflow Executions, a Parent and a Child can communicate only via asynchronous Signals [ce9306d1f].

### Parent Close Policy

When a Parent Workflow Execution reaches a Closed status, the Temporal Service propagates Cancellation Requests or Terminations to Child Workflow Executions depending on the Child's Parent Close Policy [ce9306d1f]. One documented value is `ABANDON`: a Child Workflow Execution can continue on if its Parent is canceled with a Parent Close Policy of `ABANDON` [ce9306d1f]. This contrasts with an Activity Execution, which is always canceled when its Workflow Execution is canceled (though it can react to a cancellation Signal for cleanup) [ce9306d1f].

### When to use a Child Workflow vs. a separate workflow or Activity

There is no reason to use Child Workflows just for code organization; object-oriented structure and other code organization techniques can deal with complexities instead [ce9306d1f]. It is typically recommended to start from a single Workflow Definition if the problem has bounded size in terms of the number of Activity Executions and processed Signals, because that is simpler than multiple asynchronously communicating Workflows [ce9306d1f]. Valid reasons to reach for Child Workflows include:

- **Create a separate service.** Because a Child can be processed by a completely separate set of Workers, it can act as an entirely separate service [ce9306d1f].
- **Partition problems into smaller chunks.** An individual Workflow Execution has an Event History size limit, and because Child Workflow Executions have their own Event Histories they are often used to partition large workloads into smaller chunks [ce9306d1f]. For example, a single Workflow Execution does not have enough space in its Event History to spawn 100,000 Activity Executions, but a Parent can spawn 1,000 Child Workflow Executions that each spawn 1,000 Activity Executions to reach 1,000,000 total [ce9306d1f]. Because the Parent's Event History contains Events for the status of each Child, a single Parent should not spawn more than 1,000 Child Workflow Executions [ce9306d1f].
- **Represent a single resource.** A Child can create a one-to-one mapping with a resource and use its ID to guarantee uniqueness — for example, a Workflow managing host upgrades could spawn a Child per host (hostname being the Workflow ID) to ensure all operations on the host are serialized [ce9306d1f].
- **Periodic logic execution.** A Child can execute periodic logic without overwhelming the Parent's Event History: the Parent starts a Child that calls Continue-As-New as many times as needed then completes, appearing to the Parent as a single Child Workflow invocation [ce9306d1f].

Child Workflow Executions generally result in more overall Events recorded in Event Histories than Activities, and because each Event History entry is a cost in compute resources, the docs recommend starting with a single Workflow implementation that uses Activities until there is a clear need for Child Workflows [ce9306d1f]. The key differences from an Activity: a Child Workflow has access to all Workflow APIs but is subject to the same deterministic constraints as other Workflows, whereas an Activity has the inverse — no access to Workflow APIs but no Workflow constraints [ce9306d1f]. Temporal tracks all state changes within a Child Workflow Execution in Event History, while only the input, output, and retry attempts of an Activity Execution are tracked [ce9306d1f]. A Workflow models composite operations consisting of multiple Activities or other Child Workflows, while an Activity usually models a single operation on the external world, and the standing advice is: when in doubt, use an Activity [ce9306d1f].

## Message passing: Signals, Queries, and Updates

Workflows can be thought of as stateful web services that can receive messages, with message handlers akin to endpoints that react to incoming messages in combination with the current state of the Workflow [c3c7c6653]. Temporal supports three types of messages: Signals, Queries, and Updates [c3c7c6653].

### Signals — asynchronous write requests

Signals are asynchronous write requests; they cause changes in the running Workflow, but you cannot await any response or error [c3c7c6653]. Use Signals when clients want to quickly move on after sending an asynchronous message, are okay with "fire and forget" with no result or exception needed, and don't depend on the Worker being available [c3c7c6653]. Since clients don't expect a result, latency is often not relevant when using Signals [c3c7c6653].

### Queries — read-only, must not block, no side effects

Queries are read requests: they can read the current state of the Workflow but cannot block in doing so [c3c7c6653]. For read requests you normally want a Query, because Queries are efficient — they never add entries to the Workflow Event History, whereas an Update would if accepted — and Queries can operate on completed Workflows [c3c7c6653]. Because Queries cannot block, sometimes Updates are better: when the goal is to read once the Workflow achieves a desired state, you can either poll periodically with Queries until the Workflow is ready, or write the read as an Update [c3c7c6653].

### Updates — synchronous, tracked write requests

Updates are synchronous, tracked write requests; the sender of the Update can wait for a response on completion or an error on failure [c3c7c6653]. Unlike Signals, Updates must be synchronous and must wait for the Worker running the Workflow to acknowledge the request [c3c7c6653]. Use Updates when clients want to track completion of the message, need a result or exception without performing a query, or want to validate the Update before accepting it into the Workflow and its history [c3c7c6653]. Updates suit clients who want a low-latency end-to-end operation and are willing to wait for completion or validation [c3c7c6653]. For synchronous read/write requests use an Update; if the request must be asynchronous, consider sending a Signal followed by polling with a Query [c3c7c6653]. Writing a read as an Update gives better efficiency and latency than polling, though it will write an entry to the Workflow Event History [c3c7c6653].

### Interaction with determinism and Event History

The distinction that matters for durable execution is what each message type does to the Workflow Event History. Queries never add entries to the Workflow Event History and can operate on completed Workflows, which is why they are the efficient default for reads [c3c7c6653]. Updates, by contrast, write an entry to the Workflow Event History when accepted [c3c7c6653]. On the child-workflow side, a Child Workflow has access to all Workflow APIs but is subject to the same deterministic constraints as other Workflows, and each entry in an Event History is a cost in terms of compute resources [ce9306d1f].
