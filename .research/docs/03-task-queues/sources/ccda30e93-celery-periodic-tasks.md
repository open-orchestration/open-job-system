### Navigation

- [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
- [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") \|
- [next](https://docs.celeryq.dev/en/stable/userguide/routing.html "Routing Tasks") \|
- [previous](https://docs.celeryq.dev/en/stable/userguide/daemonizing.html "Daemonization") \|
- [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
- [User Guide](https://docs.celeryq.dev/en/stable/userguide/index.html) »
- [Periodic Tasks](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html)

This document describes the current stable version of Celery (5.6).
For development docs,
[go here](https://docs.celeryq.dev/en/main/userguide/periodic-tasks.html).


# Periodic Tasks [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#periodic-tasks "Link to this heading")

- [Introduction](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#introduction)

- [Time Zones](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#time-zones)

- [Entries](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#entries)

  - [Available Fields](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#available-fields)
- [Crontab schedules](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#crontab-schedules)

- [Solar schedules](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#solar-schedules)

- [Starting the Scheduler](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#starting-the-scheduler)

  - [Using custom scheduler classes](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#using-custom-scheduler-classes)

## [Introduction](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#id1) [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#introduction "Link to this heading")

**celery beat** is a scheduler; It kicks off tasks at regular intervals,
that are then executed by available worker nodes in the cluster.

By default the entries are taken from the [`beat_schedule`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-beat_schedule) setting,
but custom stores can also be used, like storing the entries in a SQL database.

You have to ensure only a single scheduler is running for a schedule
at a time, otherwise you’d end up with duplicate tasks. Using
a centralized approach means the schedule doesn’t have to be synchronized,
and the service can operate without using locks.

## [Time Zones](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#id2) [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#time-zones "Link to this heading")

The periodic task schedules uses the UTC time zone by default,
but you can change the time zone used using the [`timezone`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-timezone)
setting.

An example time zone could be Europe/London:

```
timezone = 'Europe/London'
```

This setting must be added to your app, either by configuring it directly
using (`app.conf.timezone = 'Europe/London'`), or by adding
it to your configuration module if you have set one up using
`app.config_from_object`. See [Configuration](https://docs.celeryq.dev/en/stable/getting-started/first-steps-with-celery.html#celerytut-configuration) for
more information about configuration options.

The default scheduler (storing the schedule in the `celerybeat-schedule`
file) will automatically detect that the time zone has changed, and so will
reset the schedule itself, but other schedulers may not be so smart (e.g., the
Django database scheduler, see below) and in that case you’ll have to reset the
schedule manually.

Django Users

Celery recommends and is compatible with the `USE_TZ` setting introduced
in Django 1.4.

For Django users the time zone specified in the `TIME_ZONE` setting
will be used, or you can specify a custom time zone for Celery alone
by using the [`timezone`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-timezone) setting.

The database scheduler won’t reset when timezone related settings
change, so you must do this manually:

```
$ python manage.py shell
>>> from djcelery.models import PeriodicTask
>>> PeriodicTask.objects.update(last_run_at=None)
```

Django-Celery only supports Celery 4.0 and below, for Celery 4.0 and above, do as follow:

```
$ python manage.py shell
>>> from django_celery_beat.models import PeriodicTask
>>> PeriodicTask.objects.update(last_run_at=None)
```

## [Entries](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#id3) [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#entries "Link to this heading")

To call a task periodically you have to add an entry to the
beat schedule list.

```
from celery import Celery
from celery.schedules import crontab

app = Celery()

@app.on_after_configure.connect
def setup_periodic_tasks(sender: Celery, **kwargs):
    # Calls test('hello') every 10 seconds.
    sender.add_periodic_task(10.0, test.s('hello'), name='add every 10')

    # Calls test('hello') every 30 seconds.
    # It uses the same signature of previous task, an explicit name is
    # defined to avoid this task replacing the previous one defined.
    sender.add_periodic_task(30.0, test.s('hello'), name='add every 30')

    # Calls test('world') every 30 seconds
    sender.add_periodic_task(30.0, test.s('world'), expires=10)

    # Executes every Monday morning at 7:30 a.m.
    sender.add_periodic_task(
        crontab(hour=7, minute=30, day_of_week=1),
        test.s('Happy Mondays!'),
    )

@app.task
def test(arg):
    print(arg)

@app.task
def add(x, y):
    z = x + y
    print(z)
```

Setting these up from within the [`on_after_configure`](https://docs.celeryq.dev/en/stable/reference/celery.html#celery.Celery.on_after_configure "celery.Celery.on_after_configure") handler means
that we’ll not evaluate the app at module level when using `test.s()`. Note that
[`on_after_configure`](https://docs.celeryq.dev/en/stable/reference/celery.html#celery.Celery.on_after_configure "celery.Celery.on_after_configure") is sent after the app is set up, so tasks outside the
module where the app is declared (e.g. in a tasks.py file located by
[`celery.Celery.autodiscover_tasks()`](https://docs.celeryq.dev/en/stable/reference/celery.html#celery.Celery.autodiscover_tasks "celery.Celery.autodiscover_tasks")) must use a later signal, such as
[`on_after_finalize`](https://docs.celeryq.dev/en/stable/reference/celery.html#celery.Celery.on_after_finalize "celery.Celery.on_after_finalize").

The [`add_periodic_task()`](https://docs.celeryq.dev/en/stable/reference/celery.html#celery.Celery.add_periodic_task "celery.Celery.add_periodic_task") function will add the entry to the
[`beat_schedule`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-beat_schedule) setting behind the scenes, and the same setting
can also be used to set up periodic tasks manually:

Example: Run the tasks.add task every 30 seconds.

```
app.conf.beat_schedule = {
    'add-every-30-seconds': {
        'task': 'tasks.add',
        'schedule': 30.0,
        'args': (16, 16)
    },
}
app.conf.timezone = 'UTC'
```

Note

If you’re wondering where these settings should go then
please see [Configuration](https://docs.celeryq.dev/en/stable/getting-started/first-steps-with-celery.html#celerytut-configuration). You can either
set these options on your app directly or you can keep
a separate module for configuration.

If you want to use a single item tuple for args, don’t forget
that the constructor is a comma, and not a pair of parentheses.

Using a [`timedelta`](https://docs.python.org/dev/library/datetime.html#datetime.timedelta "(in Python v3.15)") for the schedule means the task will
be sent in 30 second intervals (the first task will be sent 30 seconds
after celery beat starts, and then every 30 seconds
after the last run).

A Crontab like schedule also exists, see the section on [Crontab schedules](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html#crontab-schedules).

Like with **cron**, the tasks may overlap if the first task doesn’t complete
before the next. If that’s a concern you should use a locking
strategy to ensure only one instance can run at a time (see for example
[Ensuring a task is only executed one at a time](https://docs.celeryq.dev/en/stable/tutorials/task-cookbook.html#cookbook-task-serial)).

### [Available Fields](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#id4) [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#available-fields "Link to this heading")

- task


> The name of the task to execute.
>
> Task names are described in the [Names](https://docs.celeryq.dev/en/stable/userguide/tasks.html#task-names) section of the User Guide.
> Note that this is not the import path of the task, even though the default
> naming pattern is built like it is.

- schedule


> The frequency of execution.
>
> This can be the number of seconds as an integer, a
> [`timedelta`](https://docs.python.org/dev/library/datetime.html#datetime.timedelta "(in Python v3.15)"), or a [`crontab`](https://docs.celeryq.dev/en/stable/reference/celery.schedules.html#celery.schedules.crontab "celery.schedules.crontab").
> You can also define your own custom schedule types, by extending the
> interface of [`schedule`](https://docs.celeryq.dev/en/stable/reference/celery.schedules.html#celery.schedules.schedule "celery.schedules.schedule").

- args


> Positional arguments ( [`list`](https://docs.python.org/dev/library/stdtypes.html#list "(in Python v3.15)") or [`tuple`](https://docs.python.org/dev/library/stdtypes.html#tuple "(in Python v3.15)")).

- kwargs


> Keyword arguments ( [`dict`](https://docs.python.org/dev/library/stdtypes.html#dict "(in Python v3.15)")).

- options


> Execution options ( [`dict`](https://docs.python.org/dev/library/stdtypes.html#dict "(in Python v3.15)")).
>
> This can be any argument supported by
> [`apply_async()`](https://docs.celeryq.dev/en/stable/reference/celery.app.task.html#celery.app.task.Task.apply_async "celery.app.task.Task.apply_async") –
> exchange, routing\_key, expires, and so on.

- relative


> If relative is true [`timedelta`](https://docs.python.org/dev/library/datetime.html#datetime.timedelta "(in Python v3.15)") schedules are scheduled
> “by the clock.” This means the frequency is rounded to the nearest
> second, minute, hour or day depending on the period of the
> [`timedelta`](https://docs.python.org/dev/library/datetime.html#datetime.timedelta "(in Python v3.15)").
>
> By default relative is false, the frequency isn’t rounded and will be
> relative to the time when **celery beat** was started.


## [Crontab schedules](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#id5) [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#crontab-schedules "Link to this heading")

If you want more control over when the task is executed, for
example, a particular time of day or day of the week, you can use
the [`crontab`](https://docs.celeryq.dev/en/stable/reference/celery.schedules.html#celery.schedules.crontab "celery.schedules.crontab") schedule type:

```
from celery.schedules import crontab

app.conf.beat_schedule = {
    # Executes every Monday morning at 7:30 a.m.
    'add-every-monday-morning': {
        'task': 'tasks.add',
        'schedule': crontab(hour=7, minute=30, day_of_week=1),
        'args': (16, 16),
    },
}
```

The syntax of these Crontab expressions are very flexible.

Some examples:

|     |     |
| --- | --- |
| **Example** | **Meaning** |
| `crontab()` | Execute every minute. |
| `crontab(minute=0, hour=0)` | Execute daily at midnight. |
| `crontab(minute=0, hour='*/3')` | Execute every three hours:<br>midnight, 3am, 6am, 9am,<br>noon, 3pm, 6pm, 9pm. |
| `crontab(minute=0,`<br>`hour='0,3,6,9,12,15,18,21')` | Same as previous. |
| `crontab(minute='*/15')` | Execute every 15 minutes. |
| `crontab(day_of_week='sunday')` | Execute every minute (!) at Sundays. |
| `crontab(minute='*',`<br>`hour='*',``day_of_week='sun')` | Same as previous. |
| `crontab(minute='*/10',`<br>`hour='3,17,22',``day_of_week='thu,fri')` | Execute every ten minutes, but only<br>between 3-4 am, 5-6 pm, and 10-11 pm on<br>Thursdays or Fridays. |
| `crontab(minute=0, hour='*/2,*/3')` | Execute every even hour, and every hour<br>divisible by three. This means:<br>at every hour _except_: 1am,<br>5am, 7am, 11am, 1pm, 5pm, 7pm,<br>11pm |
| `crontab(minute=0, hour='*/5')` | Execute hour divisible by 5. This means<br>that it is triggered at 3pm, not 5pm<br>(since 3pm equals the 24-hour clock<br>value of “15”, which is divisible by 5). |
| `crontab(minute=0, hour='*/3,8-17')` | Execute every hour divisible by 3, and<br>every hour during office hours (8am-5pm). |
| `crontab(0, 0, day_of_month='2')` | Execute on the second day of every month. |
| `crontab(0, 0,`<br>`day_of_month='2-30/2')` | Execute on every even numbered day. |
| `crontab(0, 0,`<br>`day_of_month='1-7,15-21')` | Execute on the first and third weeks of<br>the month. |
| `crontab(0, 0, day_of_month='11',`<br>`month_of_year='5')` | Execute on the eleventh of May every year. |
| `crontab(0, 0,`<br>`month_of_year='*/3')` | Execute every day on the first month<br>of every quarter. |

See [`celery.schedules.crontab`](https://docs.celeryq.dev/en/stable/reference/celery.schedules.html#celery.schedules.crontab "celery.schedules.crontab") for more documentation.

## [Solar schedules](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#id6) [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#solar-schedules "Link to this heading")

If you have a task that should be executed according to sunrise,
sunset, dawn or dusk, you can use the
[`solar`](https://docs.celeryq.dev/en/stable/reference/celery.schedules.html#celery.schedules.solar "celery.schedules.solar") schedule type:

```
from celery.schedules import solar

app.conf.beat_schedule = {
    # Executes at sunset in Melbourne
    'add-at-melbourne-sunset': {
        'task': 'tasks.add',
        'schedule': solar('sunset', -37.81753, 144.96715),
        'args': (16, 16),
    },
}
```

The arguments are simply: `solar(event, latitude, longitude)`

Be sure to use the correct sign for latitude and longitude:

|     |     |     |
| --- | --- | --- |
| **Sign** | **Argument** | **Meaning** |
| `+` | `latitude` | North |
| `-` | `latitude` | South |
| `+` | `longitude` | East |
| `-` | `longitude` | West |

Possible event types are:

|     |     |
| --- | --- |
| **Event** | **Meaning** |
| `dawn_astronomical` | Execute at the moment after which the sky<br>is no longer completely dark. This is when<br>the sun is 18 degrees below the horizon. |
| `dawn_nautical` | Execute when there’s enough sunlight for<br>the horizon and some objects to be<br>distinguishable; formally, when the sun is<br>12 degrees below the horizon. |
| `dawn_civil` | Execute when there’s enough light for<br>objects to be distinguishable so that<br>outdoor activities can commence;<br>formally, when the Sun is 6 degrees below<br>the horizon. |
| `sunrise` | Execute when the upper edge of the sun<br>appears over the eastern horizon in the<br>morning. |
| `solar_noon` | Execute when the sun is highest above the<br>horizon on that day. |
| `sunset` | Execute when the trailing edge of the sun<br>disappears over the western horizon in the<br>evening. |
| `dusk_civil` | Execute at the end of civil twilight, when<br>objects are still distinguishable and some<br>stars and planets are visible. Formally,<br>when the sun is 6 degrees below the<br>horizon. |
| `dusk_nautical` | Execute when the sun is 12 degrees below<br>the horizon. Objects are no longer<br>distinguishable, and the horizon is no<br>longer visible to the naked eye. |
| `dusk_astronomical` | Execute at the moment after which the sky<br>becomes completely dark; formally, when<br>the sun is 18 degrees below the horizon. |

All solar events are calculated using UTC, and are therefore
unaffected by your timezone setting.

In polar regions, the sun may not rise or set every day. The scheduler
is able to handle these cases (i.e., a `sunrise` event won’t run on a day
when the sun doesn’t rise). The one exception is `solar_noon`, which is
formally defined as the moment the sun transits the celestial meridian,
and will occur every day even if the sun is below the horizon.

Twilight is defined as the period between dawn and sunrise; and between
sunset and dusk. You can schedule an event according to “twilight”
depending on your definition of twilight (civil, nautical, or astronomical),
and whether you want the event to take place at the beginning or end
of twilight, using the appropriate event from the list above.

See [`celery.schedules.solar`](https://docs.celeryq.dev/en/stable/reference/celery.schedules.html#celery.schedules.solar "celery.schedules.solar") for more documentation.

## [Starting the Scheduler](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#id7) [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#starting-the-scheduler "Link to this heading")

To start the **celery beat** service:

```
$ celery -A proj beat
```

You can also embed beat inside the worker by enabling the
workers [`-B`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-worker-B) option, this is convenient if you’ll
never run more than one worker node, but it’s not commonly used and for that
reason isn’t recommended for production use:

```
$ celery -A proj worker -B
```

Beat needs to store the last run times of the tasks in a local database
file (named celerybeat-schedule by default), so it needs access to
write in the current directory, or alternatively you can specify a custom
location for this file:

```
$ celery -A proj beat -s /home/celery/var/run/celerybeat-schedule
```

Note

To daemonize beat see [Daemonization](https://docs.celeryq.dev/en/stable/userguide/daemonizing.html#daemonizing).

### [Using custom scheduler classes](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#id8) [¶](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html\#using-custom-scheduler-classes "Link to this heading")

Custom scheduler classes can be specified on the command-line (the
[`--scheduler`](https://docs.celeryq.dev/en/stable/reference/cli.html#cmdoption-celery-beat-S) argument).

The default scheduler is the [`celery.beat.PersistentScheduler`](https://docs.celeryq.dev/en/stable/reference/celery.beat.html#celery.beat.PersistentScheduler "celery.beat.PersistentScheduler"),
that simply keeps track of the last run times in a local [`shelve`](https://docs.python.org/dev/library/shelve.html#module-shelve "(in Python v3.15)")
database file.

There’s also the [https://pypi.org/project/django-celery-beat/](https://pypi.org/project/django-celery-beat/) extension that stores the schedule
in the Django database, and presents a convenient admin interface to manage
periodic tasks at runtime.

To install and use this extension:

1. Use **pip** to install the package:


> ```
> $ pip install django-celery-beat
> ```

2. Add the `django_celery_beat` module to `INSTALLED_APPS` in your
Django project’ `settings.py`:





```
INSTALLED_APPS = (
       ...,
       'django_celery_beat',
)
```





Note that there is no dash in the module name, only underscores.

3. Apply Django database migrations so that the necessary tables are created:


> ```
> $ python manage.py migrate
> ```

4. Start the **celery beat** service using the `django_celery_beat.schedulers:DatabaseScheduler` scheduler:


> ```
> $ celery -A proj beat -l INFO --scheduler django_celery_beat.schedulers:DatabaseScheduler
> ```


Note: You may also add this as the [`beat_scheduler`](https://docs.celeryq.dev/en/stable/userguide/configuration.html#std-setting-beat_scheduler) setting directly.

5. Visit the Django-Admin interface to set up some periodic tasks.


[![Logo of Celery](https://docs.celeryq.dev/en/stable/_static/celery_512.png)](https://docs.celeryq.dev/en/stable/index.html)

Star celery/celery on GitHub[Star](https://github.com/celery/celery) [28,587](https://github.com/celery/celery/stargazers)

### Donations

Please help support this community project with a donation.

[![](https://opencollective.com/celery/donate/button@2x.png?color=blue)](https://opencollective.com/celery/donate)

#### Previous topic

[Daemonization](https://docs.celeryq.dev/en/stable/userguide/daemonizing.html "previous chapter")

#### Next topic

[Routing Tasks](https://docs.celeryq.dev/en/stable/userguide/routing.html "next chapter")

### This Page

- [Show Source](https://docs.celeryq.dev/en/stable/_sources/userguide/periodic-tasks.rst.txt)

### Quick search

### Navigation

- [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
- [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") \|
- [next](https://docs.celeryq.dev/en/stable/userguide/routing.html "Routing Tasks") \|
- [previous](https://docs.celeryq.dev/en/stable/userguide/daemonizing.html "Daemonization") \|
- [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
- [User Guide](https://docs.celeryq.dev/en/stable/userguide/index.html) »
- [Periodic Tasks](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html)

© [Copyright](https://docs.celeryq.dev/en/stable/copyright.html) 2009-2023, Ask Solem & contributors.


![Read the Docs](<Base64-Image-Removed>)stable
Versions[latest](https://docs.celeryq.dev/en/latest/userguide/periodic-tasks.html)**[stable](https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html)**[v5.6.3](https://docs.celeryq.dev/en/v5.6.3/userguide/periodic-tasks.html)[v5.6.2](https://docs.celeryq.dev/en/v5.6.2/userguide/periodic-tasks.html)[v5.6.1](https://docs.celeryq.dev/en/v5.6.1/userguide/periodic-tasks.html)[v5.6.0](https://docs.celeryq.dev/en/v5.6.0/userguide/periodic-tasks.html)[v5.5.3](https://docs.celeryq.dev/en/v5.5.3/userguide/periodic-tasks.html)[v5.5.2](https://docs.celeryq.dev/en/v5.5.2/userguide/periodic-tasks.html)[v5.5.1](https://docs.celeryq.dev/en/v5.5.1/userguide/periodic-tasks.html)[v5.5.0](https://docs.celeryq.dev/en/v5.5.0/userguide/periodic-tasks.html)[v5.4.0](https://docs.celeryq.dev/en/v5.4.0/userguide/periodic-tasks.html)[v5.3.6](https://docs.celeryq.dev/en/v5.3.6/userguide/periodic-tasks.html)[v5.3.5](https://docs.celeryq.dev/en/v5.3.5/userguide/periodic-tasks.html)[v5.3.4](https://docs.celeryq.dev/en/v5.3.4/userguide/periodic-tasks.html)[v5.3.3](https://docs.celeryq.dev/en/v5.3.3/userguide/periodic-tasks.html)[v5.3.2](https://docs.celeryq.dev/en/v5.3.2/userguide/periodic-tasks.html)[v5.3.1](https://docs.celeryq.dev/en/v5.3.1/userguide/periodic-tasks.html)[v5.3.0](https://docs.celeryq.dev/en/v5.3.0/userguide/periodic-tasks.html)[v5.2.7](https://docs.celeryq.dev/en/v5.2.7/userguide/periodic-tasks.html)[v5.2.6](https://docs.celeryq.dev/en/v5.2.6/userguide/periodic-tasks.html)[v5.2.5](https://docs.celeryq.dev/en/v5.2.5/userguide/periodic-tasks.html)[v5.2.4](https://docs.celeryq.dev/en/v5.2.4/userguide/periodic-tasks.html)[v5.2.3](https://docs.celeryq.dev/en/v5.2.3/userguide/periodic-tasks.html)[v5.2.2](https://docs.celeryq.dev/en/v5.2.2/userguide/periodic-tasks.html)[v5.2.1](https://docs.celeryq.dev/en/v5.2.1/userguide/periodic-tasks.html)[v5.2.0](https://docs.celeryq.dev/en/v5.2.0/userguide/periodic-tasks.html)[v5.1.2](https://docs.celeryq.dev/en/v5.1.2/userguide/periodic-tasks.html)[v5.1.1](https://docs.celeryq.dev/en/v5.1.1/userguide/periodic-tasks.html)[v5.1.0](https://docs.celeryq.dev/en/v5.1.0/userguide/periodic-tasks.html)[v5.0.5](https://docs.celeryq.dev/en/v5.0.5/userguide/periodic-tasks.html)[v5.0.2](https://docs.celeryq.dev/en/v5.0.2/userguide/periodic-tasks.html)[v5.0.1](https://docs.celeryq.dev/en/v5.0.1/userguide/periodic-tasks.html)[v5.0.0](https://docs.celeryq.dev/en/v5.0.0/userguide/periodic-tasks.html)[v4.4.7](https://docs.celeryq.dev/en/v4.4.7/userguide/periodic-tasks.html)[v4.4.6](https://docs.celeryq.dev/en/v4.4.6/userguide/periodic-tasks.html)[v4.4.5](https://docs.celeryq.dev/en/v4.4.5/userguide/periodic-tasks.html)[v4.4.4](https://docs.celeryq.dev/en/v4.4.4/userguide/periodic-tasks.html)[4.4.3](https://docs.celeryq.dev/en/4.4.3/userguide/periodic-tasks.html)[4.4.2](https://docs.celeryq.dev/en/4.4.2/userguide/periodic-tasks.html)[4.4.1](https://docs.celeryq.dev/en/4.4.1/userguide/periodic-tasks.html)[4.4.0](https://docs.celeryq.dev/en/4.4.0/userguide/periodic-tasks.html)[v4.3.0](https://docs.celeryq.dev/en/v4.3.0/userguide/periodic-tasks.html)[v4.2.2](https://docs.celeryq.dev/en/v4.2.2/userguide/periodic-tasks.html)[v4.2.1](https://docs.celeryq.dev/en/v4.2.1/userguide/periodic-tasks.html)[v4.2.0](https://docs.celeryq.dev/en/v4.2.0/userguide/periodic-tasks.html)[v4.1.0](https://docs.celeryq.dev/en/v4.1.0/userguide/periodic-tasks.html)[v4.0.2](https://docs.celeryq.dev/en/v4.0.2/userguide/periodic-tasks.html)[v4.0.1](https://docs.celeryq.dev/en/v4.0.1/userguide/periodic-tasks.html)[v4.0.0](https://docs.celeryq.dev/en/v4.0.0/userguide/periodic-tasks.html)[4.0](https://docs.celeryq.dev/en/4.0/userguide/periodic-tasks.html)[3.1](https://docs.celeryq.dev/en/3.1/userguide/periodic-tasks.html)[3.0](https://docs.celeryq.dev/en/3.0/userguide/periodic-tasks.html)[main](https://docs.celeryq.dev/en/main/userguide/periodic-tasks.html)[2.5-archived](https://docs.celeryq.dev/en/2.5-archived/userguide/periodic-tasks.html)[2.4-archived](https://docs.celeryq.dev/en/2.4-archived/userguide/periodic-tasks.html)[2.3-archived](https://docs.celeryq.dev/en/2.3-archived/userguide/periodic-tasks.html)[2.2-archived](https://docs.celeryq.dev/en/2.2-archived/userguide/periodic-tasks.html)[2.1-archived](https://docs.celeryq.dev/en/2.1-archived/userguide/periodic-tasks.html)[2.0-archived](https://docs.celeryq.dev/en/2.0-archived/userguide/periodic-tasks.html)[1.0-archived](https://docs.celeryq.dev/en/1.0-archived/userguide/periodic-tasks.html)On Read the Docs[Project Home](https://app.readthedocs.org/projects/celery/?utm_source=celery&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/celery/builds/?utm_source=celery&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=celery&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=celery&utm_content=flyout)