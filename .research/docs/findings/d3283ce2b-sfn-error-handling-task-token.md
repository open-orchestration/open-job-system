---
id: d3283ce2b
topic: cloud-aws
title: Step Functions error handling and task-token callback
status: draft
shape: mechanism
---

# Step Functions error handling and task-token callback

The Amazon States Language (ASL) is a JSON-based, structured language used to define a state machine, which is a collection of states that can do work (`Task` states), determine which states to transition to next (`Choice` states), and stop an execution with an error (`Fail` states) [c1061168e]. Within that language, Step Functions provides explicit constructs for error propagation, retries, catch-based fallback, and a callback pattern that pauses a task until an external process returns a token [c6e7c00dd][cb1195201].

## Error names and types

Step Functions identifies errors using case-sensitive strings known as error names, and the ASL defines a set of built-in strings naming well-known errors, all beginning with the `States.` prefix [c6e7c00dd]. States can report errors with other names, but those names cannot begin with the `States.` prefix [c6e7c00dd]. All states except `Pass` and `Wait` states can encounter runtime errors, which can arise from state machine definition issues, task failures such as an exception in an AWS Lambda function, or transient issues such as network partition events [c6e7c00dd].

Key built-in error names include:

- `States.ALL` is a wildcard that matches any known error name; it must appear alone in a `Catcher` and cannot catch the `States.DataLimitExceeded` terminal error or `Runtime` error types [c6e7c00dd].
- `States.DataLimitExceeded` is a terminal error which cannot be caught by the `States.ALL` error type, although it can be caught or retried by explicitly specifying it in the `ErrorEquals` field of a `Catch` or `Retry` block [c6e7c00dd].
- `States.Runtime` is reported when an execution fails due to an exception it couldn't process; a `States.Runtime` error isn't retriable and will always cause the execution to fail, and a retry or catch on `States.ALL` won't catch `States.Runtime` errors [c6e7c00dd].
- `States.TaskFailed` is reported when a `Task` state failed during the execution, and when used in a retry or catch it acts as a wildcard that matches any known error name except for `States.Timeout` [c6e7c00dd].
- `States.Timeout` is reported when a `Task` state runs longer than the `TimeoutSeconds` value or failed to send a heartbeat for a period longer than the `HeartbeatSeconds` value [c6e7c00dd].
- `States.HeartbeatTimeout` is reported when a `Task` state failed to send a heartbeat for a period longer than the `HeartbeatSeconds` value, and is available inside the `Catch` and `Retry` fields [c6e7c00dd].

## Error propagation

When a state reports an error, Step Functions defaults to failing the entire state machine execution [c6e7c00dd]. Step Functions catchers are available for `Task`, `Parallel`, and `Map` states, but not for top-level state machine execution failures [c6e7c00dd]. If a nested state machine throws a `States.Timeout`, the parent will receive a `States.TaskFailed` error [c6e7c00dd].

## Retry field semantics

`Task`, `Parallel`, and `Map` states can have a field named `Retry`, whose value must be an array of objects known as retriers, where an individual retrier represents a certain number of retries, usually at increasing time intervals [c6e7c00dd]. When one of these states reports an error and there's a `Retry` field, Step Functions scans through the retriers in the order listed in the array, and when the error name appears in the value of a retrier's `ErrorEquals` field, the state machine makes retry attempts as defined in the `Retry` field [c6e7c00dd]. A retrier's parameters apply across all visits to the retrier in the context of a single-state execution [c6e7c00dd].

The retrier fields are:

- `ErrorEquals` (required) is a non-empty array of strings that match error names; when a state reports an error, Step Functions scans through the retriers, and when the error name appears in this array it implements the retry policy described in this retrier [c6e7c00dd].
- `IntervalSeconds` (optional) is a positive integer that represents the number of seconds before the first retry attempt (`1` by default) and has a maximum value of 99,999,999 [c6e7c00dd].
- `MaxAttempts` (optional) is a positive integer that represents the maximum number of retry attempts (`3` by default); if the error recurs more times than specified, retries cease and normal error handling resumes, a value of `0` specifies that the error is never retried, and `MaxAttempts` has a maximum value of 99,999,999 [c6e7c00dd].
- `BackoffRate` (optional) is the multiplier by which the retry interval denoted by `IntervalSeconds` increases after each retry attempt, and by default the `BackoffRate` value increases by `2.0` [c6e7c00dd].

