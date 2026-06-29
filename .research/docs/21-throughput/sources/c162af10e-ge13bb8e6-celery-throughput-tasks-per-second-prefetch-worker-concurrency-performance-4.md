### Navigation
  * [index](https://celery-safwan.readthedocs.io/en/latest/genindex.html "General Index")
  * [modules](https://celery-safwan.readthedocs.io/en/latest/py-modindex.html "Python Module Index") |
  * [next](https://celery-safwan.readthedocs.io/en/latest/userguide/debugging.html "Debugging") |
  * [previous](https://celery-safwan.readthedocs.io/en/latest/userguide/security.html "Security") |
  * [Celery 5.0.1 documentation](https://celery-safwan.readthedocs.io/en/latest/index.html) »
  * [User Guide](https://celery-safwan.readthedocs.io/en/latest/userguide/index.html) »


This document describes the current stable version of Celery (5.0). For development docs, [go here](http://docs.celeryproject.org/en/master/userguide/optimizing.html). 
# Optimizing[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#optimizing "Permalink to this headline")
## Introduction[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#introduction "Permalink to this headline")
The default configuration makes a lot of compromises. It’s not optimal for any single case, but works well enough for most situations.
There are optimizations that can be applied based on specific use cases.
Optimizations can apply to different properties of the running environment, be it the time tasks take to execute, the amount of memory used, or responsiveness at times of high load.
## Ensuring Operations[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#ensuring-operations "Permalink to this headline")
In the book [Programming Pearls](http://www.cs.bell-labs.com/cm/cs/pearls/), Jon Bentley presents the concept of back-of-the-envelope calculations by asking the question;
> ❝ How much water flows out of the Mississippi River in a day? ❞
The point of this exercise [*](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#id4) is to show that there’s a limit to how much data a system can process in a timely manner. Back of the envelope calculations can be used as a means to plan for this ahead of time.
In Celery; If a task takes 10 minutes to complete, and there are 10 new tasks coming in every minute, the queue will never be empty. This is why it’s very important that you monitor queue lengths!
A way to do this is by [using Munin](https://celery-safwan.readthedocs.io/en/latest/userguide/monitoring.html#monitoring-munin). You should set up alerts, that’ll notify you as soon as any queue has reached an unacceptable size. This way you can take appropriate action like adding new worker nodes, or revoking unnecessary tasks.
## General Settings[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#general-settings "Permalink to this headline")
### Broker Connection Pools[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#broker-connection-pools "Permalink to this headline")
The broker connection pool is enabled by default since version 2.5.
You can tweak the [`broker_pool_limit`](https://celery-safwan.readthedocs.io/en/latest/userguide/configuration.html#std-setting-broker_pool_limit) setting to minimize contention, and the value should be based on the number of active threads/green-threads using broker connections.
### Using Transient Queues[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#using-transient-queues "Permalink to this headline")
Queues created by Celery are persistent by default. This means that the broker will write messages to disk to ensure that the tasks will be executed even if the broker is restarted.
But in some cases it’s fine that the message is lost, so not all tasks require durability. You can create a _transient_ queue for these tasks to improve performance:

```
from kombu import Exchange, Queue

task_queues = (
    Queue('celery', routing_key='celery'),
    Queue('transient', Exchange('transient', delivery_mode=1),
          routing_key='transient', durable=False),
)

```

or by using [`task_routes`](https://celery-safwan.readthedocs.io/en/latest/userguide/configuration.html#std-setting-task_routes):

```
task_routes = {
    'proj.tasks.add': {'queue': 'celery', 'delivery_mode': 'transient'}
}

```

The `delivery_mode` changes how the messages to this queue are delivered. A value of one means that the message won’t be written to disk, and a value of two (default) means that the message can be written to disk.
To direct a task to your new transient queue you can specify the queue argument (or use the [`task_routes`](https://celery-safwan.readthedocs.io/en/latest/userguide/configuration.html#std-setting-task_routes) setting):

```
task.apply_async(args, queue='transient')

```

For more information see the [routing guide](https://celery-safwan.readthedocs.io/en/latest/userguide/routing.html#guide-routing).
## Worker Settings[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#worker-settings "Permalink to this headline")
### Prefetch Limits[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#prefetch-limits "Permalink to this headline")
_Prefetch_ is a term inherited from AMQP that’s often misunderstood by users.
The prefetch limit is a **limit** for the number of tasks (messages) a worker can reserve for itself. If it is zero, the worker will keep consuming messages, not respecting that there may be other available worker nodes that may be able to process them sooner [†](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#id5), or that the messages may not even fit in memory.
The workers’ default prefetch count is the [`worker_prefetch_multiplier`](https://celery-safwan.readthedocs.io/en/latest/userguide/configuration.html#std-setting-worker_prefetch_multiplier) setting multiplied by the number of concurrency slots [‡](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#id6) (processes/threads/green-threads).
If you have many tasks with a long duration you want the multiplier value to be _one_ : meaning it’ll only reserve one task per worker process at a time.
However – If you have many short-running tasks, and throughput/round trip latency is important to you, this number should be large. The worker is able to process more tasks per second if the messages have already been prefetched, and is available in memory. You may have to experiment to find the best value that works for you. Values like 50 or 150 might make sense in these circumstances. Say 64, or 128.
If you have a combination of long- and short-running tasks, the best option is to use two worker nodes that are configured separately, and route the tasks according to the run-time (see [Routing Tasks](https://celery-safwan.readthedocs.io/en/latest/userguide/routing.html#guide-routing)).
### Reserve one task at a time[¶](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#reserve-one-task-at-a-time "Permalink to this headline")
The task message is only deleted from the queue after the task is [acknowledged](https://celery-safwan.readthedocs.io/en/latest/glossary.html#term-acknowledged), so if the worker crashes before acknowledging the task, it can be redelivered to another worker (or the same after recovery).
When using the default of early acknowledgment, having a prefetch multiplier setting of _one_ , means the worker will reserve at most one extra task for every worker process: or in other words, if the worker is started with [`-c 10`](https://celery-safwan.readthedocs.io/en/latest/reference/cli.html#cmdoption-celery-worker-c), the worker may reserve at most 20 tasks (10 acknowledged tasks executing, and 10 unacknowledged reserved tasks) at any time.
Often users ask if disabling “prefetching of tasks” is possible, but what they really mean by that, is to have a worker only reserve as many tasks as there are worker processes (10 unacknowledged tasks for [`-c 10`](https://celery-safwan.readthedocs.io/en/latest/reference/cli.html#cmdoption-celery-worker-c))
That’s possible, but not without also enabling [late acknowledgment](https://celery-safwan.readthedocs.io/en/latest/glossary.html#term-late-acknowledgment). Using this option over the default behavior means a task that’s already started executing will be retried in the event of a power failure or the worker instance being killed abruptly, so this also means the task must be [idempotent](https://celery-safwan.readthedocs.io/en/latest/glossary.html#term-idempotent)
See also
Notes at [Should I use retry or acks_late?](https://celery-safwan.readthedocs.io/en/latest/faq.html#faq-acks-late-vs-retry).
You can enable this behavior by using the following configuration options:

```
task_acks_late = True
worker_prefetch_multiplier = 1

```

Footnotes 

[*](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#id1)
    
The chapter is available to read for free here: [The back of the envelope](http://books.google.com/books?id=kse_7qbWbjsC&pg=PA67). The book is a classic text. Highly recommended. 

[†](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#id2)
    
RabbitMQ and other brokers deliver messages round-robin, so this doesn’t apply to an active system. If there’s no prefetch limit and you restart the cluster, there will be timing delays between nodes starting. If there are 3 offline nodes and one active node, all messages will be delivered to the active node. 

[‡](https://celery-safwan.readthedocs.io/en/latest/userguide/optimizing.html#id3)
    
This is the concurrency setting; [`worker_concurrency`](https://celery-safwan.readthedocs.io/en/latest/userguide/configuration.html#std-setting-worker_concurrency) or the [`celery worker -c`](https://celery-safwan.readthedocs.io/en/latest/reference/cli.html#cmdoption-celery-worker-c) option.
[ ![Logo](https://celery-safwan.readthedocs.io/en/latest/_static/celery_512.png) ](https://celery-safwan.readthedocs.io/en/latest/index.html)
**Please help support this community project with a donation:** ![](https://www.paypalobjects.com/en_US/i/scr/pixel.gif)
#### Previous topic
[Security](https://celery-safwan.readthedocs.io/en/latest/userguide/security.html "previous chapter")
#### Next topic
[Debugging](https://celery-safwan.readthedocs.io/en/latest/userguide/debugging.html "next chapter")
### This Page
  * [Show Source](https://celery-safwan.readthedocs.io/en/latest/_sources/userguide/optimizing.rst.txt)


### Quick search
### Navigation
  * [index](https://celery-safwan.readthedocs.io/en/latest/genindex.html "General Index")
  * [modules](https://celery-safwan.readthedocs.io/en/latest/py-modindex.html "Python Module Index") |
  * [next](https://celery-safwan.readthedocs.io/en/latest/userguide/debugging.html "Debugging") |
  * [previous](https://celery-safwan.readthedocs.io/en/latest/userguide/security.html "Security") |
  * [Celery 5.0.1 documentation](https://celery-safwan.readthedocs.io/en/latest/index.html) »
  * [User Guide](https://celery-safwan.readthedocs.io/en/latest/userguide/index.html) »


© [Copyright](https://celery-safwan.readthedocs.io/en/latest/copyright.html) 2009-2018, Ask Solem & contributors. 

