[Documentation structure for LLMs (llms.txt)](https://circleci.com/docs/llms.txt)

[![CircleCI Logo](https://circleci.com/docs/_/img/logo.svg)![CircleCI Logo](https://circleci.com/docs/_/img/logo-dark.svg)](https://circleci.com/docs/)

ctrl+/

Clear


Light

Dark

Auto

[Go to Application](https://app.circleci.com/)

- [Home](https://circleci.com/docs/)
- [Guides](https://circleci.com/docs/guides/getting-started/first-steps/)
- [Reference](https://circleci.com/docs/reference/configuration-reference/)
- [Server](https://circleci.com/docs/server-admin/latest/overview/circleci-server-overview/)
- [Orbs](https://circleci.com/docs/orbs/use/orb-intro/)
- [Services](https://circleci.com/docs/services/services-overview/)
- [Contributors](https://circleci.com/docs/contributors/docs-style/)

- [Dev Hub](https://circleci.com/developer/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)
- [API](https://circleci.com/docs/reference/api-homepage/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)
- [Support](https://support.circleci.com/hc/en-us/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)
- [Discuss](https://discuss.circleci.com/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)
- [CircleCI.com](https://circleci.com/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)

## \[path\]

\[numberOfHits\]

12...12

Guides![Toggle](https://circleci.com/docs/_/img/arrow-down.svg)

- [Home](https://circleci.com/docs/)
- [Guides](https://circleci.com/docs/guides/getting-started/first-steps/)
- [Reference](https://circleci.com/docs/reference/configuration-reference/)
- [Server](https://circleci.com/docs/server-admin/latest/overview/circleci-server-overview/)
- [Orbs](https://circleci.com/docs/orbs/use/orb-intro/)
- [Services](https://circleci.com/docs/services/services-overview/)
- [Contributors](https://circleci.com/docs/contributors/docs-style/)

- [Home](https://circleci.com/docs/)
- [Guides](https://circleci.com/docs/guides/getting-started/first-steps/)
- About CircleCI

# Concepts

[11 days ago](https://github.com/circleci/circleci-docs/commit/f3c3087e1a1ec99dd61163f9fec5f9ac03d9e0aa)

Cloud

Server v4+


Markdown

- [View markdown](https://circleci.com/docs/guides/about-circleci/concepts/index.md)
- Copy markdown


### On This Page

- [Introduction](https://circleci.com/docs/guides/about-circleci/concepts/#introduction)
- [Concurrency](https://circleci.com/docs/guides/about-circleci/concepts/#concurrency)
- [Configuration](https://circleci.com/docs/guides/about-circleci/concepts/#configuration)
- [Contexts](https://circleci.com/docs/guides/about-circleci/concepts/#contexts)
- [Data persistence](https://circleci.com/docs/guides/about-circleci/concepts/#data-persistence)
- [Artifacts](https://circleci.com/docs/guides/about-circleci/concepts/#artifacts)
- [Caches](https://circleci.com/docs/guides/about-circleci/concepts/#caches)
- [Workspaces](https://circleci.com/docs/guides/about-circleci/concepts/#workspaces)
- [Docker layer caching](https://circleci.com/docs/guides/about-circleci/concepts/#docker-layer-caching)
- [Dynamic configuration](https://circleci.com/docs/guides/about-circleci/concepts/#dynamic-configuration)
- [Execution environments](https://circleci.com/docs/guides/about-circleci/concepts/#execution-environments)
- [Images](https://circleci.com/docs/guides/about-circleci/concepts/#images)
- [Jobs](https://circleci.com/docs/guides/about-circleci/concepts/#jobs)
- [Orbs](https://circleci.com/docs/guides/about-circleci/concepts/#orbs)
- [Parallelism](https://circleci.com/docs/guides/about-circleci/concepts/#parallelism)
- [Pipelines](https://circleci.com/docs/guides/about-circleci/concepts/#pipelines)
- [Projects](https://circleci.com/docs/guides/about-circleci/concepts/#projects)
- [Resource class](https://circleci.com/docs/guides/about-circleci/concepts/#resource-class)
- [Steps](https://circleci.com/docs/guides/about-circleci/concepts/#steps)
- [User roles](https://circleci.com/docs/guides/about-circleci/concepts/#user-types)
- [GitHub App, GitLab and Bitbucket Data Center users](https://circleci.com/docs/guides/about-circleci/concepts/#github-app-gitlab-and-bitbucket-data-center-users)
- [GitHub OAuth app and Bitbucket Cloud users](https://circleci.com/docs/guides/about-circleci/concepts/#github-oauth-app-and-bitbucket-cloud-users)
- [Workflows](https://circleci.com/docs/guides/about-circleci/concepts/#workflows)
- [See also](https://circleci.com/docs/guides/about-circleci/concepts/#see-also)

## Introduction

This guide introduces some basic concepts to help you understand how CircleCI manages your CI/CD pipelines.

## Concurrency

In CircleCI, _concurrency_ refers to utilizing multiple containers to run multiple jobs at the same time. To keep the system stable for all CircleCI customers, we use different soft concurrency limits on each of the [Resource Classes](https://circleci.com/docs/reference/configuration-reference/#resourceclass) for different executors. If you experience queueing on your jobs, you may be hitting these limits. Customers on annual plans can request an increase to those limits at no extra charge.

See the [Concurrency](https://circleci.com/docs/guides/optimize/concurrency/) page for more information.

## Configuration

CircleCI believes in _configuration as code_. A single file called `config.yml` orchestrates your entire CI/CD process. This file lives in a folder called `.circleci` at the root of your project and defines the entire pipeline.

Example of a directory setup using CircleCI:

```
├── .circleci
│   ├── config.yml
├── README
└── all-other-project-files-and-folders
```

shell

You can adapt your CircleCI configuration to fit the different needs of your project. The following terms, sorted in order of granularity and dependence, describe the components of most common CircleCI projects:

- **[Pipeline](https://circleci.com/docs/guides/about-circleci/concepts/#pipelines)**: Represents the entirety of your configuration.

- **[Workflows](https://circleci.com/docs/guides/about-circleci/concepts/#workflows)**: Responsible for orchestrating multiple _jobs_.

- **[Jobs](https://circleci.com/docs/guides/about-circleci/concepts/#jobs)**: Responsible for running a series of _steps_ that perform commands.

- **[Steps](https://circleci.com/docs/guides/about-circleci/concepts/#steps)**: Run commands (such as installing dependencies or running tests) and shell scripts to do the work required for your project.


The following illustration uses an [example Java application](https://github.com/CircleCI-Public/circleci-demo-java-spring/tree/2.1-config) to show the various configuration elements:

![configuration elements](https://circleci.com/docs/guides/_images/config-elements.png)

Figure 1. Configuration elements

CircleCI configurations use YAML. See the [Introduction to YAML Configurations](https://circleci.com/docs/guides/getting-started/introduction-to-yaml-configurations/) page for basic guidance. For a full overview of what is possible in a configuration file, see the [Configuration Reference](https://circleci.com/docs/reference/configuration-reference/) page.

## Contexts

Contexts provide a mechanism for securing and sharing environment variables across projects. You define environment variables as name/value pairs, and CircleCI injects them at runtime. The process to use a context is as follows:

1. Create a context.

2. Add environment variables to the context.

3. Use the `context` key in the workflows section of a project’s configuration file to give access to the environment variables stored in the context.


![Contexts Overview](https://circleci.com/docs/guides/_images/contexts_cloud.png)

Figure 2. Contexts overview

See the [Using Contexts](https://circleci.com/docs/guides/security/contexts/) page for more information.

## Data persistence

Persist data to move data between jobs and speed up your build. Persist data using one of three methods in CircleCI:

- Artifacts

- Caches

- Workspaces.


![workflow illustration](https://circleci.com/docs/guides/_images/workspaces.png)

Figure 3. Workflow illustration

Note the following distinctions between artifacts, caches, and workspaces:

| Type | Lifetime | Use | Example |
| --- | --- | --- | --- |
| Artifacts | Months | Preserve long-term artifacts. | Available in the Artifacts tab of the **Job** page under the `tmp/circle-artifacts.<hash>/container` or similar directory. |
| Caches | Months | Store non-vital data that may help the job run faster, for example npm or Gem packages. | The `save_cache` job step with a `path` to a list of directories to add and a `key` to uniquely identify the cache (for example, the branch, build number, or revision). Restore the cache with `restore_cache` and the appropriate `key`. |
| Workspaces | Duration of workflow | Attach the workspace in a downstream container with the `attach_workspace:` step. | The `attach_workspace` copies and recreates the entire workspace content when it runs. |

### Artifacts

Artifacts persist data after a workflow completes and provide longer-term storage of the outputs of your build process.

```
version: 2.1

jobs:
  build1:
    docker:
      - image: cimg/base:2023.03
    steps:
      - persist_to_workspace: # Persist the specified paths (workspace/echo-output)
      # into the workspace for use in downstream job. Must be an absolute path,
      # or relative path from working_directory. This is a directory on the container which is
      # taken to be the root directory of the workspace.
          root: workspace
            # Must be relative path from root
          paths:
            - echo-output

  build2:
    machine:
      image: ubuntu-2204:2024.01.2
    steps:
      - attach_workspace:
        # Must be absolute path or relative path from working_directory
          at: /tmp/workspace
  build3:
    docker:
      - image: cimg/base:2023.03
    steps:
      - store_artifacts: # See circleci.com/docs/artifacts/ for more details.
          path: /tmp/artifact-1
          destination: artifact-file

workflows:
  my-workflow:
    jobs:
      - build1
      - build2:
          requires:
            - build1
      - build3:
          requires:
            - build1
            - build2
```

yaml

See the [Storing Build Artifacts](https://circleci.com/docs/guides/optimize/artifacts/) page for more information.

### Caches

A cache stores a file or directory of files such as dependencies or source code in object storage. To speed up the build, each job may contain special steps for caching dependencies from previous jobs.

If you need to clear your cache, refer to the [Caching Dependencies](https://circleci.com/docs/guides/optimize/caching/#clearing-cache) page for more information.

```
version: 2.1

jobs:
  build1:
    docker: # Each job requires specifying an executor
    # (either docker, macos, or machine), see
    # circleci.com/docs/executor-intro/ for a comparison
    # and more examples.
      - image: cimg/ruby:2.4-node
      - image: cimg/postgres:9.4.12
    steps:
      - checkout
      - save_cache: # Caches dependencies with a cache key
      # template for an environment variable,
      # see circleci.com/docs/caching/
          key: v1-repo-{{ .Environment.CIRCLE_SHA1 }}
          paths:
            - ~/circleci-demo-workflows

  build2:
    docker:
      - image: cimg/ruby:2.4-node
      - image: cimg/postgres:9.4.12
    steps:
      - restore_cache: # Restores the cached dependency.
          key: v1-repo-{{ .Environment.CIRCLE_SHA1 }}

workflows:
  my-workflow:
    jobs:
      - build1
      - build2:
          requires:
            - build1
```

yaml

For more information see the [Caching Dependencies](https://circleci.com/docs/guides/optimize/caching/) page.

### Workspaces

Workspaces are a workflow-aware storage mechanism. A workspace stores data unique to the job, which downstream jobs may need. Each workflow has a temporary workspace associated with it. Use the workspace to pass along unique data built during a job to other jobs in the same workflow.

See the [Using Workspaces](https://circleci.com/docs/guides/orchestrate/workspaces/) page for more information.

## Docker layer caching

Docker layer caching (DLC) caches the individual layers of Docker images built during your CircleCI jobs. CircleCI uses any unchanged layers on subsequent runs, rather than rebuilding the image each time.

In the `.circleci/config.yml` snippet below, the `build_elixir` job builds an image using the `ubuntu-2004:202104-01` Dockerfile. Adding `docker_layer_caching: true` below the `machine` executor key ensures CircleCI saves each Docker image layer as the Elixir image is built.

```
version: 2.1

jobs:
  build_elixir:
    machine:
      image: ubuntu-2004:202104-01
      docker_layer_caching: true
    steps:
      - checkout
      - run:
          name: build Elixir image
          command: docker build -t circleci/elixir:example .

workflows:
  my-workflow:
    jobs:
      - build_elixir
```

yaml

On subsequent commits, if the Dockerfile has not changed, DLC pulls each Docker image layer from cache during the `build Elixir image` step and the image builds faster.

See the [Docker Layer Caching](https://circleci.com/docs/guides/optimize/docker-layer-caching/) page for more information.

## Dynamic configuration

Instead of manually creating your configuration for each CircleCI project, you can generate this configuration dynamically, based on specific pipeline parameters or file paths. Dynamic configuration is helpful where your team is working on a monorepo (or a single repository). Dynamic configuration allows you to trigger builds from _specific_ parts of your project, rather than rebuilding everything each time.

See the [Dynamic Configuration](https://circleci.com/docs/guides/orchestrate/dynamic-config/) page for more information.

## Execution environments

Each separate job defined within your configuration runs in a unique execution environment, known as executors. An executor can be a Docker container, or a virtual machine running Linux, Windows, or macOS. In some of these instances, you can set up an environment using GPU, or Arm. CircleCI also provides a machine-based and container-based self-hosted runner solution.

![Illustration of a CircleCI job](https://circleci.com/docs/guides/_images/executor_types.png)

Figure 4. Illustration of a CircleCI job

An _image_ is a packaged system that includes instructions for creating a running container or virtual machine, and you can define an image for each executor. CircleCI provides a range of images for use with the Docker executor, called _convenience images_ (details in the [images](https://circleci.com/docs/guides/about-circleci/concepts/#images) section).

|     |     |
| --- | --- |
|  | **Using Docker?** Authenticating Docker pulls from image registries is recommended when using the Docker execution environment. Authenticated pulls allow access to private Docker images, and may also grant higher rate limits, depending on your registry provider. For further information, see [Using Docker authenticated pulls](https://circleci.com/docs/guides/execution-managed/private-images/). |

- Cloud

- Server


```
version: 2.1

jobs:
  build1: # job name
    docker: # Specifies the primary container image,
      - image: cimg/base:2022.04-20.04
      - image: postgres:14.2 # Specifies the database image
        # for the secondary or service container run in a common
        # network where ports exposed on the primary container are
        # available on localhost.
        environment: # Specifies the POSTGRES_USER authentication
        # environment variable, see circleci.com/docs/env-vars/
        # for instructions about using environment variables.
          POSTGRES_USER: user
    steps:
      - checkout
#...
  build2:
    machine: # Specifies a machine image that uses
      # an Ubuntu version 20.04 image with Docker 20.10.12
      # and docker compose 1.29.2, follow CircleCI Discuss Announcements
      # for new image releases.
      image: ubuntu-2004:current
    steps:
      - checkout

#...
  build3:
    macos: # Specifies a macOS virtual machine with Xcode version 12.5.1
      xcode: "12.5.1"
    steps:
      - checkout
# ...

workflows:
  my-workflow:
    jobs:
      - build1
      - build2
      - build3
```

yaml

```
version: 2.1

jobs:
  build1: # job name
    docker: # Specifies the primary container image,
      - image: cimg/base:2022.04-20.04
      - image: postgres:14.2 # Specifies the database image
        # for the secondary or service container run in a common
        # network where ports exposed on the primary container are
        # available on localhost.
        environment: # Specifies the POSTGRES_USER authentication
        # environment variable, see circleci.com/docs/env-vars/
        # for instructions about using environment variables.
          POSTGRES_USER: user
    steps:
      - checkout
#...
  build2:
    machine: true
   # Contact your system administrator for details of the image.
    steps:
      - checkout
#...

workflows:
  my-workflow:
    jobs:
      - build1
      - build2
```

yaml

The first image listed in the `.circleci/config.yml` file defines the primary container. CircleCI executes commands in the primary container. The Docker executor spins up a container with a Docker image. The machine executor spins up a complete Ubuntu virtual machine image. You can add further images to spin up secondary/service containers.

For added security when using the Docker executor and running Docker commands, use the `setup_remote_docker` key to spin up another Docker container in which to run these commands. For more information see the [Running Docker Commands](https://circleci.com/docs/guides/execution-managed/building-docker-images/) page.

For more information, see the [Execution Environments Overview](https://circleci.com/docs/guides/execution-managed/executor-intro/) page.

## Images

An image is a packaged system that includes instructions for creating a running container. The first image listed in a `.circleci/config.yml` file defines the primary container. CircleCI executes commands for jobs in the primary container, using the Docker or machine executor.

The **Docker executor** spins up a container with a Docker image. CircleCI maintains [Convenience Images](https://circleci.com/docs/guides/execution-managed/circleci-images/) for popular languages on Docker Hub.

|     |     |
| --- | --- |
|  | **Using Docker?** Authenticating Docker pulls from image registries is recommended when using the Docker execution environment. Authenticated pulls allow access to private Docker images, and may also grant higher rate limits, depending on your registry provider. For further information, see [Using Docker authenticated pulls](https://circleci.com/docs/guides/execution-managed/private-images/). |

The **machine executor** spins up a complete Ubuntu virtual machine image, giving you full access to OS resources and complete control over the job environment. For more information, see the [Using Machine](https://circleci.com/docs/reference/configuration-reference/#machine) page.

```
version: 2.1

jobs:
  build1: # job name
    docker: # Specifies the primary container image,
      - image: cimg/base:2022.04-20.04
      - image: postgres:14.2 # Specifies the database image
        # for the secondary or service container run in a common
        # network where ports exposed on the primary container are
        # available on localhost.
        environment: # Specifies the POSTGRES_USER authentication
        # environment variable, see circleci.com/docs/env-vars/
        # for instructions about using environment variables.
          POSTGRES_USER: user
    steps:
      - checkout
#...
  build2:
    machine: # Specifies a machine image that uses
      # an Ubuntu version 22.04 image
      image: ubuntu-2204:2024.01.2
    steps:
      - checkout

#...
  build3:
    macos: # Specifies a macOS virtual machine with Xcode version 12.5.1
      xcode: "12.5.1"
    steps:
      - checkout
# ...

workflows:
  my-workflow:
    jobs:
      - build1
      - build2
      - build3
```

yaml

See the [CircleCI Images](https://circleci.com/docs/guides/execution-managed/circleci-images/) page for more information.

## Jobs

Jobs are the building blocks of your configuration. Jobs are collections of [steps](https://circleci.com/docs/guides/about-circleci/concepts/#steps), which run commands/scripts as required. Each job must declare an executor that is either `docker`, `machine`, `windows`, or `macos`. For `docker` you must [Specify an Image](https://circleci.com/docs/guides/execution-managed/executor-intro/#docker) to use for the primary container. For `macos` you must specify an [Xcode Version](https://circleci.com/docs/guides/execution-managed/executor-intro/#macos). For `windows` you must use the [Windows Orb](https://circleci.com/docs/guides/execution-managed/executor-intro/#windows).

![Illustration of a CircleCI job](https://circleci.com/docs/guides/_images/job.png)

Figure 5. Illustration of a CircleCI job

For more information, see the [Jobs and Steps](https://circleci.com/docs/guides/orchestrate/jobs-steps/) page.

## Orbs

Orbs are reusable snippets of code that help automate repeated processes, accelerate project setup, and help you to integrate with third-party tools.

The illustration in the [Configuration](https://circleci.com/docs/guides/about-circleci/concepts/#configuration) section showing an example Java configuration simplifies using orbs. The following illustration demonstrates a simplified configuration with [the Maven orb](https://circleci.com/developer/orbs/orb/circleci/maven). Here, the orb sets up a default executor that can execute steps with Maven and run a common job (`maven/test`).

![Configuration using Maven orb](https://circleci.com/docs/guides/_images/config-elements-orbs.png)

Figure 6. Configuration using Maven orb

See [Using Orbs](https://circleci.com/docs/orbs/use/orb-concepts/) for details on how to use orbs in your configuration and an introduction to orb design. Visit the [Orbs registry](https://circleci.com/developer/orbs) to search for orbs to help simplify your configuration.

## Parallelism

The more tests your project involves, the longer it takes for them to complete on a single machine. Using _test splitting_ and _parallelism_, you can spread your tests across a specified number of separate executors.

You conventionally define test suites at the [Job](https://circleci.com/docs/guides/orchestrate/jobs-steps/) level in your `.circleci/config.yml` file. The `parallelism` key specifies how CircleCI sets up independent executors to run the steps of a job. You can use the `circleci tests` commands to split your test suite to run across your parallel executors.

To run a job’s steps in parallel, set the `parallelism` key to a value greater than `1`.

```
jobs:
  build:
    docker:
      - image: cimg/go:1.18.1
    parallelism: 4
    resource_class: large
    steps:
      - run: go list ./... | circleci tests run --command "xargs gotestsum --junitfile junit.xml --format testname --" --split-by=timings --timings-type=name
```

yaml

![Executor types with parallelism](https://circleci.com/docs/guides/_images/executor_types_plus_parallelism.png)

Figure 7. Executor types with parallelism

See [Test Splitting and Parallelism](https://circleci.com/docs/guides/optimize/parallelism-faster-jobs/) page for more information.

## Pipelines

A CircleCI pipeline is the full set of processes you run when you trigger work on your projects. Pipelines encompass your workflows, which in turn coordinate your jobs. Pipelines are defined in your project [configuration file](https://circleci.com/docs/guides/about-circleci/concepts/#configuration).

Pipelines represent methods for interacting with your configuration:

- Trigger a pipeline through the API with the [trigger a pipeline](https://circleci.com/docs/api/v2/#operation/triggerPipeline) endpoint.

- Use pipeline parameters to trigger [Conditional Workflows](https://circleci.com/docs/guides/orchestrate/pipeline-variables/#conditional-workflows).

- Use `version 2.1` configuration, which provides access to:

- [Reusable Configuration](https://circleci.com/docs/reference/reusing-config/) elements, including executors, commands and jobs.

- Packaged reusable configuration, known as [Orbs](https://circleci.com/docs/orbs/use/orb-intro/).

- Improved configuration validation error messages.

- Option to enable auto-cancel, within **Advanced** project settings in the web app to terminate workflows when pipelines trigger on non-default branches.


|     |     |
| --- | --- |
|  | Consider the impact of enabling the auto-cancel feature, for example, if you have configured automated deployment jobs on non-default branches. |

See the [Pipelines Overview](https://circleci.com/docs/guides/orchestrate/pipelines/) page for more information.

## Projects

For GitHub OAuth app and Bitbucket Cloud accounts, a _project_ in CircleCI is tied to, and shares the name of the associated code repository in your VCS.

For GitHub App, GitLab SaaS and self-managed and Bitbucket Data Center users, a _project_ in CircleCI is standalone. You create a project and then connect your code (stored in your GitHub, GitLab or Bitbucket Data Center repository) to that project.

**Project names** must meet the following requirements:

- Begin with a letter.

- 3-40 characters long.

- Contain only letters, numbers, spaces, or the following characters `" - _ . : ! & + [ ] " ;`.


A standalone project can have:

- One or more configurations (pipeline definitions), including, but not limited to, a `.circleci/config.yml` file in the repository associated with the project.

- One or more triggers (events from a source of change), including, but not limited to, a VCS. A trigger determines which configuration to use to start a pipeline.


Select **Projects** in the CircleCI web app sidebar to enter the projects dashboard. On the dashboard, you can set up and follow any project you have access to.

- _Set Up_ or _Create_ any project that you are the owner of in your VCS.

- _Follow_ any project in your organization to gain access to its pipelines and to subscribe to [Email Notifications](https://circleci.com/docs/guides/integration/notifications/) for the project’s status.


![Projects dashboard for a circleci organization](https://circleci.com/docs/guides/_images/projects-dashboard-circleci-org.png)

Figure 8. The projects dashboard in the CircleCI web app for a circleci organization

If you do not see the **Create project** button you are in a `GitHub` or `Bitbucket` organization. You can use the **Set up** button to start building your project on CircleCI. For more information on organization types, see the [Users, Organizations, and Integrations Guide](https://circleci.com/docs/guides/permissions-authentication/users-organizations-and-integrations-guide/) page.

![Projects dashboard for a GitHub or Bitbucket organization](https://circleci.com/docs/guides/_images/projects-dashboard-set-up.png)

Figure 9. The projects dashboard in the CircleCI web app for a GitHub or bitbucket organization

## Resource class

A resource class is a configuration option that allows you to control available compute resources (CPU and RAM) for your jobs. When you specify an execution environment for a job, CircleCI sets a default resource class value for the environment _unless_ you define the resource class in your configuration. Define the resource class as best practice, instead of relying on a default.

The example below shows how to define a resource class in the Docker execution environment.

```
version: 2.1

jobs:
  build:
    docker:
      - image: cimg/node:current
    # resource class declaration
    resource_class: large
    steps:
      - checkout
```

yaml

Examples for all execution environments are available on the following pages:

- [Using the Docker Execution Environment](https://circleci.com/docs/guides/execution-managed/using-docker/)

- [Using the LinuxVM Execution Environment](https://circleci.com/docs/guides/execution-managed/using-linuxvm/)

- [Using the macOS Execution Environment](https://circleci.com/docs/guides/execution-managed/using-macos/)

- [Using the Windows Execution Environment](https://circleci.com/docs/guides/execution-managed/using-windows/)

- [Using the GPU Execution Environment](https://circleci.com/docs/guides/execution-managed/using-gpu/)

- [Using the Arm VM Execution Environment](https://circleci.com/docs/guides/execution-managed/using-arm/)


Pricing and plans information for the various resource classes can be found on the [Resource classes](https://circleci.com/product/features/resource-classes/) product page.

The `resource_class` key is also used to configure a [Self-Hosted Runner Instance](https://circleci.com/docs/guides/execution-runner/runner-concepts/#namespaces-and-resource-classes).

## Steps

Steps are collections of the executable commands required to complete your job. For example, the [`checkout`](https://circleci.com/docs/reference/configuration-reference/#checkout) step (which is a built-in step available across all CircleCI projects) checks out the source code for a job over SSH. The `run` step allows you to run custom commands, such as executing the command `make test`, using a non-login shell by default. You can also define commands [outside the job declaration](https://circleci.com/docs/reference/configuration-reference/#commands), making them reusable across your configuration.

```
version: 2.1

jobs:
  build:
    docker:
      - image: cimg/base:2024.02
    steps:
      - checkout # Special step to checkout your source code
      - run: # Run step to execute commands, see
      # circleci.com/docs/configuration-reference/#run
          name: Running tests
          command: make test # executable command run in
          # non-login shell with /bin/bash -eo pipefail option
          # by default.
```

yaml

See the [Jobs and Steps](https://circleci.com/docs/guides/orchestrate/jobs-steps/) page for more information.

## User roles

CircleCI sets up roles differently depending on your [Organization Type](https://circleci.com/docs/guides/permissions-authentication/users-organizations-and-integrations-guide/#organizations).

To check your organization type, check your organization slug at **Organization settings** **Overview**. `github` and `bitbucket` type organizations are OAuth authenticated orgs and the organization slug is structured as follows:

- `github/<your-org-name>` or `gh/<your-org-name>`

- `bitbucket/<your-org-name>` or `bb/<your-org-name>`


An organization slug for a `circleci` type organization is in the following format:

- `circleci/<UID>`


### GitHub App, GitLab and Bitbucket Data Center users

For `circleci` type organizations, you set roles at the organization and project level. These roles are separate from permissions and roles in your version control system. The available roles are:

- Admin

- Contributor

- Viewer


For an overview of organization and project role permissions, see the [Roles and Permissions Overview](https://circleci.com/docs/guides/permissions-authentication/roles-and-permissions-overview/#organization-role-permissions-matrix) page.

See the [Manage Roles and Permissions](https://circleci.com/docs/guides/permissions-authentication/manage-roles-and-permissions/) page for steps to add, remove, and change org and project level roles. You can also manage roles and permissions in [Groups](https://circleci.com/docs/guides/permissions-authentication/manage-groups/).

### GitHub OAuth app and Bitbucket Cloud users

CircleCI has various user roles with permissions inherited from VCS accounts.

- The _Organization Administrator_ is a permission level inherited from your VCS:



  - GitHub: **Owner** and following at least one project building on CircleCI.

  - Bitbucket: **Admin** and following at least one project building on CircleCI.


- The _Project Administrator_ is the user who adds a GitHub or Bitbucket repository to CircleCI as a Project.

- A _User_ is an individual user within an organization, inherited from your VCS.

- A CircleCI user is anyone who can log in to the CircleCI platform with a username and password. You must add users to an org in the VCS to view or follow associated CircleCI projects. Users may not view project data stored in environment variables.


## Workflows

Workflows orchestrate jobs. A workflow defines a list of jobs and their run order. You can run jobs concurrently, sequentially, on a schedule, or with a manual gate using an approval job.

![Workflows illustration cloud](https://circleci.com/docs/guides/_images/workflow_detail_newui.png)

Figure 10. Workflows illustration

The following configuration example shows two workflows with modern features:

- `build_and_test` runs on every commit with concurrent job execution.

- `deploy` is a conditional workflow that includes manual approval and flexible job dependencies.


|     |     |
| --- | --- |
|  | **Using Docker?** Authenticating Docker pulls from image registries is recommended when using the Docker execution environment. Authenticated pulls allow access to private Docker images, and may also grant higher rate limits, depending on your registry provider. For further information, see [Using Docker authenticated pulls](https://circleci.com/docs/guides/execution-managed/private-images/). |

```
version: 2.1

parameters:
  run_deploy_workflow:
    type: boolean
    default: false

jobs:
  build:
    docker:
      - image: cimg/base:current
    steps:
      - checkout
      - run:
          name: Build application
          command: echo "Building application..."

  lint:
    docker:
      - image: cimg/base:current
    steps:
      - checkout
      - run:
          name: Run linter
          command: echo "Running linter checks..."

  test:
    docker:
      - image: cimg/base:current
    steps:
      - checkout
      - run:
          name: Run tests
          command: echo "Running test suite..."

  deploy:
    docker:
      - image: cimg/base:current
    steps:
      - checkout
      - run:
          name: Deploy application
          command: echo "Deploying to production..."

  cleanup:
    docker:
      - image: cimg/base:current
    steps:
      - run:
          name: Cleanup resources
          command: echo "Cleaning up resources..."

  notify-failure:
    docker:
      - image: cimg/base:current
    steps:
      - run:
          name: Send failure notification
          command: echo "Deploy failed - sending notification..."

workflows:
  # This workflow runs on every commit
  build_and_test:
    jobs:
      - build
      - lint:
          requires:
            - build
      - test:
          requires:
            - build

  # This workflow only runs when the parameter is true
  deploy:
    when: << pipeline.parameters.run_deploy_workflow >>
    jobs:
      - build
      - test:
          requires:
            - build
      - hold:
          type: approval
          requires:
            - test
      - deploy:
          requires:
            - hold
      - cleanup:
          requires:
            - deploy: terminal
      - notify-failure:
          requires:
            - deploy:
              - failed
              - canceled
```

yaml

See the [Using Workflows](https://circleci.com/docs/guides/orchestrate/workflows/) page for more information.

## See also

- Follow our [Quickstart](https://circleci.com/docs/guides/getting-started/getting-started/) guide to walk through setting up a working pipeline.


### On This Page

- [Introduction](https://circleci.com/docs/guides/about-circleci/concepts/#introduction)
- [Concurrency](https://circleci.com/docs/guides/about-circleci/concepts/#concurrency)
- [Configuration](https://circleci.com/docs/guides/about-circleci/concepts/#configuration)
- [Contexts](https://circleci.com/docs/guides/about-circleci/concepts/#contexts)
- [Data persistence](https://circleci.com/docs/guides/about-circleci/concepts/#data-persistence)
- [Artifacts](https://circleci.com/docs/guides/about-circleci/concepts/#artifacts)
- [Caches](https://circleci.com/docs/guides/about-circleci/concepts/#caches)
- [Workspaces](https://circleci.com/docs/guides/about-circleci/concepts/#workspaces)
- [Docker layer caching](https://circleci.com/docs/guides/about-circleci/concepts/#docker-layer-caching)
- [Dynamic configuration](https://circleci.com/docs/guides/about-circleci/concepts/#dynamic-configuration)
- [Execution environments](https://circleci.com/docs/guides/about-circleci/concepts/#execution-environments)
- [Images](https://circleci.com/docs/guides/about-circleci/concepts/#images)
- [Jobs](https://circleci.com/docs/guides/about-circleci/concepts/#jobs)
- [Orbs](https://circleci.com/docs/guides/about-circleci/concepts/#orbs)
- [Parallelism](https://circleci.com/docs/guides/about-circleci/concepts/#parallelism)
- [Pipelines](https://circleci.com/docs/guides/about-circleci/concepts/#pipelines)
- [Projects](https://circleci.com/docs/guides/about-circleci/concepts/#projects)
- [Resource class](https://circleci.com/docs/guides/about-circleci/concepts/#resource-class)
- [Steps](https://circleci.com/docs/guides/about-circleci/concepts/#steps)
- [User roles](https://circleci.com/docs/guides/about-circleci/concepts/#user-types)
- [GitHub App, GitLab and Bitbucket Data Center users](https://circleci.com/docs/guides/about-circleci/concepts/#github-app-gitlab-and-bitbucket-data-center-users)
- [GitHub OAuth app and Bitbucket Cloud users](https://circleci.com/docs/guides/about-circleci/concepts/#github-oauth-app-and-bitbucket-cloud-users)
- [Workflows](https://circleci.com/docs/guides/about-circleci/concepts/#workflows)
- [See also](https://circleci.com/docs/guides/about-circleci/concepts/#see-also)

#### Suggest an edit to this page

- [Make a contribution](https://github.com/circleci/circleci-docs/edit/main/docs/guides/modules/about-circleci/pages/concepts.adoc)
- [Learn how to contribute](https://github.com/circleci/circleci-docs/blob/main/CONTRIBUTING.md)
- LLM? See the [llms.txt](https://circleci.com/docs/llms.txt)

#### Still need help?

- [Ask the CircleCI community](https://discuss.circleci.com/)
- [Join the research community](https://circleci.com/research/)
- [Visit our support site](https://support.circleci.com/hc/en-us/)

![CircleCI Logo](https://circleci.com/docs/_/img/logo.svg)![CircleCI Logo](https://circleci.com/docs/_/img/logo-dark.svg)

- © CircleCI, Inc. All rights reserved.


  - [Terms of Service](https://circleci.com/legal/terms-of-service/)
  - [Privacy Policy](https://circleci.com/legal/privacy/)
  - [Cookie Policy](https://circleci.com/legal/cookie-policy/)
  - [Security](https://circleci.com/security/)

![Arrow Back](https://circleci.com/docs/_/img/arrow-back.svg)

### Guides

ctrl+/

Clear


## \[path\]

\[numberOfHits\]

12...12

- [Home](https://circleci.com/docs/)
- [Guides](https://circleci.com/docs/guides/getting-started/first-steps/)
- [Reference](https://circleci.com/docs/reference/configuration-reference/)
- [Server](https://circleci.com/docs/server-admin/latest/overview/circleci-server-overview/)
- [Orbs](https://circleci.com/docs/orbs/use/orb-intro/)
- [Services](https://circleci.com/docs/services/services-overview/)
- [Contributors](https://circleci.com/docs/contributors/docs-style/)

- [Dev Hub](https://circleci.com/developer/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)
- [API](https://circleci.com/docs/reference/api-homepage/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)
- [Support](https://support.circleci.com/hc/en-us/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)
- [Discuss](https://discuss.circleci.com/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)
- [CircleCI.com](https://circleci.com/)![Go to](https://circleci.com/docs/_/img/link-arrow.svg)

  - About CircleCI

    - [CircleCI overview](https://circleci.com/docs/guides/about-circleci/about-circleci/)

    - [Benefits of CircleCI](https://circleci.com/docs/guides/about-circleci/benefits-of-circleci/)

    - Concepts

    - [Intro to the CircleCI web app](https://circleci.com/docs/guides/about-circleci/introduction-to-the-circleci-web-app/)

    - [Open source acknowledgements](https://circleci.com/docs/guides/about-circleci/open-source/)
  - Getting started

    - First steps

      - [Sign up and try CircleCI](https://circleci.com/docs/guides/getting-started/first-steps/)

      - [Join teammates on CircleCI](https://circleci.com/docs/guides/getting-started/invite-your-team/)

      - [Create a project](https://circleci.com/docs/guides/getting-started/create-project/)

      - [Quickstart guide](https://circleci.com/docs/guides/getting-started/getting-started/)
    - How-to guides

      - [Hello World](https://circleci.com/docs/guides/getting-started/hello-world/)

      - [Intro to YAML configuration](https://circleci.com/docs/guides/getting-started/introduction-to-yaml-configurations/)

      - [In-app config editor](https://circleci.com/docs/guides/getting-started/config-editor/)

      - [Node.js quickstart](https://circleci.com/docs/guides/getting-started/language-javascript/)

      - [Python quickstart](https://circleci.com/docs/guides/getting-started/language-python/)

      - [Go quickstart](https://circleci.com/docs/guides/getting-started/language-go/)

      - [Create an organization](https://circleci.com/docs/guides/getting-started/create-an-organization/)
    - Tutorials

      - [Configuration intro](https://circleci.com/docs/guides/getting-started/config-intro/)
  - Migrate to CircleCI

    - [Migration intro](https://circleci.com/docs/guides/migrate/migration-intro/)

    - [Migrate from AWS](https://circleci.com/docs/guides/migrate/migrating-from-aws/)

    - [Migrate from Azure DevOps](https://circleci.com/docs/guides/migrate/migrating-from-azuredevops/)

    - [Migrate from Buildkite](https://circleci.com/docs/guides/migrate/migrating-from-buildkite/)

    - [Migrate from GitHub](https://circleci.com/docs/guides/migrate/migrating-from-github/)

    - [Migrate from GitLab](https://circleci.com/docs/guides/migrate/migrating-from-gitlab/)

    - [Migrate from Jenkins](https://circleci.com/docs/guides/migrate/migrating-from-jenkins/)

    - [Migrate from TeamCity](https://circleci.com/docs/guides/migrate/migrating-from-teamcity/)

    - [Migrate from Travis CI](https://circleci.com/docs/guides/migrate/migrating-from-travis/)
  - Orchestrate

    - Set up pipelines and workflows

      - [Pipeline overview and setup](https://circleci.com/docs/guides/orchestrate/pipelines/)

      - [Jobs and steps overview](https://circleci.com/docs/guides/orchestrate/jobs-steps/)

      - [Workflow orchestration](https://circleci.com/docs/guides/orchestrate/workflows/)

      - [Pipeline values and parameters](https://circleci.com/docs/guides/orchestrate/pipeline-variables/)
    - Trigger and schedule pipelines

      - [Trigger options](https://circleci.com/docs/guides/orchestrate/triggers-overview/)

      - [Set up triggers](https://circleci.com/docs/guides/orchestrate/set-up-triggers/)

      - [GitHub trigger event options](https://circleci.com/docs/guides/orchestrate/github-trigger-event-options/)

      - [GitLab trigger options](https://circleci.com/docs/guides/orchestrate/gitlab-trigger-options/)

      - [Custom webhooks](https://circleci.com/docs/guides/orchestrate/custom-webhooks/)

      - [Schedule triggers](https://circleci.com/docs/guides/orchestrate/schedule-triggers/)

      - [Set up cross-repo triggers for library consumers](https://circleci.com/docs/guides/orchestrate/set-up-cross-repo-triggers-for-library-consumers/)

      - [Migrate scheduled workflows to schedule triggers](https://circleci.com/docs/guides/orchestrate/migrate-scheduled-workflows-to-schedule-triggers/)

      - [Schedule triggers with multiple workflows](https://circleci.com/docs/guides/orchestrate/schedule-triggers-with-multiple-workflows/)

      - [Set a nightly schedule trigger](https://circleci.com/docs/guides/orchestrate/set-a-nightly-schedule-trigger/)
    - Control workflow execution

      - [Automatic reruns](https://circleci.com/docs/guides/orchestrate/automatic-reruns/)

      - [Skip CI, auto-cancel, and block new pipelines](https://circleci.com/docs/guides/orchestrate/skip-build/)

      - [Controlling serial execution across your organization](https://circleci.com/docs/guides/orchestrate/controlling-serial-execution-across-your-organization/)

      - [Using branch filters](https://circleci.com/docs/guides/orchestrate/using-branch-filters/)

      - [Select a workflow to run using pipeline parameters](https://circleci.com/docs/guides/orchestrate/selecting-a-workflow-to-run-using-pipeline-parameters/)

      - [Notify a Slack channel of a paused workflow](https://circleci.com/docs/guides/orchestrate/notify-a-slack-channel-of-a-paused-workflow/)
    - Share data

      - [Use workspaces to share data between jobs](https://circleci.com/docs/guides/orchestrate/workspaces/)
    - Advanced configuration

      - [Orchestration cookbook](https://circleci.com/docs/guides/orchestrate/orchestration-cookbook/)

      - [Dynamic configuration overview](https://circleci.com/docs/guides/orchestrate/dynamic-config/)

      - [Using dynamic configuration](https://circleci.com/docs/guides/orchestrate/using-dynamic-configuration/)

      - [Override configuration](https://circleci.com/docs/guides/orchestrate/how-to-override-config/)

      - [Set up multiple configuration files for a project](https://circleci.com/docs/guides/orchestrate/set-up-multiple-configuration-files-for-a-project/)

      - [Configure databases](https://circleci.com/docs/guides/orchestrate/databases/)

      - [Migrate from deploy to run](https://circleci.com/docs/guides/orchestrate/migrate-from-deploy-to-run/)

      - [Using shell scripts](https://circleci.com/docs/guides/orchestrate/using-shell-scripts/)
  - Execute on managed compute

    - [Execution environments overview](https://circleci.com/docs/guides/execution-managed/executor-intro/)

    - [Resource class overview](https://circleci.com/docs/guides/execution-managed/resource-class-overview/)

    - [Resource class lifecycle](https://circleci.com/docs/guides/execution-managed/resource-class-lifecycle/)

    - Docker

      - [Using Docker](https://circleci.com/docs/guides/execution-managed/using-docker/)

      - [Convenience images](https://circleci.com/docs/guides/execution-managed/circleci-images/)

      - [Migrating to next-gen images](https://circleci.com/docs/guides/execution-managed/next-gen-migration-guide/)

      - [Using custom-built Docker images](https://circleci.com/docs/guides/execution-managed/custom-images/)

      - [Docker authenticated pulls](https://circleci.com/docs/guides/execution-managed/private-images/)

      - [Running Docker commands](https://circleci.com/docs/guides/execution-managed/building-docker-images/)
    - Linux VM

      - [Using the Linux VM execution environment](https://circleci.com/docs/guides/execution-managed/using-linuxvm/)

      - [Using Android images with the machine executor](https://circleci.com/docs/guides/execution-managed/android-machine-image/)
    - macOS

      - [Using the macOS execution environment](https://circleci.com/docs/guides/execution-managed/using-macos/)

      - [Configuring a macOS app](https://circleci.com/docs/guides/execution-managed/hello-world-macos/)

      - [iOS code signing](https://circleci.com/docs/guides/execution-managed/ios-codesigning/)
    - Windows

      - [Using the Windows execution environment](https://circleci.com/docs/guides/execution-managed/using-windows/)

      - [Hello world Windows](https://circleci.com/docs/guides/execution-managed/hello-world-windows/)
    - Arm

      - [Using the Arm VM execution environment](https://circleci.com/docs/guides/execution-managed/using-arm/)
    - GPU

      - [Using the GPU execution environment](https://circleci.com/docs/guides/execution-managed/using-gpu/)
    - How-to guides

      - [Pull an image from AWS ECR with OIDC](https://circleci.com/docs/guides/permissions-authentication/pull-an-image-from-aws-ecr-with-oidc/)

      - [Pull an image from GCP Artifact Registry with OIDC](https://circleci.com/docs/guides/permissions-authentication/pull-an-image-from-gcp-gar-with-oidc/)

      - [Run a job in a container on your machine with Docker](https://circleci.com/docs/guides/execution-managed/run-a-job-in-a-container/)

      - [Installing and using Docker Compose](https://circleci.com/docs/guides/execution-managed/docker-compose/)

      - [Debugging container ID cannot be mapped to host ID error](https://circleci.com/docs/guides/execution-managed/high-uid-error/)

      - [Migrating between the Docker machine executors](https://circleci.com/docs/guides/execution-managed/docker-to-machine/)
    - Image support policies

      - [Android images support policy](https://circleci.com/docs/guides/execution-managed/android-images-support-policy/)

      - [Convenience images support policy](https://circleci.com/docs/guides/execution-managed/convenience-images-support-policy/)

      - [Linux VM images support policy](https://circleci.com/docs/guides/execution-managed/linux-vm-support-policy/)

      - [Linux CUDA images support policy](https://circleci.com/docs/guides/execution-managed/linux-cuda-images-support-policy/)

      - [Remote Docker images support policy](https://circleci.com/docs/guides/execution-managed/remote-docker-images-support-policy/)

      - [Windows images support policy](https://circleci.com/docs/guides/execution-managed/windows-images-support-policy/)

      - [Xcode image policy](https://circleci.com/docs/guides/execution-managed/xcode-policy/)

      - [CircleCI image lifecycle: A complete guide](https://circleci.com/docs/guides/execution-managed/machine-convenience-image-lifecycle/)
  - Execute jobs on self-hosted runners

    - [Self-hosted runner overview](https://circleci.com/docs/guides/execution-runner/runner-overview/)

    - [Self-hosted runner concepts](https://circleci.com/docs/guides/execution-runner/runner-concepts/)

    - [Runner feature comparison matrix](https://circleci.com/docs/guides/execution-runner/runner-feature-comparison-matrix/)

    - Runner provisioner

      - [Runner provisioner overview - Preview\\
               Preview](https://circleci.com/docs/guides/execution-runner/runner-provisioner/)
    - Container runner

      - [Container runner installation](https://circleci.com/docs/guides/execution-runner/container-runner-installation/)

      - [Container runner performance benchmarks](https://circleci.com/docs/guides/execution-runner/container-runner-performance-benchmarks/)

      - [Container runner reference](https://circleci.com/docs/guides/execution-runner/container-runner/)
    - Machine runner 3

      - [Install machine runner 3 on Linux](https://circleci.com/docs/guides/execution-runner/install-machine-runner-3-on-linux/)

      - [Install machine runner 3 on macOS](https://circleci.com/docs/guides/execution-runner/install-machine-runner-3-on-macos/)

      - [Install machine runner 3 on Windows](https://circleci.com/docs/guides/execution-runner/install-machine-runner-3-on-windows/)

      - [Install machine runner 3 on Docker](https://circleci.com/docs/guides/execution-runner/install-machine-runner-3-on-docker/)

      - [Manual install on Linux and macOS](https://circleci.com/docs/guides/execution-runner/machine-runner-3-manual-installation/)

      - [Manual install on Windows](https://circleci.com/docs/guides/execution-runner/machine-runner-3-manual-installation-on-windows/)

      - [Migrate from launch agent to machine runner 3 on Linux](https://circleci.com/docs/guides/execution-runner/migrate-from-launch-agent-to-machine-runner-3-on-linux/)

      - [Migrate from launch agent to machine runner 3 on macOS](https://circleci.com/docs/guides/execution-runner/migrate-from-launch-agent-to-machine-runner-3-on-macos/)

      - [Migrate from launch agent to machine runner 3 on Windows](https://circleci.com/docs/guides/execution-runner/migrate-from-launch-agent-to-machine-runner-3-on-windows/)

      - [Machine runner 3 configuration reference](https://circleci.com/docs/guides/execution-runner/machine-runner-3-configuration-reference/)
    - Self-hosted runner reference

      - [Self-hosted runner API](https://circleci.com/docs/guides/execution-runner/runner-api/)

      - [Self-hosted runner FAQ](https://circleci.com/docs/guides/execution-runner/runner-faqs/)

      - [Troubleshoot self-hosted runner](https://circleci.com/docs/guides/execution-runner/troubleshoot-self-hosted-runner/)

      - [Scaling self-hosted runner](https://circleci.com/docs/guides/execution-runner/runner-scaling/)
  - Testing on CircleCI

    - Run tests on CircleCI

      - [Automated testing](https://circleci.com/docs/guides/test/test/)

      - [Collecting test data](https://circleci.com/docs/guides/test/collect-test-data/)

      - [Test Insights](https://circleci.com/docs/guides/insights/insights-tests/)
    - Manage and optimize tests

      - [Fix flaky tests\\
               Beta](https://circleci.com/docs/guides/test/fix-flaky-tests/)

      - [Test splitting and parallelism](https://circleci.com/docs/guides/optimize/parallelism-faster-jobs/)

      - [Speed up pipelines with test splitting](https://circleci.com/docs/guides/test/test-splitting-tutorial/)

      - [Use the environment CLI to split tests](https://circleci.com/docs/guides/optimize/use-the-circleci-cli-to-split-tests/)

      - [Troubleshoot test splitting](https://circleci.com/docs/guides/test/troubleshoot-test-splitting/)

      - [Automate LLM evaluation testing with the CircleCI Evals orb](https://circleci.com/docs/guides/test/automate-llm-evaluation-testing-with-the-circleci-evals-orb/)
    - Smarter Testing

      - [Getting Started With Smarter Testing\\
               Beta](https://circleci.com/docs/guides/test/getting-started-with-smarter-testing/)

      - [Set up Test Impact Analysis\\
         Beta](https://circleci.com/docs/guides/test/set-up-test-impact-analysis/)

      - [Use Dynamic Test Splitting\\
         Beta](https://circleci.com/docs/guides/test/use-dynamic-test-splitting/)

      - [Auto Rerun Failed Tests\\
         Beta](https://circleci.com/docs/guides/test/auto-rerun-failed-tests/)

      - [Test suite Config Reference\\
         Beta](https://circleci.com/docs/guides/test/testsuite-configuration-reference/)
    - Testing strategies

      - [Testing LLM-enabled applications through evaluations](https://circleci.com/docs/guides/test/testing-llm-enabled-applications-through-evaluations/)

      - [Browser testing](https://circleci.com/docs/guides/test/browser-testing/)

      - [Generate code coverage metrics](https://circleci.com/docs/guides/test/code-coverage/)

      - [Re-run failed tests overview](https://circleci.com/docs/guides/test/rerun-failed-tests/)

      - [Testing iOS applications](https://circleci.com/docs/guides/test/testing-ios/)

      - [Testing macOS applications](https://circleci.com/docs/guides/test/testing-macos/)
  - Deploy with CircleCI

    - [Deployment and deploy management](https://circleci.com/docs/guides/deploy/deployment-overview/)

    - Deploys and rollbacks

      - [Set up a rollback pipeline](https://circleci.com/docs/guides/deploy/set-up-rollbacks/)

      - [Set up a deploy pipeline](https://circleci.com/docs/guides/deploy/set-up-deploys/)

      - [Deploy a component](https://circleci.com/docs/guides/deploy/deploy-a-component/)

      - [Rollback a deployment](https://circleci.com/docs/guides/deploy/rollback-a-deployment/)

      - [Configure deploy markers](https://circleci.com/docs/guides/deploy/configure-deploy-markers/)

      - [Environment hierarchy and version promotion](https://circleci.com/docs/guides/deploy/environment-hierarchy-and-version-promotion/)
    - Release agent setup

      - [Release agent overview](https://circleci.com/docs/guides/deploy/release-agent-overview/)

      - [Set up the CircleCI release agent](https://circleci.com/docs/guides/deploy/set-up-the-circleci-release-agent/)

      - [Configure your Kubernetes components](https://circleci.com/docs/guides/deploy/configure-your-kubernetes-components/)

      - [Update the Kubernetes release agent](https://circleci.com/docs/guides/deploy/update-the-kubernetes-release-agent/)

      - [Manage releases](https://circleci.com/docs/guides/deploy/manage-releases/)
    - How-to guides

      - [Deploy Android applications](https://circleci.com/docs/guides/deploy/deploy-android-applications/)

      - [Deploy to Artifactory](https://circleci.com/docs/guides/deploy/deploy-to-artifactory/)

      - [Deploy to AWS](https://circleci.com/docs/guides/deploy/deploy-to-aws/)

      - [Push image to ECR and deploy to ECS](https://circleci.com/docs/guides/deploy/ecs-ecr/)

      - [Deploy service update to AWS ECS](https://circleci.com/docs/guides/deploy/deploy-service-update-to-aws-ecs/)

      - [Deploy to Azure Container Registry](https://circleci.com/docs/guides/deploy/deploy-to-azure-container-registry/)

      - [Deploy to Capistrano](https://circleci.com/docs/guides/deploy/deploy-to-capistrano/)

      - [Deploy to Cloud Foundry](https://circleci.com/docs/guides/deploy/deploy-to-cloud-foundry/)

      - [Deploy to Firebase](https://circleci.com/docs/guides/deploy/deploy-to-firebase/)

      - [Deploy to Google Cloud Platform](https://circleci.com/docs/guides/deploy/deploy-to-google-cloud-platform/)

      - [Deploy to Heroku](https://circleci.com/docs/guides/deploy/deploy-to-heroku/)

      - [Deploy iOS applications](https://circleci.com/docs/guides/deploy/deploy-ios-applications/)

      - [Deploy over SSH](https://circleci.com/docs/guides/deploy/deploy-over-ssh/)

      - [Publish packages to Packagecloud](https://circleci.com/docs/guides/deploy/publish-packages-to-packagecloud/)

      - [Publish to npm using OIDC trusted publishing](https://circleci.com/docs/guides/deploy/deploy-to-npm-registry/)

      - [Publish to npm with an authentication token](https://circleci.com/docs/guides/deploy/deploy-to-npm-registry-with-token/)
  - Optimize

    - [Optimizations reference](https://circleci.com/docs/guides/optimize/optimizations/)

    - Data

      - [Persisting data overview](https://circleci.com/docs/guides/optimize/persist-data/)

      - [Caching dependencies](https://circleci.com/docs/guides/optimize/caching/)

      - [Store build artifacts](https://circleci.com/docs/guides/optimize/artifacts/)
    - Speed

      - [Concurrency](https://circleci.com/docs/guides/optimize/concurrency/)

      - [Test splitting and parallelism](https://circleci.com/docs/guides/optimize/parallelism-faster-jobs/)

      - [Docker layer caching overview](https://circleci.com/docs/guides/optimize/docker-layer-caching/)
    - Config

      - [Dynamic configuration](https://circleci.com/docs/guides/orchestrate/dynamic-config/)
    - Tutorials

      - [Speed up pipelines with test splitting](https://circleci.com/docs/guides/test/test-splitting-tutorial/)
    - How-to guides

      - [Use matrix jobs](https://circleci.com/docs/guides/orchestrate/using-matrix-jobs/)

      - [Using dynamic configuration](https://circleci.com/docs/guides/orchestrate/using-dynamic-configuration/)

      - [Avoid and debug Java memory errors](https://circleci.com/docs/guides/optimize/java-oom/)
  - Insights

    - [Use Insights](https://circleci.com/docs/guides/insights/insights/)

    - [Test Insights](https://circleci.com/docs/guides/insights/insights-tests/)

    - [Generate an Insights snapshot badge](https://circleci.com/docs/guides/insights/insights-snapshot-badge/)

    - [Insights glossary](https://circleci.com/docs/guides/insights/insights-glossary/)
  - Manage roles, permissions, and authentication

    - [Users, organizations, and integrations guide](https://circleci.com/docs/guides/permissions-authentication/users-organizations-and-integrations-guide/)

    - [Manage email addresses](https://circleci.com/docs/guides/permissions-authentication/manage-email-addresses/)

    - Roles and permissions

      - [Roles and permissions overview](https://circleci.com/docs/guides/permissions-authentication/roles-and-permissions-overview/)

      - [Manage roles and permissions](https://circleci.com/docs/guides/permissions-authentication/manage-roles-and-permissions/)

      - [Manage groups](https://circleci.com/docs/guides/permissions-authentication/manage-groups/)

      - [Prevent unregistered users from spending credits](https://circleci.com/docs/guides/plans-pricing/prevent-unregistered-users-from-spending-credits/)
    - SSO authentication

      - [SSO overview](https://circleci.com/docs/guides/permissions-authentication/sso-overview/)

      - [SSO setup](https://circleci.com/docs/guides/permissions-authentication/set-up-sso/)

      - [Set up SSO group mapping with Okta](https://circleci.com/docs/guides/permissions-authentication/sso-group-mapping/)

      - [Sign in to an SSO-enabled org](https://circleci.com/docs/guides/permissions-authentication/sign-in-to-an-sso-enabled-organization/)
    - Multi-factor authentication (MFA)

      - [MFA overview](https://circleci.com/docs/guides/permissions-authentication/mfa/)
    - OIDC tokens

      - [Use OpenID Connect tokens in jobs](https://circleci.com/docs/guides/permissions-authentication/openid-connect-tokens/)

      - [OIDC tokens with custom claims](https://circleci.com/docs/guides/permissions-authentication/oidc-tokens-with-custom-claims/)

      - [Pull an image from AWS ECR with OIDC](https://circleci.com/docs/guides/permissions-authentication/pull-an-image-from-aws-ecr-with-oidc/)

      - [Pull an image from GCP Artifact Registry with OIDC](https://circleci.com/docs/guides/permissions-authentication/pull-an-image-from-gcp-gar-with-oidc/)
    - Cloud provider authentication

      - [Authorize Google Cloud SDK](https://circleci.com/docs/guides/integration/authorize-google-cloud-sdk/)
  - Manage security and secrets

    - Security features

      - [How CircleCI handles security](https://circleci.com/docs/guides/security/security/)

      - [Intro to environment variables](https://circleci.com/docs/guides/security/env-vars/)

      - [Using contexts](https://circleci.com/docs/guides/security/contexts/)

      - [IP ranges](https://circleci.com/docs/guides/security/ip-ranges/)

      - [Audit logs](https://circleci.com/docs/guides/security/audit-logs/)
    - Security recommendations

      - [Security overview](https://circleci.com/docs/guides/security/security-overview/)

      - [Protecting against supply chain attacks](https://circleci.com/docs/guides/security/security-supply-chain/)

      - [Secure secrets handling](https://circleci.com/docs/guides/security/security-recommendations/)
    - Incident management

      - [Pause or stop pipelines during an incident](https://circleci.com/docs/guides/orchestrate/pause-pipelines-during-an-incident/)

      - [Analyze pipelines and job steps during an incident](https://circleci.com/docs/guides/orchestrate/analyze-pipelines-during-an-incident/)
    - How-to guides

      - [Set an environment variable](https://circleci.com/docs/guides/security/set-environment-variable/)

      - [Inject environment variables with the API](https://circleci.com/docs/guides/security/inject-environment-variables-with-api/)

      - [Debug jobs with SSH rerun](https://circleci.com/docs/guides/execution-managed/ssh-access-jobs/)

      - [Rotate project SSH keys](https://circleci.com/docs/guides/security/rotate-project-ssh-keys/)

      - [Stop building a project on CircleCI](https://circleci.com/docs/guides/security/stop-building-a-project-on-circleci/)

      - [Rename organizations and repositories](https://circleci.com/docs/guides/security/rename-organizations-and-repositories/)

      - [Delete organizations and projects](https://circleci.com/docs/guides/security/delete-organizations-and-projects/)
  - Manage config policies

    - [Config policy management overview](https://circleci.com/docs/guides/config-policies/config-policy-management-overview/)

    - [Config policy reference](https://circleci.com/docs/guides/config-policies/config-policy-reference/)

    - How-to guides

      - [Create and manage config policies](https://circleci.com/docs/guides/config-policies/create-and-manage-config-policies/)

      - [Test config policies](https://circleci.com/docs/guides/config-policies/test-config-policies/)

      - [Use the CLI for config and policy development](https://circleci.com/docs/guides/config-policies/use-the-cli-for-config-and-policy-development/)

      - [Config policies for self-hosted runner](https://circleci.com/docs/guides/config-policies/config-policies-for-self-hosted-runner/)

      - [Manage contexts with config policies](https://circleci.com/docs/guides/config-policies/manage-contexts-with-config-policies/)
  - Integration

    - [Add SSH Keys](https://circleci.com/docs/guides/integration/add-ssh-key/)

    - VCS integration

      - [VCS, pipeline types, and feature support](https://circleci.com/docs/guides/integration/version-control-system-integration-overview/)

      - [GitHub Enterprise Server integration\\
         Preview](https://circleci.com/docs/guides/integration/github-enterprise-server-integration/)

      - [Using the CircleCI GitHub App in an OAuth org](https://circleci.com/docs/guides/integration/using-the-circleci-github-app-in-an-oauth-org/)

      - [Status updates overview](https://circleci.com/docs/guides/integration/status-updates/)

      - [Enable GitHub Checks](https://circleci.com/docs/guides/integration/enable-checks/)

      - [Build open source projects](https://circleci.com/docs/guides/integration/oss/)
    - Webhooks and events

      - [Outbound Webhooks](https://circleci.com/docs/guides/integration/outbound-webhooks/)

      - [Outbound Webhooks Reference](https://circleci.com/docs/reference/outbound-webhooks-reference/)

      - [Webhooks With Airtable](https://circleci.com/docs/guides/integration/webhooks-airtable/)
    - Notifications and status

      - [Notifications overview](https://circleci.com/docs/guides/integration/notifications/)

      - [Slack integration\\
         Beta](https://circleci.com/docs/guides/integration/slack-integration/)

      - [Use the Slack orb to set up notifications](https://circleci.com/docs/guides/getting-started/slack-orb-tutorial/)

      - [Status Badges](https://circleci.com/docs/guides/integration/status-badges/)
    - Monitoring and observability

      - [Datadog Integration](https://circleci.com/docs/guides/integration/datadog-integration/)

      - [New Relic Integration](https://circleci.com/docs/guides/integration/new-relic-integration/)

      - [Sumo Logic Integration](https://circleci.com/docs/guides/integration/sumo-logic-integration/)

      - [OpenTelemetry Integration](https://circleci.com/docs/guides/integration/open-telemetry-integration/)
    - Cost management

      - [Finout Integration](https://circleci.com/docs/guides/plans-pricing/integrate-with-finout-for-cost-management/)

      - [Vantage Integration](https://circleci.com/docs/guides/plans-pricing/integrate-with-vantage-for-cost-management/)
    - Project management

      - [Connect With Jira](https://circleci.com/docs/guides/integration/jira-plugin/)
  - Developer toolkit

    - [How to find IDs](https://circleci.com/docs/guides/toolkit/how-to-find-ids/)

    - AI features

      - [Enable AI-powered features](https://circleci.com/docs/guides/toolkit/enable-ai-powered-features/)

      - [Chunk Setup and Overview\\
         Beta](https://circleci.com/docs/guides/toolkit/chunk-setup-and-overview/)

      - [Using the CircleCI MCP server](https://circleci.com/docs/guides/toolkit/using-the-circleci-mcp-server/)

      - [Intelligent summaries](https://circleci.com/docs/guides/toolkit/intelligent-summaries/)
    - Local CLI

      - [Install and configure the CircleCI local CLI](https://circleci.com/docs/guides/toolkit/local-cli/)

      - [How to use the CircleCI local CLI](https://circleci.com/docs/guides/toolkit/how-to-use-the-circleci-local-cli/)
    - Chunk CLI

      - [Install and configure the Chunk CLI](https://circleci.com/docs/guides/toolkit/install-and-configure-the-chunk-cli/)

      - [How to use the Chunk CLI](https://circleci.com/docs/guides/toolkit/how-to-use-chunk-cli/)
    - Environment CLI

      - [CircleCI environment CLI usage guide](https://circleci.com/docs/guides/toolkit/environment-cli-usage-guide/)
    - APIs

      - [API v2 intro](https://circleci.com/docs/guides/toolkit/api-intro/)

      - [API v2 developers guide](https://circleci.com/docs/guides/toolkit/api-developers-guide/)

      - [Managing API tokens](https://circleci.com/docs/guides/toolkit/managing-api-tokens/)
    - IDE tools

      - [VS Code extension overview](https://circleci.com/docs/guides/toolkit/vs-code-extension-overview/)

      - [Get started with the VS Code extension](https://circleci.com/docs/guides/toolkit/get-started-with-the-vs-code-extension/)
    - Config tools

      - [Config SDK](https://circleci.com/docs/guides/toolkit/circleci-config-sdk/)

      - [Orb development kit](https://circleci.com/docs/orbs/author/orb-author/)

      - [Image Updater](https://circleci.com/docs/guides/toolkit/circleci-image-updater/)
    - Example projects and configs

      - [Examples and guides overview](https://circleci.com/docs/guides/toolkit/examples-and-guides-overview/)

      - [Sample config.yml files](https://circleci.com/docs/guides/toolkit/sample-config/)

      - [Database examples](https://circleci.com/docs/guides/toolkit/postgres-config/)
  - Plans and pricing

    - [CircleCI plans overview](https://circleci.com/docs/guides/plans-pricing/plan-overview/)

    - [Credits overview](https://circleci.com/docs/guides/plans-pricing/credits/)

    - [User types and registration](https://circleci.com/docs/guides/plans-pricing/user-types-and-registration/)

    - [Manage budgets](https://circleci.com/docs/guides/plans-pricing/manage-budgets/)

    - [Free Plan overview](https://circleci.com/docs/guides/plans-pricing/plan-free/)

    - [Performance Plan overview](https://circleci.com/docs/guides/plans-pricing/plan-performance/)

    - [Scale Plan overview](https://circleci.com/docs/guides/plans-pricing/plan-scale/)

    - [Server Plan overview](https://circleci.com/docs/guides/plans-pricing/plan-server/)

[Go to Application](https://app.circleci.com/)

![Project Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTI7jLeuu2k66svJDmHxYKlP7Ysf7FvNbkuvzAhHEPCsvLbhcpVRnoJCm538OSv6o5uzlQ&usqp=CAU)

Ask AI