### Navigation

- [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
- [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") \|
- [next](https://docs.celeryq.dev/en/stable/userguide/sphinx.html "Documenting Tasks with Sphinx") \|
- [previous](https://docs.celeryq.dev/en/stable/userguide/extending.html "Extensions and Bootsteps") \|
- [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
- [User Guide](https://docs.celeryq.dev/en/stable/userguide/index.html) »
- [Configuration and defaults](https://docs.celeryq.dev/en/stable/userguide/configuration.html)

This document describes the current stable version of Celery (5.6).
For development docs,
[go here](https://docs.celeryq.dev/en/main/userguide/configuration.html).


# Configuration and defaults [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#configuration-and-defaults "Link to this heading")

This document describes the configuration options available.

If you’re using the default loader, you must create the `celeryconfig.py`
module and make sure it’s available on the Python path.

- [Example configuration file](https://docs.celeryq.dev/en/stable/userguide/configuration.html#example-configuration-file)

- [New lowercase settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#new-lowercase-settings)

- [Configuration Directives](https://docs.celeryq.dev/en/stable/userguide/configuration.html#configuration-directives)

  - [General settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#general-settings)

  - [Time and date settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#time-and-date-settings)

  - [Task settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#task-settings)

  - [Task execution settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#task-execution-settings)

  - [Task result backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#task-result-backend-settings)

  - [Database backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#database-backend-settings)

  - [RPC backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#rpc-backend-settings)

  - [Cache backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#cache-backend-settings)

  - [MongoDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#mongodb-backend-settings)

  - [Redis backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#redis-backend-settings)

  - [Cassandra/AstraDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#cassandra-astradb-backend-settings)

  - [S3 backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#s3-backend-settings)

  - [Azure Block Blob backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#azure-block-blob-backend-settings)

  - [GCS backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#gcs-backend-settings)

  - [Elasticsearch backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#elasticsearch-backend-settings)

  - [AWS DynamoDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#aws-dynamodb-backend-settings)

  - [IronCache backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#ironcache-backend-settings)

  - [Couchbase backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#couchbase-backend-settings)

  - [ArangoDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#arangodb-backend-settings)

  - [CosmosDB backend settings (experimental)](https://docs.celeryq.dev/en/stable/userguide/configuration.html#cosmosdb-backend-settings-experimental)

  - [CouchDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#couchdb-backend-settings)

  - [File-system backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#file-system-backend-settings)

  - [Consul K/V store backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#consul-k-v-store-backend-settings)

  - [Message Routing](https://docs.celeryq.dev/en/stable/userguide/configuration.html#message-routing)

  - [Broker Settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#broker-settings)

  - [Worker](https://docs.celeryq.dev/en/stable/userguide/configuration.html#worker)

  - [Events](https://docs.celeryq.dev/en/stable/userguide/configuration.html#events)

  - [Remote Control Commands](https://docs.celeryq.dev/en/stable/userguide/configuration.html#remote-control-commands)

  - [`control_queue_durable`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#control-queue-durable)

  - [`control_queue_exclusive`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#control-queue-exclusive)

  - [Logging](https://docs.celeryq.dev/en/stable/userguide/configuration.html#logging)

  - [Security](https://docs.celeryq.dev/en/stable/userguide/configuration.html#security)

  - [Custom Component Classes (advanced)](https://docs.celeryq.dev/en/stable/userguide/configuration.html#custom-component-classes-advanced)

  - [Beat Settings ( **celery beat**)](https://docs.celeryq.dev/en/stable/userguide/configuration.html#beat-settings-celery-beat)

## [Example configuration file](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id12) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#example-configuration-file "Link to this heading")

This is an example configuration file to get you started.
It should contain all you need to run a basic Celery set-up.

```
## Broker settings.
broker_url = 'amqp://guest:guest@localhost:5672//'

# List of modules to import when the Celery worker starts.
imports = ('myapp.tasks',)

## Using the database to store task state and results.
result_backend = 'db+sqlite:///results.db'

task_annotations = {'tasks.add': {'rate_limit': '10/s'}}
```

## [New lowercase settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id13) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#new-lowercase-settings "Link to this heading")

Version 4.0 introduced new lower case settings and setting organization.

The major difference between previous versions, apart from the lower case
names, are the renaming of some prefixes, like `celery_beat_` to `beat_`,
`celeryd_` to `worker_`, and most of the top level `celery_` settings
have been moved into a new `task_` prefix.

Warning

Celery will still be able to read old configuration files until Celery 6.0.
Afterwards, support for the old configuration files will be removed.
We provide the `celery upgrade` command that should handle
plenty of cases (including [Django](https://docs.celeryq.dev/en/stable/history/whatsnew-4.0.html#latentcall-django-admonition)).

Please migrate to the new configuration scheme as soon as possible.

## [Configuration Directives](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id14) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#configuration-directives "Link to this heading")

### [General settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id15) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#general-settings "Link to this heading")

#### `accept_content` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#accept-content "Link to this heading")

Default: `{'json'}` (set, list, or tuple).

A white-list of content-types/serializers to allow.

If a message is received that’s not in this list then
the message will be discarded with an error.

By default only json is enabled but any content type can be added,
including pickle and yaml; when this is the case make sure
untrusted parties don’t have access to your broker.
See [Security](https://docs.celeryq.dev/en/stable/userguide/security.html#guide-security) for more.

Example:

```
# using serializer name
accept_content = ['json']

# or the actual content-type (MIME)
accept_content = ['application/json']
```

#### `result_accept_content` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-accept-content "Link to this heading")

Default: `None` (can be set, list or tuple).

Added in version 4.3.

A white-list of content-types/serializers to allow for the result backend.

If a message is received that’s not in this list then
the message will be discarded with an error.

By default it is the same serializer as `accept_content`.
However, a different serializer for accepted content of the result backend
can be specified.
Usually this is needed if signed messaging is used and the result is stored
unsigned in the result backend.
See [Security](https://docs.celeryq.dev/en/stable/userguide/security.html#guide-security) for more.

Example:

```
# using serializer name
result_accept_content = ['json']

# or the actual content-type (MIME)
result_accept_content = ['application/json']
```

### [Time and date settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id16) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#time-and-date-settings "Link to this heading")

#### `enable_utc` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#enable-utc "Link to this heading")

Added in version 2.5.

Default: Enabled by default since version 3.0.

If enabled dates and times in messages will be converted to use
the UTC timezone.

Note that workers running Celery versions below 2.5 will assume a local
timezone for all messages, so only enable if all workers have been
upgraded.

#### `timezone` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#timezone "Link to this heading")

Added in version 2.5.

Default: `"UTC"`.

Configure Celery to use a custom time zone.
The timezone value can be any time zone supported by the [ZoneInfo](https://docs.python.org/3/library/zoneinfo.html)
library.

If not set the UTC timezone is used. For backwards compatibility
there’s also a [`enable_utc`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-enable_utc) setting, and when this is set
to false the system local timezone is used instead.

### [Task settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id17) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-settings "Link to this heading")

#### `task_annotations` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-annotations "Link to this heading")

Added in version 2.5.

Default: `None`.

This setting can be used to rewrite any task attribute from the
configuration. The setting can be a dict, or a list of annotation
objects that filter for tasks and return a map of attributes
to change.

This will change the `rate_limit` attribute for the `tasks.add`
task:

```
task_annotations = {'tasks.add': {'rate_limit': '10/s'}}
```

or change the same for all tasks:

```
task_annotations = {'*': {'rate_limit': '10/s'}}
```

You can change methods too, for example the `on_failure` handler:

```
def my_on_failure(self, exc, task_id, args, kwargs, einfo):
    print('Oh no! Task failed: {0!r}'.format(exc))

task_annotations = {'*': {'on_failure': my_on_failure}}
```

If you need more flexibility then you can use objects
instead of a dict to choose the tasks to annotate:

```
class MyAnnotate:

    def annotate(self, task):
        if task.name.startswith('tasks.'):
            return {'rate_limit': '10/s'}

task_annotations = (MyAnnotate(), {other,})
```

#### `task_compression` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-compression "Link to this heading")

Default: `None`

Default compression used for task messages.
Can be `gzip`, `bzip2` (if available), or any custom
compression schemes registered in the Kombu compression registry.

The default is to send uncompressed messages.

#### `task_protocol` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-protocol "Link to this heading")

Default: 2 (since 4.0).

Set the default task message protocol version used to send tasks.
Supports protocols: 1 and 2.

Protocol 2 is supported by 3.1.24 and 4.x+.

#### `task_serializer` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-serializer "Link to this heading")

Default: `"json"` (since 4.0, earlier: pickle).

A string identifying the default serialization method to use. Can be
json (default), pickle, yaml, msgpack, or any custom serialization
methods that have been registered with `kombu.serialization.registry`.

See also

[Serializers](https://docs.celeryq.dev/en/stable/userguide/calling.html#calling-serializers).

#### `task_publish_retry` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-publish-retry "Link to this heading")

Added in version 2.2.

Default: Enabled.

Decides if publishing task messages will be retried in the case
of connection loss or other connection errors.
See also [`task_publish_retry_policy`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_publish_retry_policy).

#### `task_publish_retry_policy` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-publish-retry-policy "Link to this heading")

Added in version 2.2.

Default: See [Message Sending Retry](https://docs.celeryq.dev/en/stable/userguide/calling.html#calling-retry).

Defines the default policy when retrying publishing a task message in
the case of connection loss or other connection errors.

### [Task execution settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id18) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-execution-settings "Link to this heading")

#### `task_always_eager` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-always-eager "Link to this heading")

Default: Disabled.

If this is `True`, all tasks will be executed locally by blocking until
the task returns. `apply_async()` and `Task.delay()` will return
an [`EagerResult`](https://docs.celeryq.dev/en/stable/reference/celery.result.html#celery.result.EagerResult "celery.result.EagerResult") instance, that emulates the API
and behavior of [`AsyncResult`](https://docs.celeryq.dev/en/stable/reference/celery.result.html#celery.result.AsyncResult "celery.result.AsyncResult"), except the result
is already evaluated.

That is, tasks will be executed locally instead of being sent to
the queue.

#### `task_eager_propagates` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-eager-propagates "Link to this heading")

Default: Disabled.

If this is `True`, eagerly executed tasks (applied by task.apply(),
or when the [`task_always_eager`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_always_eager) setting is enabled), will
propagate exceptions.

It’s the same as always running `apply()` with `throw=True`.

#### `task_store_eager_result` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-store-eager-result "Link to this heading")

Added in version 5.1.

Default: Disabled.

If this is `True` and [`task_always_eager`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_always_eager) is `True`
and [`task_ignore_result`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_ignore_result) is `False`,
the results of eagerly executed tasks will be saved to the backend.

By default, even with [`task_always_eager`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_always_eager) set to `True`
and [`task_ignore_result`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_ignore_result) set to `False`,
the result will not be saved.

#### `task_remote_tracebacks` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-remote-tracebacks "Link to this heading")

Default: Disabled.

If enabled task results will include the workers stack when re-raising
task errors.

This requires the [https://pypi.org/project/tblib/](https://pypi.org/project/tblib/) library, that can be installed using
**pip**:

```
$ pip install celery[tblib]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for information on combining multiple extension
requirements.

#### `task_ignore_result` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-ignore-result "Link to this heading")

Default: Disabled.

Whether to store the task return values or not (tombstones).
If you still want to store errors, just not successful return values,
you can set [`task_store_errors_even_if_ignored`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_store_errors_even_if_ignored).

#### `task_store_errors_even_if_ignored` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-store-errors-even-if-ignored "Link to this heading")

Default: Disabled.

If set, the worker stores all task errors in the result store even if
[`Task.ignore_result`](https://docs.celeryq.dev/en/stable/reference/celery.app.task.html#celery.app.task.Task.ignore_result "celery.app.task.Task.ignore_result") is on.

#### `task_track_started` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-track-started "Link to this heading")

Default: Disabled.

If `True` the task will report its status as ‘started’ when the
task is executed by a worker. The default value is `False` as
the normal behavior is to not report that level of granularity. Tasks
are either pending, finished, or waiting to be retried. Having a ‘started’
state can be useful for when there are long running tasks and there’s a
need to report what task is currently running.

#### `task_time_limit` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-time-limit "Link to this heading")

Default: No time limit.

Task hard time limit in seconds. The worker processing the task will
be killed and replaced with a new one when this is exceeded.

#### `task_allow_error_cb_on_chord_header` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-allow-error-cb-on-chord-header "Link to this heading")

Added in version 5.3.

Default: Disabled.

Enabling this flag will allow linking an error callback to a chord header,
which by default will not link when using `link_error()`, and preventing
from the chord’s body to execute if any of the tasks in the header fails.

Consider the following canvas with the flag disabled (default behavior):

```
header = group([t1, t2])
body = t3
c = chord(header, body)
c.link_error(error_callback_sig)
```

If _any_ of the header tasks failed (`t1` or `t2`), by default, the chord body (`t3`) would **not execute**, and `error_callback_sig` will be called **once** (for the body).

Enabling this flag will change the above behavior by:

1. `error_callback_sig` will be linked to `t1` and `t2` (as well as `t3`).

2. If _any_ of the header tasks failed, `error_callback_sig` will be called **for each** failed header task **and** the `body` (even if the body didn’t run).


Consider now the following canvas with the flag enabled:

```
header = group([failingT1, failingT2])
body = t3
c = chord(header, body)
c.link_error(error_callback_sig)
```

If _all_ of the header tasks failed (`failingT1` and `failingT2`), then the chord body (`t3`) would **not execute**, and `error_callback_sig` will be called **3 times** (two times for the header and one time for the body).

Lastly, consider the following canvas with the flag enabled:

```
header = group([failingT1, failingT2])
body = t3
upgraded_chord = chain(header, body)
upgraded_chord.link_error(error_callback_sig)
```

This canvas will behave exactly the same as the previous one, since the `chain` will be upgraded to a `chord` internally.

#### `task_soft_time_limit` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-soft-time-limit "Link to this heading")

Default: No soft time limit.

Task soft time limit in seconds.

The [`SoftTimeLimitExceeded`](https://docs.celeryq.dev/en/stable/reference/celery.exceptions.html#celery.exceptions.SoftTimeLimitExceeded "celery.exceptions.SoftTimeLimitExceeded") exception will be
raised when this is exceeded. For example, the task can catch this to
clean up before the hard time limit comes:

```
from celery.exceptions import SoftTimeLimitExceeded

@app.task
def mytask():
    try:
        return do_work()
    except SoftTimeLimitExceeded:
        cleanup_in_a_hurry()
```

#### `task_acks_late` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-acks-late "Link to this heading")

Default: Disabled.

Late ack means the task messages will be acknowledged **after** the task
has been executed, not _right before_ (the default behavior).

See also

FAQ: [Should I use retry or acks\_late?](https://docs.celeryq.dev/en/stable/faq.html#faq-acks-late-vs-retry).

#### `task_acks_on_failure_or_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-acks-on-failure-or-timeout "Link to this heading")

Default: Enabled

When enabled messages for all tasks will be acknowledged even if they
fail or time out.

Configuring this setting only applies to tasks that are
acknowledged **after** they have been executed and only if
[`task_acks_late`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_acks_late) is enabled.

#### `task_reject_on_worker_lost` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-reject-on-worker-lost "Link to this heading")

Default: Disabled.

Even if [`task_acks_late`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_acks_late) is enabled, the worker will
acknowledge tasks when the worker process executing them abruptly
exits or is signaled (e.g., `KILL`/`INT`, etc).

Setting this to true allows the message to be re-queued instead,
so that the task will execute again by the same worker, or another
worker.

Warning

Enabling this can cause message loops; make sure you know
what you’re doing.

#### `task_default_rate_limit` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-default-rate-limit "Link to this heading")

Default: No rate limit.

The global default rate limit for tasks.

This value is used for tasks that doesn’t have a custom rate limit

See also

The [`worker_disable_rate_limits`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_disable_rate_limits) setting can
disable all rate limits.

### [Task result backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id19) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-result-backend-settings "Link to this heading")

#### `result_backend` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-backend "Link to this heading")

Default: No result backend enabled by default.

The backend used to store task results (tombstones).
Can be one of the following:

- `rpc`

Send results back as AMQP messages
See [RPC backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-rpc-result-backend).

- `database`

Use a relational database supported by [SQLAlchemy](http://sqlalchemy.org/).
See [Database backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-database-result-backend).

- `redis`

Use [Redis](https://redis.io/) to store the results.
See [Redis backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-redis-result-backend).

- `cache`

Use [Memcached](http://memcached.org/) to store the results.
See [Cache backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-cache-result-backend).

- `mongodb`

Use [MongoDB](http://mongodb.org/) to store the results.
See [MongoDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-mongodb-result-backend).

- `cassandra`

Use [Cassandra](http://cassandra.apache.org/) to store the results.
See [Cassandra/AstraDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-cassandra-result-backend).

- `elasticsearch`

Use [Elasticsearch](https://aws.amazon.com/elasticsearch-service/) to store the results.
See [Elasticsearch backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-elasticsearch-result-backend).

- `ironcache`

Use [IronCache](http://www.iron.io/cache) to store the results.
See [IronCache backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-ironcache-result-backend).

- `couchbase`

Use [Couchbase](https://www.couchbase.com/) to store the results.
See [Couchbase backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-couchbase-result-backend).

- `arangodb`

Use [ArangoDB](https://www.arangodb.com/) to store the results.
See [ArangoDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-arangodb-result-backend).

- `couchdb`

Use [CouchDB](http://www.couchdb.com/) to store the results.
See [CouchDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-couchdb-result-backend).

- `cosmosdbsql (experimental)`

Use the [CosmosDB](https://azure.microsoft.com/en-us/services/cosmos-db/) PaaS to store the results.
See [CosmosDB backend settings (experimental)](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-cosmosdbsql-result-backend).

- `filesystem`

Use a shared directory to store the results.
See [File-system backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-filesystem-result-backend).

- `consul`

Use the [Consul](https://consul.io/) K/V store to store the results
See [Consul K/V store backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-consul-result-backend).

- `azureblockblob`

Use the [AzureBlockBlob](https://azure.microsoft.com/en-us/services/storage/blobs/) PaaS store to store the results
See [Azure Block Blob backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-azureblockblob-result-backend).

- `s3`

Use the [S3](https://aws.amazon.com/s3/) to store the results
See [S3 backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-s3-result-backend).

- `gcs`

Use the [GCS](https://cloud.google.com/storage/) to store the results
See [GCS backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-gcs-result-backend).


#### `result_backend_always_retry` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-backend-always-retry "Link to this heading")

Default: `False`

If enable, backend will try to retry on the event of recoverable exceptions instead of propagating the exception.
It will use an exponential backoff sleep time between 2 retries.

#### `result_backend_max_sleep_between_retries_ms` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-backend-max-sleep-between-retries-ms "Link to this heading")

Default: 10000

This specifies the maximum sleep time between two backend operation retry.

#### `result_backend_base_sleep_between_retries_ms` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-backend-base-sleep-between-retries-ms "Link to this heading")

Default: 10

This specifies the base amount of sleep time between two backend operation retry.

#### `result_backend_max_retries` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-backend-max-retries "Link to this heading")

Default: Inf

This is the maximum of retries in case of recoverable exceptions.

#### `result_backend_thread_safe` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-backend-thread-safe "Link to this heading")

Default: False

If True, then the backend object is shared across threads.
This may be useful for using a shared connection pool instead of creating
a connection for every thread.

#### `result_backend_transport_options` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-backend-transport-options "Link to this heading")

Default: `{}` (empty mapping).

A dict of additional options passed to the underlying transport.

See your transport user manual for supported options (if any).

Example setting the visibility timeout (supported by Redis and SQS
transports):

```
result_backend_transport_options = {'visibility_timeout': 18000}  # 5 hours
```

#### `result_serializer` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-serializer "Link to this heading")

Default: `json` since 4.0 (earlier: pickle).

Result serialization format.

See [Serializers](https://docs.celeryq.dev/en/stable/userguide/calling.html#calling-serializers) for information about supported
serialization formats.

#### `result_compression` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-compression "Link to this heading")

Default: No compression.

Optional compression method used for task results.
Supports the same options as the [`task_compression`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_compression) setting.

#### `result_extended` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-extended "Link to this heading")

Default: `False`

Enables extended task result attributes (name, args, kwargs, worker,
retries, queue, delivery\_info) to be written to backend.

#### `result_expires` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-expires "Link to this heading")

Default: Expire after 1 day.

Time (in seconds, or a [`timedelta`](https://docs.python.org/dev/library/datetime.html#datetime.timedelta "(in Python v3.15)") object) for when after
stored task tombstones will be deleted.

A built-in periodic task will delete the results after this time
(`celery.backend_cleanup`), assuming that `celery beat` is
enabled. The task runs daily at 4am.

A value of `None` or 0 means results will never expire (depending
on backend specifications).

Note

For the moment this only works with the AMQP, database, cache, Couchbase,
filesystem and Redis backends.

When using the database or filesystem backend, `celery beat` must be
running for the results to be expired.

#### `result_cache_max` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-cache-max "Link to this heading")

Default: Disabled by default.

Enables client caching of results.

This can be useful for the old deprecated
‘amqp’ backend where the result is unavailable as soon as one result instance
consumes it.

This is the total number of results to cache before older results are evicted.
A value of 0 or None means no limit, and a value of `-1`
will disable the cache.

Disabled by default.

#### `result_chord_join_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-chord-join-timeout "Link to this heading")

Default: 3.0.

The timeout in seconds (int/float) when joining a group’s results within a chord.

#### `result_chord_retry_interval` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-chord-retry-interval "Link to this heading")

Default: 1.0.

Default interval for retrying chord tasks.

#### `override_backends` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#override-backends "Link to this heading")

Default: Disabled by default.

Path to class that implements backend.

Allows to override backend implementation.
This can be useful if you need to store additional metadata about executed tasks,
override retry policies, etc.

Example:

```
override_backends = {"db": "custom_module.backend.class"}
```

### [Database backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id20) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#database-backend-settings "Link to this heading")

#### Database URL Examples [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#database-url-examples "Link to this heading")

To use the database backend you have to configure the
[`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend) setting with a connection URL and the `db+`
prefix:

```
result_backend = 'db+scheme://user:password@host:port/dbname'
```

Examples:

```
# sqlite (filename)
result_backend = 'db+sqlite:///results.sqlite'

# mysql
result_backend = 'db+mysql://scott:tiger@localhost/foo'

# postgresql
result_backend = 'db+postgresql://scott:tiger@localhost/mydatabase'

# oracle
result_backend = 'db+oracle://scott:tiger@127.0.0.1:1521/sidname'
```

```

```

Please see [Supported Databases](http://www.sqlalchemy.org/docs/core/engines.html#supported-databases) for a table of supported databases,
and [Connection String](http://www.sqlalchemy.org/docs/core/engines.html#database-urls) for more information about connection
strings (this is the part of the URI that comes after the `db+` prefix).

Note

If you are upgrading from Celery 5.6 or earlier, the `date_done` column
in `celery_taskmeta` and `celery_tasksetmeta` tables does not have a
database index. The built-in periodic task `celery.backend_cleanup`
queries on `date_done` to delete expired task results, so adding an
index significantly improves cleanup performance on large tables.

Since SQLAlchemy’s `create_all()` will not alter existing tables, you
will need to update your database schema. If you are using Alembic for
schema migrations, you can generate an empty revision and apply the
following operations:

```
from alembic import op

def upgrade():
    op.create_index('ix_celery_taskmeta_date_done', 'celery_taskmeta', ['date_done'])
    op.create_index('ix_celery_tasksetmeta_date_done', 'celery_tasksetmeta', ['date_done'])

def downgrade():
    op.drop_index('ix_celery_tasksetmeta_date_done', table_name='celery_tasksetmeta')
    op.drop_index('ix_celery_taskmeta_date_done', table_name='celery_taskmeta')
```

Otherwise, you can add the indexes manually using SQL:

```
CREATE INDEX ix_celery_taskmeta_date_done ON celery_taskmeta (date_done);
CREATE INDEX ix_celery_tasksetmeta_date_done ON celery_tasksetmeta (date_done);
```

#### `database_create_tables_at_setup` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#database-create-tables-at-setup "Link to this heading")

Added in version 5.5.0.

Default: True by default.

- If True, Celery will create the tables in the database during setup.

- If False, Celery will create the tables lazily, i.e. wait for the first task
to be executed before creating the tables.


Note

Before celery 5.5, the tables were created lazily i.e. it was equivalent to
database\_create\_tables\_at\_setup set to False.

#### `database_engine_options` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#database-engine-options "Link to this heading")

Default: `{'pool_pre_ping': True, 'pool_recycle': 3600}`

Changed in version 5.7: The default was changed from `{}` to include `pool_pre_ping=True`
and `pool_recycle=3600` for improved connection health handling.
This helps prevent stale connection errors such as
`(OperationalError) (2006, 'MySQL server has gone away')`.

To specify additional SQLAlchemy database engine options you can use
the [`database_engine_options`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-database_engine_options) setting:

```
# echo enables verbose logging from SQLAlchemy.
app.conf.database_engine_options = {'echo': True}

# To disable the default pool health options:
app.conf.database_engine_options = {'pool_pre_ping': False, 'pool_recycle': None}
```

#### `database_short_lived_sessions` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#database-short-lived-sessions "Link to this heading")

Default: Disabled by default.

Short lived sessions are disabled by default. If enabled they can drastically reduce
performance, especially on systems processing lots of tasks. This option is useful
on low-traffic workers that experience errors as a result of cached database connections
going stale through inactivity. For example, intermittent errors like
(OperationalError) (2006, ‘MySQL server has gone away’) can be fixed by enabling
short lived sessions. This option only affects the database backend.

#### `database_table_schemas` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#database-table-schemas "Link to this heading")

Default: `{}` (empty mapping).

When SQLAlchemy is configured as the result backend, Celery automatically
creates two tables to store result meta-data for tasks. This setting allows
you to customize the schema of the tables:

```
# use custom schema for the database result backend.
database_table_schemas = {
    'task': 'celery',
    'group': 'celery',
}
```

#### `database_table_names` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#database-table-names "Link to this heading")

Default: `{}` (empty mapping).

When SQLAlchemy is configured as the result backend, Celery automatically
creates two tables to store result meta-data for tasks. This setting allows
you to customize the table names:

```
# use custom table names for the database result backend.
database_table_names = {
    'task': 'myapp_taskmeta',
    'group': 'myapp_groupmeta',
}
```

### [RPC backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id21) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#rpc-backend-settings "Link to this heading")

#### `result_persistent` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#result-persistent "Link to this heading")

Default: Disabled by default (transient messages).

If set to `True`, result messages will be persistent. This means the
messages won’t be lost after a broker restart.

#### Example configuration [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#example-configuration "Link to this heading")

```
result_backend = 'rpc://'
result_persistent = False
```

**Please note**: using this backend could trigger the raise of `celery.backends.rpc.BacklogLimitExceeded` if the task tombstone is too _old_.

E.g.

```
for i in range(10000):
    r = debug_task.delay()

print(r.state)  # this would raise celery.backends.rpc.BacklogLimitExceeded
```

### [Cache backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id22) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cache-backend-settings "Link to this heading")

Note

The cache backend supports the [https://pypi.org/project/pylibmc/](https://pypi.org/project/pylibmc/) and [https://pypi.org/project/python-memcached/](https://pypi.org/project/python-memcached/)
libraries. The latter is used only if [https://pypi.org/project/pylibmc/](https://pypi.org/project/pylibmc/) isn’t installed.

Using a single Memcached server:

```
result_backend = 'cache+memcached://127.0.0.1:11211/'
```

Using multiple Memcached servers:

```
result_backend = """
    cache+memcached://172.19.26.240:11211;172.19.26.242:11211/
""".strip()
```

The “memory” backend stores the cache in memory only:

```
result_backend = 'cache'
cache_backend = 'memory'
```

#### `cache_backend_options` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cache-backend-options "Link to this heading")

Default: `{}` (empty mapping).

You can set [https://pypi.org/project/pylibmc/](https://pypi.org/project/pylibmc/) options using the [`cache_backend_options`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-cache_backend_options)
setting:

```
cache_backend_options = {
    'binary': True,
    'behaviors': {'tcp_nodelay': True},
}
```

#### `cache_backend` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cache-backend "Link to this heading")

This setting is no longer used in celery’s builtin backends as it’s now possible to specify
the cache backend directly in the [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend) setting.

Note

The [django-celery-results - Using the Django ORM/Cache as a result backend](https://docs.celeryq.dev/en/stable/django/first-steps-with-django.html#django-celery-results) library uses `cache_backend` for choosing django caches.

### [MongoDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id23) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#mongodb-backend-settings "Link to this heading")

Note

The MongoDB backend requires the `pymongo` library:
[http://github.com/mongodb/mongo-python-driver/tree/master](http://github.com/mongodb/mongo-python-driver/tree/master)

#### mongodb\_backend\_settings [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#std-setting-mongodb_backend_settings "Link to this heading")

This is a dict supporting the following keys:

- database

The database name to connect to. Defaults to `celery`.

- taskmeta\_collection

The collection name to store task meta data.
Defaults to `celery_taskmeta`.

- max\_pool\_size

Passed as max\_pool\_size to PyMongo’s Connection or MongoClient
constructor. It is the maximum number of TCP connections to keep
open to MongoDB at a given time. If there are more open connections
than max\_pool\_size, sockets will be closed when they are released.
Defaults to 10.

- options


> Additional keyword arguments to pass to the mongodb connection
> constructor. See the `pymongo` docs to see a list of arguments
> supported.


Note

With pymongo>=4.14, options are case-sensitive when they were previously
case-insensitive. See `MongoClient` to
determine the correct case.

#### Example configuration [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#example-mongodb-result-config "Link to this heading")

```
result_backend = 'mongodb://localhost:27017/'
mongodb_backend_settings = {
    'database': 'mydb',
    'taskmeta_collection': 'my_taskmeta_collection',
}
```

### [Redis backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id24) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-backend-settings "Link to this heading")

#### Configuring the backend URL [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#configuring-the-backend-url "Link to this heading")

Note

The Redis backend requires the [https://pypi.org/project/redis/](https://pypi.org/project/redis/) library.

To install this package use **pip**:

```
$ pip install celery[redis]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for information on combining multiple extension
requirements.

This backend requires the [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend)
setting to be set to a Redis or [Redis over TLS](https://www.iana.org/assignments/uri-schemes/prov/rediss) URL:

```
result_backend = 'redis://username:password@host:port/db'
```

For example:

```
result_backend = 'redis://localhost/0'
```

is the same as:

```
result_backend = 'redis://'
```

Use the `rediss://` protocol to connect to redis over TLS:

```
result_backend = 'rediss://username:password@host:port/db?ssl_cert_reqs=required'
```

Note that the `ssl_cert_reqs` string should be one of `required`,
`optional`, or `none` (though, for backwards compatibility with older Celery versions, the string
may also be one of `CERT_REQUIRED`, `CERT_OPTIONAL`, `CERT_NONE`, but those values
only work for Celery, not for Redis directly).

If a Unix socket connection should be used, the URL needs to be in the format::

```
result_backend = 'socket:///path/to/redis.sock'
```

The fields of the URL are defined as follows:

1. `username`


> Added in version 5.1.0.
>
> Username used to connect to the database.
>
> Note that this is only supported in Redis>=6.0 and with py-redis>=3.4.0
> installed.
>
> If you use an older database version or an older client version
> you can omit the username:
>
> ```
> result_backend = 'redis://:password@host:port/db'
> ```

2. `password`


> Password used to connect to the database.

3. `host`


> Host name or IP address of the Redis server (e.g., localhost).

4. `port`


> Port to the Redis server. Default is 6379.

5. `db`


> Database number to use. Default is 0.
> The db can include an optional leading slash.


When using a TLS connection (protocol is `rediss://`), you may pass in all values in [`broker_use_ssl`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_use_ssl) as query parameters. Paths to certificates must be URL encoded, and `ssl_cert_reqs` is required. Example:

```
result_backend = 'rediss://:password@host:port/db?\
    ssl_cert_reqs=required\
    &ssl_ca_certs=%2Fvar%2Fssl%2Fmyca.pem\                  # /var/ssl/myca.pem
    &ssl_certfile=%2Fvar%2Fssl%2Fredis-server-cert.pem\     # /var/ssl/redis-server-cert.pem
    &ssl_keyfile=%2Fvar%2Fssl%2Fprivate%2Fworker-key.pem'   # /var/ssl/private/worker-key.pem
```

Note that the `ssl_cert_reqs` string should be one of `required`,
`optional`, or `none` (though, for backwards compatibility, the string
may also be one of `CERT_REQUIRED`, `CERT_OPTIONAL`, `CERT_NONE`).

Added in version 5.1.0.

#### `redis_backend_health_check_interval` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-backend-health-check-interval "Link to this heading")

Default: Not configured

The Redis backend supports health checks. This value must be
set as an integer whose value is the number of seconds between
health checks. If a ConnectionError or a TimeoutError is
encountered during the health check, the connection will be
re-established and the command retried exactly once.

#### `redis_backend_use_ssl` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-backend-use-ssl "Link to this heading")

Default: Disabled.

The Redis backend supports SSL. This value must be set in
the form of a dictionary. The valid key-value pairs are
the same as the ones mentioned in the `redis` sub-section
under [`broker_use_ssl`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_use_ssl).

Added in version 5.6.

#### `redis_backend_credential_provider` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-backend-credential-provider "Link to this heading")

Default: Disabled.

The Redis backend supports credential provider. This value must be set in
the form of a class path string or a class instance. e.g. `mymodule.myfile.myclass`
check more details in [RedisCredentialProvider](https://redis.readthedocs.io/en/stable/examples/connection_examples.html#Connecting-to-a-redis-instance-with-standard-credential-provider) doc.

#### `redis_max_connections` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-max-connections "Link to this heading")

Default: No limit.

Maximum number of connections available in the Redis connection
pool used for sending and retrieving results.

Warning

Redis will raise a ConnectionError if the number of concurrent
connections exceeds the maximum.

#### `redis_socket_connect_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-socket-connect-timeout "Link to this heading")

Added in version 4.0.1.

Default: `None`

Socket timeout for connections to Redis from the result backend
in seconds (int/float)

#### `redis_socket_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-socket-timeout "Link to this heading")

Default: 120.0 seconds.

Socket timeout for reading/writing operations to the Redis server
in seconds (int/float), used by the redis result backend.

#### `redis_retry_on_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-retry-on-timeout "Link to this heading")

Added in version 4.4.1.

Default: `False`

To retry reading/writing operations on TimeoutError to the Redis server,
used by the redis result backend. Shouldn’t set this variable if using Redis
connection by unix socket.

#### `redis_socket_keepalive` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-socket-keepalive "Link to this heading")

Added in version 4.4.1.

Default: `False`

Socket TCP keepalive to keep connections healthy to the Redis server,
used by the redis result backend.

#### `redis_client_name` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#redis-client-name "Link to this heading")

Added in version 5.6.

Default: `None`

Sets the client name for Redis connections used by the result backend.
This can help identify connections in Redis monitoring tools.

### [Cassandra/AstraDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id25) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-astradb-backend-settings "Link to this heading")

Note

This Cassandra backend driver requires [https://pypi.org/project/cassandra-driver/](https://pypi.org/project/cassandra-driver/).

This backend can refer to either a regular Cassandra installation
or a managed Astra DB instance. Depending on which one, exactly one
between the [`cassandra_servers`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-cassandra_servers) and
[`cassandra_secure_bundle_path`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-cassandra_secure_bundle_path) settings must be provided
(but not both).

To install, use **pip**:

```
$ pip install celery[cassandra]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for information on combining multiple extension
requirements.

This backend requires the following configuration directives to be set.

#### `cassandra_servers` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-servers "Link to this heading")

Default: `[]` (empty list).

List of `host` Cassandra servers. This must be provided when connecting to
a Cassandra cluster. Passing this setting is strictly exclusive
to [`cassandra_secure_bundle_path`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-cassandra_secure_bundle_path). Example:

```
cassandra_servers = ['localhost']
```

#### `cassandra_secure_bundle_path` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-secure-bundle-path "Link to this heading")

Default: None.

Absolute path to the secure-connect-bundle zip file to connect
to an Astra DB instance. Passing this setting is strictly exclusive
to [`cassandra_servers`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-cassandra_servers).
Example:

```
cassandra_secure_bundle_path = '/home/user/bundles/secure-connect.zip'
```

When connecting to Astra DB, it is necessary to specify
the plain-text auth provider and the associated username and password,
which take the value of the Client ID and the Client Secret, respectively,
of a valid token generated for the Astra DB instance.
See below for an Astra DB configuration example.

#### `cassandra_port` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-port "Link to this heading")

Default: 9042.

Port to contact the Cassandra servers on.

#### `cassandra_keyspace` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-keyspace "Link to this heading")

Default: None.

The keyspace in which to store the results. For example:

```
cassandra_keyspace = 'tasks_keyspace'
```

#### `cassandra_table` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-table "Link to this heading")

Default: None.

The table (column family) in which to store the results. For example:

```
cassandra_table = 'tasks'
```

#### `cassandra_read_consistency` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-read-consistency "Link to this heading")

Default: None.

The read consistency used. Values can be `ONE`, `TWO`, `THREE`, `QUORUM`, `ALL`,
`LOCAL_QUORUM`, `EACH_QUORUM`, `LOCAL_ONE`.

#### `cassandra_write_consistency` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-write-consistency "Link to this heading")

Default: None.

The write consistency used. Values can be `ONE`, `TWO`, `THREE`, `QUORUM`, `ALL`,
`LOCAL_QUORUM`, `EACH_QUORUM`, `LOCAL_ONE`.

#### `cassandra_entry_ttl` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-entry-ttl "Link to this heading")

Default: None.

Time-to-live for status entries. They will expire and be removed after that many seconds
after adding. A value of `None` (default) means they will never expire.

#### `cassandra_auth_provider` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-auth-provider "Link to this heading")

Default: `None`.

AuthProvider class within `cassandra.auth` module to use. Values can be
`PlainTextAuthProvider` or `SaslAuthProvider`.

#### `cassandra_auth_kwargs` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-auth-kwargs "Link to this heading")

Default: `{}` (empty mapping).

Named arguments to pass into the authentication provider. For example:

```
cassandra_auth_kwargs = {
    username: 'cassandra',
    password: 'cassandra'
}
```

#### `cassandra_options` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cassandra-options "Link to this heading")

Default: `{}` (empty mapping).

Named arguments to pass into the `cassandra.cluster` class.

```
cassandra_options = {
    'cql_version': '3.2.1'
    'protocol_version': 3
}
```

#### Example configuration (Cassandra) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#example-configuration-cassandra "Link to this heading")

```
result_backend = 'cassandra://'
cassandra_servers = ['localhost']
cassandra_keyspace = 'celery'
cassandra_table = 'tasks'
cassandra_read_consistency = 'QUORUM'
cassandra_write_consistency = 'QUORUM'
cassandra_entry_ttl = 86400
```

#### Example configuration (Astra DB) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#example-configuration-astra-db "Link to this heading")

```
result_backend = 'cassandra://'
cassandra_keyspace = 'celery'
cassandra_table = 'tasks'
cassandra_read_consistency = 'QUORUM'
cassandra_write_consistency = 'QUORUM'
cassandra_auth_provider = 'PlainTextAuthProvider'
cassandra_auth_kwargs = {
  'username': '<<CLIENT_ID_FROM_ASTRA_DB_TOKEN>>',
  'password': '<<CLIENT_SECRET_FROM_ASTRA_DB_TOKEN>>'
}
cassandra_secure_bundle_path = '/path/to/secure-connect-bundle.zip'
cassandra_entry_ttl = 86400
```

#### Additional configuration [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#additional-configuration "Link to this heading")

The Cassandra driver, when establishing the connection, undergoes a stage
of negotiating the protocol version with the server(s). Similarly,
a load-balancing policy is automatically supplied (by default
`DCAwareRoundRobinPolicy`, which in turn has a `local_dc` setting, also
determined by the driver upon connection).
When possible, one should explicitly provide these in the configuration:
moreover, future versions of the Cassandra driver will require at least the
load-balancing policy to be specified (using [execution profiles](https://docs.datastax.com/en/developer/python-driver/3.25/execution_profiles/),
as shown below).

A full configuration for the Cassandra backend would thus have the
following additional lines:

```
from cassandra.policies import DCAwareRoundRobinPolicy
from cassandra.cluster import ExecutionProfile
from cassandra.cluster import EXEC_PROFILE_DEFAULT
myEProfile = ExecutionProfile(
  load_balancing_policy=DCAwareRoundRobinPolicy(
    local_dc='datacenter1', # replace with your DC name
  )
)
cassandra_options = {
  'protocol_version': 5,    # for Cassandra 4, change if needed
  'execution_profiles': {EXEC_PROFILE_DEFAULT: myEProfile},
}
```

And similarly for Astra DB:

```
from cassandra.policies import DCAwareRoundRobinPolicy
from cassandra.cluster import ExecutionProfile
from cassandra.cluster import EXEC_PROFILE_DEFAULT
myEProfile = ExecutionProfile(
  load_balancing_policy=DCAwareRoundRobinPolicy(
    local_dc='europe-west1',  # for Astra DB, region name = dc name
  )
)
cassandra_options = {
  'protocol_version': 4,      # for Astra DB
  'execution_profiles': {EXEC_PROFILE_DEFAULT: myEProfile},
}
```

### [S3 backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id26) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#s3-backend-settings "Link to this heading")

Note

This s3 backend driver requires [https://pypi.org/project/s3/](https://pypi.org/project/s3/).

To install, use **s3**:

```
$ pip install celery[s3]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for information on combining multiple extension
requirements.

This backend requires the following configuration directives to be set.

#### `s3_access_key_id` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#s3-access-key-id "Link to this heading")

Default: None.

The s3 access key id. For example:

```
s3_access_key_id = 'access_key_id'
```

#### `s3_secret_access_key` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#s3-secret-access-key "Link to this heading")

Default: None.

The s3 secret access key. For example:

```
s3_secret_access_key = 'access_secret_access_key'
```

#### `s3_bucket` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#s3-bucket "Link to this heading")

Default: None.

The s3 bucket name. For example:

```
s3_bucket = 'bucket_name'
```

#### `s3_base_path` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#s3-base-path "Link to this heading")

Default: None.

A base path in the s3 bucket to use to store result keys. For example:

```
s3_base_path = '/prefix'
```

#### `s3_endpoint_url` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#s3-endpoint-url "Link to this heading")

Default: None.

A custom s3 endpoint url. Use it to connect to a custom self-hosted s3 compatible backend (Ceph, Scality…). For example:

```
s3_endpoint_url = 'https://.s3.custom.url'
```

#### `s3_region` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#s3-region "Link to this heading")

Default: None.

The s3 aws region. For example:

```
s3_region = 'us-east-1'
```

#### Example configuration [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id3 "Link to this heading")

```
s3_access_key_id = 's3-access-key-id'
s3_secret_access_key = 's3-secret-access-key'
s3_bucket = 'mybucket'
s3_base_path = '/celery_result_backend'
s3_endpoint_url = 'https://endpoint_url'
```

### [Azure Block Blob backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id27) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#azure-block-blob-backend-settings "Link to this heading")

To use [AzureBlockBlob](https://azure.microsoft.com/en-us/services/storage/blobs/) as the result backend you simply need to
configure the [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend) setting with the correct URL.

The required URL format is `azureblockblob://` followed by the storage
connection string. You can find the storage connection string in the
`Access Keys` pane of your storage account resource in the Azure Portal.

#### Example configuration [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id4 "Link to this heading")

```
result_backend = 'azureblockblob://DefaultEndpointsProtocol=https;AccountName=somename;AccountKey=Lou...bzg==;EndpointSuffix=core.windows.net'
```

#### `azureblockblob_container_name` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#azureblockblob-container-name "Link to this heading")

Default: celery.

The name for the storage container in which to store the results.

#### `azureblockblob_base_path` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#azureblockblob-base-path "Link to this heading")

Added in version 5.1.

Default: None.

A base path in the storage container to use to store result keys. For example:

```
azureblockblob_base_path = 'prefix/'
```

#### `azureblockblob_retry_initial_backoff_sec` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#azureblockblob-retry-initial-backoff-sec "Link to this heading")

Default: 2.

The initial backoff interval, in seconds, for the first retry.
Subsequent retries are attempted with an exponential strategy.

#### `azureblockblob_retry_increment_base` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#azureblockblob-retry-increment-base "Link to this heading")

Default: 2.

#### `azureblockblob_retry_max_attempts` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#azureblockblob-retry-max-attempts "Link to this heading")

Default: 3.

The maximum number of retry attempts.

#### `azureblockblob_connection_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#azureblockblob-connection-timeout "Link to this heading")

Default: 20.

Timeout in seconds for establishing the azure block blob connection.

#### `azureblockblob_read_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#azureblockblob-read-timeout "Link to this heading")

Default: 120.

Timeout in seconds for reading of an azure block blob.

### [GCS backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id28) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#gcs-backend-settings "Link to this heading")

Note

This gcs backend driver requires [https://pypi.org/project/google-cloud-storage/](https://pypi.org/project/google-cloud-storage/) and [https://pypi.org/project/google-cloud-firestore/](https://pypi.org/project/google-cloud-firestore/).

To install, use **gcs**:

```
$ pip install celery[gcs]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for information on combining multiple extension
requirements.

GCS could be configured via the URL provided in [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend), for example:

```
result_backend = 'gs://mybucket/some-prefix?gcs_project=myproject&ttl=600'
result_backend = 'gs://mybucket/some-prefix?gcs_project=myproject?firestore_project=myproject2&ttl=600'
```

This backend requires the following configuration directives to be set:

#### `gcs_bucket` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#gcs-bucket "Link to this heading")

Default: None.

The gcs bucket name. For example:

```
gcs_bucket = 'bucket_name'
```

#### `gcs_project` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#gcs-project "Link to this heading")

Default: None.

The gcs project name. For example:

```
gcs_project = 'test-project'
```

#### `gcs_base_path` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#gcs-base-path "Link to this heading")

Default: None.

A base path in the gcs bucket to use to store all result keys. For example:

```
gcs_base_path = '/prefix'
```

#### `gcs_ttl` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#gcs-ttl "Link to this heading")

Default: 0.

The time to live in seconds for the results blobs.
Requires a GCS bucket with “Delete” Object Lifecycle Management action enabled.
Use it to automatically delete results from Cloud Storage Buckets.

For example to auto remove results after 24 hours:

```
gcs_ttl = 86400
```

#### `gcs_threadpool_maxsize` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#gcs-threadpool-maxsize "Link to this heading")

Default: 10.

Threadpool size for GCS operations. Same value defines the connection pool size.
Allows to control the number of concurrent operations. For example:

```
gcs_threadpool_maxsize = 20
```

#### `firestore_project` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#firestore-project "Link to this heading")

Default: gcs\_project.

The Firestore project for Chord reference counting. Allows native chord ref counts.
If not specified defaults to [`gcs_project`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-gcs_project).
For example:

```
firestore_project = 'test-project2'
```

#### Example configuration [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id5 "Link to this heading")

```
gcs_bucket = 'mybucket'
gcs_project = 'myproject'
gcs_base_path = '/celery_result_backend'
gcs_ttl = 86400
```

### [Elasticsearch backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id29) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#elasticsearch-backend-settings "Link to this heading")

To use [Elasticsearch](https://aws.amazon.com/elasticsearch-service/) as the result backend you simply need to
configure the [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend) setting with the correct URL.

#### Example configuration [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id6 "Link to this heading")

```
result_backend = 'elasticsearch://example.com:9200/index_name/doc_type'
```

#### `elasticsearch_retry_on_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#elasticsearch-retry-on-timeout "Link to this heading")

Default: `False`

Should timeout trigger a retry on different node?

#### `elasticsearch_max_retries` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#elasticsearch-max-retries "Link to this heading")

Default: 3.

Maximum number of retries before an exception is propagated.

#### `elasticsearch_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#elasticsearch-timeout "Link to this heading")

Default: 10.0 seconds.

Global timeout,used by the elasticsearch result backend.

#### `elasticsearch_save_meta_as_text` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#elasticsearch-save-meta-as-text "Link to this heading")

Default: `True`

Should meta saved as text or as native json.
Result is always serialized as text.

### [AWS DynamoDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id30) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#aws-dynamodb-backend-settings "Link to this heading")

Note

The Dynamodb backend requires the [https://pypi.org/project/boto3/](https://pypi.org/project/boto3/) library.

To install this package use **pip**:

```
$ pip install celery[dynamodb]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for information on combining multiple extension
requirements.

Warning

The Dynamodb backend is not compatible with tables that have a sort key defined.

If you want to query the results table based on something other than the partition key,
please define a global secondary index (GSI) instead.

This backend requires the [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend)
setting to be set to a DynamoDB URL:

```
result_backend = 'dynamodb://aws_access_key_id:aws_secret_access_key@region:port/table?read=n&write=m'
```

For example, specifying the AWS region and the table name:

```
result_backend = 'dynamodb://@us-east-1/celery_results'
```

or retrieving AWS configuration parameters from the environment, using the default table name (`celery`)
and specifying read and write provisioned throughput:

```
result_backend = 'dynamodb://@/?read=5&write=5'
```

or using the [downloadable version](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html)
of DynamoDB
[locally](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.Endpoint.html):

```
result_backend = 'dynamodb://@localhost:8000'
```

or using downloadable version or other service with conforming API deployed on any host:

```
result_backend = 'dynamodb://@us-east-1'
dynamodb_endpoint_url = 'http://192.168.0.40:8000'
```

The fields of the DynamoDB URL in `result_backend` are defined as follows:

1. `aws_access_key_id & aws_secret_access_key`


> The credentials for accessing AWS API resources. These can also be resolved
> by the [https://pypi.org/project/boto3/](https://pypi.org/project/boto3/) library from various sources, as
> described [here](http://boto3.readthedocs.io/en/latest/guide/configuration.html#configuring-credentials).

2. `region`


> The AWS region, e.g. `us-east-1` or `localhost` for the [Downloadable Version](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html).
> See the [https://pypi.org/project/boto3/](https://pypi.org/project/boto3/) library [documentation](http://boto3.readthedocs.io/en/latest/guide/configuration.html#environment-variable-configuration)
> for definition options.

3. `port`

The listening port of the local DynamoDB instance, if you are using the downloadable version.
If you have not specified the `region` parameter as `localhost`,
setting this parameter has **no effect**.

4. `table`


> Table name to use. Default is `celery`.
> See the [DynamoDB Naming Rules](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html#limits-naming-rules)
> for information on the allowed characters and length.

5. `read & write`


> The Read & Write Capacity Units for the created DynamoDB table. Default is `1` for both read and write.
> More details can be found in the [Provisioned Throughput documentation](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ProvisionedThroughput.html).

6. `ttl_seconds`


> Time-to-live (in seconds) for results before they expire. The default is to
> not expire results, while also leaving the DynamoDB table’s Time to Live
> settings untouched. If `ttl_seconds` is set to a positive value, results
> will expire after the specified number of seconds. Setting `ttl_seconds`
> to a negative value means to not expire results, and also to actively
> disable the DynamoDB table’s Time to Live setting. Note that trying to
> change a table’s Time to Live setting multiple times in quick succession
> will cause a throttling error. More details can be found in the
> [DynamoDB TTL documentation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/TTL.html)


### [IronCache backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id31) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#ironcache-backend-settings "Link to this heading")

Note

The IronCache backend requires the [https://pypi.org/project/iron\_celery/](https://pypi.org/project/iron_celery/) library:

To install this package use **pip**:

```
$ pip install iron_celery
```

IronCache is configured via the URL provided in [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend), for example:

```
result_backend = 'ironcache://project_id:token@'
```

Or to change the cache name:

```
ironcache:://project_id:token@/awesomecache
```

For more information, see: [https://github.com/iron-io/iron\_celery](https://github.com/iron-io/iron_celery)

### [Couchbase backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id32) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#couchbase-backend-settings "Link to this heading")

Note

The Couchbase backend requires the [https://pypi.org/project/couchbase/](https://pypi.org/project/couchbase/) library.

To install this package use **pip**:

```
$ pip install celery[couchbase]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for instructions how to combine multiple extension
requirements.

This backend can be configured via the [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend)
set to a Couchbase URL:

```
result_backend = 'couchbase://username:password@host:port/bucket'
```

#### `couchbase_backend_settings` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#std-setting-couchbase_backend_settings "Link to this heading")

Default: `{}` (empty mapping).

This is a dict supporting the following keys:

- `host`


> Host name of the Couchbase server. Defaults to `localhost`.

- `port`


> The port the Couchbase server is listening to. Defaults to `8091`.

- `bucket`


> The default bucket the Couchbase server is writing to.
> Defaults to `default`.

- `username`


> User name to authenticate to the Couchbase server as (optional).

- `password`


> Password to authenticate to the Couchbase server (optional).


### [ArangoDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id33) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#arangodb-backend-settings "Link to this heading")

Note

The ArangoDB backend requires the [https://pypi.org/project/pyArango/](https://pypi.org/project/pyArango/) library.

To install this package use **pip**:

```
$ pip install celery[arangodb]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for instructions how to combine multiple extension
requirements.

This backend can be configured via the [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend)
set to a ArangoDB URL:

```
result_backend = 'arangodb://username:password@host:port/database/collection'
```

#### `arangodb_backend_settings` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#std-setting-arangodb_backend_settings "Link to this heading")

Default: `{}` (empty mapping).

This is a dict supporting the following keys:

- `host`


> Host name of the ArangoDB server. Defaults to `localhost`.

- `port`


> The port the ArangoDB server is listening to. Defaults to `8529`.

- `database`


> The default database in the ArangoDB server is writing to.
> Defaults to `celery`.

- `collection`


> The default collection in the ArangoDB servers database is writing to.
> Defaults to `celery`.

- `username`


> User name to authenticate to the ArangoDB server as (optional).

- `password`


> Password to authenticate to the ArangoDB server (optional).

- `http_protocol`


> HTTP Protocol in ArangoDB server connection.
> Defaults to `http`.

- `verify`


> HTTPS Verification check while creating the ArangoDB connection.
> Defaults to `False`.


### [CosmosDB backend settings (experimental)](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id34) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cosmosdb-backend-settings-experimental "Link to this heading")

To use [CosmosDB](https://azure.microsoft.com/en-us/services/cosmos-db/) as the result backend, you simply need to configure the
[`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend) setting with the correct URL.

#### Example configuration [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id10 "Link to this heading")

```
result_backend = 'cosmosdbsql://:{InsertAccountPrimaryKeyHere}@{InsertAccountNameHere}.documents.azure.com'
```

#### `cosmosdbsql_database_name` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cosmosdbsql-database-name "Link to this heading")

Default: celerydb.

The name for the database in which to store the results.

#### `cosmosdbsql_collection_name` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cosmosdbsql-collection-name "Link to this heading")

Default: celerycol.

The name of the collection in which to store the results.

#### `cosmosdbsql_consistency_level` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cosmosdbsql-consistency-level "Link to this heading")

Default: Session.

Represents the consistency levels supported for Azure Cosmos DB client operations.

Consistency levels by order of strength are: Strong, BoundedStaleness, Session, ConsistentPrefix and Eventual.

#### `cosmosdbsql_max_retry_attempts` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cosmosdbsql-max-retry-attempts "Link to this heading")

Default: 9.

Maximum number of retries to be performed for a request.

#### `cosmosdbsql_max_retry_wait_time` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#cosmosdbsql-max-retry-wait-time "Link to this heading")

Default: 30.

Maximum wait time in seconds to wait for a request while the retries are happening.

### [CouchDB backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id35) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#couchdb-backend-settings "Link to this heading")

Note

The CouchDB backend requires the [https://pypi.org/project/pycouchdb/](https://pypi.org/project/pycouchdb/) library:

To install this Couchbase package use **pip**:

```
$ pip install celery[couchdb]
```

See [Bundles](https://docs.celeryq.dev/en/stable/getting-started/introduction.html#bundles) for information on combining multiple extension
requirements.

This backend can be configured via the [`result_backend`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-result_backend)
set to a CouchDB URL:

```
result_backend = 'couchdb://username:password@host:port/container'
```

The URL is formed out of the following parts:

- `username`


> User name to authenticate to the CouchDB server as (optional).

- `password`


> Password to authenticate to the CouchDB server (optional).

- `host`


> Host name of the CouchDB server. Defaults to `localhost`.

- `port`


> The port the CouchDB server is listening to. Defaults to `8091`.

- `container`


> The default container the CouchDB server is writing to.
> Defaults to `default`.


### [File-system backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id36) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#file-system-backend-settings "Link to this heading")

This backend can be configured using a file URL, for example:

```
CELERY_RESULT_BACKEND = 'file:///var/celery/results'
```

The configured directory needs to be shared and writable by all servers using
the backend.

If you’re trying Celery on a single system you can simply use the backend
without any further configuration. For larger clusters you could use NFS,
[GlusterFS](http://www.gluster.org/), CIFS, [HDFS](http://hadoop.apache.org/) (using FUSE), or any other file-system.

### [Consul K/V store backend settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id37) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#consul-k-v-store-backend-settings "Link to this heading")

Note

The Consul backend requires the [https://pypi.org/project/python-consul2/](https://pypi.org/project/python-consul2/) library:

To install this package use **pip**:

```
$ pip install python-consul2
```

The Consul backend can be configured using a URL, for example:

```
CELERY_RESULT_BACKEND = 'consul://localhost:8500/'
```

or:

```
result_backend = 'consul://localhost:8500/'
```

The backend will store results in the K/V store of Consul
as individual keys. The backend supports auto expire of results using TTLs in
Consul. The full syntax of the URL is:

```
consul://host:port[?one_client=1]
```

The URL is formed out of the following parts:

- `host`


> Host name of the Consul server.

- `port`


> The port the Consul server is listening to.

- `one_client`


> By default, for correctness, the backend uses a separate client connection
> per operation. In cases of extreme load, the rate of creation of new
> connections can cause HTTP 429 “too many connections” error responses from
> the Consul server when under load. The recommended way to handle this is to
> enable retries in `python-consul2` using the patch at
> [https://github.com/poppyred/python-consul2/pull/31](https://github.com/poppyred/python-consul2/pull/31).
>
> Alternatively, if `one_client` is set, a single client connection will be
> used for all operations instead. This should eliminate the HTTP 429 errors,
> but the storage of results in the backend can become unreliable.


### [Message Routing](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id38) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#message-routing "Link to this heading")

#### `task_queues` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-queues "Link to this heading")

Default: `None` (queue taken from default queue settings).

Most users will not want to specify this setting and should rather use
the [automatic routing facilities](https://docs.celeryq.dev/en/stable/userguide/routing.html#routing-automatic).

If you really want to configure advanced routing, this setting should
be a list of [`kombu.Queue`](https://docs.celeryq.dev/projects/kombu/en/main/reference/kombu.html#kombu.Queue "(in Kombu v5.6)") objects the worker will consume from.

Note that workers can be overridden this setting via the
[`-Q`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-Q) option, or individual queues from this
list (by name) can be excluded using the [`-X`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-X)
option.

Also see [Basics](https://docs.celeryq.dev/en/stable/userguide/routing.html#routing-basics) for more information.

The default is a queue/exchange/binding key of `celery`, with
exchange type `direct`.

See also [`task_routes`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_routes)

#### `task_routes` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-routes "Link to this heading")

Default: `None`.

A list of routers, or a single router used to route tasks to queues.
When deciding the final destination of a task the routers are consulted
in order.

A router can be specified as either:

- A function with the signature `(name, args, kwargs,
options, task=None, **kwargs)`

- A string providing the path to a router function.

- A dict containing router specification:

Will be converted to a `celery.routes.MapRoute` instance.

- A list of `(pattern, route)` tuples:

Will be converted to a `celery.routes.MapRoute` instance.


Examples:

```
task_routes = {
    'celery.ping': 'default',
    'mytasks.add': 'cpu-bound',
    'feed.tasks.*': 'feeds',                           # <-- glob pattern
    re.compile(r'(image|video)\.tasks\..*'): 'media',  # <-- regex
    'video.encode': {
        'queue': 'video',
        'exchange': 'media',
        'routing_key': 'media.video.encode',
    },
}

task_routes = ('myapp.tasks.route_task', {'celery.ping': 'default'})
```

Where `myapp.tasks.route_task` could be:

```
def route_task(self, name, args, kwargs, options, task=None, **kw):
    if task == 'celery.ping':
        return {'queue': 'default'}
```

`route_task` may return a string or a dict. A string then means
it’s a queue name in [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues), a dict means it’s a custom route.

When sending tasks, the routers are consulted in order. The first
router that doesn’t return `None` is the route to use. The message options
is then merged with the found route settings, where the task’s settings
have priority.

Example if `apply_async()` has these arguments:

```
Task.apply_async(immediate=False, exchange='video',
                 routing_key='video.compress')
```

and a router returns:

```
{'immediate': True, 'exchange': 'urgent'}
```

the final message options will be:

```
immediate=False, exchange='video', routing_key='video.compress'
```

(and any default message options defined in the
[`Task`](https://docs.celeryq.dev/en/stable/reference/celery.app.task.html#celery.app.task.Task "celery.app.task.Task") class)

Values defined in [`task_routes`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_routes) have precedence over values defined in
[`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) when merging the two.

With the follow settings:

```
task_queues = {
    'cpubound': {
        'exchange': 'cpubound',
        'routing_key': 'cpubound',
    },
}

task_routes = {
    'tasks.add': {
        'queue': 'cpubound',
        'routing_key': 'tasks.add',
        'serializer': 'json',
    },
}
```

The final routing options for `tasks.add` will become:

```
{'exchange': 'cpubound',
 'routing_key': 'tasks.add',
 'serializer': 'json'}
```

See [Routers](https://docs.celeryq.dev/en/stable/userguide/routing.html#routers) for more examples.

#### `task_queue_max_priority` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-queue-max-priority "Link to this heading")

brokers:

RabbitMQ

Default: `None`.

See [RabbitMQ Message Priorities](https://docs.celeryq.dev/en/stable/userguide/routing.html#routing-options-rabbitmq-priorities).

#### `task_default_priority` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-default-priority "Link to this heading")

brokers:

RabbitMQ, Redis

Default: `None`.

See [RabbitMQ Message Priorities](https://docs.celeryq.dev/en/stable/userguide/routing.html#routing-options-rabbitmq-priorities).

#### `task_inherit_parent_priority` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-inherit-parent-priority "Link to this heading")

brokers:

RabbitMQ

Default: `False`.

If enabled, child tasks will inherit priority of the parent task.

```
# The last task in chain will also have priority set to 5.
chain = celery.chain(add.s(2) | add.s(2).set(priority=5) | add.s(3))
```

Priority inheritance also works when calling child tasks from a parent task
with delay or apply\_async.

See [RabbitMQ Message Priorities](https://docs.celeryq.dev/en/stable/userguide/routing.html#routing-options-rabbitmq-priorities).

#### `worker_direct` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-direct "Link to this heading")

Default: Disabled.

This option enables so that every worker has a dedicated queue,
so that tasks can be routed to specific workers.

The queue name for each worker is automatically generated based on
the worker hostname and a `.dq` suffix, using the `C.dq2` exchange.

For example the queue name for the worker with node name `w1@example.com`
becomes:

```
w1@example.com.dq
```

Then you can route the task to the worker by specifying the hostname
as the routing key and the `C.dq2` exchange:

```
task_routes = {
    'tasks.add': {'exchange': 'C.dq2', 'routing_key': 'w1@example.com'}
}
```

#### `task_create_missing_queues` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-create-missing-queues "Link to this heading")

Default: Enabled.

If enabled (default), any queues specified that aren’t defined in
[`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) will be automatically created. See
[Automatic routing](https://docs.celeryq.dev/en/stable/userguide/routing.html#routing-automatic).

#### `task_create_missing_queue_type` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-create-missing-queue-type "Link to this heading")

Added in version 5.6.

Default: `"classic"`

When Celery needs to declare a queue that doesn’t exist (i.e., when
`task_create_missing_queues` is enabled), this setting defines what type
of RabbitMQ queue to create.

- `"classic"` (default): declares a standard classic queue.

- `"quorum"`: declares a RabbitMQ quorum queue (adds `x-queue-type: quorum`).


#### `task_create_missing_queue_exchange_type` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-create-missing-queue-exchange-type "Link to this heading")

Added in version 5.6.

Default: `None`

If this option is None or the empty string (the default), Celery leaves the
exchange exactly as returned by your `app.amqp.Queues.autoexchange`
hook.

You can set this to a specific exchange type, such as `"direct"`, `"topic"`, or
`"fanout"`, to create the missing queue with that exchange type.

Combine this setting with task\_create\_missing\_queue\_type = “quorum”
to create quorum queues bound to a topic exchange, for example:

```
app.conf.task_create_missing_queues=True
app.conf.task_create_missing_queue_type="quorum"
app.conf.task_create_missing_queue_exchange_type="topic"
```

Like the queue-type setting above, this option does not affect queues
that you define explicitly in [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues); it applies only to
queues created implicitly at runtime.

#### `task_default_queue` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-default-queue "Link to this heading")

Default: `"celery"`.

The name of the default queue used by .apply\_async if the message has
no route or no custom queue has been specified.

This queue must be listed in [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues).
If [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) isn’t specified then it’s automatically
created containing one queue entry, where this name is used as the name of
that queue.

See also

[Changing the name of the default queue](https://docs.celeryq.dev/en/stable/userguide/routing.html#routing-changing-default-queue)

#### `task_default_queue_type` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-default-queue-type "Link to this heading")

Added in version 5.5.

Default: `"classic"`.

This setting is used to allow changing the default queue type for the
[`task_default_queue`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_default_queue) queue. The other viable option is `"quorum"` which
is only supported by RabbitMQ and sets the queue type to `quorum` using the `x-queue-type`
queue argument.

If the [`worker_detect_quorum_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_detect_quorum_queues) setting is enabled, the worker will
automatically detect the queue type and disable the global QoS accordingly.

Warning

Quorum queues require confirm publish to be enabled.
Use [`broker_transport_options`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_transport_options) to enable confirm publish by setting:

```
broker_transport_options = {"confirm_publish": True}
```

For more information, see [RabbitMQ documentation](https://www.rabbitmq.com/docs/quorum-queues#use-cases).

#### `task_default_exchange` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-default-exchange "Link to this heading")

Default: Uses the value set for [`task_default_queue`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_default_queue).

Name of the default exchange to use when no custom exchange is
specified for a key in the [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) setting.

#### `task_default_exchange_type` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-default-exchange-type "Link to this heading")

Default: `"direct"`.

Default exchange type used when no custom exchange type is specified
for a key in the [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) setting.

#### `task_default_routing_key` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-default-routing-key "Link to this heading")

Default: Uses the value set for [`task_default_queue`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_default_queue).

The default routing key used when no custom routing key
is specified for a key in the [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) setting.

#### `task_default_delivery_mode` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-default-delivery-mode "Link to this heading")

Default: `"persistent"`.

Can be transient (messages not written to disk) or persistent (written to
disk).

### [Broker Settings](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id39) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-settings "Link to this heading")

#### `broker_url` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-url "Link to this heading")

Default: `"amqp://"`

Default broker URL. This must be a URL in the form of:

```
transport://userid:password@hostname:port/virtual_host
```

Only the scheme part (`transport://`) is required, the rest
is optional, and defaults to the specific transports default values.

The transport part is the broker implementation to use, and the
default is `amqp`, (uses `librabbitmq` if installed or falls back to
`pyamqp`). There are also other choices available, including;
`redis://`, `sqs://`, and `qpid://`.

The scheme can also be a fully qualified path to your own transport
implementation:

```
broker_url = 'proj.transports.MyTransport://localhost'
```

More than one broker URL, of the same transport, can also be specified.
The broker URLs can be passed in as a single string that’s semicolon delimited:

```
broker_url = 'transport://userid:password@hostname:port//;transport://userid:password@hostname:port//'
```

Or as a list:

```
broker_url = [\
    'transport://userid:password@localhost:port//',\
    'transport://userid:password@hostname:port//'\
]
```

The brokers will then be used in the [`broker_failover_strategy`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_failover_strategy).

See [Celery with SQS](https://docs.celeryq.dev/projects/kombu/en/main/userguide/connections.html#connection-urls "(in Kombu v5.6)") in the Kombu documentation for more
information.

#### `broker_read_url` / `broker_write_url` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-read-url-broker-write-url "Link to this heading")

Default: Taken from [`broker_url`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_url).

These settings can be configured, instead of [`broker_url`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_url) to specify
different connection parameters for broker connections used for consuming and
producing.

Example:

```
broker_read_url = 'amqp://user:pass@broker.example.com:56721'
broker_write_url = 'amqp://user:pass@broker.example.com:56722'
```

Both options can also be specified as a list for failover alternates, see
[`broker_url`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_url) for more information.

#### `broker_failover_strategy` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-failover-strategy "Link to this heading")

Default: `"round-robin"`.

Default failover strategy for the broker Connection object. If supplied,
may map to a key in ‘kombu.connection.failover\_strategies’, or be a reference
to any method that yields a single item from a supplied list.

Example:

```
# Random failover strategy
def random_failover_strategy(servers):
    it = list(servers)  # don't modify callers list
    shuffle = random.shuffle
    for _ in repeat(None):
        shuffle(it)
        yield it[0]

broker_failover_strategy = random_failover_strategy
```

#### `broker_heartbeat` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-heartbeat "Link to this heading")

transports supported:

`pyamqp`

Default: `120.0` (negotiated by server).

Note: This value is only used by the worker, clients do not use
a heartbeat at the moment.

It’s not always possible to detect connection loss in a timely
manner using TCP/IP alone, so AMQP defines something called heartbeats
that’s is used both by the client and the broker to detect if
a connection was closed.

If the heartbeat value is 10 seconds, then
the heartbeat will be monitored at the interval specified
by the [`broker_heartbeat_checkrate`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_heartbeat_checkrate) setting (by default
this is set to double the rate of the heartbeat value,
so for the 10 seconds, the heartbeat is checked every 5 seconds).

#### `broker_heartbeat_checkrate` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-heartbeat-checkrate "Link to this heading")

transports supported:

`pyamqp`

Default: 2.0.

At intervals the worker will monitor that the broker hasn’t missed
too many heartbeats. The rate at which this is checked is calculated
by dividing the [`broker_heartbeat`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_heartbeat) value with this value,
so if the heartbeat is 10.0 and the rate is the default 2.0, the check
will be performed every 5 seconds (twice the heartbeat sending rate).

#### `broker_use_ssl` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-use-ssl "Link to this heading")

transports supported:

`pyamqp`, `redis`

Default: Disabled.

Toggles SSL usage on broker connection and SSL settings.

The valid values for this option vary by transport.

##### `pyamqp` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#pyamqp "Link to this heading")

If `True` the connection will use SSL with default SSL settings.
If set to a dict, will configure SSL connection according to the specified
policy. The format used is Python’s `ssl.wrap_socket()` options.

Note that SSL socket is generally served on a separate port by the broker.

Example providing a client cert and validating the server cert against a custom
certificate authority:

```
import ssl

broker_use_ssl = {
  'keyfile': '/var/ssl/private/worker-key.pem',
  'certfile': '/var/ssl/amqp-server-cert.pem',
  'ca_certs': '/var/ssl/myca.pem',
  'cert_reqs': ssl.CERT_REQUIRED
}
```

Added in version 5.1: Starting from Celery 5.1, py-amqp will always validate certificates received from the server
and it is no longer required to manually set `cert_reqs` to `ssl.CERT_REQUIRED`.

The previous default, `ssl.CERT_NONE` is insecure and we its usage should be discouraged.
If you’d like to revert to the previous insecure default set `cert_reqs` to `ssl.CERT_NONE`

##### `redis` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id11 "Link to this heading")

The setting must be a dict with the following keys:

- `ssl_cert_reqs` (required): one of the `SSLContext.verify_mode` values:

  - `ssl.CERT_NONE`

  - `ssl.CERT_OPTIONAL`

  - `ssl.CERT_REQUIRED`


- `ssl_ca_certs` (optional): path to the CA certificate

- `ssl_certfile` (optional): path to the client certificate

- `ssl_keyfile` (optional): path to the client key


#### `broker_pool_limit` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-pool-limit "Link to this heading")

Added in version 2.3.

Default: 10.

The maximum number of connections that can be open in the connection pool.

The pool is enabled by default since version 2.5, with a default limit of ten
connections. This number can be tweaked depending on the number of
threads/green-threads (eventlet/gevent) using a connection. For example
running eventlet with 1000 greenlets that use a connection to the broker,
contention can arise and you should consider increasing the limit.

If set to `None` or 0 the connection pool will be disabled and
connections will be established and closed for every use.

#### `broker_connection_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-connection-timeout "Link to this heading")

Default: 4.0.

The default timeout in seconds before we give up establishing a connection
to the AMQP server. This setting is disabled when using
gevent.

Note

The broker connection timeout only applies to a worker attempting to
connect to the broker. It does not apply to producer sending a task, see
[`broker_transport_options`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_transport_options) for how to provide a timeout for that
situation.

#### `broker_connection_retry` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-connection-retry "Link to this heading")

Default: Enabled.

Automatically try to re-establish the connection to the AMQP broker if lost
after the initial connection is made.

The time between retries is increased for each retry, and is
not exhausted before [`broker_connection_max_retries`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_connection_max_retries) is
exceeded.

Warning

The broker\_connection\_retry configuration setting will no longer determine
whether broker connection retries are made during startup in Celery 6.0 and above.
If you wish to refrain from retrying connections on startup,
you should set broker\_connection\_retry\_on\_startup to False instead.

#### `broker_connection_retry_on_startup` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-connection-retry-on-startup "Link to this heading")

Default: Enabled.

Automatically try to establish the connection to the AMQP broker on Celery startup if it is unavailable.

The time between retries is increased for each retry, and is
not exhausted before [`broker_connection_max_retries`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_connection_max_retries) is
exceeded.

#### `broker_connection_max_retries` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-connection-max-retries "Link to this heading")

Default: 100.

Maximum number of retries before we give up re-establishing a connection
to the AMQP broker.

If this is set to `None`, we’ll retry forever.

#### `broker_channel_error_retry` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-channel-error-retry "Link to this heading")

Added in version 5.3.

Default: Disabled.

Automatically try to re-establish the connection to the AMQP broker
if any invalid response has been returned.

The retry count and interval is the same as that of broker\_connection\_retry.
Also, this option doesn’t work when broker\_connection\_retry is False.

#### `broker_login_method` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-login-method "Link to this heading")

Default: `"AMQPLAIN"`.

Set custom amqp login method.

#### `broker_native_delayed_delivery_queue_type` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-native-delayed-delivery-queue-type "Link to this heading")

Added in version 5.5.

transports supported:

`pyamqp`

Default: `"quorum"`.

This setting is used to allow changing the default queue type for the
native delayed delivery queues. The other viable option is `"classic"` which
is only supported by RabbitMQ and sets the queue type to `classic` using the `x-queue-type`
queue argument.

#### `broker_transport_options` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#broker-transport-options "Link to this heading")

Added in version 2.2.

Default: `{}` (empty mapping).

A dict of additional options passed to the underlying transport.

See your transport user manual for supported options (if any).

Example setting the visibility timeout (supported by Redis and SQS
transports):

```
broker_transport_options = {'visibility_timeout': 18000}  # 5 hours
```

Example setting the producer connection maximum number of retries (so producers
won’t retry forever if the broker isn’t available at the first task execution):

```
broker_transport_options = {'max_retries': 5}
```

Example enabling publisher confirms (supported by the `pyamqp` transport).
Without this, messages can be silently dropped when the broker hits resource
limits:

```
broker_transport_options = {'confirm_publish': True}
```

### [Worker](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id40) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker "Link to this heading")

#### `imports` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#imports "Link to this heading")

Default: `[]` (empty list).

A sequence of modules to import when the worker starts.

This is used to specify the task modules to import, but also
to import signal handlers and additional remote control commands, etc.

The modules will be imported in the original order.

#### `include` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#include "Link to this heading")

Default: `[]` (empty list).

Exact same semantics as [`imports`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-imports), but can be used as a means
to have different import categories.

The modules in this setting are imported after the modules in
[`imports`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-imports).

#### `worker_deduplicate_successful_tasks` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-deduplicate-successful-tasks "Link to this heading")

Added in version 5.1.

Default: False

Before each task execution, instruct the worker to check if this task is
a duplicate message.

Deduplication occurs only with tasks that have the same identifier,
enabled late acknowledgment, were redelivered by the message broker
and their state is `SUCCESS` in the result backend.

To avoid overflowing the result backend with queries, a local cache of
successfully executed tasks is checked before querying the result backend
in case the task was already successfully executed by the same worker that
received the task.

This cache can be made persistent by setting the [`worker_state_db`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_state_db)
setting.

If the result backend is not [persistent](https://github.com/celery/celery/blob/main/celery/backends/base.py#L102)
(the RPC backend, for example), this setting is ignored.

#### `worker_concurrency` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-concurrency "Link to this heading")

Default: Number of CPU cores.

The number of concurrent worker processes/threads/green threads executing
tasks.

If you’re doing mostly I/O you can have more processes,
but if mostly CPU-bound, try to keep it close to the
number of CPUs on your machine. If not set, the number of CPUs/cores
on the host will be used.

#### `worker_prefetch_multiplier` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-prefetch-multiplier "Link to this heading")

Default: 4.

How many messages to prefetch at a time multiplied by the number of
concurrent processes. The default is 4 (four messages for each
process). The default setting is usually a good choice, however – if you
have very long running tasks waiting in the queue and you have to start the
workers, note that the first worker to start will receive four times the
number of messages initially. Thus the tasks may not be fairly distributed
to the workers.

To limit the broker to only deliver one message per process at a time,
set [`worker_prefetch_multiplier`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_prefetch_multiplier) to 1. Changing that setting to 0
will allow the worker to keep consuming as many messages as it wants.

If you need to completely disable broker prefetching while still using
early acknowledgments, enable [`worker_disable_prefetch`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_disable_prefetch).
When this option is enabled the worker only fetches a task from the broker
when one of its processes is available.

Note

This feature is currently only supported when using Redis as the broker.

You can also enable this via the [`--disable-prefetch`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-disable-prefetch)
command line flag.

For more on prefetching, read [Prefetch Limits](https://docs.celeryq.dev/en/stable/userguide/optimizing.html#optimizing-prefetch-limit)

#### `worker_eta_task_limit` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-eta-task-limit "Link to this heading")

Added in version 5.6.

Default: No limit (None).

The maximum number of ETA/countdown tasks that a worker can hold in memory at once.
When this limit is reached, the worker will not receive new tasks from the broker
until some of the existing ETA tasks are executed.

This setting helps prevent memory exhaustion when a queue contains a large number
of tasks with ETA/countdown values, as these tasks are held in memory until their
execution time. Without this limit, workers may fetch thousands of ETA tasks into
memory, potentially causing out-of-memory issues.

Note

Tasks with ETA/countdown are fetched into memory and scheduled on an internal
timer, so they are not constrained by the per-process prefetch window derived
from [`worker_prefetch_multiplier`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_prefetch_multiplier) in the same way as immediately
executed tasks. This is why `--prefetch-multiplier=1` can appear to have no
effect when many ETA/countdown tasks are present.

[`worker_eta_task_limit`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_eta_task_limit) configures the maximum number of ETA/countdown
tasks a worker will hold in memory and also sets an overall cap on
unacknowledged messages via kombu’s QoS `max_prefetch`. If the prefetch count
implied by [`worker_prefetch_multiplier`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_prefetch_multiplier) would exceed this cap, the
worker will stop consuming new messages until previously received tasks have
been acknowledged.

#### `worker_disable_prefetch` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-disable-prefetch "Link to this heading")

Added in version 5.6.

Default: `False`.

When enabled, a worker will only consume messages from the broker when it
has an available process to execute them. This disables prefetching while
still using early acknowledgments, ensuring that tasks are fairly
distributed between workers.

Note

This feature is currently only supported when using Redis as the broker.
Using this setting with other brokers will result in a warning and the
setting will be ignored.

#### `worker_enable_prefetch_count_reduction` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-enable-prefetch-count-reduction "Link to this heading")

Added in version 5.4.

Default: Enabled.

The `worker_enable_prefetch_count_reduction` setting governs the restoration behavior of the
prefetch count to its maximum allowable value following a connection loss to the message
broker. By default, this setting is enabled.

Upon a connection loss, Celery will attempt to reconnect to the broker automatically,
provided the [`broker_connection_retry_on_startup`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_connection_retry_on_startup) or [`broker_connection_retry`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-broker_connection_retry)
is not set to False. During the period of lost connection, the message broker does not keep track
of the number of tasks already fetched. Therefore, to manage the task load effectively and prevent
overloading, Celery reduces the prefetch count based on the number of tasks that are
currently running.

The prefetch count is the number of messages that a worker will fetch from the broker at
a time. The reduced prefetch count helps ensure that tasks are not fetched excessively
during periods of reconnection.

With `worker_enable_prefetch_count_reduction` set to its default value (Enabled), the prefetch
count will be gradually restored to its maximum allowed value each time a task that was
running before the connection was lost is completed. This behavior helps maintain a
balanced distribution of tasks among the workers while managing the load effectively.

To disable the reduction and restoration of the prefetch count to its maximum allowed value on
reconnection, set `worker_enable_prefetch_count_reduction` to False. Disabling this setting might
be useful in scenarios where a fixed prefetch count is desired to control the rate of task
processing or manage the worker load, especially in environments with fluctuating connectivity.

The `worker_enable_prefetch_count_reduction` setting provides a way to control the
restoration behavior of the prefetch count following a connection loss, aiding in
maintaining a balanced task distribution and effective load management across the workers.

#### `worker_lost_wait` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-lost-wait "Link to this heading")

Default: 10.0 seconds.

In some cases a worker may be killed without proper cleanup,
and the worker may have published a result before terminating.
This value specifies how long we wait for any missing results before
raising a [`WorkerLostError`](https://docs.celeryq.dev/en/stable/reference/celery.exceptions.html#celery.exceptions.WorkerLostError "celery.exceptions.WorkerLostError") exception.

#### `worker_max_tasks_per_child` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-max-tasks-per-child "Link to this heading")

Maximum number of tasks a pool worker process can execute before
it’s replaced with a new one. Default is no limit.

#### `worker_max_memory_per_child` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-max-memory-per-child "Link to this heading")

Default: No limit.
Type: int (kilobytes)

Maximum amount of resident memory, in kilobytes (1024 bytes), that may be
consumed by a worker before it will be replaced by a new worker. If a single
task causes a worker to exceed this limit, the task will be completed, and the
worker will be replaced afterwards.

Example:

```
worker_max_memory_per_child = 12288  # 12 * 1024 = 12 MB
```

#### `worker_disable_rate_limits` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-disable-rate-limits "Link to this heading")

Default: Disabled (rate limits enabled).

Disable all rate limits, even if tasks has explicit rate limits set.

#### `worker_state_db` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-state-db "Link to this heading")

Default: `None`.

Name of the file used to stores persistent worker state (like revoked tasks).
Can be a relative or absolute path, but be aware that the suffix .db
may be appended to the file name (depending on Python version).

Can also be set via the [`celery worker --statedb`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-S) argument.

#### `worker_timer_precision` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-timer-precision "Link to this heading")

Default: 1.0 seconds.

Set the maximum time in seconds that the ETA scheduler can sleep between
rechecking the schedule.

Setting this value to 1 second means the schedulers precision will
be 1 second. If you need near millisecond precision you can set this to 0.1.

#### `worker_enable_remote_control` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-enable-remote-control "Link to this heading")

Default: Enabled by default.

Specify if remote control of the workers is enabled.

#### `worker_proc_alive_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-proc-alive-timeout "Link to this heading")

Default: 4.0.

The timeout in seconds (int/float) when waiting for a new worker process to start up.

#### `worker_cancel_long_running_tasks_on_connection_loss` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-cancel-long-running-tasks-on-connection-loss "Link to this heading")

Added in version 5.1.

Default: Disabled by default.

Kill all long-running tasks with late acknowledgment enabled on connection loss.

Tasks which have not been acknowledged before the connection loss cannot do so
anymore since their channel is gone and the task is redelivered back to the queue.
This is why tasks with late acknowledged enabled must be idempotent as they may be executed more than once.
In this case, the task is being executed twice per connection loss (and sometimes in parallel in other workers).

When turning this option on, those tasks which have not been completed are
cancelled and their execution is terminated.
Tasks which have completed in any way before the connection loss
are recorded as such in the result backend as long as [`task_ignore_result`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_ignore_result) is not enabled.

Warning

This feature was introduced as a future breaking change.
If it is turned off, Celery will emit a warning message.

In Celery 6.0, the [`worker_cancel_long_running_tasks_on_connection_loss`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_cancel_long_running_tasks_on_connection_loss)
will be set to `True` by default as the current behavior leads to more
problems than it solves.

#### `worker_detect_quorum_queues` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-detect-quorum-queues "Link to this heading")

Added in version 5.5.

Default: Enabled.

Automatically detect if any of the queues in [`task_queues`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_queues) are quorum queues
(including the [`task_default_queue`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-task_default_queue)) and disable the global QoS if any quorum queue is detected.

#### `worker_soft_shutdown_timeout` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-soft-shutdown-timeout "Link to this heading")

Added in version 5.5.

Default: 0.0.

The standard [warm shutdown](https://docs.celeryq.dev/en/stable/userguide/workers.html#worker-warm-shutdown) will wait for all tasks to finish before shutting down
unless the cold shutdown is triggered. The [soft shutdown](https://docs.celeryq.dev/en/stable/userguide/workers.html#worker-soft-shutdown) will add a waiting time
before the cold shutdown is initiated. This setting specifies how long the worker will wait before the cold shutdown
is initiated and the worker is terminated.

This will apply also when the worker initiate [cold shutdown](https://docs.celeryq.dev/en/stable/userguide/workers.html#worker-cold-shutdown) without doing a warm shutdown first.

If the value is set to 0.0, the soft shutdown will be practically disabled. Regardless of the value, the soft shutdown
will be disabled if there are no tasks running (unless [`worker_enable_soft_shutdown_on_idle`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_enable_soft_shutdown_on_idle) is enabled).

Experiment with this value to find the optimal time for your tasks to finish gracefully before the worker is terminated.
Recommended values can be 10, 30, 60 seconds. Too high value can lead to a long waiting time before the worker is terminated
and trigger a `KILL` signal to forcefully terminate the worker by the host system.

#### `worker_enable_soft_shutdown_on_idle` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-enable-soft-shutdown-on-idle "Link to this heading")

Added in version 5.5.

Default: False.

If the [`worker_soft_shutdown_timeout`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_soft_shutdown_timeout) is set to a value greater than 0.0, the worker will skip
the [soft shutdown](https://docs.celeryq.dev/en/stable/userguide/workers.html#worker-soft-shutdown) anyways if there are no tasks running. This setting will
enable the soft shutdown even if there are no tasks running.

Tip

When the worker received ETA tasks, but the ETA has not been reached yet, and a shutdown is initiated,
the worker will **skip** the soft shutdown and initiate the cold shutdown immediately if there are no
tasks running. This may lead to failure in re-queueing the ETA tasks during worker teardown. To mitigate
this, enable this configuration to ensure the worker waits regadless, which gives enough time for a
graceful shutdown and successful re-queueing of the ETA tasks.

### [Events](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id41) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#events "Link to this heading")

#### `worker_send_task_events` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-send-task-events "Link to this heading")

Default: Disabled by default.

Send task-related events so that tasks can be monitored using tools like
flower. Sets the default value for the workers
[`-E`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-E) argument.

#### `task_send_sent_event` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#task-send-sent-event "Link to this heading")

Added in version 2.2.

Default: Disabled by default.

If enabled, a [`task-sent`](https://docs.celeryq.dev/en/stable/userguide/monitoring.html#std-event-task-sent) event will be sent for every task so tasks can be
tracked before they’re consumed by a worker.

#### `event_queue_ttl` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#event-queue-ttl "Link to this heading")

transports supported:

`amqp`

Default: 5.0 seconds.

Message expiry time in seconds (int/float) for when messages sent to a monitor clients
event queue is deleted (`x-message-ttl`)

For example, if this value is set to 10 then a message delivered to this queue
will be deleted after 10 seconds.

#### `event_queue_expires` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#event-queue-expires "Link to this heading")

transports supported:

`amqp`

Default: 60.0 seconds.

Expiry time in seconds (int/float) for when after a monitor clients
event queue will be deleted (`x-expires`).

#### `event_queue_durable` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#event-queue-durable "Link to this heading")

transports supported:

`amqp`

Added in version 5.6.

Default: `False`

If enabled, the event receiver’s queue will be marked as _durable_, meaning it will survive broker restarts.

#### `event_queue_exclusive` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#event-queue-exclusive "Link to this heading")

transports supported:

`amqp`

Added in version 5.6.

Default: `False`

If enabled, the event queue will be _exclusive_ to the current connection and automatically deleted when the connection closes.

Warning

You **cannot** set both `event_queue_durable` and `event_queue_exclusive` to `True` at the same time.
Celery will raise an `ImproperlyConfigured` error if both are set.

#### `event_queue_prefix` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#event-queue-prefix "Link to this heading")

Default: `"celeryev"`.

The prefix to use for event receiver queue names.

#### `event_exchange` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#event-exchange "Link to this heading")

Default: `"celeryev"`.

Name of the event exchange.

Warning

This option is in experimental stage, please use it with caution.

#### `event_serializer` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#event-serializer "Link to this heading")

Default: `"json"`.

Message serialization format used when sending event messages.

See also

[Serializers](https://docs.celeryq.dev/en/stable/userguide/calling.html#calling-serializers).

#### `events_logfile` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#events-logfile "Link to this heading")

Added in version 5.4.

Default: `None`

An optional file path for **celery events** to log into (defaults to stdout).

#### `events_pidfile` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#events-pidfile "Link to this heading")

Added in version 5.4.

Default: `None`

An optional file path for **celery events** to create/store its PID file (default to no PID file created).

#### `events_uid` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#events-uid "Link to this heading")

Added in version 5.4.

Default: `None`

An optional user ID to use when events **celery events** drops its privileges (defaults to no UID change).

#### `events_gid` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#events-gid "Link to this heading")

Added in version 5.4.

Default: `None`

An optional group ID to use when **celery events** daemon drops its privileges (defaults to no GID change).

#### `events_umask` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#events-umask "Link to this heading")

Added in version 5.4.

Default: `None`

An optional umask to use when **celery events** creates files (log, pid…) when daemonizing.

#### `events_executable` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#events-executable "Link to this heading")

Added in version 5.4.

Default: `None`

An optional python executable path for **celery events** to use when deaemonizing (defaults to [`sys.executable`](https://docs.python.org/dev/library/sys.html#sys.executable "(in Python v3.15)")).

### [Remote Control Commands](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id42) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#remote-control-commands "Link to this heading")

Note

To disable remote control commands see
the [`worker_enable_remote_control`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-worker_enable_remote_control) setting.

#### `control_queue_ttl` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#control-queue-ttl "Link to this heading")

Default: 300.0

Time in seconds, before a message in a remote control command queue
will expire.

If using the default of 300 seconds, this means that if a remote control
command is sent and no worker picks it up within 300 seconds, the command
is discarded.

This setting also applies to remote control reply queues.

#### `control_queue_expires` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#control-queue-expires "Link to this heading")

Default: 10.0

Time in seconds, before an unused remote control command queue is deleted
from the broker.

This setting also applies to remote control reply queues.

#### `control_exchange` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#control-exchange "Link to this heading")

Default: `"celery"`.

Name of the control command exchange.

Warning

This option is in experimental stage, please use it with caution.

### [`control_queue_durable`](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id43) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#control-queue-durable "Link to this heading")

- **Default:**`False`

- **Type:**`bool`


If set to `True`, the control exchange and queue will be durable — they will survive broker restarts.

### [`control_queue_exclusive`](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id44) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#control-queue-exclusive "Link to this heading")

- **Default:**`False`

- **Type:**`bool`


If set to `True`, the control queue will be exclusive to a single connection. This is generally not recommended in distributed environments.

Warning

Setting both `control_queue_durable` and `control_queue_exclusive` to `True` is not supported and will raise an error.

### [Logging](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id45) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#logging "Link to this heading")

#### `worker_hijack_root_logger` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-hijack-root-logger "Link to this heading")

Added in version 2.2.

Default: Enabled by default (hijack root logger).

By default any previously configured handlers on the root logger will be
removed. If you want to customize your own logging handlers, then you
can disable this behavior by setting
worker\_hijack\_root\_logger = False.

Note

Logging can also be customized by connecting to the
`celery.signals.setup_logging` signal.

#### `worker_log_color` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-log-color "Link to this heading")

Default: Enabled if app is logging to a terminal.

Enables/disables colors in logging output by the Celery apps.

#### `worker_log_format` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-log-format "Link to this heading")

Default:

```
"[%(asctime)s: %(levelname)s/%(processName)s] %(message)s"
```

The format to use for log messages.

See the Python [`logging`](https://docs.python.org/dev/library/logging.html#module-logging "(in Python v3.15)") module for more information about log
formats.

#### `worker_task_log_format` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-task-log-format "Link to this heading")

Default:

```
"[%(asctime)s: %(levelname)s/%(processName)s]
    %(task_name)s[%(task_id)s]: %(message)s"
```

The format to use for log messages logged in tasks.

See the Python [`logging`](https://docs.python.org/dev/library/logging.html#module-logging "(in Python v3.15)") module for more information about log
formats.

#### `worker_redirect_stdouts` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-redirect-stdouts "Link to this heading")

Default: Enabled by default.

If enabled stdout and stderr will be redirected
to the current logger.

Used by **celery worker** and **celery beat**.

#### `worker_redirect_stdouts_level` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-redirect-stdouts-level "Link to this heading")

Default: `WARNING`.

The log level output to stdout and stderr is logged as.
Can be one of `DEBUG`, `INFO`, `WARNING`,
`ERROR`, or `CRITICAL`.

### [Security](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id46) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#security "Link to this heading")

#### `security_key` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#security-key "Link to this heading")

Default: `None`.

Added in version 2.5.

The relative or absolute path to a file containing the private key
used to sign messages when [Message Signing](https://docs.celeryq.dev/en/stable/userguide/security.html#message-signing) is used.

#### `security_key_password` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#security-key-password "Link to this heading")

Default: `None`.

Added in version 5.3.0.

The password used to decrypt the private key when [Message Signing](https://docs.celeryq.dev/en/stable/userguide/security.html#message-signing)
is used.

#### `security_certificate` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#security-certificate "Link to this heading")

Default: `None`.

Added in version 2.5.

The relative or absolute path to an X.509 certificate file
used to sign messages when [Message Signing](https://docs.celeryq.dev/en/stable/userguide/security.html#message-signing) is used.

#### `security_cert_store` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#security-cert-store "Link to this heading")

Default: `None`.

Added in version 2.5.

The directory containing X.509 certificates used for
[Message Signing](https://docs.celeryq.dev/en/stable/userguide/security.html#message-signing). Can be a glob with wild-cards,
(for example `/etc/certs/*.pem`).

#### `security_digest` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#security-digest "Link to this heading")

Default: `sha256`.

Added in version 4.3.

A cryptography digest used to sign messages
when [Message Signing](https://docs.celeryq.dev/en/stable/userguide/security.html#message-signing) is used.
[https://cryptography.io/en/latest/hazmat/primitives/cryptographic-hashes/#module-cryptography.hazmat.primitives.hashes](https://cryptography.io/en/latest/hazmat/primitives/cryptographic-hashes/#module-cryptography.hazmat.primitives.hashes)

### [Custom Component Classes (advanced)](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id47) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#custom-component-classes-advanced "Link to this heading")

#### `worker_pool` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-pool "Link to this heading")

Default: `"prefork"` (`celery.concurrency.prefork:TaskPool`).

Name of the pool class used by the worker.

Eventlet/Gevent

Never use this option to select the eventlet or gevent pool.
You must use the [`-P`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-P) option to
**celery worker** instead, to ensure the monkey patches
aren’t applied too late, causing things to break in strange ways.

#### `worker_pool_restarts` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-pool-restarts "Link to this heading")

Default: Disabled by default.

If enabled the worker pool can be restarted using the
`pool_restart` remote control command.

#### `worker_autoscaler` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-autoscaler "Link to this heading")

Added in version 2.2.

Default: `"celery.worker.autoscale:Autoscaler"`.

Name of the autoscaler class to use.

#### `worker_consumer` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-consumer "Link to this heading")

Default: `"celery.worker.consumer:Consumer"`.

Name of the consumer class used by the worker.

#### `worker_timer` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-timer "Link to this heading")

Default: `"kombu.asynchronous.hub.timer:Timer"`.

Name of the ETA scheduler class used by the worker.
Default is or set by the pool implementation.

#### `worker_logfile` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-logfile "Link to this heading")

Added in version 5.4.

Default: `None`

An optional file path for **celery worker** to log into (defaults to stdout).

#### `worker_pidfile` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-pidfile "Link to this heading")

Added in version 5.4.

Default: `None`

An optional file path for **celery worker** to create/store its PID file (defaults to no PID file created).

#### `worker_uid` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-uid "Link to this heading")

Added in version 5.4.

Default: `None`

An optional user ID to use when **celery worker** daemon drops its privileges (defaults to no UID change).

#### `worker_gid` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-gid "Link to this heading")

Added in version 5.4.

Default: `None`

An optional group ID to use when **celery worker** daemon drops its privileges (defaults to no GID change).

#### `worker_umask` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-umask "Link to this heading")

Added in version 5.4.

Default: `None`

An optional umask to use when **celery worker** creates files (log, pid…) when daemonizing.

#### `worker_executable` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#worker-executable "Link to this heading")

Added in version 5.4.

Default: `None`

An optional python executable path for **celery worker** to use when deaemonizing (defaults to [`sys.executable`](https://docs.python.org/dev/library/sys.html#sys.executable "(in Python v3.15)")).

### [Beat Settings ( **celery beat**)](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#id48) [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-settings-celery-beat "Link to this heading")

#### `beat_schedule` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-schedule "Link to this heading")

Default: `{}` (empty mapping).

The periodic task schedule used by [`beat`](https://docs.celeryq.dev/en/stable/reference/celery.bin.beat.html#module-celery.bin.beat "celery.bin.beat").
See [Entries](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#beat-entries).

#### `beat_scheduler` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-scheduler "Link to this heading")

Default: `"celery.beat:PersistentScheduler"`.

The default scheduler class. May be set to
`"django_celery_beat.schedulers:DatabaseScheduler"` for instance,
if used alongside [https://pypi.org/project/django-celery-beat/](https://pypi.org/project/django-celery-beat/) extension.

Can also be set via the [`celery beat -S`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-beat-S) argument.

#### `beat_schedule_filename` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-schedule-filename "Link to this heading")

Default: `"celerybeat-schedule"`.

Name of the file used by PersistentScheduler to store the last run times
of periodic tasks. Can be a relative or absolute path, but be aware that the
suffix .db may be appended to the file name (depending on Python version).

Can also be set via the [`celery beat --schedule`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-beat-s) argument.

#### `beat_sync_every` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-sync-every "Link to this heading")

Default: 0.

The number of periodic tasks that can be called before another database sync
is issued.
A value of 0 (default) means sync based on timing - default of 3 minutes as determined by
scheduler.sync\_every. If set to 1, beat will call sync after every task
message sent.

#### `beat_max_loop_interval` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-max-loop-interval "Link to this heading")

Default: 0.

The maximum number of seconds [`beat`](https://docs.celeryq.dev/en/stable/reference/celery.bin.beat.html#module-celery.bin.beat "celery.bin.beat") can sleep
between checking the schedule.

The default for this value is scheduler specific.
For the default Celery beat scheduler the value is 300 (5 minutes),
but for the [https://pypi.org/project/django-celery-beat/](https://pypi.org/project/django-celery-beat/) database scheduler it’s 5 seconds
because the schedule may be changed externally, and so it must take
changes to the schedule into account.

Also when running Celery beat embedded ( [`-B`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-B))
on Jython as a thread the max interval is overridden and set to 1 so
that it’s possible to shut down in a timely manner.

#### `beat_cron_starting_deadline` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-cron-starting-deadline "Link to this heading")

Added in version 5.3.

Default: None.

When using cron, the number of seconds [`beat`](https://docs.celeryq.dev/en/stable/reference/celery.bin.beat.html#module-celery.bin.beat "celery.bin.beat") can look back
when deciding whether a cron schedule is due. When set to None, cronjobs that
are past due will always run immediately.

Warning

Setting this higher than 3600 (1 hour) is highly discouraged.

#### `beat_logfile` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-logfile "Link to this heading")

Added in version 5.4.

Default: `None`

An optional file path for **celery beat** to log into (defaults to stdout).

#### `beat_pidfile` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-pidfile "Link to this heading")

Added in version 5.4.

Default: `None`

An optional file path for **celery beat** to create/store it PID file (defaults to no PID file created).

#### `beat_uid` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-uid "Link to this heading")

Added in version 5.4.

Default: `None`

An optional user ID to use when beat **celery beat** drops its privileges (defaults to no UID change).

#### `beat_gid` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-gid "Link to this heading")

Added in version 5.4.

Default: `None`

An optional group ID to use when **celery beat** daemon drops its privileges (defaults to no GID change).

#### `beat_umask` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-umask "Link to this heading")

Added in version 5.4.

Default: `None`

An optional umask to use when **celery beat** creates files (log, pid…) when daemonizing.

#### `beat_executable` [¶](https://docs.celeryq.dev/en/stable/userguide/configuration.html\#beat-executable "Link to this heading")

Added in version 5.4.

Default: `None`

An optional python executable path for **celery beat** to use when deaemonizing (defaults to [`sys.executable`](https://docs.python.org/dev/library/sys.html#sys.executable "(in Python v3.15)")).

[![Logo of Celery](https://docs.celeryq.dev/en/stable/_static/celery_512.png)](https://docs.celeryq.dev/en/stable/index.html)

Star celery/celery on GitHub[Star](https://github.com/celery/celery) [28,587](https://github.com/celery/celery/stargazers)

### Donations

Please help support this community project with a donation.

[![](https://opencollective.com/celery/donate/button@2x.png?color=blue)](https://opencollective.com/celery/donate)

#### Previous topic

[Extensions and Bootsteps](https://docs.celeryq.dev/en/stable/userguide/extending.html "previous chapter")

#### Next topic

[Documenting Tasks with Sphinx](https://docs.celeryq.dev/en/stable/userguide/sphinx.html "next chapter")

### This Page

- [Show Source](https://docs.celeryq.dev/en/stable/_sources/userguide/configuration.rst.txt)

### Quick search

### Navigation

- [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
- [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") \|
- [next](https://docs.celeryq.dev/en/stable/userguide/sphinx.html "Documenting Tasks with Sphinx") \|
- [previous](https://docs.celeryq.dev/en/stable/userguide/extending.html "Extensions and Bootsteps") \|
- [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
- [User Guide](https://docs.celeryq.dev/en/stable/userguide/index.html) »
- [Configuration and defaults](https://docs.celeryq.dev/en/stable/userguide/configuration.html)

© [Copyright](https://docs.celeryq.dev/en/stable/copyright.html) 2009-2023, Ask Solem & contributors.


![Read the Docs](<Base64-Image-Removed>)stable
Versions[latest](https://docs.celeryq.dev/en/latest/userguide/configuration.html)**[stable](https://docs.celeryq.dev/en/stable/userguide/configuration.html)**[v5.6.3](https://docs.celeryq.dev/en/v5.6.3/userguide/configuration.html)[v5.6.2](https://docs.celeryq.dev/en/v5.6.2/userguide/configuration.html)[v5.6.1](https://docs.celeryq.dev/en/v5.6.1/userguide/configuration.html)[v5.6.0](https://docs.celeryq.dev/en/v5.6.0/userguide/configuration.html)[v5.5.3](https://docs.celeryq.dev/en/v5.5.3/userguide/configuration.html)[v5.5.2](https://docs.celeryq.dev/en/v5.5.2/userguide/configuration.html)[v5.5.1](https://docs.celeryq.dev/en/v5.5.1/userguide/configuration.html)[v5.5.0](https://docs.celeryq.dev/en/v5.5.0/userguide/configuration.html)[v5.4.0](https://docs.celeryq.dev/en/v5.4.0/userguide/configuration.html)[v5.3.6](https://docs.celeryq.dev/en/v5.3.6/userguide/configuration.html)[v5.3.5](https://docs.celeryq.dev/en/v5.3.5/userguide/configuration.html)[v5.3.4](https://docs.celeryq.dev/en/v5.3.4/userguide/configuration.html)[v5.3.3](https://docs.celeryq.dev/en/v5.3.3/userguide/configuration.html)[v5.3.2](https://docs.celeryq.dev/en/v5.3.2/userguide/configuration.html)[v5.3.1](https://docs.celeryq.dev/en/v5.3.1/userguide/configuration.html)[v5.3.0](https://docs.celeryq.dev/en/v5.3.0/userguide/configuration.html)[v5.2.7](https://docs.celeryq.dev/en/v5.2.7/userguide/configuration.html)[v5.2.6](https://docs.celeryq.dev/en/v5.2.6/userguide/configuration.html)[v5.2.5](https://docs.celeryq.dev/en/v5.2.5/userguide/configuration.html)[v5.2.4](https://docs.celeryq.dev/en/v5.2.4/userguide/configuration.html)[v5.2.3](https://docs.celeryq.dev/en/v5.2.3/userguide/configuration.html)[v5.2.2](https://docs.celeryq.dev/en/v5.2.2/userguide/configuration.html)[v5.2.1](https://docs.celeryq.dev/en/v5.2.1/userguide/configuration.html)[v5.2.0](https://docs.celeryq.dev/en/v5.2.0/userguide/configuration.html)[v5.1.2](https://docs.celeryq.dev/en/v5.1.2/userguide/configuration.html)[v5.1.1](https://docs.celeryq.dev/en/v5.1.1/userguide/configuration.html)[v5.1.0](https://docs.celeryq.dev/en/v5.1.0/userguide/configuration.html)[v5.0.5](https://docs.celeryq.dev/en/v5.0.5/userguide/configuration.html)[v5.0.2](https://docs.celeryq.dev/en/v5.0.2/userguide/configuration.html)[v5.0.1](https://docs.celeryq.dev/en/v5.0.1/userguide/configuration.html)[v5.0.0](https://docs.celeryq.dev/en/v5.0.0/userguide/configuration.html)[v4.4.7](https://docs.celeryq.dev/en/v4.4.7/userguide/configuration.html)[v4.4.6](https://docs.celeryq.dev/en/v4.4.6/userguide/configuration.html)[v4.4.5](https://docs.celeryq.dev/en/v4.4.5/userguide/configuration.html)[v4.4.4](https://docs.celeryq.dev/en/v4.4.4/userguide/configuration.html)[4.4.3](https://docs.celeryq.dev/en/4.4.3/userguide/configuration.html)[4.4.2](https://docs.celeryq.dev/en/4.4.2/userguide/configuration.html)[4.4.1](https://docs.celeryq.dev/en/4.4.1/userguide/configuration.html)[4.4.0](https://docs.celeryq.dev/en/4.4.0/userguide/configuration.html)[v4.3.0](https://docs.celeryq.dev/en/v4.3.0/userguide/configuration.html)[v4.2.2](https://docs.celeryq.dev/en/v4.2.2/userguide/configuration.html)[v4.2.1](https://docs.celeryq.dev/en/v4.2.1/userguide/configuration.html)[v4.2.0](https://docs.celeryq.dev/en/v4.2.0/userguide/configuration.html)[v4.1.0](https://docs.celeryq.dev/en/v4.1.0/userguide/configuration.html)[v4.0.2](https://docs.celeryq.dev/en/v4.0.2/userguide/configuration.html)[v4.0.1](https://docs.celeryq.dev/en/v4.0.1/userguide/configuration.html)[v4.0.0](https://docs.celeryq.dev/en/v4.0.0/userguide/configuration.html)[4.0](https://docs.celeryq.dev/en/4.0/userguide/configuration.html)[3.1](https://docs.celeryq.dev/en/3.1/userguide/configuration.html)[3.0](https://docs.celeryq.dev/en/3.0/userguide/configuration.html)[main](https://docs.celeryq.dev/en/main/userguide/configuration.html)[2.5-archived](https://docs.celeryq.dev/en/2.5-archived/userguide/configuration.html)[2.4-archived](https://docs.celeryq.dev/en/2.4-archived/userguide/configuration.html)[2.3-archived](https://docs.celeryq.dev/en/2.3-archived/userguide/configuration.html)[2.2-archived](https://docs.celeryq.dev/en/2.2-archived/userguide/configuration.html)[2.1-archived](https://docs.celeryq.dev/en/2.1-archived/userguide/configuration.html)[2.0-archived](https://docs.celeryq.dev/en/2.0-archived/userguide/configuration.html)[1.0-archived](https://docs.celeryq.dev/en/1.0-archived/userguide/configuration.html)On Read the Docs[Project Home](https://app.readthedocs.org/projects/celery/?utm_source=celery&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/celery/builds/?utm_source=celery&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=celery&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=celery&utm_content=flyout)