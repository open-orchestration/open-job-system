---
id: df87cdc82
topic: task-queues
title: "Spring Batch domain model: Job, JobInstance, JobExecution, Step"
status: draft
shape: reference
---

# Spring Batch domain model: Job, JobInstance, JobExecution, Step

## High-level architecture and domain language

To any experienced batch architect, the overall concepts of batch processing used in Spring Batch should be familiar and comfortable, with "Jobs" and "Steps" and developer-supplied processing units called `ItemReader` and `ItemWriter` [c70cbc0f6]. The batch reference architecture it implements is described as a blueprint proven through decades of implementations across COBOL on mainframes, C on Unix, and now Java anywhere [c70cbc0f6]. Spring Batch provides a physical implementation of the layers, components, and technical services commonly found in robust, maintainable batch systems, addressing simple to complex batch applications [c70cbc0f6].

The key high-level relationship is that a `Job` has one or more steps, each of which has exactly one `ItemReader`, an optional `ItemProcessor`, and one `ItemWriter` [c70cbc0f6]. A job is operated (started, stopped, etc.) with a `JobOperator`, and metadata about the currently running process is stored in and restored from a `JobRepository` [c70cbc0f6].

## Job

A `Job` is an entity that encapsulates an entire batch process, wired together with either an XML configuration file or Java-based configuration, a configuration that may be referred to as the "job configuration" [c70cbc0f6]. However, `Job` is only the top of an overall hierarchy [c70cbc0f6]. In Spring Batch, a `Job` is simply a container for `Step` instances; it combines multiple steps that logically belong together in a flow and allows for configuration of properties global to all steps, such as restartability [c70cbc0f6]. The job configuration contains the name of the job, the definition and ordering of `Step` instances, and whether or not the job is restartable [c70cbc0f6]. Spring Batch provides a default implementation of the `Job` interface in the form of the `SimpleJob` class, which creates some standard functionality on top of `Job` [c70cbc0f6].

## JobInstance

A `JobInstance` refers to the concept of a logical job run [c70cbc0f6]. For a job that should run once at the end of the day, such as the `EndOfDay` job, there is one such job, but each individual run of the `Job` must be tracked separately, so there is one logical `JobInstance` per day (a January 1st run, a January 2nd run, and so on) [c70cbc0f6]. If the January 1st run fails the first time and is run again the next day, it is still the January 1st run [c70cbc0f6]. Therefore, each `JobInstance` can have multiple executions, and only one `JobInstance` (which corresponds to a particular `Job` and identifying `JobParameters`) can run at a given time [c70cbc0f6].

The definition of a `JobInstance` has absolutely no bearing on the data to be loaded; it is entirely up to the `ItemReader` implementation to determine how data is loaded [c70cbc0f6]. However, using the same `JobInstance` determines whether or not the "state" (that is, the `ExecutionContext`) from previous executions is used: using a new `JobInstance` means "start from the beginning," and using an existing instance generally means "start from where you left off" [c70cbc0f6].

## JobParameters

One `JobInstance` is distinguished from another by `JobParameters` [c70cbc0f6]. A `JobParameters` object holds a set of parameters used to start a batch job, which can be used for identification or even as reference data during the run [c70cbc0f6]. In the example with two instances (January 1st and January 2nd) there is really only one `Job`, but it has two `JobParameter` objects: one started with a job parameter of 01-01-2017 and another started with a parameter of 01-02-2017 [c70cbc0f6]. Thus the contract is defined as: `JobInstance` = `Job` + identifying `JobParameters`, which lets a developer control how a `JobInstance` is defined since they control what parameters are passed in [c70cbc0f6]. Not all job parameters are required to contribute to the identification of a `JobInstance` — by default they do, but the framework also allows submission of a `Job` with parameters that do not contribute to the identity of a `JobInstance` [c70cbc0f6].

## JobExecution

A `JobExecution` refers to the technical concept of a single attempt to run a Job [c70cbc0f6]. An execution may end in failure or success, but the `JobInstance` corresponding to a given execution is not considered complete unless the execution completes successfully [c70cbc0f6]. If a `JobInstance` for 01-01-2017 failed the first time and is run again with the same identifying job parameters, a new `JobExecution` is created, but there is still only one `JobInstance` [c70cbc0f6]. A `Job` defines what a job is and how it is to be executed, a `JobInstance` is a purely organizational object to group executions together (primarily to enable correct restart semantics), and a `JobExecution` is the primary storage mechanism for what actually happened during a run, containing many more properties that must be controlled and persisted [c70cbc0f6]. Those persisted properties include a `Status` (a `BatchStatus` that is `BatchStatus#STARTED` while running, `BatchStatus#FAILED` on failure, and `BatchStatus#COMPLETED` on success), `startTime`, `endTime`, `exitStatus`, `createTime`, `lastUpdated`, an `executionContext`, and `failureExceptions` [c70cbc0f6].

