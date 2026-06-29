[Skip to main content](https://worker.graphile.org/docs#__docusaurus_skipToContent_fallback)

[![Graphile Worker](https://worker.graphile.org/img/logo.optimized.svg)\\
**Graphile Worker**](https://worker.graphile.org/) [Documentation](https://worker.graphile.org/docs)

[News](https://worker.graphile.org/news) [Releases](https://worker.graphile.org/releases) [Sponsor](https://worker.graphile.org/sponsors) [Go Pro](https://worker.graphile.org/pricing) [GitHub](https://github.com/graphile/worker)

Search`` `K`

- [Introduction](https://worker.graphile.org/docs)
- [Requirements](https://worker.graphile.org/docs/requirements)
- [Installation](https://worker.graphile.org/docs/installation)
- [Configuration](https://worker.graphile.org/docs/config)
- [Connection strings](https://worker.graphile.org/docs/connection-string)
- [Task executors](https://worker.graphile.org/docs/tasks)
- [Worker Pro!](https://worker.graphile.org/docs/pro)

- [CLI](https://worker.graphile.org/docs/cli)

- [Library](https://worker.graphile.org/docs/library)

- [Database schema](https://worker.graphile.org/docs/schema)
- [TypeScript](https://worker.graphile.org/docs/typescript)
- [Adding jobs through SQL](https://worker.graphile.org/docs/sql-add-job)
- [Job key](https://worker.graphile.org/docs/job-key)
- [Recurring tasks (crontab)](https://worker.graphile.org/docs/cron)
- [Administrative functions](https://worker.graphile.org/docs/admin-functions)
- [The 'jobs' view](https://worker.graphile.org/docs/jobs-view)
- [Forbidden flags](https://worker.graphile.org/docs/forbidden-flags)
- [Performance](https://worker.graphile.org/docs/performance)
- [Error handling](https://worker.graphile.org/docs/error-handling)
- [Exponential backoff](https://worker.graphile.org/docs/exponential-backoff)
- [Support](https://worker.graphile.org/docs/support)
- [Docker](https://worker.graphile.org/docs/docker)
- [Project status](https://worker.graphile.org/docs/project-status)
- [Contributing](https://worker.graphile.org/docs/contributing)
- [Uninstall/Reset](https://worker.graphile.org/docs/uninstall)
- [FAQ](https://worker.graphile.org/docs/faq)
- [Glossary](https://worker.graphile.org/docs/glossary)
- [Scaling tips](https://worker.graphile.org/docs/scaling)
- [Techniques](https://worker.graphile.org/docs/techniques)
- [WorkerEvents](https://worker.graphile.org/docs/worker-events)

- [Home page](https://worker.graphile.org/)
- Introduction

On this page

# Introduction

Graphile Worker is a job queue which uses PostgreSQL to store jobs, and executes
them on Node.js. A job queue allows you to run jobs (e.g. sending emails,
performing calculations, generating PDFs, etc) "in the background" so that your
HTTP response/application code is not held up waiting for them to complete.

## Keep it simple [​](https://worker.graphile.org/docs\#keep-it-simple "Direct link to Keep it simple")

The main reason behind Graphile Worker (and not a dedicated job queue) is to
help you to keep your infrastructure simple; when you're working with a small
number of engineers on a project, the more infrastructure you have, the more
time you lose to maintenance of that infrastructure, so consolidating your
infrastructure can make a lot of sense. Graphile Worker focuses on performance
to ensure that you can use it as a job queue until your engineering team has
grown enough that you can afford the time to maintain a dedicated job queue.

## Reliable [​](https://worker.graphile.org/docs\#reliable "Direct link to Reliable")

As you would expect from a job queue, Graphile Worker ensures that your jobs
will not get lost (thanks to Postgres' transactional guarantees), and that each
job will execute at least once. Most jobs will execute exactly once; but if
something goes wrong (either with the job itself, with worker, or with your
infrastructure) then Graphile Worker will automatically retry the job at a later
time, following exponential backoff.

## Postgres-centric [​](https://worker.graphile.org/docs\#postgres-centric "Direct link to Postgres-centric")

Though Graphile Worker can be executed as a regular Node.js module, its
Postgres-centric ethos means that it is exceptionally well suited to projects
where jobs need to be created from inside the database (e.g. via triggers, or
stored procedures); i.e. it pairs beautifully with
[PostGraphile](https://www.graphile.org/postgraphile/),
[PostgREST](http://postgrest.org/), and any other database-centric application
framework.

## Community-funded [​](https://worker.graphile.org/docs\#community-funded "Direct link to Community-funded")

Like all of Graphile's open source software, Graphile Worker is community
funded: we rely on sponsorship and donations to keep maintaining the project. If
you find the project useful and want to help it keep improving, please consider
[sponsoring @Benjie](https://github.com/sponsors/benjie).

## Features [​](https://worker.graphile.org/docs\#features "Direct link to Features")

- Standalone and embedded modes
- Designed to be used both from JavaScript or directly in the database
- Easy to test (recommended: `runTaskListOnce` util)
- Low latency (typically under 3ms from task schedule to execution, uses
`LISTEN`/`NOTIFY` to be informed of jobs as they're inserted)
- High performance (uses `SKIP LOCKED` to find jobs to execute, resulting in
faster fetches)
- Small tasks (uses explicit task names / payloads resulting in minimal
serialisation/deserialisation overhead)
- Parallel by default
- Adding jobs to same named queue runs them in series
- Automatically re-attempts failed jobs with exponential back-off
- Customizable retry count (default: 25 attempts over ~3 days)
- Crontab-like scheduling feature for recurring tasks (with optional backfill)
- Task de-duplication via unique `job_key`
- Append data to already enqueued jobs with ‘batch jobs’
- Flexible runtime controls that can be used for complex rate limiting (e.g. via
[graphile-worker-rate-limiter](https://github.com/politics-rewired/graphile-worker-rate-limiter))
- Open source; liberal MIT license
- Executes tasks written in Node.js (these can call out to any other language or
networked service)
- Modern JS with 100% async/await API (no callbacks)
- Written natively in TypeScript
- If you're running really lean, you can run Graphile Worker in the same Node
process as your server to keep costs and devops complexity down.

[Edit this page](https://github.com/graphile/worker/tree/main/website/docs/index.md)

[Next\\
\\
Requirements](https://worker.graphile.org/docs/requirements)

- [Keep it simple](https://worker.graphile.org/docs#keep-it-simple)
- [Reliable](https://worker.graphile.org/docs#reliable)
- [Postgres-centric](https://worker.graphile.org/docs#postgres-centric)
- [Community-funded](https://worker.graphile.org/docs#community-funded)
- [Features](https://worker.graphile.org/docs#features)

Three ants crawling atop the footer

Docs

- [Worker Introduction](https://worker.graphile.org/docs)
- [Worker Quickstart](https://worker.graphile.org/docs/cli#quickstart)
- [PostGraphile](https://postgraphile.org/)
- [Gra _fast_](https://grafast.org/)
- [Graphile Build](https://build.graphile.org/)
- [Graphile\*](https://star.graphile.org/)

Community

- [Discord](https://discord.gg/graphile)
- [Mastodon](https://fosstodon.org/@graphile)
- [Twitter](https://twitter.com/GraphileHQ)

More

- [GitHub](https://github.com/graphile/worker)
- [Sponsor](https://graphile.org/sponsor)

Copyright © 2026 Graphile Ltd. Built with Docusaurus.