The documentation gives a worked example: with `IntervalSeconds` of 3, `MaxAttempts` of 3, and `BackoffRate` of 2, the first retry attempt takes place three seconds after the error occurs, the second retry takes place six seconds after the first retry attempt, and the third retry takes place 12 seconds after the second retry attempt [c6e7c00dd]. The reserved name `States.ALL` appearing in a retrier's `ErrorEquals` field is a wildcard that must appear alone in the `ErrorEquals` array and must appear in the last retrier in the `Retry` array [c6e7c00dd].

## Catch field semantics

`Task`, `Map`, and `Parallel` states can each have a field named `Catch`, whose value must be an array of objects known as catchers [c6e7c00dd]. A catcher's `ErrorEquals` (required) is a non-empty array of strings that match error names, specified exactly as they are with the retrier field of the same name; `Next` (required) is a string that must exactly match one of the state machine's state names; and `ResultPath` (optional, JSONPath) is a path that determines what input the catcher sends to the state specified in the `Next` field [c6e7c00dd]. When a state reports an error and either there is no `Retry` field or retries fail to resolve the error, Step Functions scans through the catchers in the order listed in the array, and when the error name appears in the value of a catcher's `ErrorEquals` field, the state machine transitions to the state named in the `Next` field [c6e7c00dd]. As with retriers, `States.ALL` in a catcher's `ErrorEquals` field is a wildcard that must appear alone in the array and in the last catcher in the `Catch` array, and `States.TaskFailed` also acts as a wildcard matching any error except for `States.Timeout` [c6e7c00dd].

When Step Functions transitions to the state specified in a catch name, the object usually contains the field `Cause`, whose value is a human-readable description of the error; this object is known as the error output [c6e7c00dd]. For JSONPath workflows, if you don't specify the `ResultPath` field, it defaults to `$`, which selects and overwrites the entire input [c6e7c00dd]. When a state has both `Retry` and `Catch` fields, Step Functions uses any appropriate retriers first, and if the retry policy fails to resolve the error, Step Functions applies the matching catcher transition [c6e7c00dd].

## Wait-for-callback (`.waitForTaskToken`) integration

Callback tasks provide a way to pause a workflow until a task token is returned, which is useful when a task needs to wait for a human approval, integrate with a third party, or call legacy systems [cb1195201]. Step Functions allows you to pass a task token to AWS SDK service integrations and to some optimized service integrations, and the task will pause until it receives that task token back with a `SendTaskSuccess` or `SendTaskFailure` call [cb1195201]. To use `.waitForTaskToken` with an AWS SDK integration, the API you use must have a parameter field in which to place the task token [cb1195201]. The integration pattern is controlled by how you create the URI in the `"Resource"` field of the task definition, with `.waitForTaskToken` appended to the end [cb1195201].

The task token can be accessed in the `"Parameters"` field of the state definition with the special path designation `$$.Task.Token`, where the initial `$$.` designates that the path accesses the Context object and gets the task token for the current task in a running execution [cb1195201]. The Context object is an internal JSON object that contains information about the execution, including the task token under `"Task"."Token"` [cb1195201]. When the work is complete, the external service calls `SendTaskSuccess` or `SendTaskFailure` with the `taskToken` included, and only then does the workflow continue to the next state [cb1195201]. Task tokens must be passed from principals within the same AWS account, and the tokens won't work if sent from principals in a different AWS account [cb1195201].

## Heartbeat timeout for waiting tasks

A task that is waiting for a task token will wait until the execution reaches the one-year service quota, so to avoid stuck executions you can configure a heartbeat timeout interval in the state machine definition using the `HeartbeatSeconds` field [cb1195201]. In the documented example, the `"HeartbeatSeconds": 600` field sets the heartbeat timeout interval to 10 minutes, and the task will wait for the task token to be returned with one of the `SendTaskSuccess`, `SendTaskFailure`, or `SendTaskHeartbeat` API actions [cb1195201]. If the waiting task doesn't receive a valid task token within that 10-minute period, the task fails with a `States.Timeout` error name [cb1195201]. If a `Task` state using the callback task token times out, a new random token is generated [cb1195201].
