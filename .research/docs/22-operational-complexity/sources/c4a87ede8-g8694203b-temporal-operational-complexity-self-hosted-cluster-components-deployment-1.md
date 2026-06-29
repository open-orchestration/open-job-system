[Skip to main content](https://docs.temporal.io/self-hosted-guide#__docusaurus_skipToContent_fallback)
[![Temporal logo](https://docs.temporal.io/img/assets/temporal-logo-dark.svg)](https://temporal.io)[Home](https://docs.temporal.io/)[Courses](https://learn.temporal.io/getting_started/)[SDKs](https://docs.temporal.io/develop)[AI Cookbook](https://docs.temporal.io/ai-cookbook)[Code Exchange](https://temporal.io/code-exchange)[Temporal Cloud](https://docs.temporal.io/cloud)
Ask AI
Search`⌘``K`
  * [Home](https://docs.temporal.io/)
  * [Quickstarts](https://docs.temporal.io/quickstarts)
  * [Evaluate](https://docs.temporal.io/evaluate/)
  * [Develop](https://docs.temporal.io/develop/)
  * [Temporal Cloud](https://docs.temporal.io/cloud)
  * [Deploy to production](https://docs.temporal.io/production-deployment)
    * [Self-host](https://docs.temporal.io/self-hosted-guide)
      * [Deployment](https://docs.temporal.io/self-hosted-guide/deployment)
      * [Embedded server](https://docs.temporal.io/self-hosted-guide/embedded-server)
      * [Production checklist](https://docs.temporal.io/self-hosted-guide/production-checklist)
      * [Configurable defaults](https://docs.temporal.io/self-hosted-guide/defaults)
      * [Namespaces](https://docs.temporal.io/self-hosted-guide/namespaces)
      * [Security](https://docs.temporal.io/self-hosted-guide/security)
      * [Monitoring](https://docs.temporal.io/self-hosted-guide/monitoring)
      * [Visibility](https://docs.temporal.io/self-hosted-guide/visibility)
      * [Upgrade server](https://docs.temporal.io/self-hosted-guide/upgrade-server)
      * [Archival](https://docs.temporal.io/self-hosted-guide/archival)
      * [Multi-Cluster Replication](https://docs.temporal.io/self-hosted-guide/multi-cluster-replication)
      * [Temporal Nexus](https://docs.temporal.io/production-deployment/self-hosted-guide/nexus)
      * [Server API](https://docs.temporal.io/self-hosted-guide/server-frontend-api-reference)
    * [Worker deployments](https://docs.temporal.io/production-deployment/worker-deployments)
    * [Codecs and Encryption](https://docs.temporal.io/production-deployment/data-encryption)
  * [CLI (temporal)](https://docs.temporal.io/cli)
  * [References](https://docs.temporal.io/references/)
  * [Troubleshooting](https://docs.temporal.io/troubleshooting/)
  * [Best practices](https://docs.temporal.io/best-practices/)
  * [Encyclopedia](https://docs.temporal.io/encyclopedia/)
  * [Interactive Demos](https://docs.temporal.io/self-hosted-guide)
  * [Integrations](https://docs.temporal.io/integrations)
  * [Glossary](https://docs.temporal.io/glossary)
  * [Develop with AI](https://docs.temporal.io/with-ai)


  * [](https://docs.temporal.io/)
  * [Deploy to production](https://docs.temporal.io/production-deployment)
  * Self-host


On this page
# Self-hosted Temporal Service guide
Copy Markdown[View Markdown](https://docs.temporal.io/self-hosted-guide.md "View this page as Markdown")
[](https://chatgpt.com/?prompt=Read%20https%3A%2F%2Fdocs.temporal.io%2Fself-hosted-guide.md%20and%20answer%20questions%20about%20the%20content. "Open in ChatGPT")[](https://claude.ai/new?q=Read%20https%3A%2F%2Fdocs.temporal.io%2Fself-hosted-guide.md%20and%20answer%20questions%20about%20the%20content. "Open in Claude")
Welcome to the self-hosted Temporal Service guide. This guide shows you how to self-host open source infrastructure software that orchestrates your durable applications.
Do you need a production Temporal Service?
If you're still developing and testing your application locally, you may not need a production Temporal Service. Use the [Temporal CLI development server](https://docs.temporal.io/cli/command-reference/server#start-dev) — a single binary with no external dependencies:
`temporal server start-dev`
This starts a complete Temporal Service with Web UI on your local machine. We recommend this for local development regardless of whether you plan to use Temporal Cloud or self-host in production. See the [Temporal CLI server](https://docs.temporal.io/cli/command-reference/server) page for configuration options.
## Plan and deploy your service[​](https://docs.temporal.io/self-hosted-guide#plan-and-deploy-your-service "Direct link to Plan and deploy your service")
  * [Deployment](https://docs.temporal.io/self-hosted-guide/deployment): Choose a deployment approach (Docker, Kubernetes, or manual) and set up a production-ready Temporal Service.
  * [Embedded server](https://docs.temporal.io/self-hosted-guide/embedded-server): Run Temporal in-process as a Go library for local development and testing scenarios.
  * [Defaults](https://docs.temporal.io/self-hosted-guide/defaults): Review platform limits and default settings that can affect Workflow and Activity behavior.
  * [Production checklist](https://docs.temporal.io/self-hosted-guide/production-checklist): Validate readiness for scale, reliability, operations, and long-term maintainability.


## Operate your self-hosted service[​](https://docs.temporal.io/self-hosted-guide#operate-your-self-hosted-service "Direct link to Operate your self-hosted service")
  * [Namespaces](https://docs.temporal.io/self-hosted-guide/namespaces): Create and manage Namespace isolation, retention, and related configuration.
  * [Security](https://docs.temporal.io/self-hosted-guide/security): Configure TLS/mTLS, authentication, authorization, and related hardening controls.
  * [Monitoring](https://docs.temporal.io/self-hosted-guide/monitoring): Collect and visualize service and SDK metrics to troubleshoot and track health.
  * [Visibility](https://docs.temporal.io/self-hosted-guide/visibility): Configure Visibility storage so you can list, filter, and search Workflow Executions.
  * [Upgrading server](https://docs.temporal.io/self-hosted-guide/upgrade-server#upgrade-server): Perform safe, sequential server and schema upgrades.


## Protect data and enable advanced features[​](https://docs.temporal.io/self-hosted-guide#protect-data-and-enable-advanced-features "Direct link to Protect data and enable advanced features")
  * [Data encryption](https://docs.temporal.io/production-deployment/data-encryption): Use Payload Codecs and Codec Server patterns to protect sensitive Workflow data.
  * [Archival](https://docs.temporal.io/self-hosted-guide/archival): Move closed Workflow Histories and Visibility records to blob storage for longer retention.
  * [Multi-Cluster Replication](https://docs.temporal.io/self-hosted-guide/multi-cluster-replication): Replicate Workflow state across clusters for failover and disaster recovery.
  * [Temporal Nexus](https://docs.temporal.io/production-deployment/self-hosted-guide/nexus): Enable Nexus in self-hosted environments to connect Temporal Applications across boundaries.


**Tags:**
  * [Temporal Service](https://docs.temporal.io/tags/temporal-service)
  * [Self-hosting](https://docs.temporal.io/tags/self-hosting)


Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).
[Previous Production deployments](https://docs.temporal.io/production-deployment)[Next Deployment](https://docs.temporal.io/self-hosted-guide/deployment)
  * [Plan and deploy your service](https://docs.temporal.io/self-hosted-guide#plan-and-deploy-your-service)
  * [Operate your self-hosted service](https://docs.temporal.io/self-hosted-guide#operate-your-self-hosted-service)
  * [Protect data and enable advanced features](https://docs.temporal.io/self-hosted-guide#protect-data-and-enable-advanced-features)


  * [GitHub](https://github.com/temporalio)
  * [Twitter](https://x.com/temporalio)
  * [YouTube](https://www.youtube.com/c/Temporalio)
  * [About the docs](https://github.com/temporalio/documentation/blob/main/README.md)


  * [Temporal Cloud](https://temporal.io/cloud)
  * [Meetups](https://temporal.io/community#events)
  * [Support forum](https://community.temporal.io/)
  * [Ask an expert](https://pages.temporal.io/ask-an-expert)


  * [Learn Temporal](https://learn.temporal.io)
  * [Blog](https://temporal.io/blog)
  * [Use cases](https://temporal.io/in-use)
  * [Newsletter signup](https://pages.temporal.io/newsletter-subscribe)


  * [Security](https://docs.temporal.io/security)
  * [Privacy policy](https://temporal.io/global-privacy-policy)
  * [Terms of service](https://temporal.io/terms-of-service)
  * [We're hiring](https://temporal.io/careers)


[![Temporal logo](https://docs.temporal.io/img/favicon.png)](https://temporal.io)
Copyright © 2026 Temporal Technologies Inc.
Feedback![](https://static.scarf.sh/a.png?x-pxid=6fb132d3-92f6-455f-bf17-eb3d6937bdea)

