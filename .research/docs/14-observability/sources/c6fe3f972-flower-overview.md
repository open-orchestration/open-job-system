### Navigation

- [next](https://flower.readthedocs.io/en/latest/features.html "Features")
- [Flower 2.0.0 documentation](https://flower.readthedocs.io/en/latest/#) »

# Flower [¶](https://flower.readthedocs.io/en/latest/\#flower "Permalink to this headline")

Flower is an open-source web application for monitoring and managing [Celery](https://docs.celeryq.dev/en/stable/#) clusters.
It provides real-time information about the status of Celery workers and tasks.

## Contents [¶](https://flower.readthedocs.io/en/latest/\#contents "Permalink to this headline")

- [Features](https://flower.readthedocs.io/en/latest/features.html)
- [Getting started](https://flower.readthedocs.io/en/latest/install.html)
  - [Installation](https://flower.readthedocs.io/en/latest/install.html#installation)
  - [Usage](https://flower.readthedocs.io/en/latest/install.html#usage)
- [Configuration](https://flower.readthedocs.io/en/latest/config.html)
  - [Command line](https://flower.readthedocs.io/en/latest/config.html#command-line)
  - [Configuration file](https://flower.readthedocs.io/en/latest/config.html#configuration-file)
  - [Environment variables](https://flower.readthedocs.io/en/latest/config.html#environment-variables)
  - [Option Reference](https://flower.readthedocs.io/en/latest/config.html#option-reference)
- [Tasks filtering](https://flower.readthedocs.io/en/latest/tasks_filter.html)
- [Authentication](https://flower.readthedocs.io/en/latest/auth.html)
  - [HTTP Basic Authentication](https://flower.readthedocs.io/en/latest/auth.html#http-basic-authentication)
  - [Google OAuth](https://flower.readthedocs.io/en/latest/auth.html#google-oauth)
  - [GitHub OAuth](https://flower.readthedocs.io/en/latest/auth.html#github-oauth)
  - [Okta OAuth](https://flower.readthedocs.io/en/latest/auth.html#okta-oauth)
  - [GitLab OAuth](https://flower.readthedocs.io/en/latest/auth.html#gitlab-oauth)
- [Running behind reverse proxy](https://flower.readthedocs.io/en/latest/reverse-proxy.html)
- [Prometheus Integration](https://flower.readthedocs.io/en/latest/prometheus-integration.html)
  - [Configure Prometheus to scrape Flower metrics](https://flower.readthedocs.io/en/latest/prometheus-integration.html#configure-prometheus-to-scrape-flower-metrics)
  - [Available Metrics](https://flower.readthedocs.io/en/latest/prometheus-integration.html#available-metrics)
  - [Using Metric Labels](https://flower.readthedocs.io/en/latest/prometheus-integration.html#using-metric-labels)
  - [Example Prometheus Alerts](https://flower.readthedocs.io/en/latest/prometheus-integration.html#example-prometheus-alerts)
  - [Example Grafana Dashboard](https://flower.readthedocs.io/en/latest/prometheus-integration.html#example-grafana-dashboard)
- [Grafana Integration Guide](https://flower.readthedocs.io/en/latest/prometheus-integration.html#grafana-integration-guide)
  - [Start Celery Broker](https://flower.readthedocs.io/en/latest/prometheus-integration.html#start-celery-broker)
  - [Set Up Your Celery Application](https://flower.readthedocs.io/en/latest/prometheus-integration.html#set-up-your-celery-application)
  - [Start Flower Monitoring](https://flower.readthedocs.io/en/latest/prometheus-integration.html#start-flower-monitoring)
  - [Configure and Start Prometheus](https://flower.readthedocs.io/en/latest/prometheus-integration.html#configure-and-start-prometheus)
  - [Start Grafana](https://flower.readthedocs.io/en/latest/prometheus-integration.html#start-grafana)
  - [Add Prometheus As a Data Source In Grafana](https://flower.readthedocs.io/en/latest/prometheus-integration.html#add-prometheus-as-a-data-source-in-grafana)
  - [Import The Celery Monitoring Dashboard In Grafana](https://flower.readthedocs.io/en/latest/prometheus-integration.html#import-the-celery-monitoring-dashboard-in-grafana)
- [API Reference](https://flower.readthedocs.io/en/latest/api.html)

Flower is licensed under BSD 3-Clause License.
See the [License](https://github.com/mher/flower/blob/master/LICENSE) file for the full license text.

### [Table Of Contents](https://flower.readthedocs.io/en/latest/\#)

- [Features](https://flower.readthedocs.io/en/latest/features.html)
- [Getting started](https://flower.readthedocs.io/en/latest/install.html)
  - [Installation](https://flower.readthedocs.io/en/latest/install.html#installation)
  - [Usage](https://flower.readthedocs.io/en/latest/install.html#usage)
- [Configuration](https://flower.readthedocs.io/en/latest/config.html)
  - [Command line](https://flower.readthedocs.io/en/latest/config.html#command-line)
  - [Configuration file](https://flower.readthedocs.io/en/latest/config.html#configuration-file)
  - [Environment variables](https://flower.readthedocs.io/en/latest/config.html#environment-variables)
  - [Option Reference](https://flower.readthedocs.io/en/latest/config.html#option-reference)
- [Tasks filtering](https://flower.readthedocs.io/en/latest/tasks_filter.html)
- [Authentication](https://flower.readthedocs.io/en/latest/auth.html)
  - [HTTP Basic Authentication](https://flower.readthedocs.io/en/latest/auth.html#http-basic-authentication)
  - [Google OAuth](https://flower.readthedocs.io/en/latest/auth.html#google-oauth)
  - [GitHub OAuth](https://flower.readthedocs.io/en/latest/auth.html#github-oauth)
  - [Okta OAuth](https://flower.readthedocs.io/en/latest/auth.html#okta-oauth)
  - [GitLab OAuth](https://flower.readthedocs.io/en/latest/auth.html#gitlab-oauth)
- [Running behind reverse proxy](https://flower.readthedocs.io/en/latest/reverse-proxy.html)
- [Prometheus Integration](https://flower.readthedocs.io/en/latest/prometheus-integration.html)
  - [Configure Prometheus to scrape Flower metrics](https://flower.readthedocs.io/en/latest/prometheus-integration.html#configure-prometheus-to-scrape-flower-metrics)
  - [Available Metrics](https://flower.readthedocs.io/en/latest/prometheus-integration.html#available-metrics)
  - [Using Metric Labels](https://flower.readthedocs.io/en/latest/prometheus-integration.html#using-metric-labels)
  - [Example Prometheus Alerts](https://flower.readthedocs.io/en/latest/prometheus-integration.html#example-prometheus-alerts)
  - [Example Grafana Dashboard](https://flower.readthedocs.io/en/latest/prometheus-integration.html#example-grafana-dashboard)
- [Grafana Integration Guide](https://flower.readthedocs.io/en/latest/prometheus-integration.html#grafana-integration-guide)
  - [Start Celery Broker](https://flower.readthedocs.io/en/latest/prometheus-integration.html#start-celery-broker)
  - [Set Up Your Celery Application](https://flower.readthedocs.io/en/latest/prometheus-integration.html#set-up-your-celery-application)
  - [Start Flower Monitoring](https://flower.readthedocs.io/en/latest/prometheus-integration.html#start-flower-monitoring)
  - [Configure and Start Prometheus](https://flower.readthedocs.io/en/latest/prometheus-integration.html#configure-and-start-prometheus)
  - [Start Grafana](https://flower.readthedocs.io/en/latest/prometheus-integration.html#start-grafana)
  - [Add Prometheus As a Data Source In Grafana](https://flower.readthedocs.io/en/latest/prometheus-integration.html#add-prometheus-as-a-data-source-in-grafana)
  - [Import The Celery Monitoring Dashboard In Grafana](https://flower.readthedocs.io/en/latest/prometheus-integration.html#import-the-celery-monitoring-dashboard-in-grafana)
- [API Reference](https://flower.readthedocs.io/en/latest/api.html)

### Quick search

### Navigation

- [next](https://flower.readthedocs.io/en/latest/features.html "Features")
- [Flower 2.0.0 documentation](https://flower.readthedocs.io/en/latest/#) »

© Copyright 2023, Mher Movsisyan.


![Read the Docs](<Base64-Image-Removed>)latest
Versions**[latest](https://flower.readthedocs.io/en/latest/)**[2.0](https://flower.readthedocs.io/en/2.0/)[1.0](https://flower.readthedocs.io/en/1.0/)On Read the Docs[Project Home](https://app.readthedocs.org/projects/flower/?utm_source=flower&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/flower/builds/?utm_source=flower&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=flower&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=flower&utm_content=flyout)