[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781557625516

userId:

deviceId: 5e22c2b4-e582-4bef-87c5-f3f48164b32b

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/visibility#__docusaurus_skipToContent_fallback)

[![Temporal logo](https://docs.temporal.io/img/assets/temporal-logo-dark.svg)](https://temporal.io/)[Home](https://docs.temporal.io/) [Courses](https://learn.temporal.io/getting_started/) [SDKs](https://docs.temporal.io/develop) [AI Cookbook](https://docs.temporal.io/ai-cookbook) [Code Exchange](https://temporal.io/code-exchange) [Temporal Cloud](https://docs.temporal.io/cloud)

Ask AI

Search`Ctrl`  `K`

- [Home](https://docs.temporal.io/)
- [Quickstarts](https://docs.temporal.io/quickstarts)
- [Evaluate](https://docs.temporal.io/evaluate/)

- [Develop](https://docs.temporal.io/develop/)

- [Temporal Cloud](https://docs.temporal.io/cloud)

- [Deploy to production](https://docs.temporal.io/production-deployment)

- [CLI (temporal)](https://docs.temporal.io/cli)

- [References](https://docs.temporal.io/references/)

- [Troubleshooting](https://docs.temporal.io/troubleshooting/)

- [Best practices](https://docs.temporal.io/best-practices/)

- [Encyclopedia](https://docs.temporal.io/encyclopedia/)

  - [Temporal](https://docs.temporal.io/temporal)
  - [About the SDKs](https://docs.temporal.io/encyclopedia/temporal-sdks)
  - [Temporal Client](https://docs.temporal.io/temporal-client)
  - [Workflows](https://docs.temporal.io/workflows)

  - [Activities](https://docs.temporal.io/activities)

  - [Failures and error handling](https://docs.temporal.io/encyclopedia/failures-and-error-handling)

  - [Workers](https://docs.temporal.io/workers)

  - [Event History](https://docs.temporal.io/encyclopedia/event-history/)

  - [Workflow Message Passing](https://docs.temporal.io/encyclopedia/workflow-message-passing/)

  - [Child Workflows](https://docs.temporal.io/child-workflows)

  - [Visibility](https://docs.temporal.io/visibility)

    - [Dual Visibility](https://docs.temporal.io/dual-visibility)
    - [List Filter](https://docs.temporal.io/list-filter)
    - [Search Attributes](https://docs.temporal.io/search-attribute)
  - [Temporal Service](https://docs.temporal.io/temporal-service)

  - [Namespaces](https://docs.temporal.io/namespaces)

  - [Temporal Nexus](https://docs.temporal.io/nexus)

  - [Extensibility](https://docs.temporal.io/encyclopedia/extensibility)

  - [Web UI](https://docs.temporal.io/web-ui)
- [Interactive Demos](https://docs.temporal.io/visibility#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Encyclopedia](https://docs.temporal.io/encyclopedia/)
- Visibility

On this page

# Temporal Visibility

Copy

This page provides an overview of Temporal Visibility.

The term [Visibility](https://docs.temporal.io/visibility), within the Temporal Platform, refers to the subsystems and APIs that enable an operator to view, filter, and search for Workflow Executions that currently exist within a Temporal Service.

The [Visibility store](https://docs.temporal.io/self-hosted-guide/visibility) in your Temporal Service stores persisted Workflow Execution Event History data and is set up as a part of your [Persistence store](https://docs.temporal.io/temporal-service/persistence) to enable listing and filtering details about Workflow Executions that exist on your Temporal Service.

- [How to set up a Visibility store](https://docs.temporal.io/self-hosted-guide/visibility)

With Temporal Server v1.21, you can set up [Dual Visibility](https://docs.temporal.io/dual-visibility) to migrate your Visibility store from one database to another.

## Visibility features [​](https://docs.temporal.io/visibility\#advanced-visibility "Direct link to Visibility features")

Visibility enables the listing, filtering, and sorting of [Workflow Executions](https://docs.temporal.io/workflow-execution) through a custom SQL-like [List Filter](https://docs.temporal.io/list-filter).

Visibility supports [custom Search Attributes](https://docs.temporal.io/search-attribute#custom-search-attribute) for user-defined filtering beyond the default system attributes.

- On SQL databases (MySQL v8.0.17+, PostgreSQL v12+), Visibility is available with Temporal Server v1.20 and later.
- On Elasticsearch (v7+ with Temporal Server v1.7+, v8 with Temporal Server v1.18+) and OpenSearch (2+ with Temporal Server v1.30.1+).
- On Temporal Cloud, Visibility is enabled by default for [all users](https://docs.temporal.io/cloud/users#invite-users).

For self-hosted setup and version compatibility details, see [Visibility store setup](https://docs.temporal.io/self-hosted-guide/visibility).

### Count Workflow by ExecutionStatus [​](https://docs.temporal.io/visibility\#count-workflow-by-executionstatus "Direct link to Count Workflow by ExecutionStatus")

The Count API feature lets you count the number of Workflows that match a given query. For example, the command `temporal workflow count -q "WorkflowType='foo'"` returns the number of Workflows that match `WorkflowType='foo'`.

You can send queries to the Count API to group by a given search attribute. For example, `-q "WorkflowType='foo' GROUP BY ExecutionStatus` returns the number of Workflows that match `WorkflowType='foo'` grouped by `ExecutionStatus`.

The `GROUP BY` clause is only supported in the Count API and currently only grouping by `ExecutionStatus` is supported.

info

The Count API returns approximate counts.

## Legacy: standard Visibility [​](https://docs.temporal.io/visibility\#standard-visibility "Direct link to Legacy: standard Visibility")

Prior to Temporal Server v1.20, Temporal had two Visibility modes: "standard" and "advanced." Standard Visibility supported only predefined filters such as Workflow Type, Workflow Id, Run Id, and Execution Status, without custom Search Attributes. Advanced Visibility required Elasticsearch.

Starting with Temporal Server v1.20, advanced Visibility became available on SQL databases. Standard Visibility was deprecated in v1.21 and removed in v1.24. All current deployments use what was formerly called advanced Visibility, now simply called Visibility.

If you are running a Temporal Server version older than v1.24, see the [legacy standard Visibility section](https://docs.temporal.io/self-hosted-guide/visibility#legacy-standard-visibility) in the self-hosted guide.

**Tags:**

- [Concepts](https://docs.temporal.io/tags/concepts)
- [Visibility](https://docs.temporal.io/tags/visibility)
- [Search Attributes](https://docs.temporal.io/tags/search-attributes)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Parent Close Policy](https://docs.temporal.io/parent-close-policy) [Next\\
\\
Dual Visibility](https://docs.temporal.io/dual-visibility)

- [Visibility features](https://docs.temporal.io/visibility#advanced-visibility)
  - [Count Workflow by ExecutionStatus](https://docs.temporal.io/visibility#count-workflow-by-executionstatus)
- [Legacy: standard Visibility](https://docs.temporal.io/visibility#standard-visibility)

- [GitHub](https://github.com/temporalio)
- [Twitter](https://x.com/temporalio)
- [YouTube](https://www.youtube.com/c/Temporalio)
- [About the docs](https://github.com/temporalio/documentation/blob/main/README.md)

- [Temporal Cloud](https://temporal.io/cloud)
- [Meetups](https://temporal.io/community#events)
- [Support forum](https://community.temporal.io/)
- [Ask an expert](https://pages.temporal.io/ask-an-expert)

- [Learn Temporal](https://learn.temporal.io/)
- [Blog](https://temporal.io/blog)
- [Use cases](https://temporal.io/in-use)
- [Newsletter signup](https://pages.temporal.io/newsletter-subscribe)

- [Security](https://docs.temporal.io/security)
- [Privacy policy](https://temporal.io/global-privacy-policy)
- [Terms of service](https://temporal.io/terms-of-service)
- [We're hiring](https://temporal.io/careers)

[![Temporal logo](https://docs.temporal.io/img/favicon.png)](https://temporal.io/)

Copyright © 2026 Temporal Technologies Inc.

Feedback

reCAPTCHA

Recaptcha requires verification.

protected by **reCAPTCHA**