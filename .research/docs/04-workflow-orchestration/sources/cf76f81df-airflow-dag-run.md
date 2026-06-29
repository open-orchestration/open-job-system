[Community](https://airflow.apache.org/community/) [Meetups](https://airflow.apache.org/meetups/) [Documentation](https://airflow.apache.org/docs/) [Registry](https://airflow.apache.org/registry/) [Use Cases](https://airflow.apache.org/use-cases/) [Announcements](https://airflow.apache.org/announcements/) [Blog](https://airflow.apache.org/blog/) [Ecosystem](https://airflow.apache.org/ecosystem/)

[Community](https://airflow.apache.org/community/) [Meetups](https://airflow.apache.org/meetups/) [Documentation](https://airflow.apache.org/docs/) [Registry](https://airflow.apache.org/registry/) [Use Cases](https://airflow.apache.org/use-cases/) [Announcements](https://airflow.apache.org/announcements/) [Blog](https://airflow.apache.org/blog/) [Ecosystem](https://airflow.apache.org/ecosystem/)

Content

[Version: 3.2.2](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#)

[Stable (3.2.2)](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html) [3.2.2](https://airflow.apache.org/docs/apache-airflow/3.2.2/core-concepts/dag-run.html) [3.1.8](https://airflow.apache.org/docs/apache-airflow/3.1.8/core-concepts/dag-run.html) [3.0.6](https://airflow.apache.org/docs/apache-airflow/3.0.6/core-concepts/dag-run.html) [2.11.2](https://airflow.apache.org/docs/apache-airflow/2.11.2/core-concepts/dag-run.html) [2.10.5](https://airflow.apache.org/docs/apache-airflow/2.10.5/core-concepts/dag-run.html) [2.9.3](https://airflow.apache.org/docs/apache-airflow/2.9.3/core-concepts/dag-run.html) [2.8.4](https://airflow.apache.org/docs/apache-airflow/2.8.4/core-concepts/dag-run.html) [2.7.3](https://airflow.apache.org/docs/apache-airflow/2.7.3/core-concepts/dag-run.html) [2.6.3](https://airflow.apache.org/docs/apache-airflow/2.6.3/core-concepts/dag-run.html) [2.5.3](https://airflow.apache.org/docs/apache-airflow/2.5.3/core-concepts/dag-run.html) [2.4.3](https://airflow.apache.org/docs/apache-airflow/2.4.3/core-concepts/dag-run.html) [2.3.4](https://airflow.apache.org/docs/apache-airflow/2.3.4/core-concepts/dag-run.html) [2.2.5](https://airflow.apache.org/docs/apache-airflow/2.2.5/core-concepts/dag-run.html) [2.1.4](https://airflow.apache.org/docs/apache-airflow/2.1.4/core-concepts/dag-run.html) [2.0.3](https://airflow.apache.org/docs/apache-airflow/2.0.3/core-concepts/dag-run.html) [1.10.15](https://airflow.apache.org/docs/apache-airflow/1.10.15/core-concepts/dag-run.html)

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
  - [Dag Runs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#)
    - [Dag Run Status](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#dag-run-status)
      - [Data Interval](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#data-interval)
    - [Re-run Dag](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#re-run-dag)
      - [Catchup](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#catchup)
      - [Backfill](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#backfill)
    - [UI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#ui)
    - [CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#cli)
      - [Re-run Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#re-run-tasks)
      - [Task Instance History](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#task-instance-history)
    - [External Triggers](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#external-triggers)
      - [Passing Parameters when triggering Dags](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#passing-parameters-when-triggering-dags)
      - [Wait for a Dag Run](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#wait-for-a-dag-run)
        - [Using CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#using-cli)
    - [To Keep in Mind](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#to-keep-in-mind)
  - [Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/tasks.html)
  - [Operators](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/operators.html)
  - [Sensors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/sensors.html)
  - [TaskFlow](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/taskflow.html)
  - [Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html)
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

[Version: 3.2.2](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#)

[Stable (3.2.2)](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html) [3.2.2](https://airflow.apache.org/docs/apache-airflow/3.2.2/core-concepts/dag-run.html) [3.1.8](https://airflow.apache.org/docs/apache-airflow/3.1.8/core-concepts/dag-run.html) [3.0.6](https://airflow.apache.org/docs/apache-airflow/3.0.6/core-concepts/dag-run.html) [2.11.2](https://airflow.apache.org/docs/apache-airflow/2.11.2/core-concepts/dag-run.html) [2.10.5](https://airflow.apache.org/docs/apache-airflow/2.10.5/core-concepts/dag-run.html) [2.9.3](https://airflow.apache.org/docs/apache-airflow/2.9.3/core-concepts/dag-run.html) [2.8.4](https://airflow.apache.org/docs/apache-airflow/2.8.4/core-concepts/dag-run.html) [2.7.3](https://airflow.apache.org/docs/apache-airflow/2.7.3/core-concepts/dag-run.html) [2.6.3](https://airflow.apache.org/docs/apache-airflow/2.6.3/core-concepts/dag-run.html) [2.5.3](https://airflow.apache.org/docs/apache-airflow/2.5.3/core-concepts/dag-run.html) [2.4.3](https://airflow.apache.org/docs/apache-airflow/2.4.3/core-concepts/dag-run.html) [2.3.4](https://airflow.apache.org/docs/apache-airflow/2.3.4/core-concepts/dag-run.html) [2.2.5](https://airflow.apache.org/docs/apache-airflow/2.2.5/core-concepts/dag-run.html) [2.1.4](https://airflow.apache.org/docs/apache-airflow/2.1.4/core-concepts/dag-run.html) [2.0.3](https://airflow.apache.org/docs/apache-airflow/2.0.3/core-concepts/dag-run.html) [1.10.15](https://airflow.apache.org/docs/apache-airflow/1.10.15/core-concepts/dag-run.html)

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
  - [Dag Runs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#)
    - [Dag Run Status](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#dag-run-status)
      - [Data Interval](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#data-interval)
    - [Re-run Dag](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#re-run-dag)
      - [Catchup](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#catchup)
      - [Backfill](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#backfill)
    - [UI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#ui)
    - [CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#cli)
      - [Re-run Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#re-run-tasks)
      - [Task Instance History](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#task-instance-history)
    - [External Triggers](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#external-triggers)
      - [Passing Parameters when triggering Dags](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#passing-parameters-when-triggering-dags)
      - [Wait for a Dag Run](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#wait-for-a-dag-run)
        - [Using CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#using-cli)
    - [To Keep in Mind](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#to-keep-in-mind)
  - [Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/tasks.html)
  - [Operators](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/operators.html)
  - [Sensors](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/sensors.html)
  - [TaskFlow](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/taskflow.html)
  - [Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html)
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
- [Dag Runs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html)

`↑↓` Navigate`⏎` Select`Esc` Close

# Dag Runs [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#dag-runs "Link to this heading")

A Dag Run is an object representing an instantiation of the Dag in time.
Any time the Dag is executed, a Dag Run is created and all tasks inside it are executed. The status of the Dag Run depends on the tasks states.
Each Dag Run is run separately from one another, meaning that you can have many runs of a Dag at the same time.

## Dag Run Status [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#dag-run-status "Link to this heading")

A Dag Run status is determined when the execution of the Dag is finished.
The execution of the Dag depends on its containing tasks and their dependencies.
The status is assigned to the Dag Run when all of the tasks are in the one of the terminal states (i.e. if there is no possible transition to another state) like `success`, `failed` or `skipped`.
The Dag Run is having the status assigned based on the so-called “leaf nodes” or simply “leaves”. Leaf nodes are the tasks with no children.

There are two possible terminal states for the Dag Run:

- `success` if all of the leaf nodes states are either `success` or `skipped`,

- `failed` if any of the leaf nodes state is either `failed` or `upstream_failed`.


Note

Be careful if some of your tasks have defined some specific [trigger rule](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html#concepts-trigger-rules).
These can lead to some unexpected behavior, e.g. if you have a leaf task with trigger rule “all\_done”, it will be executed regardless of the states of the rest of the tasks and if it will succeed, then the whole Dag Run will also be marked as `success`, even if something failed in the middle.

_Added in Airflow 2.7_

Dags that have a currently running Dag run can be shown on the UI dashboard in the “Running” tab. Similarly, Dags whose latest Dag run is marked as failed can be found on the “Failed” tab.

### Data Interval [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#data-interval "Link to this heading")

Each Dag run in Airflow has an assigned “data interval” that represents the time
range it operates in. For a Dag scheduled with `@daily`, for example, each of
its data interval would start each day at midnight (00:00) and end at midnight
(24:00).

A Dag run is usually scheduled _after_ its associated data interval has ended,
to ensure the run is able to collect all the data within the time period. In
other words, a run covering the data period of 2020-01-01 generally does not
start to run until 2020-01-01 has ended, i.e. after 2020-01-02 00:00:00.

All dates in Airflow are tied to the data interval concept in some way. The
“logical date” (also called `execution_date` in Airflow versions prior to 2.2)
of a Dag run, for example, denotes the start of the data interval, not when the
Dag is actually executed.

Similarly, since the `start_date` argument for the Dag and its tasks points to
the same logical date, it marks the start of _the Dag’s first data interval_, not
when tasks in the Dag will start running. In other words, a Dag run will only be
scheduled one interval after `start_date`.

Tip

If a cron expression or timedelta object is not enough to express your Dag’s schedule,
logical date, or data interval, see [Timetables](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/timetable.html).
For more information on `logical date`, see [Running Dags](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html#concepts-dag-run) and
[What does execution\_date mean?](https://airflow.apache.org/docs/apache-airflow/stable/faq.html#faq-what-does-execution-date-mean)

## Re-run Dag [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#re-run-dag "Link to this heading")

There can be cases where you will want to execute your Dag again. One such case is when the scheduled
Dag run fails.

### Catchup [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#catchup "Link to this heading")

An Airflow Dag defined with a `start_date`, possibly an `end_date`, and a non-asset schedule, defines a series of intervals which the scheduler turns into individual Dag runs and executes.
By default, Dag runs that have not been run since the last data interval are not created by the scheduler upon activation of a Dag ( Airflow config `scheduler.catchup_by_default=False`). The scheduler creates a Dag run only for the latest interval.

If you set `catchup=True` in the Dag, the scheduler will kick off a Dag Run for any data interval that has not been run since the last data interval (or has been cleared). This concept is called Catchup.

If your Dag is not written to handle its catchup (i.e., not limited to the interval, but instead to `Now` for instance.),
then you will want to turn catchup off, which is the default setting or can be done explicitly by setting `catchup=False` in the Dag definition, if the default config has been changed for your Airflow environment.

```
"""
Code that goes along with the Airflow tutorial located at:
https://github.com/apache/airflow/blob/main/airflow/example_dags/tutorial.py
"""

from airflow.sdk import DAG
from airflow.providers.standard.operators.bash import BashOperator

import datetime
import pendulum

dag = DAG(
    "tutorial",
    default_args={
        "depends_on_past": True,
        "retries": 1,
        "retry_delay": datetime.timedelta(minutes=3),
    },
    start_date=pendulum.datetime(2015, 12, 1, tz="UTC"),
    description="A simple tutorial Dag",
    schedule="@daily",
)
```

Copy to clipboard

In the example above, if the Dag is picked up by the scheduler daemon on
2016-01-02 at 6 AM, (or from the command line), a single Dag Run will be created
with a data between 2016-01-01 and 2016-01-02, and the next one will be created
just after midnight on the morning of 2016-01-03 with a data interval between
2016-01-02 and 2016-01-03.

Be aware that using a `datetime.timedelta` object as schedule can lead to a different behavior.
In such a case, the single Dag Run created will cover data between 2016-01-01 06:00 and
2016-01-02 06:00 (one schedule interval ending now). For a more detailed description of the
differences between a cron and a delta based schedule, take a look at the
[timetables comparison](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/timetable.html#differences-between-the-cron-and-delta-data-interval-timetables)

If the `dag.catchup` value had been `True` instead, the scheduler would have created a Dag Run
for each completed interval between 2015-12-01 and 2016-01-02 (but not yet one for 2016-01-02,
as that interval hasn’t completed) and the scheduler will execute them sequentially.

Catchup is also triggered when you turn off a Dag for a specified period and then re-enable it.

This behavior is great for atomic assets that can easily be split into periods. Leaving catchup off is great
if your Dag performs catchup internally.

### Backfill [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#backfill "Link to this heading")

You may want to run the Dag for a specified historical period. For example,
a Dag is created with `start_date` **2024-11-21**, but another user requires
the output data from a month prior, i.e. **2024-10-21**.
This process is known as Backfill.

This can be done through either the UI or CLI.

## UI [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#ui "Link to this heading")

From the Dag Details page, click **Trigger** and select **Backfill** to open the backfill form. Set the date range, reprocess
behavior, max active runs, optional backwards ordering, and Advanced Config.

![Backfill pop-up window (Light Mode)](https://airflow.apache.org/docs/apache-airflow/stable/_images/backfill.png)

## CLI [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#cli "Link to this heading")

For CLI usage, run the command below:

```
airflow backfill create --dag-id DAG_ID \
    --start-date START_DATE \
    --end-date END_DATE \
    --reprocessing-behavior failed \
    --max-active-runs 3 \
    --run-backwards \
    --dag-run-conf '{"my": "param"}'
```

Copy to clipboard

The [backfill command](https://airflow.apache.org/docs/apache-airflow/stable/cli-and-env-variables-ref.html#backfill) will
re-run all the instances of the dag\_id for all the intervals within the start
date and end date.

### Re-run Tasks [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#re-run-tasks "Link to this heading")

Some of the tasks can fail during the scheduled run. Once you have fixed
the errors after going through the logs, you can re-run the tasks by clearing them for the
scheduled date. Clearing a task instance creates a record of the task instance.
The `try_number` of the current task instance is incremented, the `max_tries` set to `0` and the state set to `None`, which causes the task to re-run.

An experimental feature in Airflow 3.1.0 allows you to clear the task instances and re-run with the latest bundle version.

Click on the failed task in the Tree or Graph views and then click on **Clear**.
The executor will re-run it.

There are multiple options you can select to re-run -

- **Past** \- All the instances of the task in the runs before the Dag’s most recent data interval

- **Future** \- All the instances of the task in the runs after the Dag’s most recent data interval

- **Upstream** \- The upstream tasks in the current Dag

- **Downstream** \- The downstream tasks in the current Dag

- **Recursive** \- All the tasks in the child Dags and parent Dags

- **Failed** \- Only the failed tasks in the Dag’s most recent run


You can also clear the task through CLI using the command:

```
airflow tasks clear dag_id \
    --task-regex task_regex \
    --start-date START_DATE \
    --end-date END_DATE
```

Copy to clipboard

For the specified `dag_id` and time interval, the command clears all instances of the tasks matching the regex.
For more options, you can check the help of the [clear command](https://airflow.apache.org/docs/apache-airflow/stable/cli-and-env-variables-ref.html#clear) :

```
airflow tasks clear --help
```

Copy to clipboard

### Task Instance History [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#task-instance-history "Link to this heading")

When a task instance retries or is cleared, the task instance history is preserved. You can see this history by clicking on the task instance in the Grid view.

![../_images/task_instance_history.png](https://airflow.apache.org/docs/apache-airflow/stable/_images/task_instance_history.png)

Note

The try selector shown above is only available for tasks that have been retried or cleared.

The history shows the value of the task instance attributes at the end of the particular run. On the log page, you can also see the logs for each of the task instance tries.
This can be useful for debugging.

![../_images/task_instance_history_log.png](https://airflow.apache.org/docs/apache-airflow/stable/_images/task_instance_history_log.png)

Note

Related task instance objects like the XComs, rendered template fields, etc., are not preserved in the history. Only the task instance attributes, including the logs, are preserved.

## External Triggers [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#external-triggers "Link to this heading")

Note that Dag Runs can also be created manually through the CLI. Just run the command -

```
airflow dags trigger --logical-date logical_date run_id
```

Copy to clipboard

The Dag Runs created externally to the scheduler get associated with the trigger’s timestamp and are displayed
in the UI alongside scheduled Dag runs. The logical date passed inside the Dag can be specified using the `-e` argument.
The default is the current date in the UTC timezone.

In addition, you can also manually trigger a Dag Run using the web UI (tab **Dags** -\> column **Links** -\> button **Trigger Dag**)

### Passing Parameters when triggering Dags [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#passing-parameters-when-triggering-dags "Link to this heading")

When triggering a Dag from the CLI, the REST API or the UI, it is possible to pass configuration for a Dag Run as
a JSON blob.

Example of a parameterized Dag:

```
import pendulum

from airflow.sdk import DAG
from airflow.providers.standard.operators.bash import BashOperator

dag = DAG(
    "example_parameterized_dag",
    schedule=None,
    start_date=pendulum.datetime(2021, 1, 1, tz="UTC"),
    catchup=False,
)

parameterized_task = BashOperator(
    task_id="parameterized_task",
    bash_command="echo \"here is the message: '$message'\"",
    env={"message": '{{ dag_run.conf["message"] if dag_run else "" }}'},
    dag=dag,
)
```

Copy to clipboard

**Note**: The parameters from `dag_run.conf` can only be used in a template field of an operator.

### Wait for a Dag Run [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#wait-for-a-dag-run "Link to this heading")

Airflow provides an experimental API to **wait for a Dag run to complete**. This is particularly useful when integrating Airflow into external systems or automation pipelines that need to pause execution until a Dag finishes.

The endpoint blocks (by polling) until the specified Dag run reaches a terminal state: `success`, `failed`, or `canceled`.

This endpoint streams responses using the **NDJSON (Newline-Delimited JSON)** format. Each line in the response is a JSON object representing the state of the Dag run at that moment.

For example:

```
{"state": "running"}
{"state": "success", "results": {"op": 42}}
```

Copy to clipboard

This allows clients to monitor the run in real time and optionally collect XCom results from specific tasks.

Note

This feature is **experimental** and may change or be removed in future Airflow versions.

#### Using CLI [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#using-cli "Link to this heading")

```
airflow dags trigger --conf '{"conf1": "value1"}' example_parameterized_dag
```

Copy to clipboard

## To Keep in Mind [Link to this heading](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html\#to-keep-in-mind "Link to this heading")

- Marking task instances as failed can be done through the UI. This can be used to stop running task instances.

- Marking task instances as successful can be done through the UI. This is mostly to fix false negatives, or
for instance, when the fix has been applied outside of Airflow.


[Previous](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html "Dags") [Next](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/tasks.html "Tasks")

Was this entry helpful?

- [Dag Runs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#)
  - [Dag Run Status](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#dag-run-status)
    - [Data Interval](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#data-interval)
  - [Re-run Dag](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#re-run-dag)
    - [Catchup](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#catchup)
    - [Backfill](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#backfill)
  - [UI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#ui)
  - [CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#cli)
    - [Re-run Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#re-run-tasks)
    - [Task Instance History](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#task-instance-history)
  - [External Triggers](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#external-triggers)
    - [Passing Parameters when triggering Dags](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#passing-parameters-when-triggering-dags)
    - [Wait for a Dag Run](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#wait-for-a-dag-run)
      - [Using CLI](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#using-cli)
  - [To Keep in Mind](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#to-keep-in-mind)

[Suggest a change on this page](https://github.com/apache/airflow/edit/main/airflow-core/docs/core-concepts/dag-run.rst)

Want to be a part of Apache Airflow? [Join community](https://airflow.apache.org/community)

© The Apache Software Foundation 2026

[License](https://www.apache.org/licenses/) [Donate](https://www.apache.org/foundation/sponsorship.html) [Events](https://events.apache.org/) [Thanks](https://www.apache.org/foundation/thanks.html) [Security](https://www.apache.org/security/) [Privacy](https://privacy.apache.org/policies/privacy-policy-public.html) [Code of conduct](https://airflow.apache.org/code-of-conduct/)

Apache Airflow, Apache, Airflow, the Airflow logo, and the Apache logo are either registered trademarks or trademarks of The Apache Software Foundation.
All other products or name brands are trademarks of their respective holders, including The Apache Software Foundation.