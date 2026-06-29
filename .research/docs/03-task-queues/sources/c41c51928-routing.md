### Navigation

- [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
- [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") \|
- [next](https://docs.celeryq.dev/en/stable/userguide/monitoring.html "Monitoring and Management Guide") \|
- [previous](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html "Periodic Tasks") \|
- [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
- [User Guide](https://docs.celeryq.dev/en/stable/userguide/index.html) »
- [Routing Tasks](https://docs.celeryq.dev/en/stable/userguide/routing.html)

This document describes the current stable version of Celery (5.6).
For development docs,
[go here](https://docs.celeryq.dev/en/main/userguide/routing.html).


# Routing Tasks [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#routing-tasks "Link to this heading")

Note

Alternate routing concepts like topic and fanout is not
available for all transports, please consult the
[transport comparison table](https://docs.celeryq.dev/projects/kombu/en/main/introduction.html#transport-comparison "(in Kombu v5.6)").

- [Basics](https://docs.celeryq.dev/en/stable/userguide/routing.html#basics)

  - [Automatic routing](https://docs.celeryq.dev/en/stable/userguide/routing.html#automatic-routing)

    - [Changing the name of the default queue](https://docs.celeryq.dev/en/stable/userguide/routing.html#changing-the-name-of-the-default-queue)

    - [How the queues are defined](https://docs.celeryq.dev/en/stable/userguide/routing.html#how-the-queues-are-defined)
  - [Manual routing](https://docs.celeryq.dev/en/stable/userguide/routing.html#manual-routing)
- [Special Routing Options](https://docs.celeryq.dev/en/stable/userguide/routing.html#special-routing-options)

  - [RabbitMQ Message Priorities](https://docs.celeryq.dev/en/stable/userguide/routing.html#rabbitmq-message-priorities)

  - [Redis Message Priorities](https://docs.celeryq.dev/en/stable/userguide/routing.html#redis-message-priorities)
- [AMQP Primer](https://docs.celeryq.dev/en/stable/userguide/routing.html#id1)

  - [Messages](https://docs.celeryq.dev/en/stable/userguide/routing.html#messages)

  - [Producers, consumers, and brokers](https://docs.celeryq.dev/en/stable/userguide/routing.html#producers-consumers-and-brokers)

  - [Exchanges, queues, and routing keys](https://docs.celeryq.dev/en/stable/userguide/routing.html#exchanges-queues-and-routing-keys)

  - [Exchange types](https://docs.celeryq.dev/en/stable/userguide/routing.html#exchange-types)

    - [Direct exchanges](https://docs.celeryq.dev/en/stable/userguide/routing.html#direct-exchanges)

    - [Topic exchanges](https://docs.celeryq.dev/en/stable/userguide/routing.html#topic-exchanges)
  - [Related API commands](https://docs.celeryq.dev/en/stable/userguide/routing.html#related-api-commands)

  - [Hands-on with the API](https://docs.celeryq.dev/en/stable/userguide/routing.html#hands-on-with-the-api)
- [Routing Tasks](https://docs.celeryq.dev/en/stable/userguide/routing.html#id2)

  - [Defining queues](https://docs.celeryq.dev/en/stable/userguide/routing.html#defining-queues)

  - [Specifying task destination](https://docs.celeryq.dev/en/stable/userguide/routing.html#specifying-task-destination)

  - [Routers](https://docs.celeryq.dev/en/stable/userguide/routing.html#routers)

  - [Broadcast](https://docs.celeryq.dev/en/stable/userguide/routing.html#broadcast)

## [Basics](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id5) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#basics "Link to this heading")

### [Automatic routing](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id6) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#automatic-routing "Link to this heading")

The simplest way to do routing is to use the
[`task_create_missing_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_create_missing_queues) setting (on by default).

With this setting on, a named queue that’s not already defined in
[`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) will be created automatically. This makes it easy to
perform simple routing tasks.

Say you have two servers, x, and y that handle regular tasks,
and one server z, that only handles feed related tasks. You can use this
configuration:

```
task_routes = {'feed.tasks.import_feed': {'queue': 'feeds'}}
```

With this route enabled import feed tasks will be routed to the
“feeds” queue, while all other tasks will be routed to the default queue
(named “celery” for historical reasons).

Alternatively, you can use glob pattern matching, or even regular expressions,
to match all tasks in the `feed.tasks` name-space:

```
app.conf.task_routes = {'feed.tasks.*': {'queue': 'feeds'}}
```

If the order of matching patterns is important you should
specify the router in _items_ format instead:

```
task_routes = ([\
    ('feed.tasks.*', {'queue': 'feeds'}),\
    ('web.tasks.*', {'queue': 'web'}),\
    (re.compile(r'(video|image)\.tasks\..*'), {'queue': 'media'}),\
],)
```

Note

The [`task_routes`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_routes) setting can either be a dictionary, or a
list of router objects, so in this case we need to specify the setting
as a tuple containing a list.

After installing the router, you can start server z to only process the feeds
queue like this:

```
user@z:/$ celery -A proj worker -Q feeds
```

You can specify as many queues as you want, so you can make this server
process the default queue as well:

```
user@z:/$ celery -A proj worker -Q feeds,celery
```

#### [Changing the name of the default queue](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id7) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#changing-the-name-of-the-default-queue "Link to this heading")

You can change the name of the default queue by using the following
configuration:

```
app.conf.task_default_queue = 'default'
```

#### [How the queues are defined](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id8) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#how-the-queues-are-defined "Link to this heading")

The point with this feature is to hide the complex AMQP protocol for users
with only basic needs. However – you may still be interested in how these queues
are declared.

A queue named “video” will be created with the following settings:

```
{'exchange': 'video',
 'exchange_type': 'direct',
 'routing_key': 'video'}
```

The non-AMQP backends like Redis or SQS don’t support exchanges,
so they require the exchange to have the same name as the queue. Using this
design ensures it will work for them as well.

### [Manual routing](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id9) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#manual-routing "Link to this heading")

Say you have two servers, x, and y that handle regular tasks,
and one server z, that only handles feed related tasks, you can use this
configuration:

```
from kombu import Queue

app.conf.task_default_queue = 'default'
app.conf.task_queues = (
    Queue('default',    routing_key='task.#'),
    Queue('feed_tasks', routing_key='feed.#'),
)
app.conf.task_default_exchange = 'tasks'
app.conf.task_default_exchange_type = 'topic'
app.conf.task_default_routing_key = 'task.default'
```

[`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) is a list of [`Queue`](https://docs.celeryq.dev/projects/kombu/en/main/reference/kombu.html#kombu.Queue "(in Kombu v5.6)")
instances.
If you don’t set the exchange or exchange type values for a key, these
will be taken from the [`task_default_exchange`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_default_exchange) and
[`task_default_exchange_type`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_default_exchange_type) settings.

To route a task to the feed\_tasks queue, you can add an entry in the
[`task_routes`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_routes) setting:

```
task_routes = {
        'feeds.tasks.import_feed': {
            'queue': 'feed_tasks',
            'routing_key': 'feed.import',
        },
}
```

You can also override this using the routing\_key argument to
`Task.apply_async()`, or `send_task()`:

```
>>> from feeds.tasks import import_feed
>>> import_feed.apply_async(args=['http://cnn.com/rss'],
...                         queue='feed_tasks',
...                         routing_key='feed.import')
```

To make server z consume from the feed queue exclusively you can
start it with the [`celery worker -Q`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-Q) option:

```
user@z:/$ celery -A proj worker -Q feed_tasks --hostname=z@%h
```

Servers x and y must be configured to consume from the default queue:

```
user@x:/$ celery -A proj worker -Q default --hostname=x@%h
user@y:/$ celery -A proj worker -Q default --hostname=y@%h
```

If you want, you can even have your feed processing worker handle regular
tasks as well, maybe in times when there’s a lot of work to do:

```
user@z:/$ celery -A proj worker -Q feed_tasks,default --hostname=z@%h
```

If you have another queue but on another exchange you want to add,
just specify a custom exchange and exchange type:

```
from kombu import Exchange, Queue

app.conf.task_queues = (
    Queue('feed_tasks',    routing_key='feed.#'),
    Queue('regular_tasks', routing_key='task.#'),
    Queue('image_tasks',   exchange=Exchange('mediatasks', type='direct'),
                           routing_key='image.compress'),
)
```

If you’re confused about these terms, you should read up on AMQP.

See also

In addition to the [Redis Message Priorities](https://docs.celeryq.dev/en/stable/userguide/routing.html#amqp-primer) below, there’s
[Rabbits and Warrens](http://web.archive.org/web/20160323134044/http://blogs.digitar.com/jjww/2009/01/rabbits-and-warrens/), an excellent blog post describing queues and
exchanges. There’s also The CloudAMQP tutorial,
For users of RabbitMQ the [RabbitMQ FAQ](https://www.rabbitmq.com/faq.html)
could be useful as a source of information.

## [Special Routing Options](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id10) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#special-routing-options "Link to this heading")

### [RabbitMQ Message Priorities](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id11) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#rabbitmq-message-priorities "Link to this heading")

supported transports:

RabbitMQ

Added in version 4.0.

Queues can be configured to support priorities by setting the
`x-max-priority` argument:

```
from kombu import Exchange, Queue

app.conf.task_queues = [\
    Queue('tasks', Exchange('tasks'), routing_key='tasks',\
          queue_arguments={'x-max-priority': 10}),\
]
```

A default value for all queues can be set using the
[`task_queue_max_priority`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queue_max_priority) setting:

```
app.conf.task_queue_max_priority = 10
```

A default priority for all tasks can also be specified using the
[`task_default_priority`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_default_priority) setting:

```
app.conf.task_default_priority = 5
```

### [Redis Message Priorities](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id12) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#redis-message-priorities "Link to this heading")

supported transports:

Redis

While the Celery Redis transport does honor the priority field, Redis itself has
no notion of priorities. Please read this note before attempting to implement
priorities with Redis as you may experience some unexpected behavior.

To start scheduling tasks based on priorities you need to configure queue\_order\_strategy transport option.

```
app.conf.broker_transport_options = {
    'queue_order_strategy': 'priority',
}
```

The priority support is implemented by creating n lists for each queue.
This means that even though there are 10 (0-9) priority levels, these are
consolidated into 4 levels by default to save resources. This means that a
queue named celery will really be split into 4 queues.

The highest priority queue will be named celery, and the other queues will
have a separator (by default x06x16) and their priority number appended to
the queue name.

```
['celery', 'celery\x06\x163', 'celery\x06\x166', 'celery\x06\x169']
```

If you want more priority levels or a different separator you can set the
priority\_steps and sep transport options:

```
app.conf.broker_transport_options = {
    'priority_steps': list(range(10)),
    'sep': ':',
    'queue_order_strategy': 'priority',
}
```

The config above will give you these queue names:

```
['celery', 'celery:1', 'celery:2', 'celery:3', 'celery:4', 'celery:5', 'celery:6', 'celery:7', 'celery:8', 'celery:9']
```

That said, note that this will never be as good as priorities implemented at the
broker server level, and may be approximate at best. But it may still be good
enough for your application.

## [AMQP Primer](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id13) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id1 "Link to this heading")

### [Messages](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id14) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#messages "Link to this heading")

A message consists of headers and a body. Celery uses headers to store
the content type of the message and its content encoding. The
content type is usually the serialization format used to serialize the
message. The body contains the name of the task to execute, the
task id (UUID), the arguments to apply it with and some additional
meta-data – like the number of retries or an ETA.

This is an example task message represented as a Python dictionary:

```
{'task': 'myapp.tasks.add',
 'id': '54086c5e-6193-4575-8308-dbab76798756',
 'args': [4, 4],
 'kwargs': {}}
```

### [Producers, consumers, and brokers](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id15) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#producers-consumers-and-brokers "Link to this heading")

The client sending messages is typically called a _publisher_, or
a _producer_, while the entity receiving messages is called
a _consumer_.

The _broker_ is the message server, routing messages from producers
to consumers.

You’re likely to see these terms used a lot in AMQP related material.

### [Exchanges, queues, and routing keys](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id16) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#exchanges-queues-and-routing-keys "Link to this heading")

1. Messages are sent to exchanges.

2. An exchange routes messages to one or more queues. Several exchange types
exists, providing different ways to do routing, or implementing
different messaging scenarios.

3. The message waits in the queue until someone consumes it.

4. The message is deleted from the queue when it has been acknowledged.


The steps required to send and receive messages are:

1. Create an exchange

2. Create a queue

3. Bind the queue to the exchange.


Celery automatically creates the entities necessary for the queues in
[`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) to work (except if the queue’s auto\_declare
setting is set to `False`).

Here’s an example queue configuration with three queues;
One for video, one for images, and one default queue for everything else:

```
from kombu import Exchange, Queue

app.conf.task_queues = (
    Queue('default', Exchange('default'), routing_key='default'),
    Queue('videos',  Exchange('media'),   routing_key='media.video'),
    Queue('images',  Exchange('media'),   routing_key='media.image'),
)
app.conf.task_default_queue = 'default'
app.conf.task_default_exchange_type = 'direct'
app.conf.task_default_routing_key = 'default'
```

### [Exchange types](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id17) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#exchange-types "Link to this heading")

The exchange type defines how the messages are routed through the exchange.
The exchange types defined in the standard are direct, topic,
fanout and headers. Also non-standard exchange types are available
as plug-ins to RabbitMQ, like the [last-value-cache plug-in](https://github.com/squaremo/rabbitmq-lvc-plugin) by Michael
Bridgen.

#### [Direct exchanges](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id18) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#direct-exchanges "Link to this heading")

Direct exchanges match by exact routing keys, so a queue bound by
the routing key video only receives messages with that routing key.

#### [Topic exchanges](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id19) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#topic-exchanges "Link to this heading")

Topic exchanges matches routing keys using dot-separated words, and the
wild-card characters: `*` (matches a single word), and `#` (matches
zero or more words).

With routing keys like `usa.news`, `usa.weather`, `norway.news`, and
`norway.weather`, bindings could be `*.news` (all news), `usa.#` (all
items in the USA), or `usa.weather` (all USA weather items).

### [Related API commands](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id20) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#related-api-commands "Link to this heading")

exchange.declare(exchange\_name,type,passive,durable,auto\_delete,internal)

Declares an exchange by name.

See [`amqp:Channel.exchange_declare`](https://docs.celeryq.dev/projects/amqp/en/latest/reference/amqp.channel.html#amqp.channel.Channel.exchange_declare "(in py-amqp v5.3)").

Keyword Arguments:

- **passive** – Passive means the exchange won’t be created, but you
can use this to check if the exchange already exists.

- **durable** – Durable exchanges are persistent (i.e., they survive
a broker restart).

- **auto\_delete** – This means the exchange will be deleted by the broker
when there are no more queues using it.


queue.declare( _queue\_name_, _passive_, _durable_, _exclusive_, _auto\_delete_) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html#queue.declare "Link to this definition")

Declares a queue by name.

See [`amqp:Channel.queue_declare`](https://docs.celeryq.dev/projects/amqp/en/latest/reference/amqp.channel.html#amqp.channel.Channel.queue_declare "(in py-amqp v5.3)")

Exclusive queues can only be consumed from by the current connection.
Exclusive also implies auto\_delete.

queue.bind( _queue\_name_, _exchange\_name_, _routing\_key_) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html#queue.bind "Link to this definition")

Binds a queue to an exchange with a routing key.

Unbound queues won’t receive messages, so this is necessary.

See [`amqp:Channel.queue_bind`](https://docs.celeryq.dev/projects/amqp/en/latest/reference/amqp.channel.html#amqp.channel.Channel.queue_bind "(in py-amqp v5.3)")

queue.delete( _name_, _if\_unused=False_, _if\_empty=False_) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html#queue.delete "Link to this definition")

Deletes a queue and its binding.

See [`amqp:Channel.queue_delete`](https://docs.celeryq.dev/projects/amqp/en/latest/reference/amqp.channel.html#amqp.channel.Channel.queue_delete "(in py-amqp v5.3)")

exchange.delete( _name_, _if\_unused=False_) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html#exchange.delete "Link to this definition")

Deletes an exchange.

See [`amqp:Channel.exchange_delete`](https://docs.celeryq.dev/projects/amqp/en/latest/reference/amqp.channel.html#amqp.channel.Channel.exchange_delete "(in py-amqp v5.3)")

Note

Declaring doesn’t necessarily mean “create”. When you declare you
_assert_ that the entity exists and that it’s operable. There’s no
rule as to whom should initially create the exchange/queue/binding,
whether consumer or producer. Usually the first one to need it will
be the one to create it.

### [Hands-on with the API](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id21) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#hands-on-with-the-api "Link to this heading")

Celery comes with a tool called **celery amqp**
that’s used for command line access to the AMQP API, enabling access to
administration tasks like creating/deleting queues and exchanges, purging
queues or sending messages. It can also be used for non-AMQP brokers,
but different implementation may not implement all commands.

You can write commands directly in the arguments to **celery amqp**,
or just start with no arguments to start it in shell-mode:

```
$ celery -A proj amqp
-> connecting to amqp://guest@localhost:5672/.
-> connected.
1>
```

Here `1>` is the prompt. The number 1, is the number of commands you
have executed so far. Type `help` for a list of commands available.
It also supports auto-completion, so you can start typing a command and then
hit the tab key to show a list of possible matches.

Let’s create a queue you can send messages to:

```
$ celery -A proj amqp
1> exchange.declare testexchange direct
ok.
2> queue.declare testqueue
ok. queue:testqueue messages:0 consumers:0.
3> queue.bind testqueue testexchange testkey
ok.
```

This created the direct exchange `testexchange`, and a queue
named `testqueue`. The queue is bound to the exchange using
the routing key `testkey`.

From now on all messages sent to the exchange `testexchange` with routing
key `testkey` will be moved to this queue. You can send a message by
using the `basic.publish` command:

```
4> basic.publish 'This is a message!' testexchange testkey
ok.
```

Now that the message is sent you can retrieve it again. You can use the
`basic.get` command here, that polls for new messages on the queue
in a synchronous manner
(this is OK for maintenance tasks, but for services you want to use
`basic.consume` instead)

Pop a message off the queue:

```
5> basic.get testqueue
{'body': 'This is a message!',
 'delivery_info': {'delivery_tag': 1,
                   'exchange': u'testexchange',
                   'message_count': 0,
                   'redelivered': False,
                   'routing_key': u'testkey'},
 'properties': {}}
```

AMQP uses acknowledgment to signify that a message has been received
and processed successfully. If the message hasn’t been acknowledged
and consumer channel is closed, the message will be delivered to
another consumer.

Note the delivery tag listed in the structure above; Within a connection
channel, every received message has a unique delivery tag,
This tag is used to acknowledge the message. Also note that
delivery tags aren’t unique across connections, so in another client
the delivery tag 1 might point to a different message than in this channel.

You can acknowledge the message you received using `basic.ack`:

```
6> basic.ack 1
ok.
```

To clean up after our test session you should delete the entities you created:

```
7> queue.delete testqueue
ok. 0 messages deleted.
8> exchange.delete testexchange
ok.
```

## [Routing Tasks](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id22) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id2 "Link to this heading")

### [Defining queues](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id23) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#defining-queues "Link to this heading")

In Celery available queues are defined by the [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) setting.

Here’s an example queue configuration with three queues;
One for video, one for images, and one default queue for everything else:

```
default_exchange = Exchange('default', type='direct')
media_exchange = Exchange('media', type='direct')

app.conf.task_queues = (
    Queue('default', default_exchange, routing_key='default'),
    Queue('videos', media_exchange, routing_key='media.video'),
    Queue('images', media_exchange, routing_key='media.image')
)
app.conf.task_default_queue = 'default'
app.conf.task_default_exchange = 'default'
app.conf.task_default_routing_key = 'default'
```

Here, the [`task_default_queue`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_default_queue) will be used to route tasks that
doesn’t have an explicit route.

The default exchange, exchange type, and routing key will be used as the
default routing values for tasks, and as the default values for entries
in [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues).

Multiple bindings to a single queue are also supported. Here’s an example
of two routing keys that are both bound to the same queue:

```
from kombu import Exchange, Queue, binding

media_exchange = Exchange('media', type='direct')

CELERY_QUEUES = (
    Queue('media', [\
        binding(media_exchange, routing_key='media.video'),\
        binding(media_exchange, routing_key='media.image'),\
    ]),
)
```

### [Specifying task destination](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id24) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#specifying-task-destination "Link to this heading")

The destination for a task is decided by the following (in order):

1. The routing arguments to `Task.apply_async()`.

2. Routing related attributes defined on the [`Task`](https://docs.celeryq.dev/en/stable/reference/celery.app.task.html#celery.app.task.Task "celery.app.task.Task")
itself.

3. The [Routers](https://docs.celeryq.dev/en/stable/userguide/routing.html#routers) defined in [`task_routes`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_routes).


It’s considered best practice to not hard-code these settings, but rather
leave that as configuration options by using [Routers](https://docs.celeryq.dev/en/stable/userguide/routing.html#routers);
This is the most flexible approach, but sensible defaults can still be set
as task attributes.

### [Routers](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id25) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#routers "Link to this heading")

A router is a function that decides the routing options for a task.

All you need to define a new router is to define a function with
the signature `(name, args, kwargs, options, task=None, **kw)`:

```
def route_task(name, args, kwargs, options, task=None, **kw):
        if name == 'myapp.tasks.compress_video':
            return {'exchange': 'video',
                    'exchange_type': 'topic',
                    'routing_key': 'video.compress'}
```

If you return the `queue` key, it’ll expand with the defined settings of
that queue in [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues):

```
{'queue': 'video', 'routing_key': 'video.compress'}
```

becomes –>

```
{'queue': 'video',
 'exchange': 'video',
 'exchange_type': 'topic',
 'routing_key': 'video.compress'}
```

You install router classes by adding them to the [`task_routes`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_routes)
setting:

```
task_routes = (route_task,)
```

Router functions can also be added by name:

```
task_routes = ('myapp.routers.route_task',)
```

For simple task name -> route mappings like the router example above,
you can simply drop a dict into [`task_routes`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_routes) to get the
same behavior:

```
task_routes = {
    'myapp.tasks.compress_video': {
        'queue': 'video',
        'routing_key': 'video.compress',
    },
}
```

The routers will then be traversed in order, it will stop at the first router
returning a true value, and use that as the final route for the task.

You can also have multiple routers defined in a sequence:

```
task_routes = [\
    route_task,\
    {\
        'myapp.tasks.compress_video': {\
            'queue': 'video',\
            'routing_key': 'video.compress',\
    },\
]
```

The routers will then be visited in turn, and the first to return
a value will be chosen.

If you're using Redis or RabbitMQ you can also specify the queue's default priority
in the route.

```
task_routes = {
    'myapp.tasks.compress_video': {
        'queue': 'video',
        'routing_key': 'video.compress',
        'priority': 10,
    },
}
```

Similarly, calling apply\_async on a task will override that
default priority.

```
task.apply_async(priority=0)
```

Priority Order and Cluster Responsiveness

It is important to note that, due to worker prefetching, if a bunch of tasks
submitted at the same time they may be out of priority order at first.
Disabling worker prefetching will prevent this issue, but may cause less than
ideal performance for small, fast tasks. In most cases, simply reducing
worker\_prefetch\_multiplier to 1 is an easier and cleaner way to increase the
responsiveness of your system without the costs of disabling prefetching
entirely.

Note that priorities values are sorted in reverse when
using the redis broker: 0 being highest priority.

### [Broadcast](https://docs.celeryq.dev/en/stable/userguide/routing.html\#id26) [¶](https://docs.celeryq.dev/en/stable/userguide/routing.html\#broadcast "Link to this heading")

Celery can also support broadcast routing.
Here is an example exchange `broadcast_tasks` that delivers
copies of tasks to all workers connected to it:

```
from kombu.common import Broadcast

app.conf.task_queues = (Broadcast('broadcast_tasks'),)
app.conf.task_routes = {
    'tasks.reload_cache': {
        'queue': 'broadcast_tasks',
        'exchange': 'broadcast_tasks'
    }
}
```

Now the `tasks.reload_cache` task will be sent to every
worker consuming from this queue.

Here is another example of broadcast routing, this time with
a **celery beat** schedule:

```
from kombu.common import Broadcast
from celery.schedules import crontab

app.conf.task_queues = (Broadcast('broadcast_tasks'),)

app.conf.beat_schedule = {
    'test-task': {
        'task': 'tasks.reload_cache',
        'schedule': crontab(minute=0, hour='*/3'),
        'options': {'exchange': 'broadcast_tasks'}
    },
}
```

Broadcast & Results

Note that Celery result doesn’t define what happens if two
tasks have the same task\_id. If the same task is distributed to more
than one worker, then the state history may not be preserved.

It’s a good idea to set the `task.ignore_result` attribute in
this case.

[![Logo of Celery](https://docs.celeryq.dev/en/stable/_static/celery_512.png)](https://docs.celeryq.dev/en/stable/index.html)

Star celery/celery on GitHub[Star](https://github.com/celery/celery) [28,592](https://github.com/celery/celery/stargazers)

### Donations

Please help support this community project with a donation.

[![](https://opencollective.com/celery/donate/button@2x.png?color=blue)](https://opencollective.com/celery/donate)

#### Previous topic

[Periodic Tasks](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html "previous chapter")

#### Next topic

[Monitoring and Management Guide](https://docs.celeryq.dev/en/stable/userguide/monitoring.html "next chapter")

### This Page

- [Show Source](https://docs.celeryq.dev/en/stable/_sources/userguide/routing.rst.txt)

### Quick search

### Navigation

- [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
- [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") \|
- [next](https://docs.celeryq.dev/en/stable/userguide/monitoring.html "Monitoring and Management Guide") \|
- [previous](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html "Periodic Tasks") \|
- [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
- [User Guide](https://docs.celeryq.dev/en/stable/userguide/index.html) »
- [Routing Tasks](https://docs.celeryq.dev/en/stable/userguide/routing.html)

© [Copyright](https://docs.celeryq.dev/en/stable/copyright.html) 2009-2023, Ask Solem & contributors.


![Read the Docs](<Base64-Image-Removed>)stable
Versions[latest](https://docs.celeryq.dev/en/latest/userguide/routing.html)**[stable](https://docs.celeryq.dev/en/stable/userguide/routing.html)**[v5.6.3](https://docs.celeryq.dev/en/v5.6.3/userguide/routing.html)[v5.6.2](https://docs.celeryq.dev/en/v5.6.2/userguide/routing.html)[v5.6.1](https://docs.celeryq.dev/en/v5.6.1/userguide/routing.html)[v5.6.0](https://docs.celeryq.dev/en/v5.6.0/userguide/routing.html)[v5.5.3](https://docs.celeryq.dev/en/v5.5.3/userguide/routing.html)[v5.5.2](https://docs.celeryq.dev/en/v5.5.2/userguide/routing.html)[v5.5.1](https://docs.celeryq.dev/en/v5.5.1/userguide/routing.html)[v5.5.0](https://docs.celeryq.dev/en/v5.5.0/userguide/routing.html)[v5.4.0](https://docs.celeryq.dev/en/v5.4.0/userguide/routing.html)[v5.3.6](https://docs.celeryq.dev/en/v5.3.6/userguide/routing.html)[v5.3.5](https://docs.celeryq.dev/en/v5.3.5/userguide/routing.html)[v5.3.4](https://docs.celeryq.dev/en/v5.3.4/userguide/routing.html)[v5.3.3](https://docs.celeryq.dev/en/v5.3.3/userguide/routing.html)[v5.3.2](https://docs.celeryq.dev/en/v5.3.2/userguide/routing.html)[v5.3.1](https://docs.celeryq.dev/en/v5.3.1/userguide/routing.html)[v5.3.0](https://docs.celeryq.dev/en/v5.3.0/userguide/routing.html)[v5.2.7](https://docs.celeryq.dev/en/v5.2.7/userguide/routing.html)[v5.2.6](https://docs.celeryq.dev/en/v5.2.6/userguide/routing.html)[v5.2.5](https://docs.celeryq.dev/en/v5.2.5/userguide/routing.html)[v5.2.4](https://docs.celeryq.dev/en/v5.2.4/userguide/routing.html)[v5.2.3](https://docs.celeryq.dev/en/v5.2.3/userguide/routing.html)[v5.2.2](https://docs.celeryq.dev/en/v5.2.2/userguide/routing.html)[v5.2.1](https://docs.celeryq.dev/en/v5.2.1/userguide/routing.html)[v5.2.0](https://docs.celeryq.dev/en/v5.2.0/userguide/routing.html)[v5.1.2](https://docs.celeryq.dev/en/v5.1.2/userguide/routing.html)[v5.1.1](https://docs.celeryq.dev/en/v5.1.1/userguide/routing.html)[v5.1.0](https://docs.celeryq.dev/en/v5.1.0/userguide/routing.html)[v5.0.5](https://docs.celeryq.dev/en/v5.0.5/userguide/routing.html)[v5.0.2](https://docs.celeryq.dev/en/v5.0.2/userguide/routing.html)[v5.0.1](https://docs.celeryq.dev/en/v5.0.1/userguide/routing.html)[v5.0.0](https://docs.celeryq.dev/en/v5.0.0/userguide/routing.html)[v4.4.7](https://docs.celeryq.dev/en/v4.4.7/userguide/routing.html)[v4.4.6](https://docs.celeryq.dev/en/v4.4.6/userguide/routing.html)[v4.4.5](https://docs.celeryq.dev/en/v4.4.5/userguide/routing.html)[v4.4.4](https://docs.celeryq.dev/en/v4.4.4/userguide/routing.html)[4.4.3](https://docs.celeryq.dev/en/4.4.3/userguide/routing.html)[4.4.2](https://docs.celeryq.dev/en/4.4.2/userguide/routing.html)[4.4.1](https://docs.celeryq.dev/en/4.4.1/userguide/routing.html)[4.4.0](https://docs.celeryq.dev/en/4.4.0/userguide/routing.html)[v4.3.0](https://docs.celeryq.dev/en/v4.3.0/userguide/routing.html)[v4.2.2](https://docs.celeryq.dev/en/v4.2.2/userguide/routing.html)[v4.2.1](https://docs.celeryq.dev/en/v4.2.1/userguide/routing.html)[v4.2.0](https://docs.celeryq.dev/en/v4.2.0/userguide/routing.html)[v4.1.0](https://docs.celeryq.dev/en/v4.1.0/userguide/routing.html)[v4.0.2](https://docs.celeryq.dev/en/v4.0.2/userguide/routing.html)[v4.0.1](https://docs.celeryq.dev/en/v4.0.1/userguide/routing.html)[v4.0.0](https://docs.celeryq.dev/en/v4.0.0/userguide/routing.html)[4.0](https://docs.celeryq.dev/en/4.0/userguide/routing.html)[3.1](https://docs.celeryq.dev/en/3.1/userguide/routing.html)[3.0](https://docs.celeryq.dev/en/3.0/userguide/routing.html)[main](https://docs.celeryq.dev/en/main/userguide/routing.html)[2.5-archived](https://docs.celeryq.dev/en/2.5-archived/userguide/routing.html)[2.4-archived](https://docs.celeryq.dev/en/2.4-archived/userguide/routing.html)[2.3-archived](https://docs.celeryq.dev/en/2.3-archived/userguide/routing.html)[2.2-archived](https://docs.celeryq.dev/en/2.2-archived/userguide/routing.html)[2.1-archived](https://docs.celeryq.dev/en/2.1-archived/userguide/routing.html)[2.0-archived](https://docs.celeryq.dev/en/2.0-archived/userguide/routing.html)[1.0-archived](https://docs.celeryq.dev/en/1.0-archived/userguide/routing.html)On Read the Docs[Project Home](https://app.readthedocs.org/projects/celery/?utm_source=celery&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/celery/builds/?utm_source=celery&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=celery&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=celery&utm_content=flyout)