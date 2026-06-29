[huey](https://huey.readthedocs.io/en/latest/#)

latest

stable

2.0a

1.11.0

0.4.9


- [Installing](https://huey.readthedocs.io/en/latest/installation.html)
- [Guide](https://huey.readthedocs.io/en/latest/guide.html)
- [Consuming Tasks](https://huey.readthedocs.io/en/latest/consumer.html)
- [Deploying to Production](https://huey.readthedocs.io/en/latest/deployment.html)
- [Understanding how tasks are imported](https://huey.readthedocs.io/en/latest/imports.html)
- [Managing shared resources](https://huey.readthedocs.io/en/latest/shared_resources.html)
- [Signals](https://huey.readthedocs.io/en/latest/signals.html)
- [Huey’s API](https://huey.readthedocs.io/en/latest/api.html)
- [Huey Extensions](https://huey.readthedocs.io/en/latest/contrib.html)
- [Troubleshooting and Common Pitfalls](https://huey.readthedocs.io/en/latest/troubleshooting.html)
- [Recipes](https://huey.readthedocs.io/en/latest/recipes.html)
- [Changes in 3.0](https://huey.readthedocs.io/en/latest/changes.html)
- [Changes in 2.0](https://huey.readthedocs.io/en/latest/changes.html#changes-in-2-0)

[huey](https://huey.readthedocs.io/en/latest/#)

- [Home](https://huey.readthedocs.io/en/latest/#)
- huey
- [View page source](https://huey.readthedocs.io/en/latest/_sources/index.rst.txt)

* * *

# huey [](https://huey.readthedocs.io/en/latest/\#huey "Link to this heading")

![https://media.charlesleifer.com/blog/photos/huey3-logo.png](https://media.charlesleifer.com/blog/photos/huey3-logo.png)

_a lightweight alternative_.

huey is:

- a task queue

- written in python

- clean and simple API


huey has:

- support for redis (or valkey/redict), sqlite, file-system, or in-memory storage

- zero dependencies (`redis-py` required to use redis-like brokers).

- [example code](https://github.com/coleifer/huey/tree/master/examples/).

- [django](https://huey.readthedocs.io/en/latest/django.html#django) integration (native or via django.tasks)


huey supports:

- multi-process, multi-thread or greenlet task execution models

- schedule tasks to execute at a given time, or after a given delay

- schedule recurring tasks, like a crontab

- automatically retry tasks that fail

- task prioritization

- task result storage

- task expiration

- task locking, rate-limits and timeouts

- task pipelines and chains

- groups (fan-out), chords (map / reduce)


![http://i.imgur.com/2EpRs.jpg](http://i.imgur.com/2EpRs.jpg)

## At a glance [](https://huey.readthedocs.io/en/latest/\#at-a-glance "Link to this heading")

[`task()`](https://huey.readthedocs.io/en/latest/api.html#Huey.task "Huey.task") and [`periodic_task()`](https://huey.readthedocs.io/en/latest/api.html#Huey.periodic_task "Huey.periodic_task") decorators turn
functions into tasks executed by the consumer:

```
from huey import RedisHuey, crontab

huey = RedisHuey('my-app', host='redis.myapp.com')

@huey.task()
def add_numbers(a, b):
    return a + b

@huey.task(retries=2, retry_delay=60)
def flaky_task(url):
    # This task might fail, in which case it will be retried up to 2 times
    # with a delay of 60s between retries.
    return this_might_fail(url)

@huey.periodic_task(crontab(minute='0', hour='3'))
def nightly_backup():
    sync_all_data()
```

Calling a `task`-decorated function will enqueue the function call for
execution by the consumer. A special result handle is returned immediately,
which can be used to fetch the result once the task is finished:

```
>>> from demo import add_numbers
>>> res = add_numbers(1, 2)
>>> res
<Result: task 6b6f36fc-da0d-4069-b46c-c0d4ccff1df6>

>>> res()
3
```

Tasks can be scheduled to run in the future:

```
>>> res = add_numbers.schedule((2, 3), delay=10)  # Will be run in ~10s.
>>> res(blocking=True)  # Will block until task finishes, in ~10s.
5
```

For much more, check out the [Guide](https://huey.readthedocs.io/en/latest/guide.html#guide) or take a look at the [example code](https://github.com/coleifer/huey/tree/master/examples/).

### Running the consumer [](https://huey.readthedocs.io/en/latest/\#running-the-consumer "Link to this heading")

Run the consumer with four worker processes:

```
huey_consumer my_app.huey -k process -w 4
```

To run the consumer with a single worker thread (default):

```
huey_consumer my_app.huey
```

If your work-loads are mostly IO-bound, you can run the consumer with threads
or greenlets instead. Because greenlets are so lightweight, you can run quite a
few of them efficiently:

```
huey_consumer my_app.huey -k greenlet -w 32
```

For more information, see the [Consuming Tasks](https://huey.readthedocs.io/en/latest/consumer.html#consuming-tasks) document.

## Table of contents [](https://huey.readthedocs.io/en/latest/\#table-of-contents "Link to this heading")

- [Installing](https://huey.readthedocs.io/en/latest/installation.html)
  - [Using git](https://huey.readthedocs.io/en/latest/installation.html#using-git)
- [Guide](https://huey.readthedocs.io/en/latest/guide.html)
  - [Scheduling tasks](https://huey.readthedocs.io/en/latest/guide.html#scheduling-tasks)
  - [Periodic tasks](https://huey.readthedocs.io/en/latest/guide.html#periodic-tasks)
  - [Retrying tasks that fail](https://huey.readthedocs.io/en/latest/guide.html#retrying-tasks-that-fail)
  - [Error handling](https://huey.readthedocs.io/en/latest/guide.html#error-handling)
  - [Immediate mode](https://huey.readthedocs.io/en/latest/guide.html#immediate-mode)
  - [Testing Guidelines](https://huey.readthedocs.io/en/latest/guide.html#testing-guidelines)
  - [Task priority](https://huey.readthedocs.io/en/latest/guide.html#task-priority)
  - [Canceling or pausing tasks](https://huey.readthedocs.io/en/latest/guide.html#canceling-or-pausing-tasks)
  - [Canceling or pausing periodic tasks](https://huey.readthedocs.io/en/latest/guide.html#canceling-or-pausing-periodic-tasks)
  - [Task expiration](https://huey.readthedocs.io/en/latest/guide.html#task-expiration)
  - [Task timeouts](https://huey.readthedocs.io/en/latest/guide.html#task-timeouts)
  - [Locking tasks](https://huey.readthedocs.io/en/latest/guide.html#locking-tasks)
  - [Rate-Limiting](https://huey.readthedocs.io/en/latest/guide.html#rate-limiting)
  - [Task pipelines](https://huey.readthedocs.io/en/latest/guide.html#task-pipelines)
  - [Groups and Chords](https://huey.readthedocs.io/en/latest/guide.html#groups-and-chords)
  - [Signals](https://huey.readthedocs.io/en/latest/guide.html#signals)
  - [Logging](https://huey.readthedocs.io/en/latest/guide.html#logging)
  - [Storage Options](https://huey.readthedocs.io/en/latest/guide.html#storage-options)
  - [Tips and tricks](https://huey.readthedocs.io/en/latest/guide.html#tips-and-tricks)
  - [Reading more](https://huey.readthedocs.io/en/latest/guide.html#reading-more)
- [Consuming Tasks](https://huey.readthedocs.io/en/latest/consumer.html)
  - [Options for the consumer](https://huey.readthedocs.io/en/latest/consumer.html#options-for-the-consumer)
  - [Worker types](https://huey.readthedocs.io/en/latest/consumer.html#worker-types)
  - [Consumer shutdown](https://huey.readthedocs.io/en/latest/consumer.html#consumer-shutdown)
  - [Consumer restart](https://huey.readthedocs.io/en/latest/consumer.html#consumer-restart)
  - [supervisord and systemd](https://huey.readthedocs.io/en/latest/consumer.html#supervisord-and-systemd)
  - [Multiple Consumers](https://huey.readthedocs.io/en/latest/consumer.html#multiple-consumers)
  - [Consumer Internals](https://huey.readthedocs.io/en/latest/consumer.html#consumer-internals)
  - [Signals](https://huey.readthedocs.io/en/latest/consumer.html#signals)
- [Deploying to Production](https://huey.readthedocs.io/en/latest/deployment.html)
  - [Shutdown Signals](https://huey.readthedocs.io/en/latest/deployment.html#shutdown-signals)
  - [systemd](https://huey.readthedocs.io/en/latest/deployment.html#systemd)
  - [supervisord](https://huey.readthedocs.io/en/latest/deployment.html#supervisord)
  - [Docker](https://huey.readthedocs.io/en/latest/deployment.html#docker)
  - [Docker Compose](https://huey.readthedocs.io/en/latest/deployment.html#docker-compose)
  - [Kubernetes](https://huey.readthedocs.io/en/latest/deployment.html#kubernetes)
  - [PaaS (Heroku-style)](https://huey.readthedocs.io/en/latest/deployment.html#paas-heroku-style)
  - [Logging](https://huey.readthedocs.io/en/latest/deployment.html#logging)
  - [Health checks](https://huey.readthedocs.io/en/latest/deployment.html#health-checks)
  - [Deploying new code](https://huey.readthedocs.io/en/latest/deployment.html#deploying-new-code)
  - [Production checklist](https://huey.readthedocs.io/en/latest/deployment.html#production-checklist)
- [Understanding how tasks are imported](https://huey.readthedocs.io/en/latest/imports.html)
  - [Suggested organization of code](https://huey.readthedocs.io/en/latest/imports.html#suggested-organization-of-code)
- [Managing shared resources](https://huey.readthedocs.io/en/latest/shared_resources.html)
  - [Startup hooks](https://huey.readthedocs.io/en/latest/shared_resources.html#startup-hooks)
  - [Pre and post execute hooks](https://huey.readthedocs.io/en/latest/shared_resources.html#pre-and-post-execute-hooks)
- [Signals](https://huey.readthedocs.io/en/latest/signals.html)
  - [Signal Reference](https://huey.readthedocs.io/en/latest/signals.html#signal-reference)
  - [Signal Ordering](https://huey.readthedocs.io/en/latest/signals.html#signal-ordering)
  - [Registering Signal Handlers](https://huey.readthedocs.io/en/latest/signals.html#registering-signal-handlers)
  - [Signal Handler Error Resilience](https://huey.readthedocs.io/en/latest/signals.html#signal-handler-error-resilience)
  - [Signals and Immediate Mode](https://huey.readthedocs.io/en/latest/signals.html#signals-and-immediate-mode)
  - [Performance considerations](https://huey.readthedocs.io/en/latest/signals.html#performance-considerations)
- [Huey’s API](https://huey.readthedocs.io/en/latest/api.html)
  - [Huey types](https://huey.readthedocs.io/en/latest/api.html#huey-types)
  - [Huey object](https://huey.readthedocs.io/en/latest/api.html#huey-object)
  - [Result](https://huey.readthedocs.io/en/latest/api.html#result)
  - [Serializer](https://huey.readthedocs.io/en/latest/api.html#serializer)
  - [Exceptions](https://huey.readthedocs.io/en/latest/api.html#exceptions)
  - [Storage](https://huey.readthedocs.io/en/latest/api.html#storage)
- [Huey Extensions](https://huey.readthedocs.io/en/latest/contrib.html)
  - [Mini-Huey](https://huey.readthedocs.io/en/latest/contrib.html#mini-huey)
  - [Django](https://huey.readthedocs.io/en/latest/contrib.html#django)
  - [Django task framework](https://huey.readthedocs.io/en/latest/contrib.html#django-task-framework)
  - [AsyncIO](https://huey.readthedocs.io/en/latest/contrib.html#asyncio)
- [Troubleshooting and Common Pitfalls](https://huey.readthedocs.io/en/latest/troubleshooting.html)
- [Recipes](https://huey.readthedocs.io/en/latest/recipes.html)
  - [Key/Value Data Storage](https://huey.readthedocs.io/en/latest/recipes.html#key-value-data-storage)
  - [Exponential Backoff Retries](https://huey.readthedocs.io/en/latest/recipes.html#exponential-backoff-retries)
  - [Idempotent Tasks Using Deterministic IDs](https://huey.readthedocs.io/en/latest/recipes.html#recipe-idempotent-tasks)
  - [Progress Tracking via Key/Value Storage](https://huey.readthedocs.io/en/latest/recipes.html#progress-tracking-via-key-value-storage)
  - [Custom Error Metadata](https://huey.readthedocs.io/en/latest/recipes.html#custom-error-metadata)
  - [Task Deduplication](https://huey.readthedocs.io/en/latest/recipes.html#task-deduplication)
  - [Graceful Shutdown and Re-enqueueing Interrupted Tasks](https://huey.readthedocs.io/en/latest/recipes.html#graceful-shutdown-and-re-enqueueing-interrupted-tasks)
  - [Monitoring Queue Depth](https://huey.readthedocs.io/en/latest/recipes.html#monitoring-queue-depth)
  - [Using Signals for Task Metrics](https://huey.readthedocs.io/en/latest/recipes.html#using-signals-for-task-metrics)
  - [Signed Serializer for Untrusted Environments](https://huey.readthedocs.io/en/latest/recipes.html#signed-serializer-for-untrusted-environments)
  - [Dynamic Fan-Out](https://huey.readthedocs.io/en/latest/recipes.html#dynamic-fan-out)
  - [Run Arbitrary Functions as Tasks](https://huey.readthedocs.io/en/latest/recipes.html#run-arbitrary-functions-as-tasks)
  - [Dynamic periodic tasks](https://huey.readthedocs.io/en/latest/recipes.html#dynamic-periodic-tasks)
  - [Multiple Queues](https://huey.readthedocs.io/en/latest/recipes.html#multiple-queues)
  - [High-Availability Redis: Sentinel, Valkey and Cluster](https://huey.readthedocs.io/en/latest/recipes.html#high-availability-redis-sentinel-valkey-and-cluster)
  - [Using Huey with Flask](https://huey.readthedocs.io/en/latest/recipes.html#using-huey-with-flask)
  - [Using Huey with FastAPI](https://huey.readthedocs.io/en/latest/recipes.html#using-huey-with-fastapi)
- [Changes in 3.0](https://huey.readthedocs.io/en/latest/changes.html)
- [Changes in 2.0](https://huey.readthedocs.io/en/latest/changes.html#changes-in-2-0)
  - [Summary](https://huey.readthedocs.io/en/latest/changes.html#summary)
  - [Details](https://huey.readthedocs.io/en/latest/changes.html#details)

Huey is named in honor of my cat

![http://m.charlesleifer.com/t/800x-/blog/photos/p1473037658.76.jpg?key=mD9_qMaKBAuGPi95KzXYqg](http://m.charlesleifer.com/t/800x-/blog/photos/p1473037658.76.jpg?key=mD9_qMaKBAuGPi95KzXYqg)

# Indices and tables [](https://huey.readthedocs.io/en/latest/\#indices-and-tables "Link to this heading")

- [Index](https://huey.readthedocs.io/en/latest/genindex.html)

- [Module Index](https://huey.readthedocs.io/en/latest/py-modindex.html)

- [Search Page](https://huey.readthedocs.io/en/latest/search.html)


[Next](https://huey.readthedocs.io/en/latest/installation.html "Installing")

* * *

© Copyright 2013, charles leifer.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org/).


![Read the Docs](<Base64-Image-Removed>)latest
Versions**[latest](https://huey.readthedocs.io/en/latest/)**[stable](https://huey.readthedocs.io/en/stable/)[2.0a](https://huey.readthedocs.io/en/2.0a/)[1.11.0](https://huey.readthedocs.io/en/1.11.0/)[0.4.9](https://huey.readthedocs.io/en/0.4.9/)On Read the Docs[Project Home](https://app.readthedocs.org/projects/huey/?utm_source=huey&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/huey/builds/?utm_source=huey&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=huey&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=huey&utm_content=flyout)