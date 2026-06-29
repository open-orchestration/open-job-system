# arq [¶](https://arq-docs.helpmanual.io/\#arq "Permalink to this heading")

[![pypi](https://img.shields.io/pypi/v/arq.svg)](https://pypi.python.org/pypi/arq)[![license](https://img.shields.io/pypi/l/arq.svg)](https://github.com/samuelcolvin/arq)

Current Version: v0.28.0

Job queues and RPC in python with asyncio and redis.

_arq_ was conceived as a simple, modern and performant successor to [rq](http://python-rq.org/).

Warning

In `v0.16` _arq_ was **COMPLETELY REWRITTEN** to use an entirely different approach to registering workers,
enqueueing jobs and processing jobs. You will need to either keep using `v0.15` or entirely rewrite your _arq_
integration to use `v0.16`.

See [here](https://arq-docs.helpmanual.io/old/) for old docs.

Why use _arq_?

**non-blocking**

_arq_ is built using python 3’s [asyncio](https://docs.python.org/3/library/asyncio.html) allowing
non-blocking job enqueuing and execution. Multiple jobs (potentially hundreds) can be run simultaneously
using a pool of _asyncio_`Tasks`.

**powerful-features**

Deferred execution, easy retrying of jobs, and pessimistic execution ( [see below](https://arq-docs.helpmanual.io/#usage))
means _arq_ is great for critical jobs that **must** be completed.

**fast**

Asyncio and no forking make _arq_ around 7x faster than
_rq_ for short jobs with no io. With io that might increase to around 40x
faster. (TODO)

**elegant**

I’m a long time contributor to and user of [rq](http://python-rq.org/), _arq_ is designed to be simpler, clearer and more powerful.

**small**

and easy to reason with - currently _arq_ is only about 700 lines, that won’t change significantly.

## Install [¶](https://arq-docs.helpmanual.io/\#install "Permalink to this heading")

Just:

```
pip install arq
```

## Redesigned to be less elegant? [¶](https://arq-docs.helpmanual.io/\#redesigned-to-be-less-elegant "Permalink to this heading")

The approach used in _arq_`v0.16` of enqueueing jobs by name rather than “just calling a function” and knowing it
will be called on the worker (as used in _arq_`<= v0.15`, rq, celery et al.) might seem less elegant,
but it’s for good reason.

This approach means your frontend (calling the worker) doesn’t need access to the worker code,
meaning better code separation and possibly smaller images etc.

## Usage [¶](https://arq-docs.helpmanual.io/\#usage "Permalink to this heading")

Warning

**Jobs may be called more than once!**

_arq_ v0.16 has what I’m calling “pessimistic execution”: jobs aren’t removed from the queue until they’ve either
succeeded or failed. If the worker shuts down, the job will be cancelled immediately and will remain in the queue
to be run again when the worker starts up again (or run by another worker which is still running).

(This differs from other similar libraries like _arq_`<= v0.15`, rq, celery et al. where jobs generally don’t get
rerun when a worker shuts down. This in turn requires complex logic to try and let jobs finish before
shutting down (I wrote the `HerokuWorker` for rq), however this never really works unless either: all jobs take
less than 6 seconds or your worker never shuts down when a job is running (impossible).)

All _arq_ jobs should therefore be designed to cope with being called repeatedly if they’re cancelled,
eg. use database transactions, idempotency keys or redis to mark when an API request or similar has succeeded
to avoid making it twice.

**In summary:** sometimes _exactly once_ can be hard or impossible, _arq_ favours multiple times over zero times.

### Simple Usage [¶](https://arq-docs.helpmanual.io/\#simple-usage "Permalink to this heading")

```
import asyncio
from httpx import AsyncClient
from arq import create_pool
from arq.connections import RedisSettings

# Here you can configure the Redis connection.
# The default is to connect to localhost:6379, no password.
REDIS_SETTINGS = RedisSettings()

async def download_content(ctx, url):
    session: AsyncClient = ctx['session']
    response = await session.get(url)
    print(f'{url}: {response.text:.80}...')
    return len(response.text)

async def startup(ctx):
    ctx['session'] = AsyncClient()

async def shutdown(ctx):
    await ctx['session'].aclose()

async def main():
    redis = await create_pool(REDIS_SETTINGS)
    for url in ('https://facebook.com', 'https://microsoft.com', 'https://github.com'):
        await redis.enqueue_job('download_content', url)

# WorkerSettings defines the settings to use when creating the work,
# It's used by the arq CLI.
# redis_settings might be omitted here if using the default settings
# For a list of all available settings, see https://arq-docs.helpmanual.io/#arq.worker.Worker
class WorkerSettings:
    functions = [download_content]
    on_startup = startup
    on_shutdown = shutdown
    redis_settings = REDIS_SETTINGS

if __name__ == '__main__':
    asyncio.run(main())
```

(This script is complete, it should run “as is” both to enqueue jobs and run them)

To enqueue the jobs, simply run the script:

```
python demo.py
```

To execute the jobs, either after running `demo.py` or before/during:

```
arq demo.WorkerSettings
```

Append `--burst` to stop the worker once all jobs have finished. See [`arq.worker.Worker`](https://arq-docs.helpmanual.io/#arq.worker.Worker "arq.worker.Worker") for more available
properties of `WorkerSettings`.

You can also watch for changes and reload the worker when the source changes:

```
arq demo.WorkerSettings --watch path/to/src
```

This requires [watchfiles](https://pypi.org/project/watchfiles/) to be installed (`pip install watchfiles`).

For details on the _arq_ CLI:

```
arq --help
```

### Startup & Shutdown coroutines [¶](https://arq-docs.helpmanual.io/\#startup-shutdown-coroutines "Permalink to this heading")

The `on_startup` and `on_shutdown` coroutines are provided as a convenient way to run logic as the worker
starts and finishes, see [`arq.worker.Worker`](https://arq-docs.helpmanual.io/#arq.worker.Worker "arq.worker.Worker").

For example, in the above example `session` is created once when the work starts up and is then used in subsequent
jobs.

### Deferring Jobs [¶](https://arq-docs.helpmanual.io/\#deferring-jobs "Permalink to this heading")

By default, when a job is enqueued it will run as soon as possible (provided a worker is running). However
you can schedule jobs to run in the future, either by a given duration (`_defer_by`) or
at a particular time `_defer_until`, see [`arq.connections.ArqRedis.enqueue_job()`](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.enqueue_job "arq.connections.ArqRedis.enqueue_job").

```
import asyncio
from datetime import datetime, timedelta

from arq import create_pool
from arq.connections import RedisSettings

async def the_task(ctx):
    print('this is the tasks, delay since enqueueing:', datetime.now() - ctx['enqueue_time'])

async def main():
    redis = await create_pool(RedisSettings())

    # deferred by 10 seconds
    await redis.enqueue_job('the_task', _defer_by=10)

    # deferred by 1 minute
    await redis.enqueue_job('the_task', _defer_by=timedelta(minutes=1))

    # deferred until jan 28th 2032, you'll be waiting a long time for this...
    await redis.enqueue_job('the_task', _defer_until=datetime(2032, 1, 28))

class WorkerSettings:
    functions = [the_task]

if __name__ == '__main__':
    asyncio.run(main())
```

### Job Uniqueness [¶](https://arq-docs.helpmanual.io/\#job-uniqueness "Permalink to this heading")

Sometimes you want a job to only be run once at a time (eg. a backup) or once for a given parameter (eg. generating
invoices for a particular company).

_arq_ supports this via custom job ids, see [`arq.connections.ArqRedis.enqueue_job()`](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.enqueue_job "arq.connections.ArqRedis.enqueue_job"). It guarantees
that a job with a particular ID cannot be enqueued again until its execution has finished and its result has cleared. To control when a finished job’s result clears, you can use the keep\_result setting on your worker, see [`arq.worker.func()`](https://arq-docs.helpmanual.io/#arq.worker.func "arq.worker.func").

```
import asyncio

from arq import create_pool
from arq.connections import RedisSettings
from arq.jobs import Job

async def the_task(ctx):
    print('running the task with id', ctx['job_id'])

async def main():
    redis = await create_pool(RedisSettings())

    # no id, random id will be generated
    job1 = await redis.enqueue_job('the_task')
    print(job1)
    """
    >  <arq job 99edfef86ccf4145b2f64ee160fa3297>
    """

    # random id again, again the job will be enqueued and a job will be returned
    job2 = await redis.enqueue_job('the_task')
    print(job2)
    """
    >  <arq job 7d2163c056e54b62a4d8404921094f05>
    """

    # custom job id, job will be enqueued
    job3 = await redis.enqueue_job('the_task', _job_id='foobar')
    print(job3)
    """
    >  <arq job foobar>
    """

    # same custom job id, job will not be enqueued and enqueue_job will return None
    job4 = await redis.enqueue_job('the_task', _job_id='foobar')
    print(job4)
    """
    >  None
    """

    # you can retrieve jobs by using arq.jobs.Job
    await redis.enqueue_job('the_task', _job_id='my_job')
    job5 = Job(job_id='my_job', redis=redis)
    print(job5)
    """
    <arq job my_job>
    """

class WorkerSettings:
    functions = [the_task]

if __name__ == '__main__':
    asyncio.run(main())
```

The check of `job_id` uniqueness in the queue is performed using a redis transaction so you can be certain jobs
with the same id won’t be enqueued twice (or overwritten) even if they’re enqueued at exactly the same time.

### Job Results [¶](https://arq-docs.helpmanual.io/\#job-results "Permalink to this heading")

You can access job information, status and job results using the [`arq.jobs.Job`](https://arq-docs.helpmanual.io/#arq.jobs.Job "arq.jobs.Job") instance returned from
[`arq.connections.ArqRedis.enqueue_job()`](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.enqueue_job "arq.connections.ArqRedis.enqueue_job").

```
import asyncio

from arq import create_pool
from arq.connections import RedisSettings
# requires `pip install devtools`, used for pretty printing of job info
from devtools import debug

async def the_task(ctx):
    print('running the task')
    return 42

async def main():
    redis = await create_pool(RedisSettings())

    job = await redis.enqueue_job('the_task')

    # get the job's id
    print(job.job_id)
    """
    >  68362958a244465b9be909db4b7b5ab4 (or whatever)
    """

    # get information about the job, will include results if the job has finished, but
    # doesn't await the job's result
    debug(await job.info())
    """
    >   docs/examples/job_results.py:23 main
    JobDef(
        function='the_task',
        args=(),
        kwargs={},
        job_try=None,
        enqueue_time=datetime.datetime(2019, 4, 23, 13, 58, 56, 781000),
        score=1556027936781
    ) (JobDef)
    """

    # get the Job's status
    print(await job.status())
    """
    >  JobStatus.queued
    """

    # poll redis for the job result, if the job raised an exception,
    # it will be raised here
    # (You'll need the worker running at the same time to get a result here)
    print(await job.result(timeout=5))
    """
    >  42
    """

class WorkerSettings:
    functions = [the_task]

if __name__ == '__main__':
    asyncio.run(main())
```

### Retrying jobs and cancellation [¶](https://arq-docs.helpmanual.io/\#retrying-jobs-and-cancellation "Permalink to this heading")

As described above, when an arq worker shuts down, any ongoing jobs are cancelled immediately
(via vanilla `task.cancel()`, so a `CancelledError` will be raised). You can see this by running a slow job
(eg. add `await asyncio.sleep(5)`) and hitting `Ctrl+C` once it’s started.

You’ll get something like.

```
➤  arq slow_job.WorkerSettings
12:42:38: Starting worker for 1 functions: the_task
12:42:38: redis_version=4.0.9 mem_usage=904.50K clients_connected=4 db_keys=3
12:42:38:  10.23s → c3dd4acc171541b9ac10b1d791750cde:the_task() delayed=10.23s
^C12:42:40: shutdown on SIGINT ◆ 0 jobs complete ◆ 0 failed ◆ 0 retries ◆ 1 ongoing to cancel
12:42:40:   1.16s ↻ c3dd4acc171541b9ac10b1d791750cde:the_task cancelled, will be run again

➤  arq slow_job.WorkerSettings
12:42:50: Starting worker for 1 functions: the_task
12:42:50: redis_version=4.0.9 mem_usage=904.61K clients_connected=4 db_keys=4
12:42:50:  21.78s → c3dd4acc171541b9ac10b1d791750cde:the_task() try=2 delayed=21.78s
12:42:55:   5.00s ← c3dd4acc171541b9ac10b1d791750cde:the_task ●
^C12:42:57: shutdown on SIGINT ◆ 1 jobs complete ◆ 0 failed ◆ 0 retries ◆ 0 ongoing to cancel
```

You can also retry jobs by raising the [`arq.worker.Retry`](https://arq-docs.helpmanual.io/#arq.worker.Retry "arq.worker.Retry") exception from within a job,
optionally with a duration to defer rerunning the jobs by:

```
import asyncio
from httpx import AsyncClient
from arq import create_pool, Retry
from arq.connections import RedisSettings

async def download_content(ctx, url):
    session: AsyncClient = ctx['session']
    response = await session.get(url)
    if response.status_code != 200:
        # retry the job with increasing back-off
        # delays will be 5s, 10s, 15s, 20s
        # after max_tries (default 5) the job will permanently fail
        raise Retry(defer=ctx['job_try'] * 5)
    return len(response.text)

async def startup(ctx):
    ctx['session'] = AsyncClient()

async def shutdown(ctx):
    await ctx['session'].aclose()

async def main():
    redis = await create_pool(RedisSettings())
    await redis.enqueue_job('download_content', 'https://httpbin.org/status/503')

class WorkerSettings:
    functions = [download_content]
    on_startup = startup
    on_shutdown = shutdown

if __name__ == '__main__':
    asyncio.run(main())
```

To abort a job, call `arq.job.Job.abort()`. (Note for the `arq.job.Job.abort()` method to
have any effect, you need to set `allow_abort_jobs` to `True` on the worker, this is for performance reason.
`allow_abort_jobs=True` may become the default in future)

`arq.job.Job.abort()` will abort a job if it’s already running or prevent it being run if it’s currently
in the queue.

```
import asyncio
from arq import create_pool
from arq.connections import RedisSettings

async def do_stuff(ctx):
    print('doing stuff...')
    await asyncio.sleep(10)
    return 'stuff done'

async def main():
    redis = await create_pool(RedisSettings())
    job = await redis.enqueue_job('do_stuff')
    await asyncio.sleep(1)
    await job.abort()

class WorkerSettings:
    functions = [do_stuff]
    allow_abort_jobs = True

if __name__ == '__main__':
    asyncio.run(main())
```

### Health checks [¶](https://arq-docs.helpmanual.io/\#health-checks "Permalink to this heading")

_arq_ will automatically record some info about its current state in redis every `health_check_interval` seconds.
That key/value will expire after `health_check_interval + 1` seconds so you can be sure if the variable exists _arq_
is alive and kicking (technically you can be sure it was alive and kicking `health_check_interval` seconds ago).

You can run a health check with the CLI (assuming you’re using the first example above):

```
arq --check demo.WorkerSettings
```

The command will output the value of the health check if found;
then exit `0` if the key was found and `1` if it was not.

A health check value takes the following form:

```
Mar-01 17:41:22 j_complete=0 j_failed=0 j_retried=0 j_ongoing=0 queued=0
```

Where the items have the following meaning:

- `j_complete` the number of jobs completed

- `j_failed` the number of jobs which have failed eg. raised an exception

- `j_ongoing` the number of jobs currently being performed

- `j_retried` the number of jobs retries run


### Cron Jobs [¶](https://arq-docs.helpmanual.io/\#cron-jobs "Permalink to this heading")

Functions can be scheduled to be run periodically at specific times. See [`arq.cron.cron()`](https://arq-docs.helpmanual.io/#arq.cron.cron "arq.cron.cron").

```
from arq import cron

async def run_regularly(ctx):
    print('run foo job at 9.12am, 12.12pm and 6.12pm')

class WorkerSettings:
    cron_jobs = [\
        cron(run_regularly, hour={9, 12, 18}, minute=12)\
    ]
```

Usage roughly shadows [cron](https://helpmanual.io/man8/cron/) except `None` is equivalent on `*` in crontab.
As per the example sets can be used to run at multiple of the given unit.

Note that `second` defaults to `0` so you don’t in inadvertently run jobs every second and `microsecond`
defaults to `123456` so you don’t inadvertently run jobs every microsecond and so _arq_ avoids enqueuing jobs
at the top of a second when the world is generally slightly busier.

### Synchronous Jobs [¶](https://arq-docs.helpmanual.io/\#synchronous-jobs "Permalink to this heading")

Functions that can block the loop for extended periods should be run in an executor like
`concurrent.futures.ThreadPoolExecutor` or `concurrent.futures.ProcessPoolExecutor` using
`loop.run_in_executor` as shown below.

```
import time
import functools
import asyncio
from concurrent import futures

def sync_task(t):
    return time.sleep(t)

async def the_task(ctx, t):
    blocking = functools.partial(sync_task, t)
    loop = asyncio.get_running_loop()
    return await loop.run_in_executor(ctx['pool'], blocking)

async def startup(ctx):
    ctx['pool'] = futures.ProcessPoolExecutor()

class WorkerSettings:
    functions = [the_task]
    on_startup = startup
```

### Custom job serializers [¶](https://arq-docs.helpmanual.io/\#custom-job-serializers "Permalink to this heading")

By default, _arq_ will use the built-in `pickle` module to serialize and deserialize jobs. If you wish to
use an alternative serialization methods, you can do so by specifying them when creating the connection pool
and the worker settings. A serializer function takes a Python object and returns a binary representation
encoded in a `bytes` object. A deserializer function, on the other hand, creates Python objects out of
a `bytes` sequence.

Warning

It is essential that the serialization functions used by [`arq.connections.create_pool()`](https://arq-docs.helpmanual.io/#arq.connections.create_pool "arq.connections.create_pool") and
[`arq.worker.Worker`](https://arq-docs.helpmanual.io/#arq.worker.Worker "arq.worker.Worker") are the same, otherwise jobs created by the former cannot be executed by the
latter. This also applies when you update your serialization functions: you need to ensure that your new
functions are backward compatible with the old jobs, or that there are no jobs with the older serialization
scheme in the queue.

Here is an example with [MsgPack](http://msgpack.org/), an efficient binary serialization format that
may enable significant memory improvements over pickle:

```
import asyncio

import msgpack  # installable with "pip install msgpack"

from arq import create_pool
from arq.connections import RedisSettings

async def the_task(ctx):
    return 42

async def main():
    redis = await create_pool(
        RedisSettings(),
        job_serializer=msgpack.packb,
        job_deserializer=lambda b: msgpack.unpackb(b, raw=False),
    )
    await redis.enqueue_job('the_task')

class WorkerSettings:
    functions = [the_task]
    job_serializer = msgpack.packb
    # refer to MsgPack's documentation as to why raw=False is required
    job_deserializer = lambda b: msgpack.unpackb(b, raw=False)

if __name__ == '__main__':
    asyncio.run(main())
```

## Reference [¶](https://arq-docs.helpmanual.io/\#module-arq.connections "Permalink to this heading")

_class_ arq.connections.RedisSettings( _host:str\|list\[tuple\[str,int\]\]='localhost'_, _port:int=6379_, _unix\_socket\_path:str\|None=None_, _database:int=0_, _username:str\|None=None_, _password:str\|None=None_, _ssl:bool=False_, _ssl\_keyfile:str\|None=None_, _ssl\_certfile:str\|None=None_, _ssl\_cert\_reqs:str='required'_, _ssl\_ca\_certs:str\|None=None_, _ssl\_ca\_data:str\|None=None_, _ssl\_check\_hostname:bool=False_, _conn\_timeout:int=1_, _conn\_retries:int=5_, _conn\_retry\_delay:int=1_, _max\_connections:int\|None=None_, _sentinel:bool=False_, _sentinel\_master:str='mymaster'_, _retry\_on\_timeout:bool=False_, _retry\_on\_error:list\[type\[Exception\]\]\|None=None_, _retry:Retry\|None=None_) [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/connections#RedisSettings) [¶](https://arq-docs.helpmanual.io/#arq.connections.RedisSettings "Permalink to this definition")

No-Op class used to hold redis connection redis\_settings.

Used by [`arq.connections.create_pool()`](https://arq-docs.helpmanual.io/#arq.connections.create_pool "arq.connections.create_pool") and [`arq.worker.Worker`](https://arq-docs.helpmanual.io/#arq.worker.Worker "arq.worker.Worker").

_class_ arq.connections.ArqRedis( _pool\_or\_conn:ConnectionPool\|None=None_, _job\_serializer:Callable\[\[dict\[str,Any\]\],bytes\]\|None=None_, _job\_deserializer:Callable\[\[bytes\],dict\[str,Any\]\]\|None=None_, _default\_queue\_name:str='arq:queue'_, _expires\_extra\_ms:int=86400000_, _\*\*kwargs:Any_) [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/connections#ArqRedis) [¶](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis "Permalink to this definition")

Thin subclass of `redis.asyncio.Redis` which adds `arq.connections.enqueue_job()`.

Parameters:

- **redis\_settings** – an instance of `arq.connections.RedisSettings`.

- **job\_serializer** – a function that serializes Python objects to bytes, defaults to pickle.dumps

- **job\_deserializer** – a function that deserializes bytes into Python objects, defaults to pickle.loads

- **default\_queue\_name** – the default queue name to use, defaults to `arq.queue`.

- **expires\_extra\_ms** – the default length of time from when a job is expected to start
after which the job expires, defaults to 1 day in ms.

- **kwargs** – keyword arguments directly passed to `redis.asyncio.Redis`.


Initialize a new Redis client.
To specify a retry policy for specific errors, first set
retry\_on\_error to a list of the error/s to retry on, then set
retry to a valid Retry object.
To retry on TimeoutError, retry\_on\_timeout can also be set to True.

_async_ enqueue\_job( _function:str_, _\*args:Any_, _\_job\_id:str\|None=None_, _\_queue\_name:str\|None=None_, _\_defer\_until:datetime\|None=None_, _\_defer\_by:None\|int\|float\|timedelta=None_, _\_expires:None\|int\|float\|timedelta=None_, _\_job\_try:int\|None=None_, _\*\*kwargs:Any_)→[Job](https://arq-docs.helpmanual.io/#arq.jobs.Job "arq.jobs.Job") \|None [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/connections#ArqRedis.enqueue_job) [¶](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.enqueue_job "Permalink to this definition")

Enqueue a job.

Parameters:

- **function** – Name of the function to call

- **args** – args to pass to the function

- **\_job\_id** – ID of the job, can be used to enforce job uniqueness

- **\_queue\_name** – queue of the job, can be used to create job in different queue

- **\_defer\_until** – datetime at which to run the job

- **\_defer\_by** – duration to wait before running the job

- **\_expires** – do not start or retry a job after this duration;
defaults to 24 hours plus deferring time, if any

- **\_job\_try** – useful when re-enqueueing jobs within a job

- **kwargs** – any keyword arguments to pass to the function


Returns:

[`arq.jobs.Job`](https://arq-docs.helpmanual.io/#arq.jobs.Job "arq.jobs.Job") instance or `None` if a job with this ID already exists

_async_ all\_job\_results()→list\[arq.jobs.JobResult\] [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/connections#ArqRedis.all_job_results) [¶](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.all_job_results "Permalink to this definition")

Get results for all jobs in redis.

_async_ queued\_jobs( _\*_, _queue\_name:str\|None=None_)→list\[arq.jobs.JobDef\] [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/connections#ArqRedis.queued_jobs) [¶](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.queued_jobs "Permalink to this definition")

Get information about queued, mostly useful when testing.

_async_ arq.connections.create\_pool( _settings\_:[RedisSettings](https://arq-docs.helpmanual.io/#arq.connections.RedisSettings "arq.connections.RedisSettings") \|None=None_, _\*_, _retry:int=0_, _job\_serializer:Callable\[\[dict\[str,Any\]\],bytes\]\|None=None_, _job\_deserializer:Callable\[\[bytes\],dict\[str,Any\]\]\|None=None_, _default\_queue\_name:str='arq:queue'_, _expires\_extra\_ms:int=86400000_)→[ArqRedis](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis "arq.connections.ArqRedis") [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/connections#create_pool) [¶](https://arq-docs.helpmanual.io/#arq.connections.create_pool "Permalink to this definition")

Create a new redis pool, retrying up to `conn_retries` times if the connection fails.

Returns a [`arq.connections.ArqRedis`](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis "arq.connections.ArqRedis") instance, thus allowing job enqueuing.

arq.worker.func( _coroutine:str\|Function\|WorkerCoroutine_, _\*_, _name:str\|None=None_, _keep\_result:SecondsTimedelta\|None=None_, _timeout:SecondsTimedelta\|None=None_, _keep\_result\_forever:bool\|None=None_, _max\_tries:int\|None=None_)→Function [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/worker#func) [¶](https://arq-docs.helpmanual.io/#arq.worker.func "Permalink to this definition")

Wrapper for a job function which lets you configure more settings.

Parameters:

- **coroutine** – coroutine function to call, can be a string to import

- **name** – name for function, if None, `coroutine.__qualname__` is used

- **keep\_result** – duration to keep the result for, if 0 the result is not kept

- **keep\_result\_forever** – whether to keep results forever, if None use Worker default, wins over `keep_result`

- **timeout** – maximum time the job should take

- **max\_tries** – maximum number of tries allowed for the function, use 1 to prevent retrying


_exception_ arq.worker.Retry( _defer:SecondsTimedelta\|None=None_) [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/worker#Retry) [¶](https://arq-docs.helpmanual.io/#arq.worker.Retry "Permalink to this definition")

Special exception to retry the job (if `max_tries` hasn’t been reached).

Parameters:

**defer** – duration to wait before rerunning the job

_class_ arq.worker.Worker( _functions:Sequence\[Function\|WorkerCoroutine\]=()_, _\*_, _queue\_name:str\|None='arq:queue'_, _cron\_jobs:Sequence\[CronJob\]\|None=None_, _redis\_settings:[RedisSettings](https://arq-docs.helpmanual.io/#arq.connections.RedisSettings "arq.connections.RedisSettings") \|None=None_, _redis\_pool:[ArqRedis](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis "arq.connections.ArqRedis") \|None=None_, _burst:bool=False_, _on\_startup:StartupShutdown\|None=None_, _on\_shutdown:StartupShutdown\|None=None_, _on\_job\_start:StartupShutdown\|None=None_, _on\_job\_end:StartupShutdown\|None=None_, _after\_job\_end:StartupShutdown\|None=None_, _handle\_signals:bool=True_, _job\_completion\_wait:int=0_, _max\_jobs:int=10_, _job\_timeout:SecondsTimedelta=300_, _keep\_result:SecondsTimedelta=3600_, _keep\_result\_forever:bool=False_, _poll\_delay:SecondsTimedelta=0.5_, _queue\_read\_limit:int\|None=None_, _max\_tries:int=5_, _health\_check\_interval:SecondsTimedelta=3600_, _health\_check\_key:str\|None=None_, _ctx:dict\[Any,Any\]\|None=None_, _retry\_jobs:bool=True_, _allow\_abort\_jobs:bool=False_, _max\_burst\_jobs:int=-1_, _job\_serializer:Callable\[\[dict\[str,Any\]\],bytes\]\|None=None_, _job\_deserializer:Callable\[\[bytes\],dict\[str,Any\]\]\|None=None_, _expires\_extra\_ms:int=86400000_, _timezone:timezone\|None=None_, _log\_results:bool=True_) [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/worker#Worker) [¶](https://arq-docs.helpmanual.io/#arq.worker.Worker "Permalink to this definition")

Main class for running jobs.

Parameters:

- **functions** – list of functions to register, can either be raw coroutine functions or the
result of [`arq.worker.func()`](https://arq-docs.helpmanual.io/#arq.worker.func "arq.worker.func").

- **queue\_name** – queue name to get jobs from

- **cron\_jobs** – list of cron jobs to run, use [`arq.cron.cron()`](https://arq-docs.helpmanual.io/#arq.cron.cron "arq.cron.cron") to create them

- **redis\_settings** – settings for creating a redis connection

- **redis\_pool** – existing redis pool, generally None

- **burst** – whether to stop the worker once all jobs have been run

- **on\_startup** – coroutine function to run at startup

- **on\_shutdown** – coroutine function to run at shutdown

- **on\_job\_start** – coroutine function to run on job start

- **on\_job\_end** – coroutine function to run on job end

- **after\_job\_end** – coroutine function to run after job has ended and results have been recorded

- **handle\_signals** – default true, register signal handlers,
set to false when running inside other async framework

- **job\_completion\_wait** – time to wait before cancelling tasks after a signal.
Useful together with `terminationGracePeriodSeconds` in kubernetes,
when you want to make the pod complete jobs before shutting down.
The worker will not pick new tasks while waiting for shut down.

- **max\_jobs** – maximum number of jobs to run at a time

- **job\_timeout** – default job timeout (max run time)

- **keep\_result** – default duration to keep job results for

- **keep\_result\_forever** – whether to keep results forever

- **poll\_delay** – duration between polling the queue for new jobs

- **queue\_read\_limit** – the maximum number of jobs to pull from the queue each time it’s polled. By default it
equals `max_jobs` \\* 5, or 100; whichever is higher.

- **max\_tries** – default maximum number of times to retry a job

- **health\_check\_interval** – how often to set the health check key

- **health\_check\_key** – redis key under which health check is set

- **ctx** – dictionary to hold extra user defined state

- **retry\_jobs** – whether to retry jobs on Retry or CancelledError or not

- **allow\_abort\_jobs** – whether to abort jobs on a call to [`arq.jobs.Job.abort()`](https://arq-docs.helpmanual.io/#arq.jobs.Job.abort "arq.jobs.Job.abort")

- **max\_burst\_jobs** – the maximum number of jobs to process in burst mode (disabled with negative values)

- **job\_serializer** – a function that serializes Python objects to bytes, defaults to pickle.dumps

- **job\_deserializer** – a function that deserializes bytes into Python objects, defaults to pickle.loads

- **expires\_extra\_ms** – the default length of time from when a job is expected to start
after which the job expires, defaults to 1 day in ms.

- **timezone** – timezone used for evaluation of cron schedules,
defaults to system timezone

- **log\_results** – when set to true (default) results for successful jobs
will be logged


run()→None [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/worker#Worker.run) [¶](https://arq-docs.helpmanual.io/#arq.worker.Worker.run "Permalink to this definition")

Sync function to run the worker, finally closes worker connections.

_async_ async\_run()→None [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/worker#Worker.async_run) [¶](https://arq-docs.helpmanual.io/#arq.worker.Worker.async_run "Permalink to this definition")

Asynchronously run the worker, does not close connections. Useful when testing.

_async_ run\_check( _retry\_jobs:bool\|None=None_, _max\_burst\_jobs:int\|None=None_)→int [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/worker#Worker.run_check) [¶](https://arq-docs.helpmanual.io/#arq.worker.Worker.run_check "Permalink to this definition")

Run [`arq.worker.Worker.async_run()`](https://arq-docs.helpmanual.io/#arq.worker.Worker.async_run "arq.worker.Worker.async_run"), check for failed jobs and raise `arq.worker.FailedJobs`
if any jobs have failed.

Returns:

number of completed jobs

_async_ start\_jobs( _job\_ids:list\[bytes\]_)→None [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/worker#Worker.start_jobs) [¶](https://arq-docs.helpmanual.io/#arq.worker.Worker.start_jobs "Permalink to this definition")

For each job id, get the job definition, check it’s not running and start it in a task

handle\_sig\_wait\_for\_completion( _signum:Signals_)→None [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/worker#Worker.handle_sig_wait_for_completion) [¶](https://arq-docs.helpmanual.io/#arq.worker.Worker.handle_sig_wait_for_completion "Permalink to this definition")

Alternative signal handler that allow tasks to complete within a given time before shutting down the worker.
Time can be configured using wait\_for\_job\_completion\_on\_signal\_second.
The worker will stop picking jobs when signal has been received.

arq.cron.cron( _coroutine:str\|WorkerCoroutine_, _\*_, _name:str\|None=None_, _month:None\|set\[int\]\|int=None_, _day:None\|set\[int\]\|int=None_, _weekday:None\|set\[int\]\|int\|Literal\['mon','tues','wed','thurs','fri','sat','sun'\]=None_, _hour:None\|set\[int\]\|int=None_, _minute:None\|set\[int\]\|int=None_, _second:None\|set\[int\]\|int=0_, _microsecond:int=123456_, _run\_at\_startup:bool=False_, _unique:bool=True_, _job\_id:str\|None=None_, _timeout:int\|float\|timedelta\|None=None_, _keep\_result:float\|None=0_, _keep\_result\_forever:bool\|None=False_, _max\_tries:int\|None=1_)→CronJob [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/cron#cron) [¶](https://arq-docs.helpmanual.io/#arq.cron.cron "Permalink to this definition")

Create a cron job, eg. it should be executed at specific times.

Workers will enqueue this job at or just after the set times. If `unique` is true (the default) the
job will only be run once even if multiple workers are running.

Parameters:

- **coroutine** – coroutine function to run

- **name** – name of the job, if None, the name of the coroutine is used

- **month** – month(s) to run the job on, 1 - 12

- **day** – day(s) to run the job on, 1 - 31

- **weekday** – week day(s) to run the job on, 0 - 6 or mon - sun

- **hour** – hour(s) to run the job on, 0 - 23

- **minute** – minute(s) to run the job on, 0 - 59

- **second** – second(s) to run the job on, 0 - 59

- **microsecond** – microsecond(s) to run the job on,
defaults to 123456 as the world is busier at the top of a second, 0 - 1e6

- **run\_at\_startup** – whether to run as worker starts

- **unique** – whether the job should only be executed once at each time (useful if you have multiple workers)

- **job\_id** – ID of the job, can be used to enforce job uniqueness, spanning multiple cron schedules

- **timeout** – job timeout

- **keep\_result** – how long to keep the result for

- **keep\_result\_forever** – whether to keep results forever

- **max\_tries** – maximum number of tries for the job


_class_ arq.jobs.JobStatus( _value_, _names=<notgiven>_, _\*values_, _module=None_, _qualname=None_, _type=None_, _start=1_, _boundary=None_) [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/jobs#JobStatus) [¶](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus "Permalink to this definition")

Enum of job statuses.

deferred _='deferred'_ [¶](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.deferred "Permalink to this definition")

job is in the queue, time it should be run not yet reached

queued _='queued'_ [¶](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.queued "Permalink to this definition")

job is in the queue, time it should run has been reached

in\_progress _='in\_progress'_ [¶](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.in_progress "Permalink to this definition")

job is in progress

complete _='complete'_ [¶](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.complete "Permalink to this definition")

job is complete, result is available

not\_found _='not\_found'_ [¶](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.not_found "Permalink to this definition")

job not found in any way

_class_ arq.jobs.Job( _job\_id:str_, _redis:Redis\[bytes\]_, _\_queue\_name:str='arq:queue'_, _\_deserializer:Callable\[\[bytes\],dict\[str,Any\]\]\|None=None_) [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/jobs#Job) [¶](https://arq-docs.helpmanual.io/#arq.jobs.Job "Permalink to this definition")

Holds data a reference to a job.

_async_ result( _timeout:float\|None=None_, _\*_, _poll\_delay:float=0.5_, _pole\_delay:float\|None=None_)→Any [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/jobs#Job.result) [¶](https://arq-docs.helpmanual.io/#arq.jobs.Job.result "Permalink to this definition")

Get the result of the job or, if the job raised an exception, reraise it.

This function waits for the result if it’s not yet available and the job is
present in the queue. Otherwise `ResultNotFound` is raised.

Parameters:

- **timeout** – maximum time to wait for the job result before raising `TimeoutError`, will wait forever

- **poll\_delay** – how often to poll redis for the job result

- **pole\_delay** – deprecated, use poll\_delay instead


_async_ info()→JobDef\|None [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/jobs#Job.info) [¶](https://arq-docs.helpmanual.io/#arq.jobs.Job.info "Permalink to this definition")

All information on a job, including its result if it’s available, does not wait for the result.

_async_ result\_info()→JobResult\|None [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/jobs#Job.result_info) [¶](https://arq-docs.helpmanual.io/#arq.jobs.Job.result_info "Permalink to this definition")

Information about the job result if available, does not wait for the result. Does not raise an exception
even if the job raised one.

_async_ status()→[JobStatus](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus "arq.jobs.JobStatus") [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/jobs#Job.status) [¶](https://arq-docs.helpmanual.io/#arq.jobs.Job.status "Permalink to this definition")

Status of the job.

_async_ abort( _\*_, _timeout:float\|None=None_, _poll\_delay:float=0.5_)→bool [\[source\]](https://arq-docs.helpmanual.io/_modules/arq/jobs#Job.abort) [¶](https://arq-docs.helpmanual.io/#arq.jobs.Job.abort "Permalink to this definition")

Abort the job.

Parameters:

- **timeout** – maximum time to wait for the job result before raising `TimeoutError`,
will wait forever on None

- **poll\_delay** – how often to poll redis for the job result


Returns:

True if the job aborted properly, False otherwise

## History [¶](https://arq-docs.helpmanual.io/\#history "Permalink to this heading")

### v0.28.0 (2026-04-16) [¶](https://arq-docs.helpmanual.io/\#v0-28-0-2026-04-16 "Permalink to this heading")

- Add support for Python 3.14 by @Viicos in #522


### v0.27.0 (2026-01-30) [¶](https://arq-docs.helpmanual.io/\#v0-27-0-2026-01-30 "Permalink to this heading")

- Fix wrong reference in `Retry` docstring by @PassionateBytes in #507

- Fix retry\_on\_error type annotation by @armicron in #446

- Add support for Python 3.13, remove advertised support for Python 3.8 by @Viicos in #514


### v0.26.3 (2025-01-06) [¶](https://arq-docs.helpmanual.io/\#v0-26-3-2025-01-06 "Permalink to this heading")

- Fix negative expires\_ms and avoid worker freezing while using cron by @Matvey-Kuk in #479

- Fix race condition on task retry by @RB387 in #487


### v0.26.1 (2023-08-29) [¶](https://arq-docs.helpmanual.io/\#v0-26-1-2023-08-29 "Permalink to this heading")

- Uses `testcontainers` to provide a redis instance for the unit tests by @chrisguidry in #470

- Bump `redis` version from <5 to <6 by @Wh1isper in #460

- Bump `idna` from 3.6 to 3.7 in /requirements by @dependabot in #444

- Bump `jinja2` from 3.1.3 to 3.1.4 in /requirements by @dependabot in #452

- Bump `requests` from 2.31.0 to 2.32.0 in /requirements by @dependabot in #461

- Bump `urllib3` from 2.2.1 to 2.2.2 in /requirements by @dependabot in #464

- Bump `certifi` from 2024.2.2 to 2024.7.4 in /requirements by @dependabot in #468


### v0.26.0 (2023-05-01) [¶](https://arq-docs.helpmanual.io/\#v0-26-0-2023-05-01 "Permalink to this heading")

No changes since v0.26.0b1.

### v0.26.0b1 (2023-04-01) [¶](https://arq-docs.helpmanual.io/\#v0-26-0b1-2023-04-01 "Permalink to this heading")

- Prevent worker getting stuck in terminating state by @JonasKs in #370

- Fix redis pipeline created and not used by @iamlikeme in #374

- Bump certifi from 2022.6.15 to 2022.12.7 in `/requirements` by @dependabot in #373

- Use instance’s default queue for `queued_jobs` default by @phy1729 in #368

- Docs: Add details about reusing a unique job id by @ross-nordstrom in #391

- Delete `setup.py` in #398

- Adding a job counter to address `Semaphore` issues by @rm-21 in #408

- docs: add documentation on how to retrieve running jobs by @JonasKs in #377

- feat: add `job_id` to `JobDef`, closing #376 by @JonasKs in #378

- chore: update dependencies, fixing tests by @JonasKs in #382

- refactor: refactor all asserts into raise `<exception>`, close #371 by @JonasKs in #379

- Fix: timezone info occasionally removed from cron job execution time by @iamlikeme in #383

- 3.12 support, drop 3.7, uprev dependencies by @samuelcolvin in #439

- Extend `RedisSettings` to include redis Retry Helper settings by @mernmic in #387

- Allow to connect to Redis using a Unix socket URL… by @drygdryg in #392

- Allow infinite retry by @vvmruder in #396

- Allow `max_connections` to be set in RedisSettings by @danbox in #406

- Improve `RedisSettings` explanation in `main_demo.py` by @RamonGiovane in #422

- uprev to v0.26.0b1 by @samuelcolvin in #440


### v0.25 (2022-12-02) [¶](https://arq-docs.helpmanual.io/\#v0-25-2022-12-02 "Permalink to this heading")

- Allow to opt-out from logging results by @iamlikeme in #352

- Add timezone support for cron jobs by @iamlikeme in #354

- connections: fix pipeline usage for exists command by @utkarshgupta137 in #366

- Fix race condition causing incorrect status not found by @iamlikeme in #362

- Adds `after_job_end` hook by @AngellusMortis in #355

- Raise `ResultNotFound` when `Job.result()` finds no job and no result by @iamlikeme in #364

- use `3.11` for testing #367

- Signal handler to wait for task completion before shutting down by @JonasKs in #345


### v0.24 (2022-09-05) [¶](https://arq-docs.helpmanual.io/\#v0-24-2022-09-05 "Permalink to this heading")

- Allow customisation of timezone in logs, #281

- Add the `username` option to `RedisSettings`, #299

- Change primary branch name to `main`, 40c8803

- Add `--custom-log-dict` CLI option, #294

- Fix error in case of pytz not being installed, #318

- Support and test python 3.11, #327

- Improve docs for parameter `_expires` in `enqueue_job`, #313

- Fix redis ssl support, #323

- Fix recursion while waiting for redis connection, #311

- switch from watchgod to watchfiles, #332

- Simplify dependencies, drop pydantic as a dependency., #334

- Allow use of `unix_socket_path` in `RedisSettings`, #336

- Allow user to configure a default job expiry-extra length, #303

- Remove transaction around `info` command to support Redis 6.2.3, #338

- Switch from `setup.py` to `pyproject.toml`, #341

- Support `abort` for deferred jobs, #307


### v0.23 (2022-08-23) [¶](https://arq-docs.helpmanual.io/\#v0-23-2022-08-23 "Permalink to this heading")

No changes from **v0.23a1**.

### v0.23a1 (2022-03-09) [¶](https://arq-docs.helpmanual.io/\#v0-23a1-2022-03-09 "Permalink to this heading")

- Fix jobs timeout by @kiriusm2 in #248

- Update `index.rst` by @Kludex in #266

- Improve some docs wording by @johtso in #285

- fix error when cron jobs were terminanted by @tobymao in #273

- add `on_job_start` and `on_job_end` hooks by @tobymao in #274

- Update argument docstring definition by @sondrelg in #278

- fix tests and uprev test dependencies, #288

- Add link to WorkerSettings in documentation by @JonasKs in #279

- Allow setting `job_id` on cron jobs by @JonasKs in #293

- Fix docs typo by @johtso in #296

- support aioredis v2 by @Yolley in #259

- support python 3.10, #298


### v0.22 (2021-09-02) [¶](https://arq-docs.helpmanual.io/\#v0-22-2021-09-02 "Permalink to this heading")

- fix package importing in example, #261, thanks @cdpath

- restrict `aioredis` to `<2.0.0` (soon we’ll support `aioredis>=2.0.0`), #258, thanks @PaxPrz

- auto setting version on release, 759fe03


### v0.21 (2021-07-06) [¶](https://arq-docs.helpmanual.io/\#v0-21-2021-07-06 "Permalink to this heading")

- CI improvements #243

- fix `log_redis_info` #255


### v0.20 (2021-04-26) [¶](https://arq-docs.helpmanual.io/\#v0-20-2021-04-26 "Permalink to this heading")

- Added `queue_name` attribute to `JobResult`, #198

- set `job_deserializer`, `job_serializer` and `default_queue_name` on worker pools to better supported
nested jobs, #203, #215 and #218

- All job results to be kept indefinitely, #205

- refactor `cron` jobs to prevent duplicate jobs, #200

- correctly handle `CancelledError` in python 3.8+, #213

- allow jobs to be aborted, #212

- depreciate `pole_delay` and use correct spelling `poll_delay`, #242

- docs improvements, #207 and #232


### v0.19.1 (2020-10-26) [¶](https://arq-docs.helpmanual.io/\#v0-19-1-2020-10-26 "Permalink to this heading")

- fix timestamp issue in \_defer\_until without timezone offset, #182

- add option to disable signal handler registration from running inside other frameworks, #183

- add `default_queue_name` to `create_redis_pool` and `ArqRedis`, #191

- `Worker` can retrieve the `queue_name` from the connection pool, if present

- fix potential race condition when starting jobs, #194

- support python 3.9 and pydantic 1.7, #214


### v0.19.0 (2020-04-24) [¶](https://arq-docs.helpmanual.io/\#v0-19-0-2020-04-24 "Permalink to this heading")

- Python 3.8 support, #178

- fix concurrency with multiple workers, #180

- full mypy coverage, #181


### v0.18.4 (2019-12-19) [¶](https://arq-docs.helpmanual.io/\#v0-18-4-2019-12-19 "Permalink to this heading")

- Add `py.typed` file to tell mypy the package has type hints, #163

- Added `ssl` option to `RedisSettings`, #165


### v0.18.3 (2019-11-13) [¶](https://arq-docs.helpmanual.io/\#v0-18-3-2019-11-13 "Permalink to this heading")

- Include `queue_name` when for job object in response to `enqueue_job`, #160


### v0.18.2 (2019-11-01) [¶](https://arq-docs.helpmanual.io/\#v0-18-2-2019-11-01 "Permalink to this heading")

- Fix cron scheduling on a specific queue, by @dmvass and @Tinche


### v0.18.1 (2019-10-28) [¶](https://arq-docs.helpmanual.io/\#v0-18-1-2019-10-28 "Permalink to this heading")

- add support for Redis Sentinel fix #132

- fix `Worker.abort_job` invalid expire time error, by @dmvass


### v0.18 (2019-08-30) [¶](https://arq-docs.helpmanual.io/\#v0-18-2019-08-30 "Permalink to this heading")

- fix usage of `max_burst_jobs`, improve coverage fix #152

- stop lots of `WatchVariableError` errors in log, #153


### v0.17.1 (2019-08-21) [¶](https://arq-docs.helpmanual.io/\#v0-17-1-2019-08-21 "Permalink to this heading")

- deal better with failed job deserialization, #149 by @samuelcolvin

- fix `run_check(xmax_burst_jobs=...)` when a jobs fails, #150 by @samuelcolvin


### v0.17 (2019-08-11) [¶](https://arq-docs.helpmanual.io/\#v0-17-2019-08-11 "Permalink to this heading")

- add `worker.queue_read_limit`, fix #141, by @rubik

- custom serializers, eg. to use msgpack rather than pickle, #143 by @rubik

- add `ArqRedis.queued_jobs` utility method for getting queued jobs while testing, fix #145 by @samuelcolvin


### v0.16.1 (2019-08-02) [¶](https://arq-docs.helpmanual.io/\#v0-16-1-2019-08-02 "Permalink to this heading")

- prevent duplicate `job_id` when job result exists, fix #137

- add “don’t retry mode” via `worker.retry_jobs = False`, fix #139

- add `worker.max_burst_jobs`


### v0.16 (2019-07-30) [¶](https://arq-docs.helpmanual.io/\#v0-16-2019-07-30 "Permalink to this heading")

- improved error when a job is aborted (eg. function not found)


### v0.16.0b3 (2019-05-14) [¶](https://arq-docs.helpmanual.io/\#v0-16-0b3-2019-05-14 "Permalink to this heading")

- fix semaphore on worker with many expired jobs


### v0.16.0b2 (2019-05-14) [¶](https://arq-docs.helpmanual.io/\#v0-16-0b2-2019-05-14 "Permalink to this heading")

- add support for different queues, #127 thanks @tsutsarin


### v0.16.0b1 (2019-04-23) [¶](https://arq-docs.helpmanual.io/\#v0-16-0b1-2019-04-23 "Permalink to this heading")

- use dicts for pickling not tuples, better handling of pickling errors, #123


### v0.16.0a5 (2019-04-22) [¶](https://arq-docs.helpmanual.io/\#v0-16-0a5-2019-04-22 "Permalink to this heading")

- use `pipeline` in `enqueue_job`

- catch any error when pickling job result

- add support for python 3.6


### v0.16.0a4 (2019-03-15) [¶](https://arq-docs.helpmanual.io/\#v0-16-0a4-2019-03-15 "Permalink to this heading")

- add `Worker.run_check`, fix #115


### v0.16.0a3 (2019-03-12) [¶](https://arq-docs.helpmanual.io/\#v0-16-0a3-2019-03-12 "Permalink to this heading")

- fix `Worker` with custom redis settings


### v0.16.0a2 (2019-03-06) [¶](https://arq-docs.helpmanual.io/\#v0-16-0a2-2019-03-06 "Permalink to this heading")

- add `job_try` argument to `enqueue_job`, #113

- adding `--watch` mode to the worker (requires `watchgod`), #114

- allow `ctx` when creating Worker

- add `all_job_results` to `ArqRedis`

- fix python path when starting worker


### v0.16.0a1 (2019-03-05) [¶](https://arq-docs.helpmanual.io/\#v0-16-0a1-2019-03-05 "Permalink to this heading")

- **Breaking Change:** **COMPLETE REWRITE!!!** see docs for details, #110


### v0.15.0 (2018-11-15) [¶](https://arq-docs.helpmanual.io/\#v0-15-0-2018-11-15 "Permalink to this heading")

- update dependencies

- reconfigure `Job`, return a job instance when enqueuing tasks #93

- tweaks to docs #106


### v0.14.0 (2018-05-28) [¶](https://arq-docs.helpmanual.io/\#v0-14-0-2018-05-28 "Permalink to this heading")

- package updates, particularly compatibility for `msgpack 0.5.6`


### v0.13.0 (2017-11-27) [¶](https://arq-docs.helpmanual.io/\#v0-13-0-2017-11-27 "Permalink to this heading")

- **Breaking Change:** integration with aioredis >= 1.0, basic usage hasn’t changed but
look at aioredis’s migration docs for changes in redis API #76


### v0.12.0 (2017-11-16) [¶](https://arq-docs.helpmanual.io/\#v0-12-0-2017-11-16 "Permalink to this heading")

- better signal handling, support `uvloop` #73

- drain pending tasks and drain task cancellation #74

- add aiohttp and docker demo `/demo` #75


### v0.11.0 (2017-08-25) [¶](https://arq-docs.helpmanual.io/\#v0-11-0-2017-08-25 "Permalink to this heading")

- extract `create_pool_lenient` from `RedixMixin`

- improve redis connection traceback


### v0.10.4 (2017-08-22) [¶](https://arq-docs.helpmanual.io/\#v0-10-4-2017-08-22 "Permalink to this heading")

- `RedisSettings` repr method

- add `create_connection_timeout` to connection pool


### v0.10.3 (2017-08-19) [¶](https://arq-docs.helpmanual.io/\#v0-10-3-2017-08-19 "Permalink to this heading")

- fix bug with `RedisMixin.get_redis_pool` creating multiple queues

- tweak drain logs


### v0.10.2 (2017-08-17) [¶](https://arq-docs.helpmanual.io/\#v0-10-2-2017-08-17 "Permalink to this heading")

- only save job on task in drain if re-enqueuing

- add semaphore timeout to drains

- add key count to `log_redis_info`


### v0.10.1 (2017-08-16) [¶](https://arq-docs.helpmanual.io/\#v0-10-1-2017-08-16 "Permalink to this heading")

- correct format of `log_redis_info`


### v0.10.0 (2017-08-16) [¶](https://arq-docs.helpmanual.io/\#v0-10-0-2017-08-16 "Permalink to this heading")

- log redis version when starting worker, fix #64

- log “connection success” when connecting to redis after connection failures, fix #67

- add job ids, for now they’re just used in logging, fix #53


### v0.9.0 (2017-06-23) [¶](https://arq-docs.helpmanual.io/\#v0-9-0-2017-06-23 "Permalink to this heading")

- allow set encoding in msgpack for jobs #49

- cron tasks allowing scheduling of functions in the future #50

- **Breaking change:** switch `to_unix_ms` to just return the timestamp int, add `to_unix_ms_tz` to
return tz offset too


### v0.8.1 (2017-06-05) [¶](https://arq-docs.helpmanual.io/\#v0-8-1-2017-06-05 "Permalink to this heading")

- uprev setup requires

- correct setup arguments


### v0.8.0 (2017-06-05) [¶](https://arq-docs.helpmanual.io/\#v0-8-0-2017-06-05 "Permalink to this heading")

- add `async-timeout` dependency

- use async-timeout around `shadow_factory`

- change logger name for control process log messages

- use `Semaphore` rather than `asyncio.wait(...return_when=asyncio.FIRST_COMPLETED)` for improved performance

- improve log display

- add timeout and retry logic to `RedisMixin.create_redis_pool`


### v0.7.0 (2017-06-01) [¶](https://arq-docs.helpmanual.io/\#v0-7-0-2017-06-01 "Permalink to this heading")

- implementing reusable `Drain` which takes tasks from a redis list and allows them to be execute asynchronously.

- Drain uses python 3.6 `async yield`, therefore **python 3.5 is no longer supported**.

- prevent repeated identical health check log messages


### v0.6.1 (2017-05-06) [¶](https://arq-docs.helpmanual.io/\#v0-6-1-2017-05-06 "Permalink to this heading")

- mypy at last passing, #30

- adding trove classifiers, #29


### v0.6.0 (2017-04-14) [¶](https://arq-docs.helpmanual.io/\#v0-6-0-2017-04-14 "Permalink to this heading")

- add `StopJob` exception for cleaning ending jobs, #21

- add `flushdb` to `MockRedis`, #23

- allow configurable length job logging via `log_curtail` on `Worker`, #28


### v0.5.2 (2017-02-25) [¶](https://arq-docs.helpmanual.io/\#v0-5-2-2017-02-25 "Permalink to this heading")

- add `shadow_kwargs` method to `BaseWorker` to make customising actors easier.


### v0.5.1 (2017-02-25) [¶](https://arq-docs.helpmanual.io/\#v0-5-1-2017-02-25 "Permalink to this heading")

- reimplement worker reuse as it turned out to be useful in tests.


### v0.5.0 (2017-02-20) [¶](https://arq-docs.helpmanual.io/\#v0-5-0-2017-02-20 "Permalink to this heading")

- use `gather` rather than `wait` for startup and shutdown so exceptions propagate.

- add `--check` option to confirm arq worker is running.


### v0.4.1 (2017-02-11) [¶](https://arq-docs.helpmanual.io/\#v0-4-1-2017-02-11 "Permalink to this heading")

- fix issue with `Concurrent` class binding with multiple actor instances.


### v0.4.0 (2017-02-10) [¶](https://arq-docs.helpmanual.io/\#v0-4-0-2017-02-10 "Permalink to this heading")

- improving naming of log handlers and formatters

- upgrade numerous packages, nothing significant

- add `startup` and `shutdown` methods to actors

- switch `@concurrent` to return a `Concurrent` instance so the direct method is accessible via `<func>.direct`


### v0.3.2 (2017-01-24) [¶](https://arq-docs.helpmanual.io/\#v0-3-2-2017-01-24 "Permalink to this heading")

- improved solution for preventing new jobs starting when the worker is about to stop

- switch `SIGRTMIN` \> `SIGUSR1` to work with mac


### v0.3.1 (2017-01-20) [¶](https://arq-docs.helpmanual.io/\#v0-3-1-2017-01-20 "Permalink to this heading")

- fix main process signal handling so the worker shuts down when just the main process receives a signal

- re-enqueue un-started jobs popped from the queue if the worker is about to exit


### v0.3.0 (2017-01-19) [¶](https://arq-docs.helpmanual.io/\#v0-3-0-2017-01-19 "Permalink to this heading")

- rename settings class to `RedisSettings` and simplify significantly


### v0.2.0 (2016-12-09) [¶](https://arq-docs.helpmanual.io/\#v0-2-0-2016-12-09 "Permalink to this heading")

- add `concurrency_enabled` argument to aid in testing

- fix conflict with unitest.mock


### v0.1.0 (2016-12-06) [¶](https://arq-docs.helpmanual.io/\#v0-1-0-2016-12-06 "Permalink to this heading")

- prevent logs disabling other logs


### v0.0.6 (2016-08-14) [¶](https://arq-docs.helpmanual.io/\#v0-0-6-2016-08-14 "Permalink to this heading")

- first proper release


# [arq](https://arq-docs.helpmanual.io/\#)

Star samuelcolvin/arq on GitHub[Star](https://github.com/samuelcolvin/arq) [ stargazers on GitHub](https://github.com/samuelcolvin/arq/stargazers)

[![https://secure.travis-ci.org/samuelcolvin/arq.svg?branch=master](https://secure.travis-ci.org/samuelcolvin/arq.svg?branch=master)](https://travis-ci.org/samuelcolvin/arq)

[![https://codecov.io/github/samuelcolvin/arq/coverage.svg?branch=master](https://codecov.io/github/samuelcolvin/arq/coverage.svg?branch=master)](https://codecov.io/github/samuelcolvin/arq)

### [Table of Contents](https://arq-docs.helpmanual.io/\#)

- [arq](https://arq-docs.helpmanual.io/#)
  - [Install](https://arq-docs.helpmanual.io/#install)
  - [Redesigned to be less elegant?](https://arq-docs.helpmanual.io/#redesigned-to-be-less-elegant)
  - [Usage](https://arq-docs.helpmanual.io/#usage)
    - [Simple Usage](https://arq-docs.helpmanual.io/#simple-usage)
    - [Startup & Shutdown coroutines](https://arq-docs.helpmanual.io/#startup-shutdown-coroutines)
    - [Deferring Jobs](https://arq-docs.helpmanual.io/#deferring-jobs)
    - [Job Uniqueness](https://arq-docs.helpmanual.io/#job-uniqueness)
    - [Job Results](https://arq-docs.helpmanual.io/#job-results)
    - [Retrying jobs and cancellation](https://arq-docs.helpmanual.io/#retrying-jobs-and-cancellation)
    - [Health checks](https://arq-docs.helpmanual.io/#health-checks)
    - [Cron Jobs](https://arq-docs.helpmanual.io/#cron-jobs)
    - [Synchronous Jobs](https://arq-docs.helpmanual.io/#synchronous-jobs)
    - [Custom job serializers](https://arq-docs.helpmanual.io/#custom-job-serializers)
  - [Reference](https://arq-docs.helpmanual.io/#module-arq.connections)
    - [`RedisSettings`](https://arq-docs.helpmanual.io/#arq.connections.RedisSettings)
    - [`ArqRedis`](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis)
      - [`ArqRedis.enqueue_job()`](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.enqueue_job)
      - [`ArqRedis.all_job_results()`](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.all_job_results)
      - [`ArqRedis.queued_jobs()`](https://arq-docs.helpmanual.io/#arq.connections.ArqRedis.queued_jobs)
    - [`create_pool()`](https://arq-docs.helpmanual.io/#arq.connections.create_pool)
    - [`func()`](https://arq-docs.helpmanual.io/#arq.worker.func)
    - [`Retry`](https://arq-docs.helpmanual.io/#arq.worker.Retry)
    - [`Worker`](https://arq-docs.helpmanual.io/#arq.worker.Worker)
      - [`Worker.run()`](https://arq-docs.helpmanual.io/#arq.worker.Worker.run)
      - [`Worker.async_run()`](https://arq-docs.helpmanual.io/#arq.worker.Worker.async_run)
      - [`Worker.run_check()`](https://arq-docs.helpmanual.io/#arq.worker.Worker.run_check)
      - [`Worker.start_jobs()`](https://arq-docs.helpmanual.io/#arq.worker.Worker.start_jobs)
      - [`Worker.handle_sig_wait_for_completion()`](https://arq-docs.helpmanual.io/#arq.worker.Worker.handle_sig_wait_for_completion)
    - [`cron()`](https://arq-docs.helpmanual.io/#arq.cron.cron)
    - [`JobStatus`](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus)
      - [`JobStatus.deferred`](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.deferred)
      - [`JobStatus.queued`](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.queued)
      - [`JobStatus.in_progress`](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.in_progress)
      - [`JobStatus.complete`](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.complete)
      - [`JobStatus.not_found`](https://arq-docs.helpmanual.io/#arq.jobs.JobStatus.not_found)
    - [`Job`](https://arq-docs.helpmanual.io/#arq.jobs.Job)
      - [`Job.result()`](https://arq-docs.helpmanual.io/#arq.jobs.Job.result)
      - [`Job.info()`](https://arq-docs.helpmanual.io/#arq.jobs.Job.info)
      - [`Job.result_info()`](https://arq-docs.helpmanual.io/#arq.jobs.Job.result_info)
      - [`Job.status()`](https://arq-docs.helpmanual.io/#arq.jobs.Job.status)
      - [`Job.abort()`](https://arq-docs.helpmanual.io/#arq.jobs.Job.abort)
  - [History](https://arq-docs.helpmanual.io/#history)
    - [v0.28.0 (2026-04-16)](https://arq-docs.helpmanual.io/#v0-28-0-2026-04-16)
    - [v0.27.0 (2026-01-30)](https://arq-docs.helpmanual.io/#v0-27-0-2026-01-30)
    - [v0.26.3 (2025-01-06)](https://arq-docs.helpmanual.io/#v0-26-3-2025-01-06)
    - [v0.26.1 (2023-08-29)](https://arq-docs.helpmanual.io/#v0-26-1-2023-08-29)
    - [v0.26.0 (2023-05-01)](https://arq-docs.helpmanual.io/#v0-26-0-2023-05-01)
    - [v0.26.0b1 (2023-04-01)](https://arq-docs.helpmanual.io/#v0-26-0b1-2023-04-01)
    - [v0.25 (2022-12-02)](https://arq-docs.helpmanual.io/#v0-25-2022-12-02)
    - [v0.24 (2022-09-05)](https://arq-docs.helpmanual.io/#v0-24-2022-09-05)
    - [v0.23 (2022-08-23)](https://arq-docs.helpmanual.io/#v0-23-2022-08-23)
    - [v0.23a1 (2022-03-09)](https://arq-docs.helpmanual.io/#v0-23a1-2022-03-09)
    - [v0.22 (2021-09-02)](https://arq-docs.helpmanual.io/#v0-22-2021-09-02)
    - [v0.21 (2021-07-06)](https://arq-docs.helpmanual.io/#v0-21-2021-07-06)
    - [v0.20 (2021-04-26)](https://arq-docs.helpmanual.io/#v0-20-2021-04-26)
    - [v0.19.1 (2020-10-26)](https://arq-docs.helpmanual.io/#v0-19-1-2020-10-26)
    - [v0.19.0 (2020-04-24)](https://arq-docs.helpmanual.io/#v0-19-0-2020-04-24)
    - [v0.18.4 (2019-12-19)](https://arq-docs.helpmanual.io/#v0-18-4-2019-12-19)
    - [v0.18.3 (2019-11-13)](https://arq-docs.helpmanual.io/#v0-18-3-2019-11-13)
    - [v0.18.2 (2019-11-01)](https://arq-docs.helpmanual.io/#v0-18-2-2019-11-01)
    - [v0.18.1 (2019-10-28)](https://arq-docs.helpmanual.io/#v0-18-1-2019-10-28)
    - [v0.18 (2019-08-30)](https://arq-docs.helpmanual.io/#v0-18-2019-08-30)
    - [v0.17.1 (2019-08-21)](https://arq-docs.helpmanual.io/#v0-17-1-2019-08-21)
    - [v0.17 (2019-08-11)](https://arq-docs.helpmanual.io/#v0-17-2019-08-11)
    - [v0.16.1 (2019-08-02)](https://arq-docs.helpmanual.io/#v0-16-1-2019-08-02)
    - [v0.16 (2019-07-30)](https://arq-docs.helpmanual.io/#v0-16-2019-07-30)
    - [v0.16.0b3 (2019-05-14)](https://arq-docs.helpmanual.io/#v0-16-0b3-2019-05-14)
    - [v0.16.0b2 (2019-05-14)](https://arq-docs.helpmanual.io/#v0-16-0b2-2019-05-14)
    - [v0.16.0b1 (2019-04-23)](https://arq-docs.helpmanual.io/#v0-16-0b1-2019-04-23)
    - [v0.16.0a5 (2019-04-22)](https://arq-docs.helpmanual.io/#v0-16-0a5-2019-04-22)
    - [v0.16.0a4 (2019-03-15)](https://arq-docs.helpmanual.io/#v0-16-0a4-2019-03-15)
    - [v0.16.0a3 (2019-03-12)](https://arq-docs.helpmanual.io/#v0-16-0a3-2019-03-12)
    - [v0.16.0a2 (2019-03-06)](https://arq-docs.helpmanual.io/#v0-16-0a2-2019-03-06)
    - [v0.16.0a1 (2019-03-05)](https://arq-docs.helpmanual.io/#v0-16-0a1-2019-03-05)
    - [v0.15.0 (2018-11-15)](https://arq-docs.helpmanual.io/#v0-15-0-2018-11-15)
    - [v0.14.0 (2018-05-28)](https://arq-docs.helpmanual.io/#v0-14-0-2018-05-28)
    - [v0.13.0 (2017-11-27)](https://arq-docs.helpmanual.io/#v0-13-0-2017-11-27)
    - [v0.12.0 (2017-11-16)](https://arq-docs.helpmanual.io/#v0-12-0-2017-11-16)
    - [v0.11.0 (2017-08-25)](https://arq-docs.helpmanual.io/#v0-11-0-2017-08-25)
    - [v0.10.4 (2017-08-22)](https://arq-docs.helpmanual.io/#v0-10-4-2017-08-22)
    - [v0.10.3 (2017-08-19)](https://arq-docs.helpmanual.io/#v0-10-3-2017-08-19)
    - [v0.10.2 (2017-08-17)](https://arq-docs.helpmanual.io/#v0-10-2-2017-08-17)
    - [v0.10.1 (2017-08-16)](https://arq-docs.helpmanual.io/#v0-10-1-2017-08-16)
    - [v0.10.0 (2017-08-16)](https://arq-docs.helpmanual.io/#v0-10-0-2017-08-16)
    - [v0.9.0 (2017-06-23)](https://arq-docs.helpmanual.io/#v0-9-0-2017-06-23)
    - [v0.8.1 (2017-06-05)](https://arq-docs.helpmanual.io/#v0-8-1-2017-06-05)
    - [v0.8.0 (2017-06-05)](https://arq-docs.helpmanual.io/#v0-8-0-2017-06-05)
    - [v0.7.0 (2017-06-01)](https://arq-docs.helpmanual.io/#v0-7-0-2017-06-01)
    - [v0.6.1 (2017-05-06)](https://arq-docs.helpmanual.io/#v0-6-1-2017-05-06)
    - [v0.6.0 (2017-04-14)](https://arq-docs.helpmanual.io/#v0-6-0-2017-04-14)
    - [v0.5.2 (2017-02-25)](https://arq-docs.helpmanual.io/#v0-5-2-2017-02-25)
    - [v0.5.1 (2017-02-25)](https://arq-docs.helpmanual.io/#v0-5-1-2017-02-25)
    - [v0.5.0 (2017-02-20)](https://arq-docs.helpmanual.io/#v0-5-0-2017-02-20)
    - [v0.4.1 (2017-02-11)](https://arq-docs.helpmanual.io/#v0-4-1-2017-02-11)
    - [v0.4.0 (2017-02-10)](https://arq-docs.helpmanual.io/#v0-4-0-2017-02-10)
    - [v0.3.2 (2017-01-24)](https://arq-docs.helpmanual.io/#v0-3-2-2017-01-24)
    - [v0.3.1 (2017-01-20)](https://arq-docs.helpmanual.io/#v0-3-1-2017-01-20)
    - [v0.3.0 (2017-01-19)](https://arq-docs.helpmanual.io/#v0-3-0-2017-01-19)
    - [v0.2.0 (2016-12-09)](https://arq-docs.helpmanual.io/#v0-2-0-2016-12-09)
    - [v0.1.0 (2016-12-06)](https://arq-docs.helpmanual.io/#v0-1-0-2016-12-06)
    - [v0.0.6 (2016-08-14)](https://arq-docs.helpmanual.io/#v0-0-6-2016-08-14)

### Quick search