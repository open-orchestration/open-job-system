---
id: d90bfcee4
topic: workflow-orchestration
title: "ML and data-pipeline orchestrators: Kubeflow Pipelines, Luigi, Mage, and Metaflow"
status: draft
shape: survey
---

# ML and data-pipeline orchestrators: Kubeflow Pipelines, Luigi, Mage, and Metaflow

This survey states what each of four ML/data-pipeline orchestrators IS, in the
project's own definitional wording, so the four can be told apart by their
defining model and domain.

## Kubeflow Pipelines

Kubeflow Pipelines (KFP) is described as "a platform for building and deploying
portable and scalable machine learning (ML) workflows using containers on
Kubernetes-based systems" [c7a50cffa]. Its authoring model is built around
"components" and "pipelines": with KFP a user can author components and
pipelines using the "KFP Python SDK", compile pipelines to an "intermediate
representation YAML", and submit the pipeline to run on a "KFP-conformant
backend" [c7a50cffa]. A pipeline is defined as "a definition of a workflow that
composes one or more components together" [c7a50cffa]. The open source KFP
backend is available as a core component of Kubeflow or as a standalone
installation [c7a50cffa].

## Luigi

Luigi is described as "a Python ... package that helps you build complex
pipelines of batch jobs" [c904f5453]. It handles "dependency resolution,
workflow management, visualization, handling failures, command line
integration, and much more" [c904f5453]. Its stated purpose is "to address all
the plumbing typically associated with long-running batch processes"; rather
than replacing lower-level data-processing tools such as Hive, Pig, or
Cascading, it "helps you stitch many tasks together," where each task can be a
Hive query, a Hadoop job, a Spark job, a Python snippet, or a database dump
[c904f5453]. The hosted source repository is `spotify/luigi`, and the
visualiser server "comes with a web interface" for searching and filtering
tasks [c904f5453].

## Mage

Mage is described as "a hybrid framework for transforming and integrating
data" that "combines the best of both worlds: the flexibility of notebooks with
the rigor of modular code" [c368c6093]. Its stated capabilities are to extract
and synchronize data from third-party sources, transform data "with real-time
and batch pipelines using Python, SQL, and R," load data into a data warehouse
or data lake using pre-built connectors, and "run, monitor, and orchestrate
thousands of pipelines" [c368c6093]. It is offered in two versions: a fully
managed platform "for integrating and transforming data," and a self-hosted
"system to build, run, and manage data pipelines" [c368c6093].

## Metaflow

Metaflow is described in its own definitional statement as a tool that "makes
it easy to build and manage real-life data science, AI, and ML projects"
[c662849c7]. Its documentation organizes its model around "Flows": the
project's sections cover Flow Development, Scaling Flows, and Deploying to
Production [c662849c7]. The hosted source repository is `Netflix/metaflow`
[c662849c7].

## Note on substantiation

All four pages carry genuine definitional prose about what the tool IS, and
each section above quotes only that source. Beyond the single-sentence
self-description quoted above, the Metaflow page consists primarily of
navigation and section links rather than extended definitional paragraphs, so
its entry is correspondingly narrower [c662849c7].
