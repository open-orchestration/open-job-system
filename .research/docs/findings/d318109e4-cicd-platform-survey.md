---
id: d318109e4
topic: cicd
title: "CI/CD Pipeline Platform Landscape: GitHub Actions, Jenkins, Drone, and CircleCI"
status: draft
shape: survey
---

# CI/CD Pipeline Platform Landscape: GitHub Actions, Jenkins, Drone, and CircleCI

A survey of four CI/CD pipeline platforms, drawn strictly from each platform's own documentation. Each section states what the platform IS and how its pipelines are defined, triggered, and executed. Per the survey rule, every claim carries only the cid of the platform it describes.

## GitHub Actions

GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline [c9c1805a5]. You can create workflows that build and test every pull request to your repository, or deploy merged pull requests to production [c9c1805a5]. GitHub Actions goes beyond just DevOps and lets you run workflows when other events happen in your repository, such as running a workflow to automatically add the appropriate labels whenever someone creates a new issue [c9c1805a5].

A workflow is a configurable automated process that will run one or more jobs, defined by a YAML file checked in to your repository [c9c1805a5]. Workflows are defined in the `.github/workflows` directory in a repository, and a repository can have multiple workflows each performing a different set of tasks [c9c1805a5]. A workflow runs when triggered by an event in the repository, or it can be triggered manually or at a defined schedule [c9c1805a5]. An event is a specific activity in a repository that triggers a workflow run, such as creating a pull request, opening an issue, or pushing a commit; a workflow can also be triggered on a schedule, by posting to a REST API, or manually [c9c1805a5].

A workflow contains one or more jobs which can run in sequential order or in parallel, and each job runs inside its own runner or inside a container and has one or more steps [c9c1805a5]. Each step either runs a script that you define or runs an action, a reusable extension that can simplify your workflow [c9c1805a5]. By default jobs have no dependencies and run in parallel, but a job can be configured to depend on another job and will then wait for the dependent job to complete before running [c9c1805a5]. A runner is a server that runs your workflows when they are triggered, and each runner can run a single job at a time [c9c1805a5]. GitHub provides Ubuntu Linux, Microsoft Windows, and macOS virtual machines to run workflows, and each workflow run executes in a fresh, newly-provisioned virtual machine [c9c1805a5]. If you need a different operating system or a specific hardware configuration, you can host your own self-hosted runners in your own data center or cloud infrastructure [c9c1805a5].

## Jenkins

Jenkins Pipeline is a suite of plugins which supports implementing and integrating continuous delivery pipelines into Jenkins [c428c480a]. A Pipeline is a user-defined model of a CD pipeline whose code defines the entire build process, which typically includes stages for building an application, testing it, and then delivering it [c428c480a]. Pipeline provides an extensible set of tools for modeling simple-to-complex delivery pipelines "as code" via the Pipeline domain-specific language (DSL) syntax [c428c480a].

The definition of a Jenkins Pipeline is written into a text file called a `Jenkinsfile`, which in turn can be committed to a project's source control repository [c428c480a]. This is the foundation of "Pipeline-as-code", treating the CD pipeline as a part of the application to be versioned and reviewed like any other code [c428c480a]. While the syntax for defining a Pipeline is the same in the web UI or with a `Jenkinsfile`, it is generally considered best practice to define the Pipeline in a `Jenkinsfile` and check it in to source control [c428c480a].

A `Jenkinsfile` can be written using two types of syntax, Declarative and Scripted, which are constructed fundamentally differently [c428c480a]. Declarative Pipeline is designed to make writing and reading Pipeline code easier and provides richer syntactical features over Scripted Pipeline syntax [c428c480a]. In Declarative Pipeline syntax, the `pipeline` block defines all the work done throughout the entire Pipeline; in Scripted Pipeline syntax, one or more `node` blocks do the core work [c428c480a]. Key concepts include the Node, a machine that is part of the Jenkins environment and is capable of executing a Pipeline; the Stage, a block defining a conceptually distinct subset of tasks such as "Build", "Test", and "Deploy"; and the Step, a single task that tells Jenkins what to do at a particular point in the process [c428c480a].

## Drone

In Drone, pipelines help you automate steps in your software delivery process, such as initiating code builds, running automated tests, and deploying to a staging or production environment [c797764b0]. Pipeline execution is triggered by a source code repository: a change in code triggers a webhook to Drone which runs the corresponding pipeline, while other common triggers include automatically scheduled or user-initiated workflows [c797764b0].

Pipelines are configured by placing a `.drone.yml` file in the root of your git repository, and the YAML syntax is designed to be easy to read and expressive so that anyone viewing the repository can understand the workflow [c797764b0]. Drone supports different types of pipelines, each optimized for different use cases and runtime environments, including Docker, Kubernetes, Exec, SSH, Digital Ocean, and MacStadium pipelines [c797764b0].

## CircleCI

CircleCI believes in configuration as code: a single file called `config.yml` orchestrates the entire CI/CD process, lives in a folder called `.circleci` at the root of the project, and defines the entire pipeline [c3f8aaa77]. CircleCI configurations use YAML [c3f8aaa77]. The components of most common CircleCI projects, sorted in order of granularity and dependence, are the Pipeline (the entirety of the configuration), Workflows (responsible for orchestrating multiple jobs), Jobs (responsible for running a series of steps that perform commands), and Steps (which run commands and shell scripts to do the required work) [c3f8aaa77].

A CircleCI pipeline is the full set of processes you run when you trigger work on your projects, encompassing your workflows, which in turn coordinate your jobs, and pipelines are defined in your project configuration file [c3f8aaa77]. Workflows orchestrate jobs by defining a list of jobs and their run order, which can run concurrently, sequentially, on a schedule, or with a manual gate using an approval job [c3f8aaa77]. Jobs are collections of steps, and each job must declare an executor that is either `docker`, `machine`, `windows`, or `macos` [c3f8aaa77]. Each separate job runs in a unique execution environment, known as executors, where an executor can be a Docker container or a virtual machine running Linux, Windows, or macOS [c3f8aaa77].

Contexts provide a mechanism for securing and sharing environment variables across projects: you define environment variables as name/value pairs and CircleCI injects them at runtime, with access granted via the `context` key in the workflows section of a project's configuration file [c3f8aaa77]. Orbs are reusable snippets of code that help automate repeated processes, accelerate project setup, and help you integrate with third-party tools [c3f8aaa77].

## Dropped sources

None. All four cited sources (c9c1805a5, c428c480a, c797764b0, c3f8aaa77) were anchored to body prose.
