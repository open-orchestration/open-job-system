---
id: da5f99648
topic: cicd
title: "CI/CD Configuration-as-Code: Pipeline Definition Syntax"
status: draft
shape: synthesis
---

# CI/CD Configuration-as-Code: Pipeline Definition Syntax

CircleCI, GitHub Actions, and Drone each express a CI/CD pipeline as a
declarative YAML file checked into the repository. The three reference docs
differ in vocabulary — CircleCI's `config.yml` keys, GitHub Actions' workflow
syntax, Drone's pipeline `trigger` section — but converge on the same idea: the
pipeline's structure, its execution environment, and the conditions under which
it runs are all data, not code.

## CircleCI: `config.yml` keys

CircleCI's pipeline is a `.circleci/config.yml` file whose top-level keys are
documented in the configuration reference. The `version` field is required and
takes the string `2`, `2.0`, or `2.1`; it "is intended to be used in order to
issue warnings for deprecation or breaking changes" [c16e7ac03]. The optional
boolean `setup` field "enables you to conditionally trigger configurations from
outside the primary `.circleci` parent directory, update pipeline parameters,
or generate customized configurations," and designates the `config.yaml` for
use of CircleCI's Dynamic Configuration feature [c16e7ac03].

Reuse is expressed through the `orbs` key, which is supported in `version: 2.1`
configuration and is used "to reference or define reusable configuration blocks
(orbs)"; its value is a map of user-selected names to either orb references
(strings) or orb definitions (maps), and an orb definition "must be the
orb-relevant subset of 2.1 config" [c16e7ac03].

The work itself is structured through `jobs`, `steps`, `workflows`, and
`executors`. A Workflow "is comprised of one or more uniquely named jobs," and
jobs are specified in the `jobs` map where the job's name is the key and the
value is a map describing the job [c16e7ac03]. Within a job, the `steps` key is
required and holds "A list of steps to be performed," and a job's name "must be
unique and case-insensitive within the `jobs` list" [c16e7ac03]. The
`workflows` key is "Used for orchestrating all jobs"; each workflow's name is a
key whose value map's top-level keys are `version` and `jobs`, and the name
"must be unique within the current `config.yml`" [c16e7ac03]. Executors are
factored out via the `executors` key — also supported in `version: 2.1`
configuration — which lets you "define the execution environment where job
steps run, letting you reuse a single executor definition across multiple jobs";
a job can instead name a declared reusable executor through its `executor` key
[c16e7ac03].

## GitHub Actions: workflow YAML under `.github/workflows`

GitHub Actions frames the same artifact as a *workflow*: "A workflow is a
configurable automated process made up of one or more jobs," and "You must
create a YAML file to define your workflow configuration" [cebcb4921]. Workflow
files use YAML syntax, must carry a `.yml` or `.yaml` extension, and must be
stored "in the `.github/workflows` directory of your repository" [cebcb4921].

Two keys name the workflow for display. The `name` field is "The name of the
workflow"; GitHub displays workflow names under the repository's "Actions" tab,
and "If you omit `name`, GitHub displays the workflow file path relative to the
root of the repository" [cebcb4921]. The `run-name` field is "The name for
workflow runs generated from the workflow"; "If `run-name` is omitted or is only
whitespace, then the run name is set to event-specific information for the
workflow run," such as the commit message or pull request title for a `push` or
`pull_request` event [cebcb4921].

Triggering is declarative through `on`: "To automatically trigger a workflow,
use `on` to define which events can cause the workflow to run," and you can
"define single or multiple events that can trigger a workflow, or set a time
schedule," as well as restrict execution to specific files, tags, or branch
changes [cebcb4921]. Finer event control comes from `on.<event_name>.types`,
which defines "the type of activity that will trigger a workflow run"
[cebcb4921]. The work is held under `jobs`: "A workflow run is made up of one or
more `jobs`, which run in parallel by default," and "To run jobs sequentially,
you can define dependencies on other jobs using the `jobs.<job_id>.needs`
keyword" [cebcb4921]. Each job "runs in a runner environment specified by
`runs-on`" [cebcb4921].

## Drone: the `trigger` section

Drone's reference doc focuses on the pipeline `trigger` section, which controls
*whether* a pipeline runs. Execution is webhook-driven: "When you push code to
your repository, open a pull request, or create a tag, your source control
management system automatically sends a webhook to Drone which in turn triggers
pipeline execution" [cc0f727de]. The trigger section "is common across all
pipeline types, and is used to limit pipeline execution" [cc0f727de].

Matching is glob-based, not regex: "You can use wildcard matching in your
triggers. Note that triggers use glob pattern matching, not regular
expressions" [cc0f727de]. Multiple triggers can be combined, with the
constraint that "all triggers must evaluate to true when combining multiple
triggers" [cc0f727de].

Conditions are expressed per dimension. The branch trigger "limits step
execution based on the git branch," where "the target branch is evaluated for
pull requests; and branch names are not available for tag events" [cc0f727de].
The event trigger "limits step execution based on the drone event type," which
"can be helpful when you want to limit steps based on push, pull request, tag
and more" [cc0f727de]. The reference (`ref`) trigger "limits step execution
based on the git reference name," useful "when you want to glob match branch or
tag names" [cc0f727de].

## Synthesis

All three systems push pipeline definition into version-controlled declarative
config, but they cut the problem at different joints. CircleCI exposes the most
key surface — `version`, `setup`, `orbs`, `jobs`, `steps`, `workflows`,
`executors` — with explicit reuse primitives (orbs, reusable executors)
[c16e7ac03]. GitHub Actions centers on the workflow-as-process abstraction with
event-driven `on` triggers and parallel-by-default `jobs` gated by `needs`
[cebcb4921]. Drone, in the slice documented here, isolates the gating concern:
a webhook-driven `trigger` section using glob matching across branch, event, and
ref conditions to limit execution [cc0f727de].

## Dropped sources

None — all three cited sources were anchored to body prose.