There is no requirement that one `JobInstance` be kicked off after another unless there is potential for the two jobs to access the same data; it is entirely up to the scheduler to determine when a `Job` should be run [c70cbc0f6]. Since separate `JobInstances` are involved, Spring Batch makes no attempt to stop them from being run concurrently, but attempting to run the same `JobInstance` while another is already running results in a `JobExecutionAlreadyRunningException` being thrown [c70cbc0f6].

## Step

A `Step` is a domain object that encapsulates an independent, sequential phase of a batch job; therefore, every `Job` is composed entirely of one or more steps [c70cbc0f6]. A `Step` contains all the information necessary to define and control the actual batch processing, and its contents are at the discretion of the developer writing a `Job` — it can be as simple or complex as desired [c70cbc0f6]. As with a `Job`, a `Step` has an individual `StepExecution` that correlates with a unique `JobExecution` [c70cbc0f6].

## StepExecution

A `StepExecution` represents a single attempt to execute a `Step`, and a new `StepExecution` is created each time a `Step` is run, similar to `JobExecution` [c70cbc0f6]. However, if a step fails to execute because the step before it fails, no execution is persisted for it; a `StepExecution` is created only when its `Step` is actually started [c70cbc0f6]. Each execution contains a reference to its corresponding step and `JobExecution` and transaction-related data, such as commit and rollback counts and start and end times, and additionally each step execution contains an `ExecutionContext` holding data persisted across batch runs such as statistics or state needed to restart [c70cbc0f6]. `StepExecution` properties include `Status`, `startTime`, `endTime`, `exitStatus`, `executionContext`, `readCount`, `writeCount`, `commitCount`, `rollbackCount`, `readSkipCount`, `processSkipCount`, `filterCount`, and `writeSkipCount` [c70cbc0f6].

## JobRepository

`JobRepository` is the persistence mechanism for all of the stereotypes mentioned earlier, providing CRUD operations for `JobLauncher`, `Job`, and `Step` implementations [c70cbc0f6]. When a `Job` is first launched, a `JobExecution` is obtained from the repository, and during the course of execution `StepExecution` and `JobExecution` implementations are persisted by passing them to the repository [c70cbc0f6]. When using Java configuration, the `@EnableBatchProcessing` annotation provides a `JobRepository` as one of the components that is automatically configured [c70cbc0f6].

## JobOperator

`JobOperator` represents a simple interface for operations like starting, stopping, and restarting jobs [c70cbc0f6]. A `Job` is started with a given set of `JobParameters`, and it is expected that implementations obtain a valid `JobExecution` from the `JobRepository` and execute the `Job` [c70cbc0f6].

## ExecutionContext

An `ExecutionContext` represents a collection of key/value pairs that are persisted and controlled by the framework to give developers a place to store persistent state scoped to a `StepExecution` object or a `JobExecution` object [c70cbc0f6]. Its best usage example is to facilitate restart: the framework periodically persists the `ExecutionContext` at commit points so the `ItemReader` can store its state in case of a fatal error [c70cbc0f6]. Exactly one `ExecutionContext` exists per `StepExecution` at any given time, there is at least one per `JobExecution` and one for every `StepExecution`, and the one scoped to the `Step` does not equal the one scoped to the Job [c70cbc0f6]. The one scoped to the `Step` is saved at every commit point in the `Step`, whereas the one scoped to the Job is saved in between every `Step` execution [c70cbc0f6].

## Cardinality summary

- A `Job` has one or more `Step` instances; each `Step` has exactly one `ItemReader`, an optional `ItemProcessor`, and one `ItemWriter` [c70cbc0f6].
- `JobInstance` = `Job` + identifying `JobParameters` [c70cbc0f6].
- One `JobInstance` can have multiple `JobExecution`s, but only one `JobInstance` for a given `Job` + identifying `JobParameters` can run at a given time [c70cbc0f6].
- Each `Step` run produces one `StepExecution`, which correlates with a unique `JobExecution` [c70cbc0f6].
- Exactly one `ExecutionContext` exists per `StepExecution`, with at least one per `JobExecution` [c70cbc0f6].
- `JobRepository` persists all of these stereotypes and provides CRUD for `JobLauncher`, `Job`, and `Step` implementations [c70cbc0f6].
