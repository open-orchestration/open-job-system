[Jenkins](https://www.jenkins.io/)

- CDF
What is CDF?JayeXTektonSpinnaker


- Blog
- Success Stories
- Contributor Spotlight
- Documentation
**User Guide**\- Installing Jenkins\- Jenkins Pipeline\- Managing Jenkins\- Securing Jenkins\- System Administration\- Troubleshooting Jenkins\- Terms and Definitions**Solution Pages****Tutorials****Developer Guide****Contributor Guide****Books**

- Plugins
- Community
Overview[Chat with the rest of the Jenkins community on IRC](https://www.jenkins.io/chat/ "Chat with the rest of the Jenkins community on IRC") ChatMeetEventsForumIssue Tracker[Browse Jenkins mailing list archives and/ or subscribe to lists](https://www.jenkins.io/mailing-lists/ "Browse Jenkins mailing list archives and/ or subscribe to lists") Mailing ListsRoadmap[Create/manage your account for accessing wiki, issue tracker, etc](https://accounts.jenkins.io/ "Create/manage your account for accessing wiki, issue tracker, etc") Account Management**Special Interest Groups**\- Advocacy and Outreach\- Documentation\- Google Summer of Code\- Platform\- User Experience

- Subprojects
OverviewGoogle Summer of Code in JenkinsInfrastructureCI/CD and Jenkins Area MeetupsJenkins Configuration as CodeJenkins OperatorJenkins RemotingDocument Jenkins on Kubernetes

- Security
OverviewSecurity AdvisoriesReporting Vulnerabilities

- About
RoadmapPressAwardsConductArtwork

- Support
- Download

Search`` `K`

[\> User Documentation Home](https://www.jenkins.io/doc/)

##### User Handbook

- [User Handbook Overview](https://www.jenkins.io/doc/book/getting-started/)
- [Installing Jenkins](https://www.jenkins.io/doc/book/installing/)
- [Platform Information](https://www.jenkins.io/doc/book/platform-information/)
- [Using Jenkins](https://www.jenkins.io/doc/book/using/)
- [Pipeline](https://www.jenkins.io/doc/book/pipeline/)

  - [Getting started with Pipeline](https://www.jenkins.io/doc/book/pipeline/getting-started/)
  - [Using a Jenkinsfile](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/)
  - [Running Pipelines](https://www.jenkins.io/doc/book/pipeline/running-pipelines/)
  - [Branches and Pull Requests](https://www.jenkins.io/doc/book/pipeline/multibranch/)
  - [Using Docker with Pipeline](https://www.jenkins.io/doc/book/pipeline/docker/)
  - [Extending with Shared Libraries](https://www.jenkins.io/doc/book/pipeline/shared-libraries/)
  - [Pipeline Development Tools](https://www.jenkins.io/doc/book/pipeline/development/)
  - [Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
  - [Pipeline as Code](https://www.jenkins.io/doc/book/pipeline/pipeline-as-code/)
  - [Pipeline Best Practices](https://www.jenkins.io/doc/book/pipeline/pipeline-best-practices/)
  - [Scaling Pipelines](https://www.jenkins.io/doc/book/pipeline/scaling-pipeline/)
  - [Pipeline CPS Method Mismatches](https://www.jenkins.io/doc/book/pipeline/cps-method-mismatches/)

- [Blue Ocean](https://www.jenkins.io/doc/book/blueocean/)
- [Managing Jenkins](https://www.jenkins.io/doc/book/managing/)
- [Securing Jenkins](https://www.jenkins.io/doc/book/security/)
- [System Administration](https://www.jenkins.io/doc/book/system-administration/)
- [Scaling Jenkins](https://www.jenkins.io/doc/book/scaling/)
- [Troubleshooting Jenkins](https://www.jenkins.io/doc/book/troubleshooting/)
- [Glossary](https://www.jenkins.io/doc/book/glossary/)

##### Tutorials

- [Guided Tour](https://www.jenkins.io/doc/pipeline/tour/getting-started/)
- [Jenkins Pipeline](https://www.jenkins.io/doc/tutorials#pipeline)
- [Using Build Tools](https://www.jenkins.io/doc/tutorials#tools)

##### Resources

- [Pipeline Syntax reference](https://www.jenkins.io/doc/book/pipeline/syntax/)
- [Pipeline Steps reference](https://www.jenkins.io/doc/pipeline/steps/)
- [LTS Upgrade guides](https://www.jenkins.io/doc/upgrade-guide/)

[⇐ Using Jenkins](https://www.jenkins.io/doc/book/using)

[Index](https://www.jenkins.io/doc/book/)

[Getting started with Pipeline ⇒](https://www.jenkins.io/doc/book/pipeline/getting-started)

# Pipeline [Anchor](https://www.jenkins.io/doc/book/pipeline/\#pipeline-1)

Chapter Sub-Sections

- [Getting started with Pipeline](https://www.jenkins.io/doc/book/pipeline/getting-started)
- [Using a Jenkinsfile](https://www.jenkins.io/doc/book/pipeline/jenkinsfile)
- [Running Pipelines](https://www.jenkins.io/doc/book/pipeline/running-pipelines)
- [Branches and Pull Requests](https://www.jenkins.io/doc/book/pipeline/multibranch)
- [Using Docker with Pipeline](https://www.jenkins.io/doc/book/pipeline/docker)
- [Extending with Shared Libraries](https://www.jenkins.io/doc/book/pipeline/shared-libraries)
- [Pipeline Development Tools](https://www.jenkins.io/doc/book/pipeline/development)
- [Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax)
- [Pipeline as Code](https://www.jenkins.io/doc/book/pipeline/pipeline-as-code)
- [Pipeline Best Practices](https://www.jenkins.io/doc/book/pipeline/pipeline-best-practices)
- [Scaling Pipelines](https://www.jenkins.io/doc/book/pipeline/scaling-pipeline)
- [Pipeline CPS Method Mismatches](https://www.jenkins.io/doc/book/pipeline/cps-method-mismatches)

Table of Contents

- [What is Jenkins Pipeline?](https://www.jenkins.io/doc/book/pipeline/#overview)
  - [Declarative versus Scripted Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/#declarative-versus-scripted-pipeline-syntax)
- [Why Pipeline?](https://www.jenkins.io/doc/book/pipeline/#why)
- [Pipeline concepts](https://www.jenkins.io/doc/book/pipeline/#pipeline-concepts)
  - [Pipeline](https://www.jenkins.io/doc/book/pipeline/#pipeline)
  - [Node](https://www.jenkins.io/doc/book/pipeline/#node)
  - [Stage](https://www.jenkins.io/doc/book/pipeline/#stage)
  - [Step](https://www.jenkins.io/doc/book/pipeline/#step)
- [Pipeline syntax overview](https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview)
  - [Declarative Pipeline fundamentals](https://www.jenkins.io/doc/book/pipeline/#declarative-pipeline-fundamentals)
  - [Scripted Pipeline fundamentals](https://www.jenkins.io/doc/book/pipeline/#scripted-pipeline-fundamentals)
- [Pipeline example](https://www.jenkins.io/doc/book/pipeline/#pipeline-example)

This chapter covers all recommended aspects of Jenkins Pipeline functionality,
including how to:

- [Get started with Pipeline](https://www.jenkins.io/doc/book/pipeline/getting-started), which covers how to
[define a Jenkins Pipeline](https://www.jenkins.io/doc/book/pipeline/getting-started#defining-a-pipeline) (your
`Pipeline`) through
[Blue Ocean](https://www.jenkins.io/doc/book/pipeline/getting-started#through-blue-ocean), through the
[classic UI](https://www.jenkins.io/doc/book/pipeline/getting-started#through-the-classic-ui) or in
[SCM](https://www.jenkins.io/doc/book/pipeline/getting-started#defining-a-pipeline-in-scm).

- [Create and use a `Jenkinsfile`](https://www.jenkins.io/doc/book/pipeline/jenkinsfile), which covers use-case scenarios
on how to craft and construct your `Jenkinsfile`.

- Work with [branches and pull requests](https://www.jenkins.io/doc/book/pipeline/multibranch).

- [Use Docker with Pipeline](https://www.jenkins.io/doc/book/pipeline/docker), covering how Jenkins can invoke Docker
containers on agents/nodes (from a `Jenkinsfile`) to build your Pipeline
projects.

- [Extend Pipeline with shared libraries](https://www.jenkins.io/doc/book/pipeline/shared-libraries).

- Use different [development tools](https://www.jenkins.io/doc/book/pipeline/development) to facilitate the creation
of your Pipeline.

- Work with [Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/syntax), which provides a comprehensive
reference of all Declarative Pipeline syntax.


For an overview of content in the Jenkins User Handbook, refer to the [User Handbook Overview](https://www.jenkins.io/doc/book/pipeline/getting-started).

## What is Jenkins Pipeline? [Anchor](https://www.jenkins.io/doc/book/pipeline/\#overview)

Jenkins Pipeline (or simply "Pipeline" with a capital "P") is a suite of plugins
which supports implementing and integrating _continuous delivery pipelines_ into
Jenkins.

A _continuous delivery (CD) pipeline_ is an automated expression of your process
for getting software from version control right through to your users and
customers. Every change to your software (committed in source control) goes
through a complex process on its way to being released. This process involves
building the software in a reliable and repeatable manner, as well as
progressing the built software (called a "build") through multiple stages of
testing and deployment.

Pipeline provides an extensible set of tools for modeling simple-to-complex
delivery pipelines "as code" via the
[Pipeline domain-specific language (DSL) syntax](https://www.jenkins.io/doc/book/pipeline/syntax).
\[ [1](https://www.jenkins.io/doc/book/pipeline/#_footnotedef_1 "View footnote.")\]

The definition of a Jenkins Pipeline is written into a text file (called a
[`Jenkinsfile`](https://www.jenkins.io/doc/book/pipeline/jenkinsfile)) which in turn can be committed to a project’s
source control repository.
\[ [2](https://www.jenkins.io/doc/book/pipeline/#_footnotedef_2 "View footnote.")\]
This is the foundation of "Pipeline-as-code"; treating the CD pipeline as a part of
the application to be versioned and reviewed like any other code.

Creating a `Jenkinsfile` and committing it to source control provides a number
of immediate benefits:

- Automatically creates a Pipeline build process for all branches and pull
requests.

- Code review/iteration on the Pipeline (along with the remaining source code).

- Audit trail for the Pipeline.

- Single source of truth
\[ [3](https://www.jenkins.io/doc/book/pipeline/#_footnotedef_3 "View footnote.")\]
for the Pipeline, which can be viewed and edited by multiple
members of the project.


While the syntax for defining a Pipeline, either in the web UI or with a
`Jenkinsfile` is the same, it is generally considered best practice to define
the Pipeline in a `Jenkinsfile` and check that in to source control.

### Declarative versus Scripted Pipeline syntax [Anchor](https://www.jenkins.io/doc/book/pipeline/\#declarative-versus-scripted-pipeline-syntax)

A `Jenkinsfile` can be written using two types of syntax — Declarative and
Scripted.

Declarative and Scripted Pipelines are constructed fundamentally differently.
Declarative Pipeline is designed to make writing and reading Pipeline code easier, and provides richer syntactical features over Scripted Pipeline syntax.

Many of the individual syntactical components (or "steps") written into a
`Jenkinsfile`, however, are common to both Declarative and Scripted Pipeline.
Read more about how these two types of syntax differ in [Pipeline concepts](https://www.jenkins.io/doc/book/pipeline/#pipeline-concepts)
and [Pipeline syntax overview](https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview) below.

## Why Pipeline? [Anchor](https://www.jenkins.io/doc/book/pipeline/\#why)

Jenkins is, fundamentally, an automation engine which supports a number of
automation patterns. Pipeline adds a powerful set of automation tools onto
Jenkins, supporting use cases that span from simple continuous integration to
comprehensive CD pipelines. By modeling a series of related tasks, users can
take advantage of the many features of Pipeline:

- **Code**: Pipelines are implemented in code and typically checked into source
control, giving teams the ability to edit, review, and iterate upon their
delivery pipeline.

- **Durable**: Pipelines can survive both planned and unplanned restarts of the
Jenkins controller.

- **Pausable**: Pipelines can optionally stop and wait for human input or approval
before continuing the Pipeline run.

- **Versatile**: Pipelines support complex real-world CD requirements, including
the ability to fork/join, loop, and perform work in parallel.

- **Extensible**: The Pipeline plugin supports custom extensions to its DSL
\[ [1](https://www.jenkins.io/doc/book/pipeline/#_footnotedef_1 "View footnote.")\] and multiple options for integration with other plugins.


While Jenkins has always allowed rudimentary forms of chaining Freestyle Jobs
together to perform sequential tasks,
\[ [4](https://www.jenkins.io/doc/book/pipeline/#_footnotedef_4 "View footnote.")\] Pipeline makes this concept a first-class citizen in
Jenkins.

What is the difference between Freestyle and Pipeline in Jenkins

What Is The Difference Between Freestyle and Pipeline in Jenkins - YouTube

Tap to unmute

[What Is The Difference Between Freestyle and Pipeline in Jenkins](https://www.youtube.com/watch?v=IOUm1lw7F58) [CloudBeesTV](https://www.youtube.com/channel/UCKlF3GIFy9KVUefVbycx_vw)

![thumbnail-image](https://yt3.ggpht.com/LLGBIy_tgbNEfWCUonec2QYTJAfLSPfnTp203Aknp1_rQR8nwtpEq8x1tiWwxkaiw61oOEifWA=s68-c-k-c0x00ffffff-no-rj)

CloudBeesTV38.1K subscribers

[Watch on](https://www.youtube.com/watch?v=IOUm1lw7F58)

Building on the core Jenkins value of extensibility, Pipeline is also extensible
both by users with [Pipeline Shared Libraries](https://www.jenkins.io/doc/book/pipeline/shared-libraries) and by
plugin developers.
\[ [5](https://www.jenkins.io/doc/book/pipeline/#_footnotedef_5 "View footnote.")\]

The flowchart below is an example of one CD scenario easily modeled in Jenkins
Pipeline:

![Pipeline Flow](https://www.jenkins.io/doc/book/resources/pipeline/realworld-pipeline-flow.png)

## Pipeline concepts [Anchor](https://www.jenkins.io/doc/book/pipeline/\#pipeline-concepts)

The following concepts are key aspects of Jenkins Pipeline, which tie in closely
to Pipeline syntax (refer to the [overview](https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview) below).

### Pipeline [Anchor](https://www.jenkins.io/doc/book/pipeline/\#pipeline)

A Pipeline is a user-defined model of a CD pipeline. A Pipeline’s code defines
your entire build process, which typically includes stages for building an
application, testing it and then delivering it.

Also, a `pipeline` block is a
[key part of Declarative Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/#declarative-pipeline-fundamentals).

### Node [Anchor](https://www.jenkins.io/doc/book/pipeline/\#node)

A node is a machine which is part of the Jenkins environment and is capable of
executing a Pipeline.

Also, a `node` block is a
[key part of Scripted Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/#scripted-pipeline-fundamentals).

### Stage [Anchor](https://www.jenkins.io/doc/book/pipeline/\#stage)

A `stage` block defines a conceptually distinct subset of tasks performed
through the entire Pipeline (e.g. "Build", "Test" and "Deploy" stages),
which is used by many plugins to visualize or present Jenkins Pipeline
status/progress.
\[ [6](https://www.jenkins.io/doc/book/pipeline/#_footnotedef_6 "View footnote.")\]

### Step [Anchor](https://www.jenkins.io/doc/book/pipeline/\#step)

A single task. Fundamentally, a step tells Jenkins _what_ to do at a
particular point in time (or "step" in the process). For example, to execute
the shell command `make`, use the `sh` step: `sh 'make'`. When a plugin
extends the Pipeline DSL, \[ [1](https://www.jenkins.io/doc/book/pipeline/#_footnotedef_1 "View footnote.")\] that typically means the plugin has
implemented a new _step_.

## Pipeline syntax overview [Anchor](https://www.jenkins.io/doc/book/pipeline/\#pipeline-syntax-overview)

The following Pipeline code skeletons illustrate the fundamental differences
between [Declarative Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/#declarative-pipeline-fundamentals) and
[Scripted Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/#scripted-pipeline-fundamentals).

Be aware that both [stages](https://www.jenkins.io/doc/book/pipeline/#stage) and [steps](https://www.jenkins.io/doc/book/pipeline/#step) (above) are common
elements of both Declarative and Scripted Pipeline syntax.

### Declarative Pipeline fundamentals [Anchor](https://www.jenkins.io/doc/book/pipeline/\#declarative-pipeline-fundamentals)

In Declarative Pipeline syntax, the `pipeline` block defines all the work done
throughout your entire Pipeline.

Jenkinsfile (Declarative Pipeline)

```groovy
pipeline {
    agent any (1)
    stages {
        stage('Build') { (2)
            steps {
                // (3)
            }
        }
        stage('Test') { (4)
            steps {
                // (5)
            }
        }
        stage('Deploy') { (6)
            steps {
                // (7)
            }
        }
    }
}
```

groovy

Copied!

|     |     |
| --- | --- |
| **1** | Execute this Pipeline or any of its stages, on any available agent. |
| **2** | Defines the "Build" stage. |
| **3** | Perform some steps related to the "Build" stage. |
| **4** | Defines the "Test" stage. |
| **5** | Perform some steps related to the "Test" stage. |
| **6** | Defines the "Deploy" stage. |
| **7** | Perform some steps related to the "Deploy" stage. |

### Scripted Pipeline fundamentals [Anchor](https://www.jenkins.io/doc/book/pipeline/\#scripted-pipeline-fundamentals)

In Scripted Pipeline syntax, one or more `node` blocks do the core work
throughout the entire Pipeline. Although this is not a mandatory requirement of
Scripted Pipeline syntax, confining your Pipeline’s work inside of a `node`
block does two things:

1. Schedules the steps contained within the block to run by adding an item
to the Jenkins queue. As soon as an executor is free on a node, the
steps will run.

2. Creates a workspace (a directory specific to that particular
Pipeline) where work can be done on files checked out from source control.

**Caution:** Depending on your Jenkins configuration, some workspaces may
not get automatically cleaned up after a period of inactivity. Refer to the tickets
and discussion linked from
[JENKINS-2111](https://issue-redirect.jenkins.io/issue/2111) for more
information.


Jenkinsfile (Scripted Pipeline)

```groovy
node {  (1)
    stage('Build') { (2)
        // (3)
    }
    stage('Test') { (4)
        // (5)
    }
    stage('Deploy') { (6)
        // (7)
    }
}
```

groovy

Copied!

|     |     |
| --- | --- |
| **1** | Execute this Pipeline or any of its stages, on any available agent. |
| **2** | Defines the "Build" stage. `stage` blocks are optional in Scripted Pipeline<br>syntax. However, implementing `stage` blocks in a Scripted Pipeline provides<br>clearer visualization of each `stage`'s subset of tasks/steps in the Jenkins UI. |
| **3** | Perform some steps related to the "Build" stage. |
| **4** | Defines the "Test" stage. |
| **5** | Perform some steps related to the "Test" stage. |
| **6** | Defines the "Deploy" stage. |
| **7** | Perform some steps related to the "Deploy" stage. |

## Pipeline example [Anchor](https://www.jenkins.io/doc/book/pipeline/\#pipeline-example)

Here is an example of a `Jenkinsfile` using Declarative Pipeline syntax — its
Scripted syntax equivalent can be accessed by clicking the **Toggle Scripted**
**Pipeline** link below:

Jenkinsfile (Declarative Pipeline)

```groovy
pipeline { (1)
    agent any (2)
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') { (3)
            steps { (4)
                sh 'make' (5)
            }
        }
        stage('Test'){
            steps {
                sh 'make check'
                junit 'reports/**/*.xml' (6)
            }
        }
        stage('Deploy') {
            steps {
                sh 'make publish' //
            }
        }
    }
}
```

groovy

Copied!

[Toggle Scripted Pipeline](https://www.jenkins.io/doc/book/pipeline/#) _(Advanced)_

Jenkinsfile (Scripted Pipeline)

```groovy
node { //
    stage('Build') { (3)
        sh 'make' (5)
    }
    stage('Test') {
        sh 'make check'
        junit 'reports/**/*.xml' (6)
    }
    if (currentBuild.currentResult == 'SUCCESS') {
        stage('Deploy') {
            sh 'make publish' //
        }
    }
}
```

groovy

Copied!

|     |     |
| --- | --- |
| **1** | [`pipeline`](https://www.jenkins.io/doc/book/pipeline/syntax#declarative-pipeline) is Declarative<br>Pipeline-specific syntax that defines a "block" containing all content and<br>instructions for executing the entire Pipeline. |
| **2** | [`agent`](https://www.jenkins.io/doc/book/pipeline/syntax#agent) is Declarative Pipeline-specific syntax that<br>instructs Jenkins to allocate an executor (on a node) and workspace for the<br>entire Pipeline. |
| **3** | `stage` is a syntax block that describes a<br>[stage of this Pipeline](https://www.jenkins.io/doc/book/pipeline/#stage). Read more about `stage` blocks in<br>Declarative Pipeline syntax on the [Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/syntax#stage) page. As<br>mentioned [above](https://www.jenkins.io/doc/book/pipeline/#scripted-pipeline-fundamentals), `stage` blocks are<br>optional in Scripted Pipeline syntax. |
| **4** | [`steps`](https://www.jenkins.io/doc/book/pipeline/syntax#steps) is Declarative Pipeline-specific syntax that<br>describes the steps to be run in this `stage`. |
| **5** | `sh` is a Pipeline [step](https://www.jenkins.io/doc/book/pipeline/syntax#steps) (provided by the<br>[Pipeline: Nodes and Processes plugin](https://plugins.jenkins.io/workflow-durable-task-step)) that<br>executes the given shell command. |
| **6** | `junit` is another Pipeline [step](https://www.jenkins.io/doc/book/pipeline/syntax#steps) (provided by the<br>[JUnit plugin](https://plugins.jenkins.io/junit)) for aggregating test reports. |

Read more about Pipeline syntax on the [Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax) page.

* * *

[1](https://www.jenkins.io/doc/book/pipeline/#_footnoteref_1). [Domain-specific language](https://en.wikipedia.org/wiki/Domain-specific_language)

[2](https://www.jenkins.io/doc/book/pipeline/#_footnoteref_2). [Source control management](https://en.wikipedia.org/wiki/Version_control)

[3](https://www.jenkins.io/doc/book/pipeline/#_footnoteref_3). [Single source of truth](https://en.wikipedia.org/wiki/Single_source_of_truth)

[4](https://www.jenkins.io/doc/book/pipeline/#_footnoteref_4). Additional plugins have been used to implement complex behaviors utilizing Freestyle Jobs such as the Copy Artifact, Parameterized Trigger, and Promoted Builds plugins

[5](https://www.jenkins.io/doc/book/pipeline/#_footnoteref_5). [GitHub Branch Source plugin](https://plugins.jenkins.io/github-branch-source)

[6](https://www.jenkins.io/doc/book/pipeline/#_footnoteref_6). [Blue Ocean](https://www.jenkins.io/doc/book/blueocean), [Pipeline: Stage View plugin](https://plugins.jenkins.io/pipeline-stage-view)

* * *

[⇐ Using Jenkins](https://www.jenkins.io/doc/book/using)

[Index](https://www.jenkins.io/doc/book/)

[Getting started with Pipeline ⇒](https://www.jenkins.io/doc/book/pipeline/getting-started)

* * *

[Was this page helpful?](https://www.jenkins.io/doc/book/pipeline/#feedback)

Please submit your feedback about this page through this
[quick form](https://www.jenkins.io/doc/feedback-form/).

Alternatively, if you don't wish to complete the quick form, you can simply
indicate if you found this page helpful?

YesNo

Type the answer to 5 plus 6 before clicking "Submit" below.

Submit

See existing feedback [here](https://docs.google.com/spreadsheets/d/1IIdpVs39JDYKg0sLQIv-MNO928qcGApAIfdW5ohfD78).

[Edit content/doc/book/pipeline/index.adoc on GitHub](https://github.com/jenkins-infra/jenkins.io/edit/master/content/doc/book/pipeline/index.adoc "Edit content/doc/book/pipeline/index.adoc on GitHub")

[Improve this page](https://github.com/jenkins-infra/jenkins.io/edit/master/content/doc/book/pipeline/index.adoc "Edit content/doc/book/pipeline/index.adoc on GitHub")

[Report a page issue with content/doc/book/pipeline/index.adoc](https://github.com/jenkins-infra/jenkins.io/issues/new?labels=bug&template=4-bug.yml&problem=%5BPipeline%5D%28https%3A%2F%2Fwww.jenkins.io%2Fdoc%2Fbook%2Fpipeline%2F%29+page%5Bsource+file%5D%28https%3A%2F%2Fgithub.com%2Fjenkins-infra%2Fjenkins.io%2Ftree%2Fmaster%2Fcontent%2Fdoc%2Fbook%2Fpipeline%2Findex.adoc%29 "Report a page issue with content/doc/book/pipeline/index.adoc")

[Report page issue](https://github.com/jenkins-infra/jenkins.io/issues/new?labels=bug&template=4-bug.yml&problem=%5BPipeline%5D%28https%3A%2F%2Fwww.jenkins.io%2Fdoc%2Fbook%2Fpipeline%2F%29+page%5Bsource+file%5D%28https%3A%2F%2Fgithub.com%2Fjenkins-infra%2Fjenkins.io%2Ftree%2Fmaster%2Fcontent%2Fdoc%2Fbook%2Fpipeline%2Findex.adoc%29 "Report a page issue with content/doc/book/pipeline/index.adoc")

[![Creative Commons Attribution-ShareAlike license](https://mirrors.creativecommons.org/presskit/buttons/88x31/svg/by-sa.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

The content driving this site is licensed under the Creative Commons Attribution-ShareAlike 4.0 license.

##### Resources

- [Downloads](https://www.jenkins.io/download/)
- [Blog](https://www.jenkins.io/blog/)
- [Documentation](https://www.jenkins.io/doc/)
- [Plugins](https://plugins.jenkins.io/)
- [Security](https://www.jenkins.io/security/)
- [Contributing](https://www.jenkins.io/participate/)

##### Project

- [Structure and governance](https://www.jenkins.io/project/)
- [Issue tracker](https://issues.jenkins.io/)
- [Roadmap](https://www.jenkins.io/project/roadmap/)
- [GitHub](https://github.com/jenkinsci)
- [Jenkins on Jenkins](https://ci.jenkins.io/)
- [Statistics](https://stats.jenkins.io/)

##### Community

- [Forum](https://community.jenkins.io/)
- [Events](https://www.jenkins.io/events/)
- [Mailing lists](https://www.jenkins.io/mailing-lists/)
- [Chats](https://www.jenkins.io/chat/)
- [Special Interest Groups](https://www.jenkins.io/sigs/)
- [𝕏 (formerly Twitter)](https://twitter.com/jenkinsci)
- [LinkedIn](https://www.linkedin.com/company/jenkins-project/)
- [Bluesky](https://bsky.app/profile/jenkinsci.bsky.social)
- [Mastodon](https://mastodon.social/@Jenkinsci)
- [Youtube](https://www.youtube.com/@jenkinscicd)
- [Reddit](https://reddit.com/r/jenkinsci)

##### Other

- [Code of Conduct](https://www.jenkins.io/project/conduct/)
- [Press information](https://www.jenkins.io/press/)
- [Merchandise](https://www.jenkins.io/merchandise/)
- [Artwork](https://www.jenkins.io/artwork/)
- [Awards](https://www.jenkins.io/awards/)

Copyright © 2026 CD Foundation The Linux Foundation®. All rights reserved. The Linux Foundation has registered trademarks and uses trademarks. For a list of trademarks of The Linux Foundation, please see our [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage) page. Linux is a registered trademark of Linus Torvalds. [Privacy Policy](https://www.linuxfoundation.org/legal/privacy-policy) and [Terms of Use](https://www.linuxfoundation.org/legal/terms).