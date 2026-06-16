[Luigi\\
![Logo](https://luigi.readthedocs.io/en/stable/_static/luigi.png)](https://luigi.readthedocs.io/en/stable/#)

latest

stable


- [Example – Top Artists](https://luigi.readthedocs.io/en/stable/example_top_artists.html)
- [Building workflows](https://luigi.readthedocs.io/en/stable/workflows.html)
- [Tasks](https://luigi.readthedocs.io/en/stable/tasks.html)
- [Parameters](https://luigi.readthedocs.io/en/stable/parameters.html)
- [Running Luigi](https://luigi.readthedocs.io/en/stable/running_luigi.html)
- [Using the Central Scheduler](https://luigi.readthedocs.io/en/stable/central_scheduler.html)
- [Execution Model](https://luigi.readthedocs.io/en/stable/execution_model.html)
- [Luigi Patterns](https://luigi.readthedocs.io/en/stable/luigi_patterns.html)
- [Configuration](https://luigi.readthedocs.io/en/stable/configuration.html)
- [Configure logging](https://luigi.readthedocs.io/en/stable/logging.html)
- [Design and limitations](https://luigi.readthedocs.io/en/stable/design_and_limitations.html)
- [Mypy plugin](https://luigi.readthedocs.io/en/stable/mypy.html)

- [luigi](https://luigi.readthedocs.io/en/stable/api/luigi.html)

[Luigi](https://luigi.readthedocs.io/en/stable/#)

- [Home](https://luigi.readthedocs.io/en/stable/#)
- Getting Started
- [View page source](https://luigi.readthedocs.io/en/stable/_sources/index.rst.txt)

* * *

![Luigi Logo](https://raw.githubusercontent.com/spotify/luigi/master/doc/luigi.png)[![https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fspotify%2Fluigi%2Fbadge&label=build&logo=none&%3Fref%3Dmaster&style=flat](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fspotify%2Fluigi%2Fbadge&label=build&logo=none&%3Fref%3Dmaster&style=flat)](https://actions-badge.atrox.dev/spotify/luigi/goto?ref=master) [![https://img.shields.io/codecov/c/github/spotify/luigi/master.svg?style=flat](https://img.shields.io/codecov/c/github/spotify/luigi/master.svg?style=flat)](https://codecov.io/gh/spotify/luigi?branch=master) [![https://img.shields.io/pypi/v/luigi.svg?style=flat](https://img.shields.io/pypi/v/luigi.svg?style=flat)](https://pypi.python.org/pypi/luigi) [![https://img.shields.io/pypi/l/luigi.svg?style=flat](https://img.shields.io/pypi/l/luigi.svg?style=flat)](https://pypi.python.org/pypi/luigi) [![Documentation Status](https://readthedocs.org/projects/luigi/badge/?version=stable)](https://luigi.readthedocs.io/en/stable/?badge=stable)

Luigi is a Python (3.10, 3.11, 3.12, 3.13 tested) package that helps you build complex
pipelines of batch jobs. It handles dependency resolution, workflow management,
visualization, handling failures, command line integration, and much more.

# Getting Started [](https://luigi.readthedocs.io/en/stable/\#getting-started "Link to this heading")

Run `pip install luigi` to install the latest stable version from [PyPI](https://pypi.python.org/pypi/luigi). [Documentation for the latest release](https://luigi.readthedocs.io/en/stable/) is hosted on readthedocs.

Run `pip install luigi[toml]` to install Luigi with [TOML-based configs](https://luigi.readthedocs.io/en/stable/configuration.html) support.

For the bleeding edge code, `pip install
git+https://github.com/spotify/luigi.git`. [Bleeding edge documentation](https://luigi.readthedocs.io/en/latest/) is also available.

# Background [](https://luigi.readthedocs.io/en/stable/\#background "Link to this heading")

The purpose of Luigi is to address all the plumbing typically associated
with long-running batch processes. You want to chain many tasks,
automate them, and failures _will_ happen. These tasks can be anything,
but are typically long running things like
[Hadoop](http://hadoop.apache.org/) jobs, dumping data to/from
databases, running machine learning algorithms, or anything else.

There are other software packages that focus on lower level aspects of
data processing, like [Hive](http://hive.apache.org/),
[Pig](http://pig.apache.org/), or
[Cascading](http://www.cascading.org/). Luigi is not a framework to
replace these. Instead it helps you stitch many tasks together, where
each task can be a [Hive query](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.hive.html),
a [Hadoop job in Java](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.hadoop_jar.html),
a [Spark job in Scala or Python](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.spark.html),
a Python snippet,
[dumping a table](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.sqla.html)
from a database, or anything else. It’s easy to build up
long-running pipelines that comprise thousands of tasks and take days or
weeks to complete. Luigi takes care of a lot of the workflow management
so that you can focus on the tasks themselves and their dependencies.

You can build pretty much any task you want, but Luigi also comes with a
_toolbox_ of several common task templates that you use. It includes
support for running
[Python mapreduce jobs](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.hadoop.html)
in Hadoop, as well as
[Hive](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.hive.html),
and [Pig](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.pig.html),
jobs. It also comes with
[file system abstractions for HDFS](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.hdfs.html),
and local files that ensures all file system operations are atomic. This
is important because it means your data pipeline will not crash in a
state containing partial data.

# Visualiser page [](https://luigi.readthedocs.io/en/stable/\#visualiser-page "Link to this heading")

The Luigi server comes with a web interface too, so you can search and filter
among all your tasks.

![Visualiser page](https://raw.githubusercontent.com/spotify/luigi/master/doc/visualiser_front_page.png)

# Dependency graph example [](https://luigi.readthedocs.io/en/stable/\#dependency-graph-example "Link to this heading")

Just to give you an idea of what Luigi does, this is a screen shot from
something we are running in production. Using Luigi’s visualiser, we get
a nice visual overview of the dependency graph of the workflow. Each
node represents a task which has to be run. Green tasks are already
completed whereas yellow tasks are yet to be run. Most of these tasks
are Hadoop jobs, but there are also some things that run locally and
build up data files.

![Dependency graph](https://raw.githubusercontent.com/spotify/luigi/master/doc/user_recs.png)

# Philosophy [](https://luigi.readthedocs.io/en/stable/\#philosophy "Link to this heading")

Conceptually, Luigi is similar to [GNU\\
Make](http://www.gnu.org/software/make/) where you have certain tasks
and these tasks in turn may have dependencies on other tasks. There are
also some similarities to [Oozie](http://oozie.apache.org/)
and [Azkaban](https://azkaban.github.io/). One major
difference is that Luigi is not just built specifically for Hadoop, and
it’s easy to extend it with other kinds of tasks.

Everything in Luigi is in Python. Instead of XML configuration or
similar external data files, the dependency graph is specified _within_
_Python_. This makes it easy to build up complex dependency graphs of
tasks, where the dependencies can involve date algebra or recursive
references to other versions of the same task. However, the workflow can
trigger things not in Python, such as running
[Pig scripts](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.pig.html)
or [scp’ing files](https://luigi.readthedocs.io/en/latest/api/luigi.contrib.ssh.html).

# Who uses Luigi? [](https://luigi.readthedocs.io/en/stable/\#who-uses-luigi "Link to this heading")

We use Luigi internally at [Spotify](https://www.spotify.com/) to run
thousands of tasks every day, organized in complex dependency graphs.
Most of these tasks are Hadoop jobs. Luigi provides an infrastructure
that powers all kinds of stuff including recommendations, toplists, A/B
test analysis, external reports, internal dashboards, etc.

Since Luigi is open source and without any registration walls, the exact number
of Luigi users is unknown. But based on the number of unique contributors, we
expect hundreds of enterprises to use it. Some users have written blog posts
or held presentations about Luigi:

- [Spotify](https://www.spotify.com/) [(presentation, 2014)](http://www.slideshare.net/erikbern/luigi-presentation-nyc-data-science)

- [Foursquare](https://foursquare.com/) [(presentation, 2013)](http://www.slideshare.net/OpenAnayticsMeetup/luigi-presentation-17-23199897)

- [Mortar Data (Datadog)](https://www.datadoghq.com/) [(documentation / tutorial)](http://help.mortardata.com/technologies/luigi)

- [Stripe](https://stripe.com/) [(presentation, 2014)](http://www.slideshare.net/PyData/python-as-part-of-a-production-machine-learning-stack-by-michael-manapat-pydata-sv-2014)

- [Buffer](https://buffer.com/) [(blog, 2014)](https://buffer.com/resources/buffers-new-data-architecture/)

- [SeatGeek](https://seatgeek.com/) [(blog, 2015)](http://chairnerd.seatgeek.com/building-out-the-seatgeek-data-pipeline/)

- [Treasure Data](https://www.treasuredata.com/) [(blog, 2015)](http://blog.treasuredata.com/blog/2015/02/25/managing-the-data-pipeline-with-git-luigi/)

- [Growth Intelligence](http://growthintel.com/) [(presentation, 2015)](http://www.slideshare.net/growthintel/a-beginners-guide-to-building-data-pipelines-with-luigi)

- [AdRoll](https://www.adroll.com/) [(blog, 2015)](http://tech.adroll.com/blog/data/2015/09/22/data-pipelines-docker.html)

- 17zuoye [(presentation, 2015)](https://speakerdeck.com/mvj3/luiti-an-offline-task-management-framework)

- [Custobar](https://www.custobar.com/) [(presentation, 2016)](http://www.slideshare.net/teemukurppa/managing-data-workflows-with-luigi)

- [Blendle](https://launch.blendle.com/) [(presentation)](http://www.anneschuth.nl/wp-content/uploads/sea-anneschuth-streamingblendle.pdf#page=126)

- [TrustYou](http://www.trustyou.com/) [(presentation, 2015)](https://speakerdeck.com/mfcabrera/pydata-berlin-2015-processing-hotel-reviews-with-python)

- [Groupon](https://www.groupon.com/) / [OrderUp](https://orderup.com/) [(alternative implementation)](https://github.com/groupon/luigi-warehouse)

- [Red Hat - Marketing Operations](https://www.redhat.com/) [(blog, 2017)](https://github.com/rh-marketingops/rh-mo-scc-luigi)

- [GetNinjas](https://www.getninjas.com.br/) [(blog, 2017)](https://labs.getninjas.com.br/using-luigi-to-create-and-monitor-pipelines-of-batch-jobs-eb8b3cd2a574)

- [voyages-sncf.com](https://www.voyages-sncf.com/) [(presentation, 2017)](https://github.com/voyages-sncf-technologies/meetup-afpy-nantes-luigi)

- [Open Targets](https://www.opentargets.org/) [(blog, 2017)](https://blog.opentargets.org/using-containers-with-luigi)

- [Leipzig University Library](https://ub.uni-leipzig.de/) [(presentation, 2016)](https://de.slideshare.net/MartinCzygan/build-your-own-discovery-index-of-scholary-eresources) / [(project)](https://finc.info/de/datenquellen)

- [Synetiq](https://synetiq.net/) [(presentation, 2017)](https://www.youtube.com/watch?v=M4xUQXogSfo)

- [Glossier](https://www.glossier.com/) [(blog, 2018)](https://medium.com/glossier/how-to-build-a-data-warehouse-what-weve-learned-so-far-at-glossier-6ff1e1783e31)

- [Data Revenue](https://www.datarevenue.com/) [(blog, 2018)](https://www.datarevenue.com/en/blog/how-to-scale-your-machine-learning-pipeline)

- [Uppsala University](http://pharmb.io/) [(tutorial)](http://uppnex.se/twiki/do/view/Courses/EinfraMPS2015/Luigi.html) / [(presentation, 2015)](https://www.youtube.com/watch?v=f26PqSXZdWM) / [(slides, 2015)](https://www.slideshare.net/SamuelLampa/building-workflows-with-spotifys-luigi) / [(poster, 2015)](https://pharmb.io/poster/2015-sciluigi/) / [(paper, 2016)](https://doi.org/10.1186/s13321-016-0179-6) / [(project)](https://github.com/pharmbio/sciluigi)

- [GIPHY](https://giphy.com/) [(blog, 2019)](https://engineering.giphy.com/luigi-the-10x-plumber-containerizing-scaling-luigi-in-kubernetes/)

- [xtream](https://xtreamers.io/) [(blog, 2019)](https://towardsdatascience.com/lessons-from-a-real-machine-learning-project-part-1-from-jupyter-to-luigi-bdfd0b050ca5)

- [CIAN](https://cian.ru/) [(presentation, 2019)](https://www.highload.ru/moscow/2019/abstracts/6030)


Some more companies are using Luigi but haven’t had a chance yet to write about it:

- [Schibsted](http://www.schibsted.com/)

- [enbrite.ly](http://enbrite.ly/)

- [Dow Jones / The Wall Street Journal](http://wsj.com/)

- [Hotels.com](https://hotels.com/)

- [Newsela](https://newsela.com/)

- [Squarespace](https://www.squarespace.com/)

- [OAO](https://adops.com/)

- [Grovo](https://grovo.com/)

- [Weebly](https://www.weebly.com/)

- [Deloitte](https://www.deloitte.co.uk/)

- [Stacktome](https://stacktome.com/)

- [LINX+Neemu+Chaordic](https://www.chaordic.com.br/)

- [Foxberry](https://www.foxberry.com/)

- [Okko](https://okko.tv/)

- [ISVWorld](http://isvworld.com/)

- [Big Data](https://bigdata.com.br/)

- [Movio](https://movio.co.nz/)

- [Bonnier News](https://www.bonniernews.se/)

- [Starsky Robotics](https://www.starsky.io/)

- [BaseTIS](https://www.basetis.com/)

- [Hopper](https://www.hopper.com/)

- [VOYAGE GROUP/Zucks](https://zucks.co.jp/en/)

- [Textpert](https://www.textpert.ai/)

- [Tracktics](https://www.tracktics.com/)

- [Whizar](https://www.whizar.com/)

- [xtream](https://www.xtreamers.io/)

- [Skyscanner](https://www.skyscanner.net/)

- [Jodel](https://www.jodel.com/)

- [Mekar](https://mekar.id/en/)

- [M3](https://corporate.m3.com/en/)

- [Assist Digital](https://www.assistdigital.com/)

- [Meltwater](https://www.meltwater.com/)

- [DevSamurai](https://www.devsamurai.com/)

- [Veridas](https://veridas.com/)

- [Aidentified](https://www.aidentified.com/)


We’re more than happy to have your company added here. Just send a PR on GitHub.

# External links [](https://luigi.readthedocs.io/en/stable/\#external-links "Link to this heading")

- [Mailing List](https://groups.google.com/d/forum/luigi-user/) for discussions and asking questions. (Google Groups)

- [Releases](https://pypi.python.org/pypi/luigi) (PyPI)

- [Source code](https://github.com/spotify/luigi) (GitHub)

- [Hubot Integration](https://github.com/houzz/hubot-luigi) plugin for Slack, Hipchat, etc (GitHub)


# Authors [](https://luigi.readthedocs.io/en/stable/\#authors "Link to this heading")

Luigi was built at [Spotify](https://www.spotify.com/), mainly by
[Erik Bernhardsson](https://github.com/erikbern) and
[Elias Freider](https://github.com/freider).
[Many other people](https://github.com/spotify/luigi/graphs/contributors)
have contributed since open sourcing in late 2012.
[Arash Rouhani](https://github.com/tarrasch) was the chief maintainer from 2015 to 2019, and now
Spotify’s Data Team maintains Luigi.

# Table of Contents [](https://luigi.readthedocs.io/en/stable/\#table-of-contents "Link to this heading")

- [Example – Top Artists](https://luigi.readthedocs.io/en/stable/example_top_artists.html)
  - [Step 1 - Aggregate Artist Streams](https://luigi.readthedocs.io/en/stable/example_top_artists.html#step-1-aggregate-artist-streams)
  - [Running this Locally](https://luigi.readthedocs.io/en/stable/example_top_artists.html#running-this-locally)
  - [Step 1b - Aggregate artists with Spark](https://luigi.readthedocs.io/en/stable/example_top_artists.html#step-1b-aggregate-artists-with-spark)
  - [Step 2 – Find the Top Artists](https://luigi.readthedocs.io/en/stable/example_top_artists.html#step-2-find-the-top-artists)
  - [Step 3 - Insert into Postgres](https://luigi.readthedocs.io/en/stable/example_top_artists.html#step-3-insert-into-postgres)
  - [Using the Central Planner](https://luigi.readthedocs.io/en/stable/example_top_artists.html#using-the-central-planner)
- [Building workflows](https://luigi.readthedocs.io/en/stable/workflows.html)
  - [Target](https://luigi.readthedocs.io/en/stable/workflows.html#target)
  - [Task](https://luigi.readthedocs.io/en/stable/workflows.html#task)
  - [Parameter](https://luigi.readthedocs.io/en/stable/workflows.html#parameter)
  - [Dependencies](https://luigi.readthedocs.io/en/stable/workflows.html#dependencies)
- [Tasks](https://luigi.readthedocs.io/en/stable/tasks.html)
  - [Task.requires](https://luigi.readthedocs.io/en/stable/tasks.html#task-requires)
  - [Requiring another Task](https://luigi.readthedocs.io/en/stable/tasks.html#requiring-another-task)
  - [Task.output](https://luigi.readthedocs.io/en/stable/tasks.html#task-output)
  - [Task.run](https://luigi.readthedocs.io/en/stable/tasks.html#task-run)
  - [Task.input](https://luigi.readthedocs.io/en/stable/tasks.html#task-input)
  - [Dynamic dependencies](https://luigi.readthedocs.io/en/stable/tasks.html#dynamic-dependencies)
  - [Task status tracking](https://luigi.readthedocs.io/en/stable/tasks.html#task-status-tracking)
  - [Events and callbacks](https://luigi.readthedocs.io/en/stable/tasks.html#events-and-callbacks)
  - [But I just want to run a Hadoop job?](https://luigi.readthedocs.io/en/stable/tasks.html#but-i-just-want-to-run-a-hadoop-job)
  - [Task priority](https://luigi.readthedocs.io/en/stable/tasks.html#task-priority)
  - [Namespaces, families and ids](https://luigi.readthedocs.io/en/stable/tasks.html#namespaces-families-and-ids)
  - [Instance caching](https://luigi.readthedocs.io/en/stable/tasks.html#instance-caching)
- [Parameters](https://luigi.readthedocs.io/en/stable/parameters.html)
  - [Instance caching](https://luigi.readthedocs.io/en/stable/parameters.html#instance-caching)
  - [Insignificant parameters](https://luigi.readthedocs.io/en/stable/parameters.html#insignificant-parameters)
  - [Parameter visibility](https://luigi.readthedocs.io/en/stable/parameters.html#parameter-visibility)
  - [Parameter types](https://luigi.readthedocs.io/en/stable/parameters.html#parameter-types)
  - [Setting parameter value for other classes](https://luigi.readthedocs.io/en/stable/parameters.html#setting-parameter-value-for-other-classes)
  - [Parameter resolution order](https://luigi.readthedocs.io/en/stable/parameters.html#parameter-resolution-order)
- [Running Luigi](https://luigi.readthedocs.io/en/stable/running_luigi.html)
  - [Running from the Command Line](https://luigi.readthedocs.io/en/stable/running_luigi.html#running-from-the-command-line)
  - [Running from Python code](https://luigi.readthedocs.io/en/stable/running_luigi.html#running-from-python-code)
  - [Response of luigi.build()/luigi.run()](https://luigi.readthedocs.io/en/stable/running_luigi.html#response-of-luigi-build-luigi-run)
  - [Luigi on Windows](https://luigi.readthedocs.io/en/stable/running_luigi.html#luigi-on-windows)
- [Using the Central Scheduler](https://luigi.readthedocs.io/en/stable/central_scheduler.html)
  - [The luigid server](https://luigi.readthedocs.io/en/stable/central_scheduler.html#the-luigid-server)
  - [Enabling Task History](https://luigi.readthedocs.io/en/stable/central_scheduler.html#enabling-task-history)
- [Execution Model](https://luigi.readthedocs.io/en/stable/execution_model.html)
  - [Workers and task execution](https://luigi.readthedocs.io/en/stable/execution_model.html#workers-and-task-execution)
  - [Scheduler](https://luigi.readthedocs.io/en/stable/execution_model.html#scheduler)
  - [Triggering tasks](https://luigi.readthedocs.io/en/stable/execution_model.html#triggering-tasks)
- [Luigi Patterns](https://luigi.readthedocs.io/en/stable/luigi_patterns.html)
  - [Code Reuse](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#code-reuse)
  - [Triggering Many Tasks](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#triggering-many-tasks)
  - [Triggering recurring tasks](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#triggering-recurring-tasks)
  - [Efficiently triggering recurring tasks](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#efficiently-triggering-recurring-tasks)
  - [Backfilling tasks](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#backfilling-tasks)
  - [Propagating parameters with Range](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#propagating-parameters-with-range)
  - [Batching multiple parameter values into a single run](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#batching-multiple-parameter-values-into-a-single-run)
  - [Tasks that regularly overwrite the same data source](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#tasks-that-regularly-overwrite-the-same-data-source)
  - [Avoiding concurrent writes to a single file](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#avoiding-concurrent-writes-to-a-single-file)
  - [Decreasing resources of running tasks](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#decreasing-resources-of-running-tasks)
  - [Monitoring task pipelines](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#monitoring-task-pipelines)
  - [Atomic Writes Problem](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#atomic-writes-problem)
  - [Sending messages to tasks](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#sending-messages-to-tasks)
  - [Gathering custom metrics from tasks’ executions](https://luigi.readthedocs.io/en/stable/luigi_patterns.html#gathering-custom-metrics-from-tasks-executions)
- [Configuration](https://luigi.readthedocs.io/en/stable/configuration.html)
  - [Parameters from config Ingestion](https://luigi.readthedocs.io/en/stable/configuration.html#parameters-from-config-ingestion)
  - [Configurable options](https://luigi.readthedocs.io/en/stable/configuration.html#configurable-options)
  - [\[core\]](https://luigi.readthedocs.io/en/stable/configuration.html#core)
  - [\[cors\]](https://luigi.readthedocs.io/en/stable/configuration.html#cors)
  - [\[worker\]](https://luigi.readthedocs.io/en/stable/configuration.html#worker)
  - [\[elasticsearch\]](https://luigi.readthedocs.io/en/stable/configuration.html#elasticsearch)
  - [\[email\]](https://luigi.readthedocs.io/en/stable/configuration.html#email)
  - [\[batch\_email\]](https://luigi.readthedocs.io/en/stable/configuration.html#batch-email)
  - [\[hadoop\]](https://luigi.readthedocs.io/en/stable/configuration.html#hadoop)
  - [\[hdfs\]](https://luigi.readthedocs.io/en/stable/configuration.html#hdfs)
  - [\[hive\]](https://luigi.readthedocs.io/en/stable/configuration.html#hive)
  - [\[kubernetes\]](https://luigi.readthedocs.io/en/stable/configuration.html#kubernetes)
  - [\[mysql\]](https://luigi.readthedocs.io/en/stable/configuration.html#mysql)
  - [\[postgres\]](https://luigi.readthedocs.io/en/stable/configuration.html#postgres)
  - [\[prometheus\]](https://luigi.readthedocs.io/en/stable/configuration.html#prometheus)
  - [\[redshift\]](https://luigi.readthedocs.io/en/stable/configuration.html#redshift)
  - [\[resources\]](https://luigi.readthedocs.io/en/stable/configuration.html#resources)
  - [\[retcode\]](https://luigi.readthedocs.io/en/stable/configuration.html#retcode)
  - [\[scalding\]](https://luigi.readthedocs.io/en/stable/configuration.html#scalding)
  - [\[scheduler\]](https://luigi.readthedocs.io/en/stable/configuration.html#scheduler)
  - [\[sendgrid\]](https://luigi.readthedocs.io/en/stable/configuration.html#sendgrid)
  - [\[smtp\]](https://luigi.readthedocs.io/en/stable/configuration.html#smtp)
  - [\[spark\]](https://luigi.readthedocs.io/en/stable/configuration.html#spark)
  - [\[task\_history\]](https://luigi.readthedocs.io/en/stable/configuration.html#task-history)
  - [\[execution\_summary\]](https://luigi.readthedocs.io/en/stable/configuration.html#execution-summary)
  - [\[webhdfs\]](https://luigi.readthedocs.io/en/stable/configuration.html#webhdfs)
  - [\[datadog\]](https://luigi.readthedocs.io/en/stable/configuration.html#datadog)
  - [Per Task Retry-Policy](https://luigi.readthedocs.io/en/stable/configuration.html#per-task-retry-policy)
  - [Retry-Policy Fields](https://luigi.readthedocs.io/en/stable/configuration.html#retry-policy-fields)
- [Configure logging](https://luigi.readthedocs.io/en/stable/logging.html)
  - [Config options:](https://luigi.readthedocs.io/en/stable/logging.html#config-options)
  - [Config section](https://luigi.readthedocs.io/en/stable/logging.html#config-section)
  - [Luigid CLI options:](https://luigi.readthedocs.io/en/stable/logging.html#luigid-cli-options)
  - [Worker CLI options:](https://luigi.readthedocs.io/en/stable/logging.html#worker-cli-options)
  - [Configuration options resolution order:](https://luigi.readthedocs.io/en/stable/logging.html#configuration-options-resolution-order)
- [Design and limitations](https://luigi.readthedocs.io/en/stable/design_and_limitations.html)
- [Mypy plugin](https://luigi.readthedocs.io/en/stable/mypy.html)
  - [How to use](https://luigi.readthedocs.io/en/stable/mypy.html#how-to-use)
  - [Examples](https://luigi.readthedocs.io/en/stable/mypy.html#examples)

# API Reference [](https://luigi.readthedocs.io/en/stable/\#api-reference "Link to this heading")

|     |     |
| --- | --- |
| [`luigi`](https://luigi.readthedocs.io/en/stable/api/luigi.html#module-luigi "luigi") | Package containing core luigi functionality. |

## Indices and tables [](https://luigi.readthedocs.io/en/stable/\#indices-and-tables "Link to this heading")

- [Index](https://luigi.readthedocs.io/en/stable/genindex.html)

- [Module Index](https://luigi.readthedocs.io/en/stable/py-modindex.html)

- [Search Page](https://luigi.readthedocs.io/en/stable/search.html)


[Next](https://luigi.readthedocs.io/en/stable/example_top_artists.html "Example – Top Artists")

* * *

© Copyright 2011-2026, The Luigi Authors.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org/).


![Read the Docs](<Base64-Image-Removed>)stable
Versions[latest](https://luigi.readthedocs.io/en/latest/)**[stable](https://luigi.readthedocs.io/en/stable/)**Downloads[PDF](https://luigi.readthedocs.io/_/downloads/en/stable/pdf/)[EPUB](https://luigi.readthedocs.io/_/downloads/en/stable/epub/)On Read the Docs[Project Home](https://app.readthedocs.org/projects/luigi/?utm_source=luigi&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/luigi/builds/?utm_source=luigi&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=luigi&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=luigi&utm_content=flyout)