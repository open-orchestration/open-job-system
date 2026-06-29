[![Spring](https://docs.spring.io/spring-batch/reference/_/img/spring-logo.svg)](https://spring.io/)

[Why Spring](https://docs.spring.io/spring-batch/reference/domain.html#)

[Overview](https://spring.io/why-spring) Trending
[Generative AI](https://spring.io/ai) [Cloud](https://spring.io/cloud) Architecture Patterns
[Microservices](https://spring.io/microservices) [Reactive](https://spring.io/reactive) [Event Driven](https://spring.io/event-driven) Application Types
[Web Applications](https://spring.io/web-applications) [Serverless](https://spring.io/serverless) [Batch](https://spring.io/batch)

[Learn](https://docs.spring.io/spring-batch/reference/domain.html#)

Getting Started
[Quickstart](https://spring.io/quickstart) [Guides](https://spring.io/guides) Academy
[Courses](https://spring.academy/courses) [Get Certified](https://spring.academy/learning-path)

[Projects](https://docs.spring.io/spring-batch/reference/domain.html#)

[Overview](https://spring.io/projects) Projects
[Spring Boot](https://spring.io/projects/spring-boot) [Spring Framework](https://spring.io/projects/spring-framework) [Spring Cloud](https://spring.io/projects/spring-cloud) [Spring AI](https://spring.io/projects/spring-ai) [Spring Data](https://spring.io/projects/spring-data) [Spring Integration](https://spring.io/projects/spring-integration) [Spring Batch](https://spring.io/projects/spring-batch) [Spring Security](https://spring.io/projects/spring-security) Foundational Projects
[Micrometer](https://micrometer.io/) [Reactor](https://projectreactor.io/) Development Tools
[Spring Tools](https://spring.io/tools) [Spring Initializr](https://start.spring.io/)

[Resources](https://docs.spring.io/spring-batch/reference/domain.html#)

[Blog](https://spring.io/blog) [Release Calendar](https://spring.io/projects#release-calendar) [Version Mappings](https://spring.io/projects/generations) [Release Highlights](https://spring.io/projects/release-highlights) [Security Advisories](https://spring.io/security) GitHub Orgs
[Spring Projects](https://github.com/spring-projects) [Spring Cloud](https://github.com/spring-cloud)

[Community](https://docs.spring.io/spring-batch/reference/domain.html#)

[Overview](https://spring.io/community) [Events](https://spring.io/events) [Authors](https://spring.io/authors)

[Enterprise](https://docs.spring.io/spring-batch/reference/domain.html#)

[Overview](https://enterprise.spring.io/) [Long-term Support](https://enterprise.spring.io/lts-releases) [Automated Upgrades](https://enterprise.spring.io/spring-application-advisor) [Governance and Compliance](https://enterprise.spring.io/enterprise-extensions) [Modern App Development](https://enterprise.spring.io/enterprise-components)

light

Spring Batch Documentation6.0.4

SearchCTRL + k

- [Overview](https://docs.spring.io/spring-batch/reference/index.html)
- [Spring Batch Introduction](https://docs.spring.io/spring-batch/reference/spring-batch-intro.html)
- [Spring Batch Architecture](https://docs.spring.io/spring-batch/reference/spring-batch-architecture.html)
- [What’s new in Spring Batch 6](https://docs.spring.io/spring-batch/reference/whatsnew.html)
- [The Domain Language of Batch](https://docs.spring.io/spring-batch/reference/domain.html)
- [Configuring and Running a Job](https://docs.spring.io/spring-batch/reference/job.html)  - [Batch infrastructure Configuration](https://docs.spring.io/spring-batch/reference/job/configuring-infrastructure.html)
  - [Configuring a Job](https://docs.spring.io/spring-batch/reference/job/configuring-job.html)
  - [Configuring a JobRepository](https://docs.spring.io/spring-batch/reference/job/configuring-repository.html)
  - [Configuring a JobOperator](https://docs.spring.io/spring-batch/reference/job/configuring-operator.html)
  - [Running a Job](https://docs.spring.io/spring-batch/reference/job/running.html)
  - [Advanced Metadata Usage](https://docs.spring.io/spring-batch/reference/job/advanced-meta-data.html)
- [Configuring a `Step`](https://docs.spring.io/spring-batch/reference/step.html)  - [Chunk-oriented Processing](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing.html)    - [Configuring a Step](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/configuring.html)
    - [Inheriting from a Parent `Step`](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/inheriting-from-parent.html)
    - [The Commit Interval](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/commit-interval.html)
    - [Configuring a `Step` for Restart](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/restart.html)
    - [Configuring Skip Logic](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/configuring-skip.html)
    - [Configuring Retry Logic](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/retry-logic.html)
    - [Transaction Attributes](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/transaction-attributes.html)
    - [Registering `ItemStream` with a `Step`](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/registering-item-streams.html)
    - [Intercepting `Step` Execution](https://docs.spring.io/spring-batch/reference/step/chunk-oriented-processing/intercepting-execution.html)
  - [`TaskletStep`](https://docs.spring.io/spring-batch/reference/step/tasklet.html)
  - [Controlling Step Flow](https://docs.spring.io/spring-batch/reference/step/controlling-flow.html)
  - [Late Binding of `Job` and `Step` Attributes](https://docs.spring.io/spring-batch/reference/step/late-binding.html)
- [ItemReaders and ItemWriters](https://docs.spring.io/spring-batch/reference/readersAndWriters.html)  - [`ItemReader`](https://docs.spring.io/spring-batch/reference/readers-and-writers/item-reader.html)
  - [`ItemWriter`](https://docs.spring.io/spring-batch/reference/readers-and-writers/item-writer.html)
  - [`ItemStream`](https://docs.spring.io/spring-batch/reference/readers-and-writers/item-stream.html)
  - [The Delegate Pattern and Registering with the Step](https://docs.spring.io/spring-batch/reference/readers-and-writers/delegate-pattern-registering.html)
  - [Flat Files](https://docs.spring.io/spring-batch/reference/readers-and-writers/flat-files.html)    - [The `FieldSet`](https://docs.spring.io/spring-batch/reference/readers-and-writers/flat-files/field-set.html)
    - [`FlatFileItemReader`](https://docs.spring.io/spring-batch/reference/readers-and-writers/flat-files/file-item-reader.html)
    - [`FlatFileItemWriter`](https://docs.spring.io/spring-batch/reference/readers-and-writers/flat-files/file-item-writer.html)
  - [XML Item Readers and Writers](https://docs.spring.io/spring-batch/reference/readers-and-writers/xml-reading-writing.html)
  - [JSON Item Readers And Writers](https://docs.spring.io/spring-batch/reference/readers-and-writers/json-reading-writing.html)
  - [Multi-File Input](https://docs.spring.io/spring-batch/reference/readers-and-writers/multi-file-input.html)
  - [Database](https://docs.spring.io/spring-batch/reference/readers-and-writers/database.html)
  - [Reusing Existing Services](https://docs.spring.io/spring-batch/reference/readers-and-writers/reusing-existing-services.html)
  - [Preventing State Persistence](https://docs.spring.io/spring-batch/reference/readers-and-writers/process-indicator.html)
  - [Creating Custom ItemReaders and ItemWriters](https://docs.spring.io/spring-batch/reference/readers-and-writers/custom.html)
  - [Item Reader and Writer Implementations](https://docs.spring.io/spring-batch/reference/readers-and-writers/item-reader-writer-implementations.html)
- [Item processing](https://docs.spring.io/spring-batch/reference/processor.html)
- [Scaling and Parallel Processing](https://docs.spring.io/spring-batch/reference/scalability.html)
- [Repeat](https://docs.spring.io/spring-batch/reference/repeat.html)
- [Retry](https://docs.spring.io/spring-batch/reference/retry.html)
- [Unit Testing](https://docs.spring.io/spring-batch/reference/testing.html)
- [Common Batch Patterns](https://docs.spring.io/spring-batch/reference/common-patterns.html)
- [Spring Batch Integration](https://docs.spring.io/spring-batch/reference/spring-batch-integration.html)  - [Namespace Support](https://docs.spring.io/spring-batch/reference/spring-batch-integration/namespace-support.html)
  - [Launching Batch Jobs through Messages](https://docs.spring.io/spring-batch/reference/spring-batch-integration/launching-jobs-through-messages.html)
  - [Available Attributes of the Job-Launching Gateway](https://docs.spring.io/spring-batch/reference/spring-batch-integration/available-attributes-of-the-job-launching-gateway.html)
  - [Providing Feedback with Informational Messages](https://docs.spring.io/spring-batch/reference/spring-batch-integration/providing-feedback-with-informational-messages.html)
  - [Asynchronous Processors](https://docs.spring.io/spring-batch/reference/spring-batch-integration/asynchronous-processing.html)
  - [Externalizing Batch Process Execution](https://docs.spring.io/spring-batch/reference/spring-batch-integration/externalizing-execution.html)
- [Spring Batch Observability](https://docs.spring.io/spring-batch/reference/spring-batch-observability.html)  - [Micrometer support](https://docs.spring.io/spring-batch/reference/spring-batch-observability/micrometer.html)
  - [Java Flight Recorder (JFR) support](https://docs.spring.io/spring-batch/reference/spring-batch-observability/jfr.html)
- Appendices  - [List of ItemReaders and ItemWriters](https://docs.spring.io/spring-batch/reference/appendix.html)
  - [Meta-Data Schema](https://docs.spring.io/spring-batch/reference/schema-appendix.html)
  - [Glossary](https://docs.spring.io/spring-batch/reference/glossary.html)
  - [Frequently Asked Questions](https://docs.spring.io/spring-batch/reference/faq.html)

SearchCTRL + k

### The Domain Language of Batch

- [Job](https://docs.spring.io/spring-batch/reference/domain.html#job)
- [JobInstance](https://docs.spring.io/spring-batch/reference/domain.html#jobinstance)
- [JobParameters](https://docs.spring.io/spring-batch/reference/domain.html#jobParameters)
- [JobExecution](https://docs.spring.io/spring-batch/reference/domain.html#jobexecution)
- [Step](https://docs.spring.io/spring-batch/reference/domain.html#step)
- [StepExecution](https://docs.spring.io/spring-batch/reference/domain.html#stepexecution)
- [ExecutionContext](https://docs.spring.io/spring-batch/reference/domain.html#executioncontext)
- [JobRepository](https://docs.spring.io/spring-batch/reference/domain.html#jobrepository)
- [JobOperator](https://docs.spring.io/spring-batch/reference/domain.html#jobOperator)
- [ItemReader](https://docs.spring.io/spring-batch/reference/domain.html#itemreader)
- [ItemWriter](https://docs.spring.io/spring-batch/reference/domain.html#itemwriter)
- [ItemProcessor](https://docs.spring.io/spring-batch/reference/domain.html#itemprocessor)
- [Batch Namespace](https://docs.spring.io/spring-batch/reference/domain.html#batch-namespace)

[Edit this Page](https://github.com/spring-projects/spring-batch/blob/v6.0.4/spring-batch-docs/modules/ROOT/pages/domain.adoc) [GitHub Project](https://github.com/spring-projects/spring-batch "GitHub") [Stack Overflow](https://stackoverflow.com/tags/spring-batch)

- [Spring Batch Documentation](https://docs.spring.io/spring-batch/reference/index.html)
- [The Domain Language of Batch](https://docs.spring.io/spring-batch/reference/domain.html)

# The Domain Language of Batch

### The Domain Language of Batch

- [Job](https://docs.spring.io/spring-batch/reference/domain.html#job)
- [JobInstance](https://docs.spring.io/spring-batch/reference/domain.html#jobinstance)
- [JobParameters](https://docs.spring.io/spring-batch/reference/domain.html#jobParameters)
- [JobExecution](https://docs.spring.io/spring-batch/reference/domain.html#jobexecution)
- [Step](https://docs.spring.io/spring-batch/reference/domain.html#step)
- [StepExecution](https://docs.spring.io/spring-batch/reference/domain.html#stepexecution)
- [ExecutionContext](https://docs.spring.io/spring-batch/reference/domain.html#executioncontext)
- [JobRepository](https://docs.spring.io/spring-batch/reference/domain.html#jobrepository)
- [JobOperator](https://docs.spring.io/spring-batch/reference/domain.html#jobOperator)
- [ItemReader](https://docs.spring.io/spring-batch/reference/domain.html#itemreader)
- [ItemWriter](https://docs.spring.io/spring-batch/reference/domain.html#itemwriter)
- [ItemProcessor](https://docs.spring.io/spring-batch/reference/domain.html#itemprocessor)
- [Batch Namespace](https://docs.spring.io/spring-batch/reference/domain.html#batch-namespace)

To any experienced batch architect, the overall concepts of batch processing used in
Spring Batch should be familiar and comfortable. There are “Jobs” and “Steps” and
developer-supplied processing units called `ItemReader` and `ItemWriter`. However,
because of the Spring patterns, operations, templates, callbacks, and idioms, there are
opportunities for the following:

- Significant improvement in adherence to a clear separation of concerns.

- Clearly delineated architectural layers and services provided as interfaces.

- Simple and default implementations that allow for quick adoption and ease of use
out of the box.

- Significantly enhanced extensibility.


The following diagram is a simplified version of the batch reference architecture that
has been used for decades. It provides an overview of the components that make up the
domain language of batch processing. This architecture framework is a blueprint that has
been proven through decades of implementations on the last several generations of
platforms (COBOL on mainframes, C on Unix, and now Java anywhere). JCL and COBOL developers
are likely to be as comfortable with the concepts as C, C#, and Java developers. Spring
Batch provides a physical implementation of the layers, components, and technical
services commonly found in the robust, maintainable systems that are used to address the
creation of simple to complex batch applications, with the infrastructure and extensions
to address very complex processing needs.

![Figure 2.1: Batch Stereotypes](https://docs.spring.io/spring-batch/reference/_images/spring-batch-reference-model.png)

Figure 1. Batch Stereotypes

The preceding diagram highlights the key concepts that make up the domain language of
Spring Batch. A `Job` has one or more steps, each of which has exactly one `ItemReader`,
an optional `ItemProcessor`, and one `ItemWriter`. A job is operated (started, stopped, etc)
with a `JobOperator`, and metadata about the currently running process is stored in and
restored from a `JobRepository`.

## Job

This section describes stereotypes relating to the concept of a batch job. A `Job` is an
entity that encapsulates an entire batch process. As is common with other Spring
projects, a `Job` is wired together with either an XML configuration file or Java-based
configuration. This configuration may be referred to as the “job configuration”. However,
`Job` is only the top of an overall hierarchy, as shown in the following diagram:

![Job Hierarchy](https://docs.spring.io/spring-batch/reference/_images/job-heirarchy.png)

Figure 2. Job Hierarchy

In Spring Batch, a `Job` is simply a container for `Step` instances. It combines multiple
steps that logically belong together in a flow and allows for configuration of properties
global to all steps, such as restartability. The job configuration contains:

- The name of the job.

- Definition and ordering of `Step` instances.

- Whether or not the job is restartable.


- Java

- XML


For those who use Java configuration, Spring Batch provides a default implementation of
the `Job` interface in the form of the `SimpleJob` class, which creates some standard
functionality on top of `Job`. When using Java-based configuration, a collection of
builders is made available for the instantiation of a `Job`, as the following
example shows:

```java
@Bean
public Job footballJob(JobRepository jobRepository) {
    return new JobBuilder("footballJob", jobRepository)
                     .start(playerLoad())
                     .next(gameLoad())
                     .next(playerSummarization())
                     .build();
}Copied!
```

For those who use XML configuration, Spring Batch provides a default implementation of the
`Job` interface in the form of the `SimpleJob` class, which creates some standard
functionality on top of `Job`. However, the batch namespace abstracts away the need to
instantiate it directly. Instead, you can use the `<job>` element, as the
following example shows:

```xml
<job id="footballJob">
    <step id="playerload" next="gameLoad"/>
    <step id="gameLoad" next="playerSummarization"/>
    <step id="playerSummarization"/>
</job>Copied!
```

### JobInstance

A `JobInstance` refers to the concept of a logical job run. Consider a batch job that
should be run once at the end of the day, such as the `EndOfDay``Job` from the preceding
diagram. There is one `EndOfDay` job, but each individual run of the `Job` must be
tracked separately. In the case of this job, there is one logical `JobInstance` per day.
For example, there is a January 1st run, a January 2nd run, and so on. If the January 1st
run fails the first time and is run again the next day, it is still the January 1st run.
(Usually, this corresponds with the data it is processing as well, meaning the January
1st run processes data for January 1st). Therefore, each `JobInstance` can have multiple
executions (`JobExecution` is discussed in more detail later in this chapter), and only
one `JobInstance` (which corresponds to a particular `Job` and identifying `JobParameters`) can
run at a given time.

The definition of a `JobInstance` has absolutely no bearing on the data to be loaded.
It is entirely up to the `ItemReader` implementation to determine how data is loaded. For
example, in the `EndOfDay` scenario, there may be a column on the data that indicates the
`effective date` or `schedule date` to which the data belongs. So, the January 1st run
would load only data from the 1st, and the January 2nd run would use only data from the
2nd. Because this determination is likely to be a business decision, it is left up to the
`ItemReader` to decide. However, using the same `JobInstance` determines whether or not
the “state” (that is, the `ExecutionContext`, which is discussed later in this chapter)
from previous executions is used. Using a new `JobInstance` means “start from the
beginning,” and using an existing instance generally means “start from where you left
off”.

### JobParameters

Having discussed `JobInstance` and how it differs from `Job`, the natural question to ask
is: “How is one `JobInstance` distinguished from another?” The answer is:
`JobParameters`. A `JobParameters` object holds a set of parameters used to start a batch
job. They can be used for identification or even as reference data during the run, as the
following image shows:

![Job Parameters](https://docs.spring.io/spring-batch/reference/_images/job-stereotypes-parameters.png)

Figure 3. Job Parameters

In the example from the [Job Instance](https://docs.spring.io/spring-batch/reference/domain.html#jobinstance) section, where there are
two instances, one for January 1st and another for January 2nd, there is really only one `Job`,
but it has two `JobParameter` objects: one that was started with a job parameter of 01-01-2017
and another that was started with a parameter of 01-02-2017. Thus, the contract can be defined
as: `JobInstance` = `Job` \+ identifying `JobParameters`. This allows a developer to effectively
control how a `JobInstance` is defined, since they control what parameters are passed in.

|     |     |
| --- | --- |
|  | Not all job parameters are required to contribute to the identification of a<br>`JobInstance`. By default, they do so. However, the framework also allows the submission<br>of a `Job` with parameters that do not contribute to the identity of a `JobInstance`. |

### JobExecution

A `JobExecution` refers to the technical concept of a single attempt to run a Job. An
execution may end in failure or success, but the `JobInstance` corresponding to a given
execution is not considered to be complete unless the execution completes successfully.
Using the `EndOfDay``Job` described previously as an example, consider a `JobInstance` for
01-01-2017 that failed the first time it was run. If it is run again with the same
identifying job parameters as the first run (01-01-2017), a new `JobExecution` is
created. However, there is still only one `JobInstance`.

A `Job` defines what a job is and how it is to be executed, and a `JobInstance` is a
purely organizational object to group executions together, primarily to enable correct
restart semantics. A `JobExecution`, however, is the primary storage mechanism for what
actually happened during a run and contains many more properties that must be controlled
and persisted, as the following table shows:

|     |     |
| --- | --- |
| Property | Definition |
| `Status` | A `BatchStatus` object that indicates the status of the execution. While running, it is<br>`BatchStatus#STARTED`. If it fails, it is `BatchStatus#FAILED`. If it finishes<br>successfully, it is `BatchStatus#COMPLETED` |
| `startTime` | A `java.time.LocalDateTime` representing the current system time when the execution was started.<br>This field is empty if the job has yet to start. |
| `endTime` | A `java.time.LocalDateTime` representing the current system time when the execution finished,<br>regardless of whether it was successful or not. The field is empty if the job has yet to<br>finish. |
| `exitStatus` | The `ExitStatus`, indicating the result of the run. It is most important, because it<br>contains an exit code that is returned to the caller. See chapter 5 for more details. The<br>field is empty if the job has yet to finish. |
| `createTime` | A `java.time.LocalDateTime` representing the current system time when the `JobExecution` was<br>first persisted. The job may not have been started yet (and thus has no start time), but<br>it always has a `createTime`, which is required by the framework for managing job-level<br>`ExecutionContexts`. |
| `lastUpdated` | A `java.time.LocalDateTime` representing the last time a `JobExecution` was persisted. This field<br>is empty if the job has yet to start. |
| `executionContext` | The “property bag” containing any user data that needs to be persisted between<br>executions. |
| `failureExceptions` | The list of exceptions encountered during the execution of a `Job`. These can be useful<br>if more than one exception is encountered during the failure of a `Job`. |

Table 1. JobExecution Properties

These properties are important because they are persisted and can be used to completely
determine the status of an execution. For example, if the `EndOfDay` job for 01-01 is
executed at 9:00 PM and fails at 9:30, the following entries are made in the batch
metadata tables:

|     |     |
| --- | --- |
| JOB\_INST\_ID | JOB\_NAME |
| 1 | EndOfDayJob |

Table 2. BATCH\_JOB\_INSTANCE

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| JOB\_EXECUTION\_ID | TYPE\_CD | KEY\_NAME | DATE\_VAL | IDENTIFYING |
| 1 | DATE | schedule.Date | 2017-01-01 | TRUE |

Table 3. BATCH\_JOB\_EXECUTION\_PARAMS

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| JOB\_EXEC\_ID | JOB\_INST\_ID | START\_TIME | END\_TIME | STATUS |
| 1 | 1 | 2017-01-01 21:00 | 2017-01-01 21:30 | FAILED |

Table 4. BATCH\_JOB\_EXECUTION

|     |     |
| --- | --- |
|  | Column names may have been abbreviated or removed for the sake of clarity and<br>formatting. |

Now that the job has failed, assume that it took the entire night for the problem to be
determined, so that the “batch window” is now closed. Further assuming that the window
starts at 9:00 PM, the job is kicked off again for 01-01, starting where it left off and
completing successfully at 9:30. Because it is now the next day, the 01-02 job must be
run as well, and it is kicked off just afterwards at 9:31 and completes in its normal one
hour time at 10:30. There is no requirement that one `JobInstance` be kicked off after
another, unless there is potential for the two jobs to attempt to access the same data,
causing issues with locking at the database level. It is entirely up to the scheduler to
determine when a `Job` should be run. Since they are separate `JobInstances`, Spring
Batch makes no attempt to stop them from being run concurrently. (Attempting to run the
same `JobInstance` while another is already running results in a
`JobExecutionAlreadyRunningException` being thrown). There should now be an extra entry
in both the `JobInstance` and `JobParameters` tables and two extra entries in the
`JobExecution` table, as shown in the following tables:

|     |     |
| --- | --- |
| JOB\_INST\_ID | JOB\_NAME |
| 1 | EndOfDayJob |
| 2 | EndOfDayJob |

Table 5. BATCH\_JOB\_INSTANCE

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| JOB\_EXECUTION\_ID | TYPE\_CD | KEY\_NAME | DATE\_VAL | IDENTIFYING |
| 1 | DATE | schedule.Date | 2017-01-01 00:00:00 | TRUE |
| 2 | DATE | schedule.Date | 2017-01-01 00:00:00 | TRUE |
| 3 | DATE | schedule.Date | 2017-01-02 00:00:00 | TRUE |

Table 6. BATCH\_JOB\_EXECUTION\_PARAMS

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| JOB\_EXEC\_ID | JOB\_INST\_ID | START\_TIME | END\_TIME | STATUS |
| 1 | 1 | 2017-01-01 21:00 | 2017-01-01 21:30 | FAILED |
| 2 | 1 | 2017-01-02 21:00 | 2017-01-02 21:30 | COMPLETED |
| 3 | 2 | 2017-01-02 21:31 | 2017-01-02 22:29 | COMPLETED |

Table 7. BATCH\_JOB\_EXECUTION

|     |     |
| --- | --- |
|  | Column names may have been abbreviated or removed for the sake of clarity and<br>formatting. |

## Step

A `Step` is a domain object that encapsulates an independent, sequential phase of a batch
job. Therefore, every `Job` is composed entirely of one or more steps. A `Step` contains
all the information necessary to define and control the actual batch processing. This
is a necessarily vague description because the contents of any given `Step` are at the
discretion of the developer writing a `Job`. A `Step` can be as simple or complex as the
developer desires. A simple `Step` might load data from a file into the database,
requiring little or no code (depending upon the implementations used). A more complex
`Step` may have complicated business rules that are applied as part of the processing. As
with a `Job`, a `Step` has an individual `StepExecution` that correlates with a unique
`JobExecution`, as the following image shows:

![Figure 2.1: Job Hierarchy With Steps](https://docs.spring.io/spring-batch/reference/_images/jobHeirarchyWithSteps.png)

Figure 4. Job Hierarchy With Steps

### StepExecution

A `StepExecution` represents a single attempt to execute a `Step`. A new `StepExecution`
is created each time a `Step` is run, similar to `JobExecution`. However, if a step fails
to execute because the step before it fails, no execution is persisted for it. A
`StepExecution` is created only when its `Step` is actually started.

`Step` executions are represented by objects of the `StepExecution` class. Each execution
contains a reference to its corresponding step and `JobExecution` and transaction-related
data, such as commit and rollback counts and start and end times. Additionally, each step
execution contains an `ExecutionContext`, which contains any data a developer needs to
have persisted across batch runs, such as statistics or state information needed to
restart. The following table lists the properties for `StepExecution`:

|     |     |
| --- | --- |
| Property | Definition |
| `Status` | A `BatchStatus` object that indicates the status of the execution. While running, the<br>status is `BatchStatus.STARTED`. If it fails, the status is `BatchStatus.FAILED`. If it<br>finishes successfully, the status is `BatchStatus.COMPLETED`. |
| `startTime` | A `java.time.LocalDateTime` representing the current system time when the execution was started.<br>This field is empty if the step has yet to start. |
| `endTime` | A `java.time.LocalDateTime` representing the current system time when the execution finished,<br>regardless of whether it was successful or not. This field is empty if the step has yet to<br>exit. |
| `exitStatus` | The `ExitStatus` indicating the result of the execution. It is most important, because<br>it contains an exit code that is returned to the caller. See chapter 5 for more details.<br>This field is empty if the job has yet to exit. |
| `executionContext` | The “property bag” containing any user data that needs to be persisted between<br>executions. |
| `readCount` | The number of items that have been successfully read. |
| `writeCount` | The number of items that have been successfully written. |
| `commitCount` | The number of transactions that have been committed for this execution. |
| `rollbackCount` | The number of times the business transaction controlled by the `Step` has been rolled<br>back. |
| `readSkipCount` | The number of times `read` has failed, resulting in a skipped item. |
| `processSkipCount` | The number of times `process` has failed, resulting in a skipped item. |
| `filterCount` | The number of items that have been “filtered” by the `ItemProcessor`. |
| `writeSkipCount` | The number of times `write` has failed, resulting in a skipped item. |

Table 8. StepExecution Properties

## ExecutionContext

An `ExecutionContext` represents a collection of key/value pairs that are persisted and
controlled by the framework to give developers a place to store persistent
state that is scoped to a `StepExecution` object or a `JobExecution` object. (For those
familiar with Quartz, it is very similar to `JobDataMap`.) The best usage example is to
facilitate restart. Using flat file input as an example, while processing individual
lines, the framework periodically persists the `ExecutionContext` at commit points. Doing
so lets the `ItemReader` store its state in case a fatal error occurs during the run
or even if the power goes out. All that is needed is to put the current number of lines
read into the context, as the following example shows, and the framework does the
rest:

```java
executionContext.putLong(getKey(LINES_READ_COUNT), reader.getPosition());Copied!
```

Using the `EndOfDay` example from the `Job` stereotypes section as an example, assume there
is one step, `loadData`, that loads a file into the database. After the first failed run,
the metadata tables would look like the following example:

|     |     |
| --- | --- |
| JOB\_INST\_ID | JOB\_NAME |
| 1 | EndOfDayJob |

Table 9. BATCH\_JOB\_INSTANCE

|     |     |     |     |
| --- | --- | --- | --- |
| JOB\_INST\_ID | TYPE\_CD | KEY\_NAME | DATE\_VAL |
| 1 | DATE | schedule.Date | 2017-01-01 |

Table 10. BATCH\_JOB\_EXECUTION\_PARAMS

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| JOB\_EXEC\_ID | JOB\_INST\_ID | START\_TIME | END\_TIME | STATUS |
| 1 | 1 | 2017-01-01 21:00 | 2017-01-01 21:30 | FAILED |

Table 11. BATCH\_JOB\_EXECUTION

|     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- |
| STEP\_EXEC\_ID | JOB\_EXEC\_ID | STEP\_NAME | START\_TIME | END\_TIME | STATUS |
| 1 | 1 | loadData | 2017-01-01 21:00 | 2017-01-01 21:30 | FAILED |

Table 12. BATCH\_STEP\_EXECUTION

|     |     |
| --- | --- |
| STEP\_EXEC\_ID | SHORT\_CONTEXT |
| 1 | {piece.count=40321} |

Table 13. BATCH\_STEP\_EXECUTION\_CONTEXT

In the preceding case, the `Step` ran for 30 minutes and processed 40,321 “pieces”, which
would represent lines in a file in this scenario. This value is updated just before each
commit by the framework and can contain multiple rows corresponding to entries within the
`ExecutionContext`. Being notified before a commit requires one of the various
`StepListener` implementations (or an `ItemStream`), which are discussed in more detail
later in this guide. As with the previous example, it is assumed that the `Job` is
restarted the next day. When it is restarted, the values from the `ExecutionContext` of
the last run are reconstituted from the database. When the `ItemReader` is opened, it can
check to see if it has any stored state in the context and initialize itself from there,
as the following example shows:

```java
if (executionContext.containsKey(getKey(LINES_READ_COUNT))) {
    log.debug("Initializing for restart. Restart data is: " + executionContext);

    long lineCount = executionContext.getLong(getKey(LINES_READ_COUNT));

    LineReader reader = getReader();

    Object record = "";
    while (reader.getPosition() < lineCount && record != null) {
        record = readLine();
    }
}Copied!
```

In this case, after the preceding code runs, the current line is 40,322, letting the `Step`
start again from where it left off. You can also use the `ExecutionContext` for
statistics that need to be persisted about the run itself. For example, if a flat file
contains orders for processing that exist across multiple lines, it may be necessary to
store how many orders have been processed (which is much different from the number of
lines read), so that an email can be sent at the end of the `Step` with the total number
of orders processed in the body. The framework handles storing this for the developer,
to correctly scope it with an individual `JobInstance`. It can be very difficult to
know whether an existing `ExecutionContext` should be used or not. For example, using the
`EndOfDay` example from above, when the 01-01 run starts again for the second time, the
framework recognizes that it is the same `JobInstance` and on an individual `Step` basis,
pulls the `ExecutionContext` out of the database, and hands it (as part of the
`StepExecution`) to the `Step` itself. Conversely, for the 01-02 run, the framework
recognizes that it is a different instance, so an empty context must be handed to the
`Step`. There are many of these types of determinations that the framework makes for the
developer, to ensure the state is given to them at the correct time. It is also important
to note that exactly one `ExecutionContext` exists per `StepExecution` at any given time.
Clients of the `ExecutionContext` should be careful, because this creates a shared
keyspace. As a result, care should be taken when putting values in to ensure no data is
overwritten. However, the `Step` stores absolutely no data in the context, so there is no
way to adversely affect the framework.

Note that there is at least one `ExecutionContext` per
`JobExecution` and one for every `StepExecution`. For example, consider the following
code snippet:

```java
ExecutionContext ecStep = stepExecution.getExecutionContext();
ExecutionContext ecJob = jobExecution.getExecutionContext();
//ecStep does not equal ecJobCopied!
```

As noted in the comment, `ecStep` does not equal `ecJob`. They are two different
`ExecutionContexts`. The one scoped to the `Step` is saved at every commit point in the
`Step`, whereas the one scoped to the Job is saved in between every `Step` execution.

|     |     |
| --- | --- |
|  | In the `ExecutionContext`, all non-transient entries must be `Serializable`.<br>Proper serialization of the execution context underpins the restart capability of steps and jobs.<br>Should you use keys or values that are not natively serializable, you are required to<br>employ a tailored serialization approach. Failing to serialize the execution context<br>may jeopardize the state persistence process, making failed jobs impossible to recover properly. |

## JobRepository

`JobRepository` is the persistence mechanism for all of the stereotypes mentioned earlier.
It provides CRUD operations for `JobLauncher`, `Job`, and `Step` implementations. When a
`Job` is first launched, a `JobExecution` is obtained from the repository. Also, during
the course of execution, `StepExecution` and `JobExecution` implementations are persisted
by passing them to the repository.

- Java

- XML


When using Java configuration, the `@EnableBatchProcessing` annotation provides a
`JobRepository` as one of the components that is automatically configured.

The Spring Batch XML namespace provides support for configuring a `JobRepository` instance
with the `<job-repository>` tag, as the following example shows:

```xml
<job-repository id="jobRepository"/>Copied!
```

## JobOperator

`JobOperator` represents a simple interface for operations like starting, stopping and restarting
jobs, as the following example shows:

```java
public interface JobOperator {

    JobExecution start(Job job, JobParameters jobParameters) throws Exception;
    JobExecution startNextInstance(Job job) throws Exception;
    boolean stop(JobExecution jobExecution) throws Exception;
    JobExecution restart(JobExecution jobExecution) throws Exception;
    JobExecution abandon(JobExecution jobExecution) throws Exception;

}Copied!
```

A `Job` is started with a given set of `JobParameters`. It is expected that implementations obtain
a valid `JobExecution` from the `JobRepository` and execute the `Job`.

## ItemReader

`ItemReader` is an abstraction that represents the retrieval of input for a `Step`, one
item at a time. When the `ItemReader` has exhausted the items it can provide, it
indicates this by returning `null`. You can find more details about the `ItemReader` interface and its
various implementations in
[Readers And Writers](https://docs.spring.io/spring-batch/reference/readersAndWriters.html).

## ItemWriter

`ItemWriter` is an abstraction that represents the output of a `Step`, one batch or chunk
of items at a time. Generally, an `ItemWriter` has no knowledge of the input it should
receive next and knows only the item that was passed in its current invocation. You can find more
details about the `ItemWriter` interface and its various implementations in
[Readers And Writers](https://docs.spring.io/spring-batch/reference/readersAndWriters.html).

## ItemProcessor

`ItemProcessor` is an abstraction that represents the business processing of an item.
While the `ItemReader` reads one item, and the `ItemWriter` writes one item, the
`ItemProcessor` provides an access point to transform or apply other business processing.
If, while processing the item, it is determined that the item is not valid, returning
`null` indicates that the item should not be written out. You can find more details about the
`ItemProcessor` interface in
[Readers And Writers](https://docs.spring.io/spring-batch/reference/readersAndWriters.html).

## Batch Namespace

Many of the domain concepts listed previously need to be configured in a Spring
`ApplicationContext`. While there are implementations of the interfaces above that you can
use in a standard bean definition, a namespace has been provided for ease of
configuration, as the following example shows:

```xml
<beans:beans xmlns="http://www.springframework.org/schema/batch"
xmlns:beans="http://www.springframework.org/schema/beans"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="
   http://www.springframework.org/schema/beans
   https://www.springframework.org/schema/beans/spring-beans.xsd
   http://www.springframework.org/schema/batch
   https://www.springframework.org/schema/batch/spring-batch.xsd">

<job id="ioSampleJob">
    <step id="step1">
        <tasklet>
            <chunk reader="itemReader" writer="itemWriter" commit-interval="2"/>
        </tasklet>
    </step>
</job>

</beans:beans>Copied!
```

As long as the batch namespace has been declared, any of its elements can be used. You can find more
information on configuring a Job in [Configuring and Running a Job](https://docs.spring.io/spring-batch/reference/job.html)
. You can find more information on configuring a `Step` in
[Configuring a Step](https://docs.spring.io/spring-batch/reference/step.html).

|     |     |
| --- | --- |
|  | The batch XML namespace is deprecated as of Spring Batch 6.0 and will be removed in version 7.0. |

[What’s new in Spring Batch 6](https://docs.spring.io/spring-batch/reference/whatsnew.html)[Configuring and Running a Job](https://docs.spring.io/spring-batch/reference/job.html)

- [Spring Batch Documentation](https://docs.spring.io/spring-batch/reference/index.html)




Stable




  - [6.0.4](https://docs.spring.io/spring-batch/reference/domain.html)
  - [5.2.6](https://docs.spring.io/spring-batch/reference/5.2/domain.html)
  - [5.1.3](https://docs.spring.io/spring-batch/reference/5.1/domain.html)

Snapshot


  - [6.0.5-SNAPSHOT](https://docs.spring.io/spring-batch/reference/6.0-SNAPSHOT/domain.html)
  - [5.2.7-SNAPSHOT](https://docs.spring.io/spring-batch/reference/5.2-SNAPSHOT/domain.html)
  - [5.1.4-SNAPSHOT](https://docs.spring.io/spring-batch/reference/5.1-SNAPSHOT/domain.html)

- Related Spring Documentation
  - [Spring Boot](https://docs.spring.io/spring-boot/)
  - [Spring Framework](https://docs.spring.io/spring-framework/reference/)
  - Spring Cloud
    - [Spring Cloud Build](https://docs.spring.io/spring-cloud-build/reference/)
    - [Spring Cloud Bus](https://docs.spring.io/spring-cloud-bus/reference/)
    - [Spring Cloud Circuit Breaker](https://docs.spring.io/spring-cloud-circuitbreaker/reference/)
    - [Spring Cloud Commons](https://docs.spring.io/spring-cloud-commons/reference/)
    - [Spring Cloud Config](https://docs.spring.io/spring-cloud-config/reference/)
    - [Spring Cloud Consul](https://docs.spring.io/spring-cloud-consul/reference/)
    - [Spring Cloud Contract](https://docs.spring.io/spring-cloud-contract/reference/)
    - [Spring Cloud Function](https://docs.spring.io/spring-cloud-function/reference/)
    - [Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/reference/)
    - [Spring Cloud Kubernetes](https://docs.spring.io/spring-cloud-kubernetes/reference/)
    - [Spring Cloud Netflix](https://docs.spring.io/spring-cloud-netflix/reference/)
    - [Spring Cloud OpenFeign](https://docs.spring.io/spring-cloud-openfeign/reference/)
    - [Spring Cloud Stream](https://docs.spring.io/spring-cloud-stream/reference/)
    - [Spring Cloud Task](https://docs.spring.io/spring-cloud-task/reference/)
    - [Spring Cloud Vault](https://docs.spring.io/spring-cloud-vault/reference/)
    - [Spring Cloud Zookeeper](https://docs.spring.io/spring-cloud-zookeeper/reference/)
  - Spring Data
    - [Spring Data Cassandra](https://docs.spring.io/spring-data/cassandra/reference/)
    - [Spring Data Commons](https://docs.spring.io/spring-data/commons/reference/)
    - [Spring Data Couchbase](https://docs.spring.io/spring-data/couchbase/reference/)
    - [Spring Data Elasticsearch](https://docs.spring.io/spring-data/elasticsearch/reference/)
    - [Spring Data JPA](https://docs.spring.io/spring-data/jpa/reference/)
    - [Spring Data KeyValue](https://docs.spring.io/spring-data/keyvalue/reference/)
    - [Spring Data LDAP](https://docs.spring.io/spring-data/ldap/reference/)
    - [Spring Data MongoDB](https://docs.spring.io/spring-data/mongodb/reference/)
    - [Spring Data Neo4j](https://docs.spring.io/spring-data/neo4j/reference/)
    - [Spring Data Redis](https://docs.spring.io/spring-data/redis/reference/)
    - [Spring Data JDBC & R2DBC](https://docs.spring.io/spring-data/relational/reference/)
    - [Spring Data REST](https://docs.spring.io/spring-data/rest/reference/)
  - [Spring Integration](https://docs.spring.io/spring-integration/reference/)
  - [Spring Batch](https://docs.spring.io/spring-batch/reference/)
  - [Spring Security](https://docs.spring.io/spring-security/reference/)    - [Spring Authorization Server](https://docs.spring.io/spring-authorization-server/reference/)
    - [Spring LDAP](https://docs.spring.io/spring-ldap/reference/)
    - [Spring Security Kerberos](https://docs.spring.io/spring-security-kerberos/reference/)
    - [Spring Session](https://docs.spring.io/spring-session/reference/)
    - [Spring Vault](https://docs.spring.io/spring-vault/reference/)
  - [Spring AI](https://docs.spring.io/spring-ai/reference/)
  - [Spring AMQP](https://docs.spring.io/spring-amqp/reference/)
  - [Spring CLI](https://docs.spring.io/spring-cli/reference/)
  - [Spring GraphQL](https://docs.spring.io/spring-graphql/reference/)
  - [Spring for Apache Kafka](https://docs.spring.io/spring-kafka/reference/)
  - [Spring Modulith](https://docs.spring.io/spring-modulith/reference/)
  - [Spring for Apache Pulsar](https://docs.spring.io/spring-pulsar/reference/)
  - [Spring Shell](https://docs.spring.io/spring-shell/reference/)
[All Docs...](https://docs.spring.io/spring-batch/reference/spring-projects.html)

![Spring](https://docs.spring.io/spring-batch/reference/_/img/spring-logo.svg)

Copyright © 2005 - 2026 Broadcom. All Rights Reserved. The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.

[Terms of Use](https://www.vmware.com/help/legal.html) • [Privacy](https://www.vmware.com/help/privacy.html) • [Trademark Guidelines](https://spring.io/trademarks)• [Thank you](https://spring.io/thank-you) • [Your California Privacy Rights](https://www.vmware.com/help/privacy/california-privacy-rights.html) • Cookie Settings

Apache®, Apache Tomcat®, Apache Kafka®, Apache Cassandra™, and Apache Geode™ are trademarks or registered trademarks of the Apache Software Foundation in the United States and/or other countries. Java™, Java™ SE, Java™ EE, and OpenJDK™ are trademarks of Oracle and/or its affiliates. Kubernetes® is a registered trademark of the Linux Foundation in the United States and other countries. Linux® is the registered trademark of Linus Torvalds in the United States and other countries. Windows® and Microsoft® Azure are registered trademarks of Microsoft Corporation. “AWS” and “Amazon Web Services” are trademarks or registered trademarks of Amazon.com Inc. or its affiliates. All other trademarks and copyrights are property of their respective owners and are only mentioned for informative purposes. Other names may be trademarks of their respective owners.

[Youtube](https://www.youtube.com/user/SpringSourceDev "Youtube")[GitHub](https://github.com/spring-projects "GitHub")[Twitter](https://twitter.com/springcentral "Twitter")

[Search in all Spring Docs](https://docs.spring.io/spring-batch/reference/search.html)

[![](https://docs.spring.io/spring-batch/reference/_/img/algolia-light.svg)![](https://docs.spring.io/spring-batch/reference/_/img/algolia-dark.svg)](https://www.algolia.com/)