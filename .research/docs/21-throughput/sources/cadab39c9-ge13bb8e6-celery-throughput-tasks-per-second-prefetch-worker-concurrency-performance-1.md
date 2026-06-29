### Navigation
  * [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
  * [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") |
  * [next](https://docs.celeryq.dev/en/stable/userguide/concurrency/eventlet.html "Concurrency with Eventlet") |
  * [previous](https://docs.celeryq.dev/en/stable/userguide/debugging.html "Debugging") |
  * [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
  * [User Guide](https://docs.celeryq.dev/en/stable/userguide/index.html) »
  * [Concurrency](https://docs.celeryq.dev/en/stable/userguide/concurrency/index.html)


This document describes the current stable version of Celery (5.6). For development docs, [go here](https://docs.celeryq.dev/en/main/userguide/concurrency/index.html). 
# Concurrency[¶](https://docs.celeryq.dev/en/stable/userguide/concurrency/index.html#concurrency "Link to this heading") 

Release: 
    
5.6 

Date: 
    
Mar 26, 2026
Concurrency in Celery enables the parallel execution of tasks. The default model, prefork, is well-suited for many scenarios and generally recommended for most users. In fact, switching to another mode will silently disable certain features like soft_timeout and max_tasks_per_child.
This page gives a quick overview of the available options which you can pick between using the –pool option when starting the worker.
## Overview of Concurrency Options[¶](https://docs.celeryq.dev/en/stable/userguide/concurrency/index.html#overview-of-concurrency-options "Link to this heading")
  * prefork: The default option, ideal for CPU-bound tasks and most use cases. It is robust and recommended unless there’s a specific need for another model.
  * eventlet and gevent: Designed for IO-bound tasks, these models use greenlets for high concurrency. Note that certain features, like soft_timeout, are not available in these modes. These have detailed documentation pages linked below.
  * solo: Executes tasks sequentially in the main thread.
  * threads: Utilizes threading for concurrency, available if the concurrent.futures module is present.
  * custom: Enables specifying a custom worker pool implementation through environment variables.


  * [Concurrency with Eventlet](https://docs.celeryq.dev/en/stable/userguide/concurrency/eventlet.html)
    * [Introduction](https://docs.celeryq.dev/en/stable/userguide/concurrency/eventlet.html#introduction)
    * [Enabling Eventlet](https://docs.celeryq.dev/en/stable/userguide/concurrency/eventlet.html#enabling-eventlet)
    * [Examples](https://docs.celeryq.dev/en/stable/userguide/concurrency/eventlet.html#examples)
  * [Concurrency with gevent](https://docs.celeryq.dev/en/stable/userguide/concurrency/gevent.html)
    * [Introduction](https://docs.celeryq.dev/en/stable/userguide/concurrency/gevent.html#introduction)
    * [Enabling gevent](https://docs.celeryq.dev/en/stable/userguide/concurrency/gevent.html#enabling-gevent)
    * [Examples](https://docs.celeryq.dev/en/stable/userguide/concurrency/gevent.html#examples)
    * [Known issues](https://docs.celeryq.dev/en/stable/userguide/concurrency/gevent.html#known-issues)


Note
While alternative models like eventlet and gevent are available, they may lack certain features compared to prefork. We recommend prefork as the starting point unless specific requirements dictate otherwise.
[ ![Logo of Celery](https://docs.celeryq.dev/en/stable/_static/celery_512.png) ](https://docs.celeryq.dev/en/stable/index.html)
### Donations
Please help support this community project with a donation.
[ ![](https://opencollective.com/celery/donate/button@2x.png?color=blue) ](https://opencollective.com/celery/donate)
#### Previous topic
[Debugging](https://docs.celeryq.dev/en/stable/userguide/debugging.html "previous chapter")
#### Next topic
[Concurrency with Eventlet](https://docs.celeryq.dev/en/stable/userguide/concurrency/eventlet.html "next chapter")
### This Page
  * [Show Source](https://docs.celeryq.dev/en/stable/_sources/userguide/concurrency/index.rst.txt)


### Quick search
### Navigation
  * [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
  * [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") |
  * [next](https://docs.celeryq.dev/en/stable/userguide/concurrency/eventlet.html "Concurrency with Eventlet") |
  * [previous](https://docs.celeryq.dev/en/stable/userguide/debugging.html "Debugging") |
  * [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
  * [User Guide](https://docs.celeryq.dev/en/stable/userguide/index.html) »
  * [Concurrency](https://docs.celeryq.dev/en/stable/userguide/concurrency/index.html)


© [Copyright](https://docs.celeryq.dev/en/stable/copyright.html) 2009-2023, Ask Solem & contributors. 

