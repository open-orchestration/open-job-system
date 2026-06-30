---
id: d93d3272e
topic: task-queues
title: "Celery monitoring and management"
status: draft
shape: reference
---

# Celery monitoring and management

There are several tools available to monitor and inspect Celery clusters, and the guide describes some of these along with features related to monitoring, like events and broadcast commands [c5276a516].

## Command-line management utilities (`inspect` / `control`)

The `celery` command can be used to inspect and manage worker nodes, and to some degree tasks [c5276a516]. Running `celery --help` lists all the commands available, and `celery <command> --help` gets help for a specific command [c5276a516].

The `status` command lists active nodes in this cluster, invoked as `celery -A proj status` [c5276a516]. The `result` command shows the result of a task, and the name of the task can be omitted as long as the task doesn't use a custom result backend [c5276a516]. The `shell` command drops into a Python shell whose locals include the `celery` variable (the current app) and all known tasks, unless the `--without-tasks` flag is set [c5276a516].

The `purge` command purges messages from all configured task queues, removing all messages from queues configured in the `CELERY_QUEUES` setting, and there is no undo for this operation as messages will be permanently deleted [c5276a516]. Queues to purge can be specified with the `-Q` option (`celery -A proj purge -Q celery,foo,bar`) and excluded with the `-X` option (`celery -A proj purge -X celery`) [c5276a516].

The `inspect` commands report worker and task state [c5276a516]:

- `inspect active` lists active tasks, which are all the tasks that are currently being executed [c5276a516].
- `inspect scheduled` lists scheduled ETA tasks, which are tasks reserved by the worker when they have an eta or countdown argument set [c5276a516].
- `inspect reserved` lists reserved tasks, which are all tasks that have been prefetched by the worker and are currently waiting to be executed, not including tasks with an ETA value set [c5276a516].
- `inspect revoked` lists the history of revoked tasks [c5276a516].
- `inspect registered` lists registered tasks [c5276a516].
- `inspect stats` shows worker statistics [c5276a516].
- `inspect query_task` shows information about task(s) by id, and any worker having a task in the given set of ids reserved or active will respond with status and information [c5276a516].

The `control enable_events` and `control disable_events` commands enable and disable events respectively [c5276a516]. The `migrate` command migrates all the tasks from one broker to another and is described as new and experimental, so a backup of the data should be made before proceeding [c5276a516].

All `inspect` and `control` commands support a `--timeout` argument, the number of seconds to wait for responses, which may have to be increased when a response is not received due to latency [c5276a516].

### Specifying destination nodes

By default the inspect and control commands operate on all workers, and a single worker or a list of workers can be specified using the `--destination` argument (for example `celery -A proj inspect -d w1@e.com,w2@e.com reserved`) [c5276a516].

## Flower: real-time web monitor

Flower is a real-time web based monitor and administration tool for Celery, and being the recommended monitor for Celery it obsoletes the Django-Admin monitor, `celerymon`, and the `ncurses` based monitor [c5276a516]. Its features include real-time monitoring using Celery Events (task progress and history, task details, graphs and statistics), remote control (viewing worker status and statistics, shutting down and restarting worker instances, controlling worker pool size and autoscale settings, viewing and modifying the queues a worker consumes from, viewing running, scheduled, reserved and revoked tasks, applying time and rate limits, and revoking or terminating tasks), an HTTP API, and OpenID authentication [c5276a516].

Flower can be installed with `pip install flower`, and running `celery -A proj flower` starts a web-server that can be visited [c5276a516]. The default port is `http://localhost:5555`, which can be changed using the `--port` argument, and the broker URL can be passed through the `--broker` argument [c5276a516].

## celery events: curses monitor

`celery events` is a simple curses monitor displaying task and worker history, where the result and traceback of tasks can be inspected, and it also supports some management commands like rate limiting and shutting down workers; it was started as a proof of concept and Flower is the suggested alternative [c5276a516]. It is started with `celery -A proj events`, is also used to start snapshot cameras (`celery -A proj events --camera=<camera-class> --frequency=1.0`), and includes a tool to dump events to `stdout` (`celery -A proj events --dump`) [c5276a516].

## Broker and result-backend monitoring

To manage a Celery cluster it is important to know how RabbitMQ can be monitored, and RabbitMQ ships with the `rabbitmqctl(1)` command that can list queues, exchanges, bindings, queue lengths, the memory usage of each queue, and manage users, virtual hosts and their permissions [c5276a516]. The number of tasks in a queue is found with `rabbitmqctl list_queues name messages messages_ready messages_unacknowledged`, where `messages_ready` is the number of messages ready for delivery (sent but not received), `messages_unacknowledged` is the number received by a worker but not yet acknowledged, and `messages` is the sum of ready and unacknowledged messages [c5276a516]. The number of workers consuming from a queue is found with `rabbitmqctl list_queues name consumers` [c5276a516].

If Redis is used as the broker, the Celery cluster can be monitored using the `redis-cli(1)` command to list lengths of queues [c5276a516]. The number of tasks in a queue is found with `redis-cli -h HOST -p PORT -n DATABASE_NUMBER llen QUEUE_NAME`, the default queue is named `celery`, and queue keys only exist when there are tasks in them because in Redis a list with no elements is automatically removed [c5276a516].

While Prometheus monitoring is not a native part of Celery, Celery workers can be monitored using Prometheus via Flower, which also provides pre-made Grafana dashboards to graph the amount of tasks, workers and other statistics [c5276a516].

## Events

The worker has the ability to send a message whenever some event happens, and these events are then captured by tools like Flower and `celery events` to monitor the cluster [c5276a516].

A single worker can produce a huge amount of events, so storing the history of all events on disk may be very expensive; taking periodic snapshots of the cluster state lets all history be kept while only periodically writing it to disk [c5276a516]. Taking snapshots requires a Camera class that defines what should happen every time the state is captured, and `celery events` is then used to take snapshots with the camera (for example `celery -A proj events -c myapp.Camera --frequency=2.0`) [c5276a516].

To process events in real-time you need an event consumer (the `Receiver`), a set of handlers called when events come in (with a handler per event type or a catch-all handler `'*'`), and optionally State [c5276a516]. `app.events.State` is a convenient in-memory representation of tasks and workers in the cluster that is updated as events come in, and it encapsulates solutions for things like checking if a worker is still alive by verifying heartbeats, merging event fields, and keeping time-stamps in sync [c5276a516]. The `wakeup` argument to `capture` sends a signal to all workers to force them to send a heartbeat, so workers can be seen immediately when the monitor starts [c5276a516].

The worker sends task events including `task-sent`, `task-received`, `task-started`, `task-succeeded`, `task-failed`, `task-rejected`, `task-revoked`, and `task-retried`, and worker events including `worker-online`, `worker-heartbeat`, and `worker-offline` [c5276a516]. The `worker-heartbeat` event is sent every minute, and if the worker hasn't sent a heartbeat in 2 minutes it is considered to be offline [c5276a516].
