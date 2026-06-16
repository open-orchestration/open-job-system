### Navigation

- [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
- [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") \|
- [next](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/index.html "Backends and Brokers") \|
- [previous](https://docs.celeryq.dev/en/stable/getting-started/index.html "Getting Started") \|
- [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
- [Getting Started](https://docs.celeryq.dev/en/stable/getting-started/index.html) »
- [Introduction to Celery](https://docs.celeryq.dev/en/stable/getting-started/introduction.html)

This document describes the current stable version of Celery (5.6).
For development docs,
[go here](https://docs.celeryq.dev/en/main/getting-started/introduction.html).


# Introduction to Celery [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#introduction-to-celery "Link to this heading")

- [What’s a Task Queue?](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#what-s-a-task-queue)

- [What do I need?](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#what-do-i-need)

- [Get Started](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#get-started)

- [Celery is…](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#celery-is)

- [Features](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#features)

- [Framework Integration](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#framework-integration)

- [Quick Jump](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#quick-jump)

- [Installation](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#installation)


## [What’s a Task Queue?](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#id2) [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#what-s-a-task-queue "Link to this heading")

Task queues are used as a mechanism to distribute work across threads or
machines.

A task queue’s input is a unit of work called a task. Dedicated worker
processes constantly monitor task queues for new work to perform.

Celery communicates via messages, usually using a broker
to mediate between clients and workers. To initiate a task the client adds a
message to the queue, the broker then delivers that message to a worker.

A Celery system can consist of multiple workers and brokers, giving way
to high availability and horizontal scaling.

Celery is written in Python, but the protocol can be implemented in any
language. In addition to Python there’s [node-celery](https://github.com/mher/node-celery) for Node.js,
a [PHP client](https://github.com/gjedeer/celery-php), [gocelery](https://github.com/gocelery/gocelery), [gopher-celery](https://github.com/marselester/gopher-celery) for Go, and [rusty-celery](https://github.com/rusty-celery/rusty-celery) for Rust.

Language interoperability can also be achieved
exposing an HTTP endpoint and having a task that requests it (webhooks).

## [What do I need?](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#id3) [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#what-do-i-need "Link to this heading")

Version Requirements

Celery version 5.5.x runs on:

- Python ❨3.8, 3.9, 3.10, 3.11, 3.12, 3.13❩

- PyPy3.9+ ❨v7.3.12+❩


If you’re running an older version of Python, you need to be running
an older version of Celery:

- Python 3.7: Celery 5.2 or earlier.

- Python 3.6: Celery 5.1 or earlier.

- Python 2.7: Celery 4.x series.

- Python 2.6: Celery series 3.1 or earlier.

- Python 2.5: Celery series 3.0 or earlier.

- Python 2.4: Celery series 2.2 or earlier..


Celery is a project with minimal funding,
so we don’t support Microsoft Windows.
Please don’t open any issues related to that platform.

_Celery_ requires a message transport to send and receive messages.
The RabbitMQ and Redis broker transports are feature complete,
but there’s also support for a myriad of other experimental solutions, including
using SQLite for local development.

_Celery_ can run on a single machine, on multiple machines, or even
across data centers.

## [Get Started](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#id4) [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#get-started "Link to this heading")

If this is the first time you’re trying to use Celery, or if you haven’t
kept up with development in the 3.1 version and are coming from previous versions,
then you should read our getting started tutorials:

- [First Steps with Celery](https://docs.celeryq.dev/en/stable/getting-started/first-steps-with-celery.html#first-steps)

- [Next Steps](https://docs.celeryq.dev/en/stable/getting-started/next-steps.html#next-steps)


## [Celery is…](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#id5) [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#celery-is "Link to this heading")

- **Simple**


> Celery is easy to use and maintain, and it _doesn’t need configuration files_.
>
> It has an active, friendly community you can talk to for support,
> including a [mailing-list](https://groups.google.com/group/celery-users) and an IRC channel.
>
> Here’s one of the simplest applications you can make:
>
> ```
> from celery import Celery
>
> app = Celery('hello', broker='amqp://guest@localhost//')
>
> @app.task
> def hello():
>     return 'hello world'
> ```

- **Highly Available**


> Workers and clients will automatically retry in the event
> of connection loss or failure, and some brokers support
> HA in way of _Primary/Primary_ or _Primary/Replica_ replication.

- **Fast**


> A single Celery process can process millions of tasks a minute,
> with sub-millisecond round-trip latency (using RabbitMQ,
> librabbitmq, and optimized settings).

- **Flexible**


> Almost every part of _Celery_ can be extended or used on its own,
> Custom pool implementations, serializers, compression schemes, logging,
> schedulers, consumers, producers, broker transports, and much more.


It supports

|     |     |
| --- | --- |
| - **Brokers**<br>  <br>  <br>  > - [RabbitMQ](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/rabbitmq.html#broker-rabbitmq), [Redis](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/redis.html#broker-redis),<br>  >     <br>  >   - [Amazon SQS](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/sqs.html#broker-sqs), and more…<br>  <br>- **Concurrency**<br>  <br>  <br>  > - prefork (multiprocessing),<br>  >     <br>  >   - [Eventlet](http://eventlet.net/), [gevent](http://gevent.org/)<br>  >     <br>  >   - thread (multithreaded)<br>  >     <br>  >   - solo (single threaded) | - **Result Stores**<br>  <br>  <br>  > - AMQP, Redis<br>  >     <br>  >   - Memcached,<br>  >     <br>  >   - SQLAlchemy, Django ORM<br>  >     <br>  >   - Apache Cassandra, Elasticsearch, Riak<br>  >     <br>  >   - MongoDB, CouchDB, Couchbase, ArangoDB<br>  >     <br>  >   - Amazon DynamoDB, Amazon S3<br>  >     <br>  >   - Microsoft Azure Block Blob, Microsoft Azure Cosmos DB<br>  >     <br>  >   - Google Cloud Storage<br>  >     <br>  >   - File system<br>  <br>- **Serialization**<br>  <br>  <br>  > - _pickle_, _json_, _yaml_, _msgpack_.<br>  >     <br>  >   - _zlib_, _bzip2_ compression.<br>  >     <br>  >   - Cryptographic message signing. |

## [Features](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#id6) [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#features "Link to this heading")

|     |     |
| --- | --- |
| - **Monitoring**<br>  <br>  <br>  > A stream of monitoring events is emitted by workers and<br>  > is used by built-in and external tools to tell you what<br>  > your cluster is doing – in real-time.<br>  > <br>  > [Read more…](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#guide-monitoring).<br>  <br>- **Work-flows**<br>  <br>  <br>  > Simple and complex work-flows can be composed using<br>  > a set of powerful primitives we call the “canvas”,<br>  > including grouping, chaining, chunking, and more.<br>  > <br>  > [Read more…](https://docs.celeryq.dev/en/stable/userguide/canvas.html#guide-canvas).<br>  <br>- **Time & Rate Limits**<br>  <br>  <br>  > You can control how many tasks can be executed per second/minute/hour,<br>  > or how long a task can be allowed to run, and this can be set as<br>  > a default, for a specific worker or individually for each task type.<br>  > <br>  > [Read more…](https://docs.celeryq.dev/en/stable/userguide/workers.html#worker-time-limits). | - **Scheduling**<br>  <br>  <br>  > You can specify the time to run a task in seconds or a<br>  > [`datetime`](https://docs.python.org/dev/library/datetime.html#datetime.datetime "(in Python v3.15)"), or you can use<br>  > periodic tasks for recurring events based on a<br>  > simple interval, or Crontab expressions<br>  > supporting minute, hour, day of week, day of month, and<br>  > month of year.<br>  > <br>  > [Read more…](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#guide-beat).<br>  <br>- **Resource Leak Protection**<br>  <br>  <br>  > The [`--max-tasks-per-child`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-max-tasks-per-child)<br>  > option is used for user tasks leaking resources, like memory or<br>  > file descriptors, that are simply out of your control.<br>  > <br>  > [Read more…](https://docs.celeryq.dev/en/stable/userguide/workers.html#worker-max-tasks-per-child).<br>  <br>- **User Components**<br>  <br>  <br>  > Each worker component can be customized, and additional components<br>  > can be defined by the user. The worker is built up using “bootsteps” — a<br>  > dependency graph enabling fine grained control of the worker’s<br>  > internals. |

## [Framework Integration](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#id7) [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#framework-integration "Link to this heading")

Celery is easy to integrate with web frameworks, some of them even have
integration packages:

> |     |     |
> | --- | --- |
> | [Pyramid](http://docs.pylonsproject.org/en/latest/docs/pyramid.html) | [https://pypi.org/project/pyramid\_celery/](https://pypi.org/project/pyramid_celery/) |
> | [Pylons](http://pylonshq.com/) | [https://pypi.org/project/celery-pylons/](https://pypi.org/project/celery-pylons/) |
> | [Flask](http://flask.pocoo.org/) | not needed |
> | [web2py](http://web2py.com/) | [https://pypi.org/project/web2py-celery/](https://pypi.org/project/web2py-celery/) |
> | [Tornado](http://www.tornadoweb.org/) | [https://pypi.org/project/tornado-celery/](https://pypi.org/project/tornado-celery/) |
> | [Tryton](http://www.tryton.org/) | [https://pypi.org/project/celery\_tryton/](https://pypi.org/project/celery_tryton/) |

For [Django](https://djangoproject.com/) see [First steps with Django](https://docs.celeryq.dev/en/stable/django/first-steps-with-django.html#django-first-steps).

The integration packages aren’t strictly necessary, but they can make
development easier, and sometimes they add important hooks like closing
database connections at _fork(2)_.

## [Quick Jump](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#id8) [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#quick-jump "Link to this heading")

I want to ⟶

|     |     |
| --- | --- |
| - [get the return value of a task](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-states)<br>  <br>- [use logging from my task](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-logging)<br>  <br>- [learn about best practices](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-best-practices)<br>  <br>- [create a custom task base class](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-custom-classes)<br>  <br>- [add a callback to a group of tasks](https://docs.celeryq.dev/en/stable/userguide/canvas.html#canvas-chord)<br>  <br>- [split a task into several chunks](https://docs.celeryq.dev/en/stable/userguide/canvas.html#canvas-chunks)<br>  <br>- [optimize the worker](https://docs.celeryq.dev/en/stable/userguide/optimizing.html#guide-optimizing)<br>  <br>- [see a list of built-in task states](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-builtin-states)<br>  <br>- [create custom task states](https://docs.celeryq.dev/en/stable/userguide/tasks.html#custom-states)<br>  <br>- [set a custom task name](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-names)<br>  <br>- [track when a task starts](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-track-started)<br>  <br>- [retry a task when it fails](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-retry)<br>  <br>- [get the id of the current task](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-request-info) | - [know what queue a task was delivered to](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-request-info)<br>  <br>- [see a list of running workers](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#monitoring-control)<br>  <br>- [purge all messages](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#monitoring-control)<br>  <br>- [inspect what the workers are doing](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#monitoring-control)<br>  <br>- [see what tasks a worker has registered](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#monitoring-control)<br>  <br>- [migrate tasks to a new broker](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#monitoring-control)<br>  <br>- [see a list of event message types](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#event-reference)<br>  <br>- [contribute to Celery](https://docs.celeryq.dev/en/stable/contributing.html#contributing)<br>  <br>- [learn about available configuration settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#configuration)<br>  <br>- [get a list of people and companies using Celery](https://docs.celeryq.dev/en/stable/community.html#res-using-celery)<br>  <br>- [write my own remote control command](https://docs.celeryq.dev/en/stable/userguide/workers.html#worker-custom-control-commands)<br>  <br>- [change worker queues at runtime](https://docs.celeryq.dev/en/stable/userguide/workers.html#worker-queues) |

Jump to ⟶

|     |     |     |     |
| --- | --- | --- | --- |
| - [Brokers](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/index.html#brokers)<br>  <br>- [Applications](https://docs.celeryq.dev/en/stable/userguide/application.html#guide-app)<br>  <br>- [Tasks](https://docs.celeryq.dev/en/stable/userguide/tasks.html#guide-tasks)<br>  <br>- [Calling](https://docs.celeryq.dev/en/stable/userguide/calling.html#guide-calling) | - [Workers](https://docs.celeryq.dev/en/stable/userguide/workers.html#guide-workers)<br>  <br>- [Daemonizing](https://docs.celeryq.dev/en/stable/userguide/daemonizing.html#daemonizing)<br>  <br>- [Monitoring](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#guide-monitoring)<br>  <br>- [Optimizing](https://docs.celeryq.dev/en/stable/userguide/optimizing.html#guide-optimizing) | - [Security](https://docs.celeryq.dev/en/stable/userguide/security.html#guide-security)<br>  <br>- [Routing](https://docs.celeryq.dev/en/stable/userguide/routing.html#guide-routing)<br>  <br>- [Configuration](https://docs.celeryq.dev/en/stable/userguide/configuration.html#configuration)<br>  <br>- [Django](https://docs.celeryq.dev/en/stable/django/index.html#django) | - [Contributing](https://docs.celeryq.dev/en/stable/contributing.html#contributing)<br>  <br>- [Signals](https://docs.celeryq.dev/en/stable/userguide/signals.html#signals)<br>  <br>- [FAQ](https://docs.celeryq.dev/en/stable/faq.html#faq)<br>  <br>- [API Reference](https://docs.celeryq.dev/en/stable/reference/index.html#apiref) |

## [Installation](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#id9) [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#installation "Link to this heading")

You can install Celery either via the Python Package Index (PyPI)
or from source.

To install using **pip**:

```
$ pip install -U Celery
```

### Bundles [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#bundles "Link to this heading")

Celery also defines a group of bundles that can be used
to install Celery and the dependencies for a given feature.

You can specify these in your requirements or on the **pip**
command-line by using brackets. Multiple bundles can be specified by
separating them by commas.

```
$ pip install "celery[librabbitmq]"

$ pip install "celery[librabbitmq,redis,auth,msgpack]"
```

The following bundles are available:

#### Serializers [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#serializers "Link to this heading")

`celery[auth]`:

for using the `auth` security serializer.

`celery[msgpack]`:

for using the msgpack serializer.

`celery[yaml]`:

for using the yaml serializer.

#### Concurrency [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#concurrency "Link to this heading")

`celery[eventlet]`:

for using the [https://pypi.org/project/eventlet/](https://pypi.org/project/eventlet/) pool.

`celery[gevent]`:

for using the [https://pypi.org/project/gevent/](https://pypi.org/project/gevent/) pool.

#### Transports and Backends [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#transports-and-backends "Link to this heading")

`celery[librabbitmq]`:

for using the librabbitmq C library.

`celery[redis]`:

for using Redis as a message transport or as a result backend.

`celery[sqs]`:

for using Amazon SQS as a message transport ( _experimental_).

`celery[tblib]`:

for using the [`task_remote_tracebacks`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_remote_tracebacks) feature.

`celery[memcache]`:

for using Memcached as a result backend (using [https://pypi.org/project/pylibmc/](https://pypi.org/project/pylibmc/))

`celery[pymemcache]`:

for using Memcached as a result backend (pure-Python implementation).

`celery[cassandra]`:

for using Apache Cassandra/Astra DB as a result backend with DataStax driver.

`celery[couchbase]`:

for using Couchbase as a result backend.

`celery[arangodb]`:

for using ArangoDB as a result backend.

`celery[elasticsearch]`:

for using Elasticsearch as a result backend.

`celery[riak]`:

for using Riak as a result backend.

`celery[dynamodb]`:

for using AWS DynamoDB as a result backend.

`celery[zookeeper]`:

for using Zookeeper as a message transport.

`celery[sqlalchemy]`:

for using SQLAlchemy as a result backend ( _supported_).

`celery[pyro]`:

for using the Pyro4 message transport ( _experimental_).

`celery[slmq]`:

for using the SoftLayer Message Queue transport ( _experimental_).

`celery[consul]`:

for using the Consul.io Key/Value store as a message transport or result backend ( _experimental_).

`celery[django]`:

specifies the lowest version possible for Django support.

You should probably not use this in your requirements, it’s here
for informational purposes only.

`celery[gcs]`:

for using the Google Cloud Storage as a result backend ( _experimental_).

`celery[gcpubsub]`:

for using the Google Cloud Pub/Sub as a message transport ( _experimental_)..

### Downloading and installing from source [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#downloading-and-installing-from-source "Link to this heading")

Download the latest version of Celery from PyPI:

[https://pypi.org/project/celery/](https://pypi.org/project/celery/)

You can install it by doing the following,:

```
$ tar xvfz celery-0.0.0.tar.gz
$ cd celery-0.0.0
$ python setup.py build
# python setup.py install
```

The last command must be executed as a privileged user if
you aren’t currently using a virtualenv.

### Using the development version [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#using-the-development-version "Link to this heading")

#### With pip [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#with-pip "Link to this heading")

The Celery development version also requires the development
versions of [https://pypi.org/project/kombu/](https://pypi.org/project/kombu/), [https://pypi.org/project/amqp/](https://pypi.org/project/amqp/), [https://pypi.org/project/billiard/](https://pypi.org/project/billiard/), and [https://pypi.org/project/vine/](https://pypi.org/project/vine/).

You can install the latest snapshot of these using the following
pip commands:

```
$ pip install https://github.com/celery/celery/zipball/main#egg=celery
$ pip install https://github.com/celery/billiard/zipball/main#egg=billiard
$ pip install https://github.com/celery/py-amqp/zipball/main#egg=amqp
$ pip install https://github.com/celery/kombu/zipball/main#egg=kombu
$ pip install https://github.com/celery/vine/zipball/main#egg=vine
```

#### With git [¶](https://docs.celeryq.dev/en/stable/getting-started/introduction.html\#with-git "Link to this heading")

Please see the [Contributing](https://docs.celeryq.dev/en/stable/contributing.html#contributing) section.

[![Logo of Celery](https://docs.celeryq.dev/en/stable/_static/celery_512.png)](https://docs.celeryq.dev/en/stable/index.html)

Star celery/celery on GitHub[Star](https://github.com/celery/celery) [28,593](https://github.com/celery/celery/stargazers)

### Donations

Please help support this community project with a donation.

[![](https://opencollective.com/celery/donate/button@2x.png?color=blue)](https://opencollective.com/celery/donate)

#### Previous topic

[Getting Started](https://docs.celeryq.dev/en/stable/getting-started/index.html "previous chapter")

#### Next topic

[Backends and Brokers](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/index.html "next chapter")

### This Page

- [Show Source](https://docs.celeryq.dev/en/stable/_sources/getting-started/introduction.rst.txt)

### Quick search

### Navigation

- [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
- [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") \|
- [next](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/index.html "Backends and Brokers") \|
- [previous](https://docs.celeryq.dev/en/stable/getting-started/index.html "Getting Started") \|
- [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
- [Getting Started](https://docs.celeryq.dev/en/stable/getting-started/index.html) »
- [Introduction to Celery](https://docs.celeryq.dev/en/stable/getting-started/introduction.html)

© [Copyright](https://docs.celeryq.dev/en/stable/copyright.html) 2009-2023, Ask Solem & contributors.


![Read the Docs](<Base64-Image-Removed>)stable
Versions[latest](https://docs.celeryq.dev/en/latest/getting-started/introduction.html)**[stable](https://docs.celeryq.dev/en/stable/getting-started/introduction.html)**[v5.6.3](https://docs.celeryq.dev/en/v5.6.3/getting-started/introduction.html)[v5.6.2](https://docs.celeryq.dev/en/v5.6.2/getting-started/introduction.html)[v5.6.1](https://docs.celeryq.dev/en/v5.6.1/getting-started/introduction.html)[v5.6.0](https://docs.celeryq.dev/en/v5.6.0/getting-started/introduction.html)[v5.5.3](https://docs.celeryq.dev/en/v5.5.3/getting-started/introduction.html)[v5.5.2](https://docs.celeryq.dev/en/v5.5.2/getting-started/introduction.html)[v5.5.1](https://docs.celeryq.dev/en/v5.5.1/getting-started/introduction.html)[v5.5.0](https://docs.celeryq.dev/en/v5.5.0/getting-started/introduction.html)[v5.4.0](https://docs.celeryq.dev/en/v5.4.0/getting-started/introduction.html)[v5.3.6](https://docs.celeryq.dev/en/v5.3.6/getting-started/introduction.html)[v5.3.5](https://docs.celeryq.dev/en/v5.3.5/getting-started/introduction.html)[v5.3.4](https://docs.celeryq.dev/en/v5.3.4/getting-started/introduction.html)[v5.3.3](https://docs.celeryq.dev/en/v5.3.3/getting-started/introduction.html)[v5.3.2](https://docs.celeryq.dev/en/v5.3.2/getting-started/introduction.html)[v5.3.1](https://docs.celeryq.dev/en/v5.3.1/getting-started/introduction.html)[v5.3.0](https://docs.celeryq.dev/en/v5.3.0/getting-started/introduction.html)[v5.2.7](https://docs.celeryq.dev/en/v5.2.7/getting-started/introduction.html)[v5.2.6](https://docs.celeryq.dev/en/v5.2.6/getting-started/introduction.html)[v5.2.5](https://docs.celeryq.dev/en/v5.2.5/getting-started/introduction.html)[v5.2.4](https://docs.celeryq.dev/en/v5.2.4/getting-started/introduction.html)[v5.2.3](https://docs.celeryq.dev/en/v5.2.3/getting-started/introduction.html)[v5.2.2](https://docs.celeryq.dev/en/v5.2.2/getting-started/introduction.html)[v5.2.1](https://docs.celeryq.dev/en/v5.2.1/getting-started/introduction.html)[v5.2.0](https://docs.celeryq.dev/en/v5.2.0/getting-started/introduction.html)[v5.1.2](https://docs.celeryq.dev/en/v5.1.2/getting-started/introduction.html)[v5.1.1](https://docs.celeryq.dev/en/v5.1.1/getting-started/introduction.html)[v5.1.0](https://docs.celeryq.dev/en/v5.1.0/getting-started/introduction.html)[v5.0.5](https://docs.celeryq.dev/en/v5.0.5/getting-started/introduction.html)[v5.0.2](https://docs.celeryq.dev/en/v5.0.2/getting-started/introduction.html)[v5.0.1](https://docs.celeryq.dev/en/v5.0.1/getting-started/introduction.html)[v5.0.0](https://docs.celeryq.dev/en/v5.0.0/getting-started/introduction.html)[v4.4.7](https://docs.celeryq.dev/en/v4.4.7/getting-started/introduction.html)[v4.4.6](https://docs.celeryq.dev/en/v4.4.6/getting-started/introduction.html)[v4.4.5](https://docs.celeryq.dev/en/v4.4.5/getting-started/introduction.html)[v4.4.4](https://docs.celeryq.dev/en/v4.4.4/getting-started/introduction.html)[4.4.3](https://docs.celeryq.dev/en/4.4.3/getting-started/introduction.html)[4.4.2](https://docs.celeryq.dev/en/4.4.2/getting-started/introduction.html)[4.4.1](https://docs.celeryq.dev/en/4.4.1/getting-started/introduction.html)[4.4.0](https://docs.celeryq.dev/en/4.4.0/getting-started/introduction.html)[v4.3.0](https://docs.celeryq.dev/en/v4.3.0/getting-started/introduction.html)[v4.2.2](https://docs.celeryq.dev/en/v4.2.2/getting-started/introduction.html)[v4.2.1](https://docs.celeryq.dev/en/v4.2.1/getting-started/introduction.html)[v4.2.0](https://docs.celeryq.dev/en/v4.2.0/getting-started/introduction.html)[v4.1.0](https://docs.celeryq.dev/en/v4.1.0/getting-started/introduction.html)[v4.0.2](https://docs.celeryq.dev/en/v4.0.2/getting-started/introduction.html)[v4.0.1](https://docs.celeryq.dev/en/v4.0.1/getting-started/introduction.html)[v4.0.0](https://docs.celeryq.dev/en/v4.0.0/getting-started/introduction.html)[4.0](https://docs.celeryq.dev/en/4.0/getting-started/introduction.html)[3.1](https://docs.celeryq.dev/en/3.1/getting-started/introduction.html)[3.0](https://docs.celeryq.dev/en/3.0/getting-started/introduction.html)[main](https://docs.celeryq.dev/en/main/getting-started/introduction.html)[2.5-archived](https://docs.celeryq.dev/en/2.5-archived/getting-started/introduction.html)[2.4-archived](https://docs.celeryq.dev/en/2.4-archived/getting-started/introduction.html)[2.3-archived](https://docs.celeryq.dev/en/2.3-archived/getting-started/introduction.html)[2.2-archived](https://docs.celeryq.dev/en/2.2-archived/getting-started/introduction.html)[2.1-archived](https://docs.celeryq.dev/en/2.1-archived/getting-started/introduction.html)[2.0-archived](https://docs.celeryq.dev/en/2.0-archived/getting-started/introduction.html)[1.0-archived](https://docs.celeryq.dev/en/1.0-archived/getting-started/introduction.html)On Read the Docs[Project Home](https://app.readthedocs.org/projects/celery/?utm_source=celery&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/celery/builds/?utm_source=celery&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=celery&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=celery&utm_content=flyout)