[Skip to main content](https://docs.temporal.io/self-hosted-guide/deployment#__docusaurus_skipToContent_fallback)
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
  * [Interactive Demos](https://docs.temporal.io/self-hosted-guide/deployment)
  * [Integrations](https://docs.temporal.io/integrations)
  * [Glossary](https://docs.temporal.io/glossary)
  * [Develop with AI](https://docs.temporal.io/with-ai)


  * [](https://docs.temporal.io/)
  * [Deploy to production](https://docs.temporal.io/production-deployment)
  * [Self-host](https://docs.temporal.io/self-hosted-guide)
  * Deployment


On this page
# Deploying a Temporal Service
Copy Markdown[View Markdown](https://docs.temporal.io/self-hosted-guide/deployment.md "View this page as Markdown")
[](https://chatgpt.com/?prompt=Read%20https%3A%2F%2Fdocs.temporal.io%2Fself-hosted-guide%2Fdeployment.md%20and%20answer%20questions%20about%20the%20content. "Open in ChatGPT")[](https://claude.ai/new?q=Read%20https%3A%2F%2Fdocs.temporal.io%2Fself-hosted-guide%2Fdeployment.md%20and%20answer%20questions%20about%20the%20content. "Open in Claude")
There are many ways to self-host a [Temporal Service](https://docs.temporal.io/temporal-service). The right way for you depends entirely on your use case and where you plan to run it.
This page provides instructions for deploying a Temporal Service for sustained workloads that exceed what the [development server](https://docs.temporal.io/cli#start-a-development-server) is designed to handle. For local development or testing, you can use the Temporal CLI to [start a local development Temporal Service](https://docs.temporal.io/cli#start-a-development-server).
Temporal Hosts Should Not Be Exposed to the Open Internet
In self-hosted deployments, the Temporal Service is a critical control and persistence component and should be secured similarly to a database. Temporal services should run on hosts that are not accessible from the public internet, with network configurations that restrict access to trusted internal networks only.
For step-by-step guides on deploying and configuring Temporal, refer to our [Infrastructure tutorials](https://learn.temporal.io/tutorials/infrastructure/).
## Use Docker Compose[​](https://docs.temporal.io/self-hosted-guide/deployment#use-docker-compose "Direct link to Use Docker Compose")
You can run a Temporal Service in [Docker](https://docs.docker.com/engine/install) containers using [Docker Compose](https://docs.docker.com/compose/install).
### Prerequisites[​](https://docs.temporal.io/self-hosted-guide/deployment#prerequisites "Direct link to Prerequisites")
  * You have Docker Compose installed.
  * Docker is running and the daemon is available.
  * Git is installed and available.


### Procedure[​](https://docs.temporal.io/self-hosted-guide/deployment#procedure "Direct link to Procedure")
  1. Clone the [temporalio/samples-server](https://github.com/temporalio/samples-server) repository.
  2. Change into the `compose` directory.

```


cd samples-server/compose  



```

  3. Run the `docker compose up` command. This uses the default configuration from the `docker-compose.yaml` file, which includes a PostgreSQL database, an Elasticsearch instance, and exposes the Temporal gRPC Frontend on port 7233.

```


docker compose up  



```

The Temporal Web UI will be available at `http://localhost:8080`.
  4. (Optional) Review [the additional configuration options](https://github.com/temporalio/samples-server/tree/main/compose#other-configuration-files) available in the samples-server repository and use `docker compose up` with the corresponding configuration file to try them out. The configurations include different databases, visibility stores, and TLS settings.


## Use Temporal Server binaries[​](https://docs.temporal.io/self-hosted-guide/deployment#use-temporal-server-binaries "Direct link to Use Temporal Server binaries")
You can run a complete Temporal Server by deploying two Go binaries -- the [core Temporal Server](https://github.com/temporalio/temporal/releases/), and the [Temporal UI Server](https://github.com/temporalio/ui-server/releases).
Each service can be deployed separately. Refer to [How to Configure a Temporal Service without a Proxy](https://learn.temporal.io/tutorials/infrastructure/configuring-sqlite-binary/) to deploy each service using `systemd`. If you need to run the Temporal Server behind a reverse proxy, refer to our tutorials to deploy the Temporal Service behind an [Nginx reverse proxy](https://learn.temporal.io/tutorials/infrastructure/nginx-sqlite-binary/) or an [Envoy edge proxy](https://learn.temporal.io/tutorials/infrastructure/envoy-sqlite-binary/).
### Configuration templating[​](https://docs.temporal.io/self-hosted-guide/deployment#configuration-templating "Direct link to Configuration templating")
Configuration templating is how the Temporal Server turns a template config file into the final `config.yaml` it runs with. It lets you reuse one template across environments by filling in values from environment variables. For example, database endpoints, TLS paths, or feature flags.
If you are **not** using a custom config template, you can skip this section. The default configuration is rendered automatically by the server and embedded in the binary.
#### Template compatibility[​](https://docs.temporal.io/self-hosted-guide/deployment#template-compatibility "Direct link to Template compatibility")
If you use a custom configuration template, be aware of the following:
  * The server renders templates with embedded `sprig`, so any `dockerize`-specific syntax or helpers will fail
  * Some template syntax differs, particularly `.Env` and `default` function usage.
  * Refer to the [sprig documentation](http://masterminds.github.io/sprig/) for supported template functions
  * Use `temporal-server render-config` to verify your templates render correctly


#### Helm Chart configuration[​](https://docs.temporal.io/self-hosted-guide/deployment#helm-chart-configuration "Direct link to Helm Chart configuration")
When deploying with Helm charts versions 0.73.1 or later, you may need to adjust the following configuration options depending on the images you are using.  
| Configuration Option  | Description  | Default  |  
| --- | --- | --- |  
| `server.useEntrypointScript`  | Whether to use entrypoint script that autodetects `dockerize` vs `sprig`.  | `false`  |  
| `server.configMapsToMount`  | Which config template to mount: `"dockerize"`, `"sprig"`, or `"both"`.  | `"dockerize"`  |  
| `server.setConfigFilePath`  | Set `TEMPORAL_SERVER_CONFIG_FILE_PATH` environment variable.  | `false`  |  
Refer to the following guidelines to determine if you need to adjust the configuration options:
  * The default settings work if you are only using pre-1.30 images with 0.73.1 or later Helm chart.
  * If you are using 1.30+ images with 0.73.1 or later Helm chart, you need to set `server.configMapsToMount` to `"sprig"` and `server.setConfigFilePath` to `true`. Keep the `server.useEntrypointScript` as `false`.
  * If you need use the Helm chart with both pre-1.30 and 1.30+ images, you need to set `server.configMapsToMount` to `"both"` and `server.useEntrypointScript` to `true`. Keep the `server.setConfigFilePath` as `false`.


## Import the Server package[​](https://docs.temporal.io/self-hosted-guide/deployment#import-the-server-package "Direct link to Import the Server package")
The Temporal Server is a standalone Go application that can be [imported](https://docs.temporal.io/references/server-options) into another project.
You might want to do this to pass custom plugins or any other customizations through the [Server Options](https://docs.temporal.io/references/server-options). Then you can build and run a binary that contains your customizations.
This requires Go v1.19 or later, as specified in the Temporal Server [Build prerequisites](https://github.com/temporalio/temporal/blob/main/CONTRIBUTING.md#build-prerequisites).
## Use Helm charts[​](https://docs.temporal.io/self-hosted-guide/deployment#use-helm-charts "Direct link to Use Helm charts")
[Temporal Helm charts](https://github.com/temporalio/helm-charts) enable you to get a Temporal Service running on [Kubernetes](https://kubernetes.io/) by deploying the Temporal Server services to individual pods and connecting them to your existing database and Elasticsearch instances.
The Temporal Helm charts repo contains [extensive documentation](https://github.com/temporalio/helm-charts/blob/main/README.md) about Kubernetes deployments.
Helm Chart version compatibility
If you are using Temporal Server images 1.30+, you must upgrade to Helm chart version 0.73.1 or later.
Helm chart versions below 0.73.1 are **not compatible** with `server` and `admin-tools` images **version 1.30 and later**. You **cannot** override old chart versions with newer images.
**Tags:**
  * [Temporal Service](https://docs.temporal.io/tags/temporal-service)
  * [Self-hosting](https://docs.temporal.io/tags/self-hosting)


Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).
[Previous Self-hosted guide](https://docs.temporal.io/self-hosted-guide)[Next Embedded server](https://docs.temporal.io/self-hosted-guide/embedded-server)
  * [Use Docker Compose](https://docs.temporal.io/self-hosted-guide/deployment#use-docker-compose)
    * [Prerequisites](https://docs.temporal.io/self-hosted-guide/deployment#prerequisites)
    * [Procedure](https://docs.temporal.io/self-hosted-guide/deployment#procedure)
  * [Use Temporal Server binaries](https://docs.temporal.io/self-hosted-guide/deployment#use-temporal-server-binaries)
    * [Configuration templating](https://docs.temporal.io/self-hosted-guide/deployment#configuration-templating)
      * [Template compatibility](https://docs.temporal.io/self-hosted-guide/deployment#template-compatibility)
      * [Helm Chart configuration](https://docs.temporal.io/self-hosted-guide/deployment#helm-chart-configuration)
  * [Import the Server package](https://docs.temporal.io/self-hosted-guide/deployment#import-the-server-package)
  * [Use Helm charts](https://docs.temporal.io/self-hosted-guide/deployment#use-helm-charts)


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

