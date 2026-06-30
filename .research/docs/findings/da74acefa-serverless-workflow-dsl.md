---
id: da74acefa
topic: specs
title: "Serverless Workflow DSL: the workflow and task model"
status: draft
shape: reference
---

# Serverless Workflow DSL: the workflow and task model

## What the DSL is

The Serverless Workflow DSL is a Domain Specific Language called Serverless Workflow, tailored for building platform agnostic workflows [c206336e5]. It aims to simplify the orchestration of complex processes across diverse environments, providing developers with a unified syntax and set of tools for defining and executing serverless workflows [c206336e5]. It addresses the complexity and inefficiency of orchestrating serverless workflows across multiple environments by providing a DSL specifically designed for serverless workflow orchestration, abstracting away the underlying infrastructure complexities and offering a modular and extensible framework [c206336e5].

Its design philosophy prioritizes clarity, expressiveness, and ease of use, founded on linguistic fluency and a fluent style that promotes intuitive understanding through natural language constructs [c206336e5]. Verbs are employed in the imperative tense to denote actions, and the DSL embraces implicit default behaviors so authors are spared unnecessary repetition [c206336e5]. The DSL allows both inline declaration of components and the creation of reusable elements, and it eschews strong-typed enumerations wherever feasible to foster extensibility and adaptability across different runtime environments [c206336e5].

## Workflow structure and the `document`

A workflow serves as a blueprint outlining the series of tasks required to execute a specific business operation, detailing the sequence in which tasks must be completed [cc117ea67]. A Serverless Workflow is a sequence of specific tasks that are executed in a defined order, which by default follows the declaration sequence within the workflow definition [c206336e5]. Workflows are designed to automate processes and orchestrate various serverless functions and services [c206336e5].

A workflow's top-level properties include a required `document`, a required `do` (the `map[string, task]` of task(s) the workflow must perform), and optional `input`, `use`, `timeout`, `output`, and `schedule` properties [cc117ea67]. The `use` property defines the workflow's reusable components, if any [cc117ea67].

The `document` documents the workflow definition and carries the workflow's identity metadata [cc117ea67]. Its required fields are `dsl` (the version of the DSL used to define the workflow), `namespace`, `name`, and `version` (the workflow's semantic version); optional fields include `title`, `summary`, `tags`, and `metadata` [cc117ea67].

The DSL allows defining reusable components that can be referenced across the workflow, including Authentications, Errors, Extensions, Functions, Retries, and Secrets [c206336e5]. Secrets are sensitive information required by a workflow to securely access protected resources or services, and runtimes must implement a mechanism capable of providing the workflow with the data contained within the defined secrets [c206336e5].

## Tasks: the fundamental unit

Tasks are the fundamental computing units of a workflow; they define the different types of actions a workflow can perform, including the ability to mutate their input and output data, and can also write to and modify the context data [c206336e5]. A task represents a discrete unit of work that contributes to achieving the overall objectives defined by the workflow, encapsulating a specific action or set of actions executed in a predefined order [cc117ea67]. Tasks are designed to be modular and focused, each serving a distinct purpose within the broader context of the workflow [cc117ea67].

The Serverless Workflow DSL defines several default task types that runtimes must implement [c206336e5]:

- **`Call`** — used to call services and/or functions [c206336e5].
- **`Do`** — used to define one or more subtasks to perform in sequence [c206336e5].
- **`Emit`** — used to emit events [c206336e5].
- **`For`** — used to iterate over a collection of items, and conditionally perform a task for each of them [c206336e5].
- **`Fork`** — used to define one or more subtasks to perform in parallel [c206336e5]; the reference describes Fork as defining one or more subtasks to perform concurrently [cc117ea67].
- **`Listen`** — used to listen for an event or more [c206336e5].
- **`Raise`** — used to raise an error and potentially fault the workflow [c206336e5].
- **`Run`** — used to run a container, a script, a shell command or even another workflow [c206336e5].
- **`Set`** — used to dynamically set the workflow's data during its execution [c206336e5].
- **`Switch`** — used to dynamically select and execute one of multiple alternative paths based on specified conditions [c206336e5].
- **`Try`** — used to attempt executing a specified task, and to handle any resulting errors gracefully, allowing the workflow to continue without interruption [c206336e5].
- **`Wait`** — used to pause or wait for a specified duration before proceeding to the next task [c206336e5].

To ensure conformance to the DSL, runtimes should pass all the feature conformance test scenarios defined in the ctk [c206336e5].

## Control flow

A workflow begins with the first task defined [c206336e5]. Once a task has been executed, one of three outcomes can happen: `continue` (the task ran to completion and the next task should execute), `fault` (the task raised an uncaught error, which abruptly halts execution and transitions the workflow to the `faulted` status phase), or `end` (the task explicitly and gracefully ends the workflow's execution) [c206336e5]. The task to run next is implicitly the next in declaration order, or explicitly defined by the `then` property of the executed task; if the executed task is the last, the workflow's execution gracefully ends [c206336e5].

Flow Directives are commands within a workflow that dictate its progression [cc117ea67]. The `"continue"` directive instructs the workflow to proceed with the next task in line; `"exit"` completes the current scope's execution, potentially terminating the entire workflow if the current task resides within the main `do` scope; `"end"` provides a graceful conclusion to the workflow execution; and a `string` value continues the workflow at the task with the specified name [cc117ea67]. Flow directives may only redirect to tasks declared within their own scope and cannot target tasks at a different depth [c206336e5].

## Data flow

Data flow management ensures the right data is passed between tasks and to the workflow itself, through transformation stages applied at strategic points [c206336e5]. Before the workflow starts, input data can be validated against the `input.schema` property and transformed via the top-level `input.from` expression, which evaluates the raw workflow input and defaults to the identity expression; the result sets the initial value for the `$input` runtime expression argument and is passed to the first task [c206336e5]. Each task can likewise validate and transform its input via `input.schema` and `input.from`, transform its output via the `output.as` runtime expression, and validate that output against `output.schema` [c206336e5].

To update the execution context, the `export.as` runtime expression evaluates the transformed task output and its result replaces the workflow's current context and the content of the `$context` runtime expression argument; the exported context may be validated against `export.schema` [c206336e5]. After the context is updated, the workflow continues to the next task, passing the transformed output of the previous task as the raw input to the next, repeating the data flow cycle; once no more tasks are defined, the transformed output is passed to the workflow output transformation step, where the final output can be transformed via `output.as` and validated against `output.schema` [c206336e5]. A failed validation at any of these stages faults the workflow with a ValidationError [c206336e5].

## Events and scheduling

Events facilitate communication and coordination between different components and services, enabling workflows to react to external stimuli for event-driven architectures and real-time processing [c206336e5]. Events in Serverless Workflow adhere to the CloudEvents specification, ensuring interoperability and compatibility with event-driven systems [c206336e5]. The Emit task allows workflows to publish events to event brokers or messaging systems, enabling them to broadcast notifications about occurrences such as order placements, data updates, or system events [c206336e5]. The Listen task provides a mechanism for workflows to await and react to external events, subscribing to specific event types or patterns and triggering actions based on incoming events [c206336e5].

Workflows can be triggered upon request, scheduled using CRON expressions, or initiated upon correlation with specific events [c206336e5]. Workflow scheduling offers four key properties: `every` (the interval for periodic execution regardless of the previous run's status), `cron` (CRON expressions for execution at specific times or intervals), `after` (a delay duration before restarting the workflow after completion), and `on` (event-driven scheduling that triggers execution based on specified events) [c206336e5].
