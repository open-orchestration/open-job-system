[Community](https://airflow.apache.org/community/) [Meetups](https://airflow.apache.org/meetups/) [Documentation](https://airflow.apache.org/docs/) [Registry](https://airflow.apache.org/registry/) [Use Cases](https://airflow.apache.org/use-cases/) [Announcements](https://airflow.apache.org/announcements/) [Blog](https://airflow.apache.org/blog/) [Ecosystem](https://airflow.apache.org/ecosystem/)

[Community](https://airflow.apache.org/community/) [Meetups](https://airflow.apache.org/meetups/) [Documentation](https://airflow.apache.org/docs/) [Registry](https://airflow.apache.org/registry/) [Use Cases](https://airflow.apache.org/use-cases/) [Announcements](https://airflow.apache.org/announcements/) [Blog](https://airflow.apache.org/blog/) [Ecosystem](https://airflow.apache.org/ecosystem/)

Content

[Version: 3.2.2](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#)

[Stable (3.2.2)](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html) [3.2.2](https://airflow.apache.org/docs/apache-airflow/3.2.2/core-concepts/executor/index.html) [3.1.8](https://airflow.apache.org/docs/apache-airflow/3.1.8/core-concepts/executor/index.html) [3.0.6](https://airflow.apache.org/docs/apache-airflow/3.0.6/core-concepts/executor/index.html) [2.11.2](https://airflow.apache.org/docs/apache-airflow/2.11.2/core-concepts/executor/index.html) [2.10.5](https://airflow.apache.org/docs/apache-airflow/2.10.5/core-concepts/executor/index.html) [2.9.3](https://airflow.apache.org/docs/apache-airflow/2.9.3/core-concepts/executor/index.html) [2.8.4](https://airflow.apache.org/docs/apache-airflow/2.8.4/core-concepts/executor/index.html) [2.7.3](https://airflow.apache.org/docs/apache-airflow/2.7.3/core-concepts/executor/index.html) [2.6.3](https://airflow.apache.org/docs/apache-airflow/2.6.3/core-concepts/executor/index.html) [2.5.3](https://airflow.apache.org/docs/apache-airflow/2.5.3/core-concepts/executor/index.html) [2.4.3](https://airflow.apache.org/docs/apache-airflow/2.4.3/core-concepts/executor/index.html) [2.3.4](https://airflow.apache.org/docs/apache-airflow/2.3.4/core-concepts/executor/index.html) [2.2.5](https://airflow.apache.org/docs/apache-airflow/2.2.5/core-concepts/executor/index.html) [2.1.4](https://airflow.apache.org/docs/apache-airflow/2.1.4/core-concepts/executor/index.html) [2.0.3](https://airflow.apache.org/docs/apache-airflow/2.0.3/core-concepts/executor/index.html) [1.10.15](https://airflow.apache.org/docs/apache-airflow/1.10.15/core-concepts/executor/index.html)

Search docs `
            ⌘
            K
        `

Content

- [Overview](https://airflow.apache.org/docs/apache-airflow/stable/index.html)
- [Quick Start](https://airflow.apache.org/docs/apache-airflow/stable/start.html)
- [Installation of Airflow®](https://airflow.apache.org/docs/apache-airflow/stable/installation/index.html)
- [Security](https://airflow.apache.org/docs/apache-airflow/stable/security/index.html)
- [Tutorials](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/index.html)
- [How-to Guides](https://airflow.apache.org/docs/apache-airflow/stable/howto/index.html)
- [UI Overview](https://airflow.apache.org/docs/apache-airflow/stable/ui.html)
- [Core Concepts](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/index.html)
  - [Architecture Overview](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/overview.html)
  - [Dags](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html)
  - [Dag Runs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html)
  - [Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/tasks.html)
  - [Operators](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/operators.html)
  - [Sensors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/sensors.html)
  - [TaskFlow](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/taskflow.html)
  - [Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#)
    - [Executor Types](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#executor-types)
      - [Local Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#local-executors)
        - [Local Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/local.html)
      - [Remote Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#remote-executors)
    - [Using Multiple Executors Concurrently](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#using-multiple-executors-concurrently)
      - [Configuration](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#configuration)
        - [Aliases](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#aliases)
      - [Writing Dags and Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#writing-dags-and-tasks)
      - [Monitoring](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#monitoring)
      - [Statically-coded Hybrid Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#statically-coded-hybrid-executors)
    - [Writing Your Own Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#writing-your-own-executor)
      - [Workloads](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#workloads)
      - [Important BaseExecutor Methods](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#important-baseexecutor-methods)
      - [Mandatory Methods to Implement](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#mandatory-methods-to-implement)
      - [Optional Interface Methods to Implement](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#optional-interface-methods-to-implement)
      - [Compatibility Attributes](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#compatibility-attributes)
      - [CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#cli)
      - [Logging](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#logging)
      - [Next Steps](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#next-steps)
  - [Auth manager](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/auth-manager/index.html)
  - [Multi-Team](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/multi-team.html)
  - [Object Storage](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/objectstorage.html)
  - [Backfill](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/backfill.html)
  - [Message Queues](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/message-queues.html)
  - [XComs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/xcoms.html)
  - [Variables](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/variables.html)
  - [Params](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/params.html)
  - [Debugging Airflow Dags](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/debug.html)
  - [Debugging Airflow Dags on the command line](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/debug.html#debugging-airflow-dags-on-the-command-line)
- [Authoring and Scheduling](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/index.html)
- [Administration and Deployment](https://airflow.apache.org/docs/apache-airflow/stable/administration-and-deployment/index.html)
- [Integration](https://airflow.apache.org/docs/apache-airflow/stable/integration.html)
- [Public Interface for Airflow 3.0+](https://airflow.apache.org/docs/apache-airflow/stable/public-airflow-interface.html)
- [Best Practices](https://airflow.apache.org/docs/apache-airflow/stable/best-practices.html)
- [FAQ](https://airflow.apache.org/docs/apache-airflow/stable/faq.html)
- [Troubleshooting](https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html)
- [Release Policies](https://airflow.apache.org/docs/apache-airflow/stable/release-process.html)
- [Release Notes](https://airflow.apache.org/docs/apache-airflow/stable/release_notes.html)
- [Privacy Notice](https://airflow.apache.org/docs/apache-airflow/stable/privacy_notice.html)
- [Project](https://airflow.apache.org/docs/apache-airflow/stable/project.html)
- [License](https://airflow.apache.org/docs/apache-airflow/stable/license.html)

References

- [Operators and hooks](https://airflow.apache.org/docs/apache-airflow/stable/operators-and-hooks-ref.html)
- [CLI](https://airflow.apache.org/docs/apache-airflow/stable/cli-and-env-variables-ref.html)
- [Templates](https://airflow.apache.org/docs/apache-airflow/stable/templates-ref.html)
- [Airflow public API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html)
- [Configurations](https://airflow.apache.org/docs/apache-airflow/stable/configurations-ref.html)
- [Extra packages](https://airflow.apache.org/docs/apache-airflow/stable/extra-packages-ref.html)

Internal DB details

- [Database Migrations](https://airflow.apache.org/docs/apache-airflow/stable/migrations-ref.html)
- [Database ERD Schema](https://airflow.apache.org/docs/apache-airflow/stable/database-erd-ref.html)

[Version: 3.2.2](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#)

[Stable (3.2.2)](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html) [3.2.2](https://airflow.apache.org/docs/apache-airflow/3.2.2/core-concepts/executor/index.html) [3.1.8](https://airflow.apache.org/docs/apache-airflow/3.1.8/core-concepts/executor/index.html) [3.0.6](https://airflow.apache.org/docs/apache-airflow/3.0.6/core-concepts/executor/index.html) [2.11.2](https://airflow.apache.org/docs/apache-airflow/2.11.2/core-concepts/executor/index.html) [2.10.5](https://airflow.apache.org/docs/apache-airflow/2.10.5/core-concepts/executor/index.html) [2.9.3](https://airflow.apache.org/docs/apache-airflow/2.9.3/core-concepts/executor/index.html) [2.8.4](https://airflow.apache.org/docs/apache-airflow/2.8.4/core-concepts/executor/index.html) [2.7.3](https://airflow.apache.org/docs/apache-airflow/2.7.3/core-concepts/executor/index.html) [2.6.3](https://airflow.apache.org/docs/apache-airflow/2.6.3/core-concepts/executor/index.html) [2.5.3](https://airflow.apache.org/docs/apache-airflow/2.5.3/core-concepts/executor/index.html) [2.4.3](https://airflow.apache.org/docs/apache-airflow/2.4.3/core-concepts/executor/index.html) [2.3.4](https://airflow.apache.org/docs/apache-airflow/2.3.4/core-concepts/executor/index.html) [2.2.5](https://airflow.apache.org/docs/apache-airflow/2.2.5/core-concepts/executor/index.html) [2.1.4](https://airflow.apache.org/docs/apache-airflow/2.1.4/core-concepts/executor/index.html) [2.0.3](https://airflow.apache.org/docs/apache-airflow/2.0.3/core-concepts/executor/index.html) [1.10.15](https://airflow.apache.org/docs/apache-airflow/1.10.15/core-concepts/executor/index.html)

Search docs `
            ⌘
            K
        `

Content

- [Overview](https://airflow.apache.org/docs/apache-airflow/stable/index.html)
- [Quick Start](https://airflow.apache.org/docs/apache-airflow/stable/start.html)
- [Installation of Airflow®](https://airflow.apache.org/docs/apache-airflow/stable/installation/index.html)
- [Security](https://airflow.apache.org/docs/apache-airflow/stable/security/index.html)
- [Tutorials](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/index.html)
- [How-to Guides](https://airflow.apache.org/docs/apache-airflow/stable/howto/index.html)
- [UI Overview](https://airflow.apache.org/docs/apache-airflow/stable/ui.html)
- [Core Concepts](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/index.html)
  - [Architecture Overview](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/overview.html)
  - [Dags](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html)
  - [Dag Runs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html)
  - [Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/tasks.html)
  - [Operators](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/operators.html)
  - [Sensors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/sensors.html)
  - [TaskFlow](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/taskflow.html)
  - [Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#)
    - [Executor Types](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#executor-types)
      - [Local Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#local-executors)
        - [Local Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/local.html)
      - [Remote Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#remote-executors)
    - [Using Multiple Executors Concurrently](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#using-multiple-executors-concurrently)
      - [Configuration](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#configuration)
        - [Aliases](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#aliases)
      - [Writing Dags and Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#writing-dags-and-tasks)
      - [Monitoring](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#monitoring)
      - [Statically-coded Hybrid Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#statically-coded-hybrid-executors)
    - [Writing Your Own Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#writing-your-own-executor)
      - [Workloads](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#workloads)
      - [Important BaseExecutor Methods](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#important-baseexecutor-methods)
      - [Mandatory Methods to Implement](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#mandatory-methods-to-implement)
      - [Optional Interface Methods to Implement](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#optional-interface-methods-to-implement)
      - [Compatibility Attributes](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#compatibility-attributes)
      - [CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#cli)
      - [Logging](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#logging)
      - [Next Steps](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#next-steps)
  - [Auth manager](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/auth-manager/index.html)
  - [Multi-Team](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/multi-team.html)
  - [Object Storage](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/objectstorage.html)
  - [Backfill](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/backfill.html)
  - [Message Queues](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/message-queues.html)
  - [XComs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/xcoms.html)
  - [Variables](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/variables.html)
  - [Params](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/params.html)
  - [Debugging Airflow Dags](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/debug.html)
  - [Debugging Airflow Dags on the command line](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/debug.html#debugging-airflow-dags-on-the-command-line)
- [Authoring and Scheduling](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/index.html)
- [Administration and Deployment](https://airflow.apache.org/docs/apache-airflow/stable/administration-and-deployment/index.html)
- [Integration](https://airflow.apache.org/docs/apache-airflow/stable/integration.html)
- [Public Interface for Airflow 3.0+](https://airflow.apache.org/docs/apache-airflow/stable/public-airflow-interface.html)
- [Best Practices](https://airflow.apache.org/docs/apache-airflow/stable/best-practices.html)
- [FAQ](https://airflow.apache.org/docs/apache-airflow/stable/faq.html)
- [Troubleshooting](https://airflow.apache.org/docs/apache-airflow/stable/troubleshooting.html)
- [Release Policies](https://airflow.apache.org/docs/apache-airflow/stable/release-process.html)
- [Release Notes](https://airflow.apache.org/docs/apache-airflow/stable/release_notes.html)
- [Privacy Notice](https://airflow.apache.org/docs/apache-airflow/stable/privacy_notice.html)
- [Project](https://airflow.apache.org/docs/apache-airflow/stable/project.html)
- [License](https://airflow.apache.org/docs/apache-airflow/stable/license.html)

References

- [Operators and hooks](https://airflow.apache.org/docs/apache-airflow/stable/operators-and-hooks-ref.html)
- [CLI](https://airflow.apache.org/docs/apache-airflow/stable/cli-and-env-variables-ref.html)
- [Templates](https://airflow.apache.org/docs/apache-airflow/stable/templates-ref.html)
- [Airflow public API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html)
- [Configurations](https://airflow.apache.org/docs/apache-airflow/stable/configurations-ref.html)
- [Extra packages](https://airflow.apache.org/docs/apache-airflow/stable/extra-packages-ref.html)

Internal DB details

- [Database Migrations](https://airflow.apache.org/docs/apache-airflow/stable/migrations-ref.html)
- [Database ERD Schema](https://airflow.apache.org/docs/apache-airflow/stable/database-erd-ref.html)

- [Home](https://airflow.apache.org/docs/apache-airflow/stable/index.html)
- [Core Concepts](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/index.html)
- [Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html)

`↑↓` Navigate`⏎` Select`Esc` Close

# Executor [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#executor "Link to this heading")

Executors are the mechanism by which [task instances](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/tasks.html) get run. They have a common API and are “pluggable”, meaning you can swap executors based on your installation needs.

Executors are set by the `executor` option in the `[core]` section of [the configuration file](https://airflow.apache.org/docs/apache-airflow/stable/howto/set-config.html).

Built-in executors are referred to by name, for example:

```
[core]
executor = KubernetesExecutor
```

Copy to clipboard

Custom or third-party executors can be configured by providing the module path of the executor python class, for example:

```
[core]
executor = my.custom.executor.module.ExecutorClass
```

Copy to clipboard

Note

For more information on Airflow’s configuration, see [Setting Configuration Options](https://airflow.apache.org/docs/apache-airflow/stable/howto/set-config.html).

If you want to check which executor is currently set, you can use the `airflow config get-value core executor` command:

```
$ airflow config get-value core executor
LocalExecutor
```

Copy to clipboard

## Executor Types [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#executor-types "Link to this heading")

There is only one type of executor that runs tasks _locally_ (inside the `scheduler` process) in the repo tree, but custom ones
can be written to achieve similar results, and there are those that run their tasks _remotely_ (usually via a pool of _workers_). Airflow comes configured with the `LocalExecutor` by default, which is a local executor, and the simplest option for execution.
However, as the `LocalExecutor` runs processes in the scheduler process that can have an impact on the performance of the scheduler. You can use the `LocalExecutor`
for small, single-machine production installations, or one of the remote executors for a multi-machine/cloud installation.

### Local Executors [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#local-executors "Link to this heading")

Airflow tasks are run locally within the scheduler process.

**Pros**: Very easy to use, fast, very low latency, and few requirements for setup.

**Cons**: Limited in capabilities and shares resources with the Airflow scheduler.

**Examples**:

- [Local Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/local.html)

### Remote Executors [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#remote-executors "Link to this heading")

Remote executors can further be divided into two categories:

_Queued/Batch Executors_

Airflow tasks are sent to a central queue where remote workers pull tasks to execute. Often workers are persistent and run multiple tasks at once.

**Pros**: More robust since you’re decoupling workers from the scheduler process. Workers can be large hosts that can churn through many tasks (often in parallel) which is cost effective. Latency can be relatively low since workers can be provisioned to be running at all times to take tasks immediately from the queue.

**Cons**: Shared workers have the noisy neighbor problem with tasks competing for resources on the shared hosts or competing for how the environment/system is configured. They can also be expensive if your workload is not constant, you may have workers idle, overly scaled in resources, or you have to manage scaling them up and down.

**Examples**:

- [CeleryExecutor](https://airflow.apache.org/docs/apache-airflow-providers-celery/stable/celery_executor.html "(in apache-airflow-providers-celery v3.20.0)")

- [BatchExecutor](https://airflow.apache.org/docs/apache-airflow-providers-amazon/stable/executors/batch-executor.html "(in apache-airflow-providers-amazon v9.29.0)")

- [EdgeExecutor](https://airflow.apache.org/docs/apache-airflow-providers-edge3/stable/edge_executor.html "(in apache-airflow-providers-edge3 v3.7.0)")


_Containerized Executors_

Airflow tasks are executed ad hoc inside containers/pods. Each task is isolated in its own containerized environment that is deployed when the Airflow task is queued.

**Pros**: Each Airflow task is isolated to one container so no noisy neighbor problem. The execution environment can be customized for specific tasks (system libs, binaries, dependencies, amount of resources, etc). Cost effective as the workers are only alive for the duration of the task.

**Cons**: There is latency on startup since the container or pod needs to deploy before the task can begin. Can be expensive if you’re running many short/small tasks. No workers to manage however you must manage something like a Kubernetes cluster.

**Examples**:

- [KubernetesExecutor](https://airflow.apache.org/docs/apache-airflow-providers-cncf-kubernetes/stable/kubernetes_executor.html "(in apache-airflow-providers-cncf-kubernetes v10.17.1)")

- [EcsExecutor](https://airflow.apache.org/docs/apache-airflow-providers-amazon/stable/executors/ecs-executor.html "(in apache-airflow-providers-amazon v9.29.0)")


Note

New Airflow users may assume they need to run a separate executor process using one of the Local or Remote Executors. This is not correct. The executor logic runs _inside_ the scheduler process, and will run the tasks locally or not depending on the executor selected.

## Using Multiple Executors Concurrently [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#using-multiple-executors-concurrently "Link to this heading")

Starting with version 2.10.0, Airflow can now operate with a multi-executor configuration. Each executor has its own set of pros and cons, often they are trade-offs between latency, isolation and compute efficiency among other properties (see [here](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#executor-types-comparison) for comparisons of executors). Running multiple executors allows you to make better use of the strengths of all the available executors and avoid their weaknesses. In other words, you can use a specific executor for a specific set of tasks where its particular merits and benefits make the most sense for that use case.

### Configuration [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#configuration "Link to this heading")

Configuring multiple executors uses the same configuration option (as described [here](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#executor-basic-configuration)) as single executor use cases, leveraging a comma separated list notation to specify multiple executors.

Note

The first executor in the list (either on its own or along with other executors) will behave the same as it did in pre-2.10.0 releases. In other words, this will be the default executor for the environment. Any Airflow Task or Dag that does not specify a specific executor will use this environment level executor. All other executors in the list will be initialized and ready to run tasks if specified on an Airflow Task or Dag. If you do not specify an executor in this configuration list, it cannot be used to run tasks.

Some examples of valid multiple executor configuration:

```
[core]
executor = LocalExecutor
```

Copy to clipboard

```
[core]
executor = LocalExecutor,CeleryExecutor
```

Copy to clipboard

```
[core]
executor = KubernetesExecutor,my.custom.module.ExecutorClass
```

Copy to clipboard

#### Aliases [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#aliases "Link to this heading")

To make it easier to specify executors on tasks and Dags, executor configuration supports aliases. You may then use this alias to refer to the executor in your Dags (see below).

Aliases work with both custom executor module paths and built-in core executors:

```
[core]
executor = LocalExecutor,short_name:my.custom.module.ExecutorClass
```

Copy to clipboard

```
[core]
executor = my_local_exec:LocalExecutor,my_celery_exec:CeleryExecutor
```

Copy to clipboard

Aliasing core executors is particularly useful when the same executor is used at both the global and team level when
running Multi-Team Airflow, since it allows tasks to explicitly target a specific instance by alias:

```
[core]
executor = global_celery_exec:CeleryExecutor;team1=team_celery_exec:CeleryExecutor
```

Copy to clipboard

Note

Using two instances of the same Executor class is only supported in multi-team Airflow. For example: Two separate
teams can both use the CeleryExecutor but one single team cannot use two instances of the CeleryExecutor. An executor
can also be used globally and in teams at the same time. Please see the [Multi-Team Airflow documentation](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/multi-team.html) for
more details on this.

### Writing Dags and Tasks [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#writing-dags-and-tasks "Link to this heading")

Note

If a Dag specifies a task to use an executor that is not configured, the Dag will fail to parse and a warning dialog will be shown in the Airflow UI. Please ensure that all executors you wish to use are specified in Airflow configuration on _any_ host/container that is running an Airflow component (scheduler, workers, etc).

To specify an executor for a task, make use of the executor parameter on Airflow Operators:

```
BashOperator(
    task_id="hello_world",
    executor="LocalExecutor",
    bash_command="echo 'hello world!'",
)
```

Copy to clipboard

```
@task(executor="LocalExecutor")
def hello_world():
    print("hello world!")
```

Copy to clipboard

To specify an executor for an entire Dag, make use of the existing Airflow mechanism of default arguments. All tasks in the Dag will then use the specified executor (unless explicitly overridden by a specific task):

```
def hello_world():
    print("hello world!")

def hello_world_again():
    print("hello world again!")

with DAG(
    dag_id="hello_worlds",
    default_args={"executor": "LocalExecutor"},  # Applies to all tasks in the Dag
) as dag:
    # All tasks will use the executor from default args automatically
    hw = hello_world()
    hw_again = hello_world_again()
```

Copy to clipboard

Note

Tasks store the executor they were configured to run on in the Airflow database. Changes are reflected after each parsing of a Dag.

### Monitoring [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#monitoring "Link to this heading")

When using a single executor, Airflow metrics will behave as they were <2.9. But if multiple executors are configured then the executor metrics (`executor.open_slots`, `executor.queued_slots`, and `executor.running_tasks`) will be published for each executor configured, with the executor name appended to the metric name (e.g. `executor.open_slots.<executor class name>`).

Logging works the same as the single executor use case.

### Statically-coded Hybrid Executors [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#statically-coded-hybrid-executors "Link to this heading")

There were two “statically coded” executors, but they are no longer supported starting from Airflow 3.0.0.

These executors are hybrids of two different executors: the [LocalKubernetesExecutor](https://airflow.apache.org/docs/apache-airflow-providers-cncf-kubernetes/stable/local_kubernetes_executor.html "(in apache-airflow-providers-cncf-kubernetes v10.17.1)") and the [CeleryKubernetesExecutor](https://airflow.apache.org/docs/apache-airflow-providers-celery/stable/celery_kubernetes_executor.html "(in apache-airflow-providers-celery v3.20.0)"). Their implementation is not native or intrinsic to core Airflow. These hybrid executors instead make use of the `queue` field on Task Instances to indicate and persist which sub-executor to run on. This is a misuse of the `queue` field and makes it impossible to use it for its intended purpose when using these hybrid executors.

Executors such as these also require hand crafting new “concrete” classes to create each permutation of possible combinations of executors. This is untenable as more executors are created and leads to more maintenance overhead. Bespoke coding effort should not be required to use any combination of executors.

Therefore using these types of executors is no longer supported starting from Airflow 3.0.0. It’s recommended to use the [Using Multiple Executors Concurrently](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#using-multiple-executors-concurrently) feature instead.

## Writing Your Own Executor [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#writing-your-own-executor "Link to this heading")

All Airflow executors implement a common interface so that they are pluggable and any executor has access to all abilities and integrations within Airflow. Primarily, the Airflow scheduler uses this interface to interact with the executor, but other components such as logging and CLI do as well.
The public interface is the `BaseExecutor`. You can look through the code for the most detailed and up to date interface, but some important highlights are outlined below.

Note

For more information about Airflow’s public interface see [Public Interface for Airflow 3.0+](https://airflow.apache.org/docs/apache-airflow/stable/public-airflow-interface.html).

Some reasons you may want to write a custom executor include:

- An executor does not exist which fits your specific use case, such as a specific tool or service for compute.

- You’d like to use an executor that leverages a compute service from your preferred cloud provider.

- You have a private tool/service for task execution that is only available to you or your organization.


### Workloads [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#workloads "Link to this heading")

A workload in context of an Executor is the fundamental unit of execution for an executor. It represents a discrete
operation or job that the executor runs on a worker. For example, it can run user code encapsulated in an Airflow task
on a worker.

Example:

```
ExecuteTask(
    token="mock",
    ti=TaskInstance(
        id=UUID("4d828a62-a417-4936-a7a6-2b3fabacecab"),
        task_id="mock",
        dag_id="mock",
        run_id="mock",
        try_number=1,
        map_index=-1,
        pool_slots=1,
        queue="default",
        priority_weight=1,
        executor_config=None,
        parent_context_carrier=None,
        context_carrier=None,
        queued_dttm=None,
    ),
    dag_rel_path=PurePosixPath("mock.py"),
    bundle_info=BundleInfo(name="n/a", version="no matter"),
    log_path="mock.log",
    type="ExecuteTask",
)
```

Copy to clipboard

### Important BaseExecutor Methods [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#important-baseexecutor-methods "Link to this heading")

These methods don’t require overriding to implement your own executor, but are useful to be aware of:

- `heartbeat`: The Airflow scheduler Job loop will periodically call heartbeat on the executor. This is one of the main points of interaction between the Airflow scheduler and the executor. This method updates some metrics, triggers newly queued tasks to execute and updates state of running/completed tasks.

- `queue_workload`: The Airflow Executor will call this method of the BaseExecutor to provide tasks to be run by the executor. The BaseExecutor simply adds the _workloads_ (check section above to understand) to an internal list of queued workloads to run within the executor. All executors present in the repository use this method.

- `get_event_buffer`: The Airflow scheduler calls this method to retrieve the current state of the TaskInstances the executor is executing.

- `has_task`: The scheduler uses this BaseExecutor method to determine if an executor already has a specific task instance queued or running.

- `send_callback`: Sends any callbacks to the sink configured on the executor.


### Mandatory Methods to Implement [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#mandatory-methods-to-implement "Link to this heading")

The following methods must be overridden at minimum to have your executor supported by Airflow:

- `sync`: Sync will get called periodically during executor heartbeats. Implement this method to update the state of the tasks which the executor knows about. Optionally, attempting to execute queued tasks that have been received from the scheduler.

- `execute_async`: Executes a _workload_ asynchronously. This method is called (after a few layers) during executor heartbeat which is run periodically by the scheduler. In practice, this method often just enqueues tasks into an internal or external queue of tasks to be run (e.g. `KubernetesExecutor`). But can also execute the tasks directly as well (e.g. `LocalExecutor`). This will depend on the executor.

- `_process_workloads`: Processes a list of workloads that have been queued via `queue_workload`. This method is called during executor heartbeat and defines how the executor handles the execution of workloads (e.g., queuing them to workers, submitting to external systems, etc.).


### Optional Interface Methods to Implement [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#optional-interface-methods-to-implement "Link to this heading")

The following methods aren’t required to override to have a functional Airflow executor. However, some powerful capabilities and stability can come from implementing them:

- `start`: The Airflow scheduler job will call this method after it initializes the executor object. Any additional setup required by the executor can be completed here.

- `end`: The Airflow scheduler job will call this method as it is tearing down. Any synchronous cleanup required to finish running jobs should be done here.

- `terminate`: More forcefully stop the executor, even killing/stopping in-flight tasks instead of synchronously waiting for completion.

- `try_adopt_task_instances`: Tasks that have been abandoned (e.g. from a scheduler job that died) are provided to the executor to adopt or otherwise handle them via this method. Any tasks that cannot be adopted (by default the BaseExecutor assumes all cannot be adopted) should be returned.

- `get_cli_commands`: Executors may vend CLI commands to users by implementing this method, see the [CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#cli) section below for more details.

- `get_task_log`: Executors may vend log messages to Airflow task logs by implementing this method, see the [Logging](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#logging) section below for more details.


### Compatibility Attributes [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#compatibility-attributes "Link to this heading")

The `BaseExecutor` class interface contains a set of attributes that Airflow core code uses to check the features that your executor is compatible with. When writing your own Airflow executor be sure to set these correctly for your use case. Each attribute is simply a boolean to enable/disable a feature or indicate that a feature is supported/unsupported by the executor:

- `supports_pickling`: Whether or not the executor supports reading pickled Dags from the Database before execution (rather than reading the Dag definition from the file system).

- `sentry_integration`: If the executor supports [Sentry](https://sentry.io/), this should be a import path to a callable that creates the integration. For example, `CeleryExecutor` sets this to `"sentry_sdk.integrations.celery.CeleryIntegration"`.

- `is_local`: Whether or not the executor is remote or local. See the [Executor Types](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#executor-types) section above.

- `is_single_threaded`: Whether or not the executor is single threaded. This is particularly relevant to what database backends are supported. Single threaded executors can run with any backend, including SQLite.

- `is_production`: Whether or not the executor should be used for production purposes. A UI message is displayed to users when they are using a non-production ready executor.

- `serve_logs`: Whether or not the executor supports serving logs, see [Logging for Tasks](https://airflow.apache.org/docs/apache-airflow/stable/administration-and-deployment/logging-monitoring/logging-tasks.html).


### CLI [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#cli "Link to this heading")

Important

Starting in Airflow `3.2.0`, provider-level CLI commands are available to manage core extensions such as auth managers and executors. Implementing provider-level CLI commands can reduce CLI startup time by avoiding heavy imports when they are not required.
See [provider-level CLI](https://airflow.apache.org/docs/apache-airflow-providers/core-extensions/cli-commands.html "(in apache-airflow-providers vstable)") for implementation guidance.

Executors may vend CLI commands which will be included in the `airflow` command line tool by implementing the `get_cli_commands` method. Executors such as `CeleryExecutor` and `KubernetesExecutor` for example, make use of this mechanism. The commands can be used to setup required workers, initialize environment or set other configuration. Commands are only vended for the currently configured executor. A pseudo-code example of implementing CLI command vending from an executor can be seen below:

```
@staticmethod
def get_cli_commands() -> list[GroupCommand]:
    sub_commands = [\
        ActionCommand(\
            name="command_name",\
            help="Description of what this specific command does",\
            func=lazy_load_command("path.to.python.function.for.command"),\
            args=(),\
        ),\
    ]

    return [\
        GroupCommand(\
            name="my_cool_executor",\
            help="Description of what this group of commands do",\
            subcommands=sub_commands,\
        ),\
    ]
```

Copy to clipboard

Note

Currently there are no strict rules in place for the Airflow command namespace. It is up to developers to use names for their CLI commands that are sufficiently unique so as to not cause conflicts with other Airflow executors or components.

Note

When creating a new executor, or updating any existing executors, be sure to not import or execute any expensive operations/code at the module level. Executor classes are imported in several places and if they are slow to import this will negatively impact the performance of your Airflow environment, especially for CLI commands.

### Logging [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#logging "Link to this heading")

Executors may vend log messages which will be included in the Airflow task logs by implementing the `get_task_logs` method. This can be helpful if the execution environment has extra context in the case of task failures, which may be due to the execution environment itself rather than the Airflow task code. It can also be helpful to include setup/teardown logging from the execution environment.
The `KubernetesExecutor` leverages this capability to include logs from the pod which ran a specific Airflow task and display them in the logs for that Airflow task. A pseudo-code example of implementing task log vending from an executor can be seen below:

```
def get_task_log(self, ti: TaskInstance, try_number: int) -> tuple[list[str], list[str]]:
    messages = []
    log = []
    try:
        res = helper_function_to_fetch_logs_from_execution_env(ti, try_number)
        for line in res:
            log.append(remove_escape_codes(line.decode()))
        if log:
            messages.append("Found logs from execution environment!")
    except Exception as e:  # No exception should cause task logs to fail
        messages.append(f"Failed to find logs from execution environment: {e}")
    return messages, ["\n".join(log)]
```

Copy to clipboard

### Next Steps [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html\#next-steps "Link to this heading")

Once you have created a new executor class implementing the `BaseExecutor` interface, you can configure Airflow to use it by setting the `core.executor` configuration value to the module path of your executor:

```
[core]
executor = my_company.executors.MyCustomExecutor
```

Copy to clipboard

Note

For more information on Airflow’s configuration, see [Setting Configuration Options](https://airflow.apache.org/docs/apache-airflow/stable/howto/set-config.html) and for more information on managing Python modules in Airflow see [Modules Management](https://airflow.apache.org/docs/apache-airflow/stable/administration-and-deployment/modules_management.html).

[Previous](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/taskflow.html "TaskFlow") [Next](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/local.html "Local Executor")

Was this entry helpful?

- [Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#)
  - [Executor Types](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#executor-types)
    - [Local Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#local-executors)
    - [Remote Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#remote-executors)
  - [Using Multiple Executors Concurrently](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#using-multiple-executors-concurrently)
    - [Configuration](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#configuration)
      - [Aliases](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#aliases)
    - [Writing Dags and Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#writing-dags-and-tasks)
    - [Monitoring](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#monitoring)
    - [Statically-coded Hybrid Executors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#statically-coded-hybrid-executors)
  - [Writing Your Own Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#writing-your-own-executor)
    - [Workloads](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#workloads)
    - [Important BaseExecutor Methods](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#important-baseexecutor-methods)
    - [Mandatory Methods to Implement](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#mandatory-methods-to-implement)
    - [Optional Interface Methods to Implement](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#optional-interface-methods-to-implement)
    - [Compatibility Attributes](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#compatibility-attributes)
    - [CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#cli)
    - [Logging](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#logging)
    - [Next Steps](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html#next-steps)

[Suggest a change on this page](https://github.com/apache/airflow/edit/main/airflow-core/docs/core-concepts/executor/index.rst)

Want to be a part of Apache Airflow? [Join community](https://airflow.apache.org/community)

© The Apache Software Foundation 2026

[License](https://www.apache.org/licenses/) [Donate](https://www.apache.org/foundation/sponsorship.html) [Events](https://events.apache.org/) [Thanks](https://www.apache.org/foundation/thanks.html) [Security](https://www.apache.org/security/) [Privacy](https://privacy.apache.org/policies/privacy-policy-public.html) [Code of conduct](https://airflow.apache.org/code-of-conduct/)

Apache Airflow, Apache, Airflow, the Airflow logo, and the Apache logo are either registered trademarks or trademarks of The Apache Software Foundation.
All other products or name brands are trademarks of their respective holders, including The Apache Software Foundation.