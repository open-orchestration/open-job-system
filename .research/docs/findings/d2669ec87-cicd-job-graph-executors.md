---
id: d2669ec87
topic: cicd
title: "CI/CD systems as job-graph executors for build, test, deploy"
status: draft
shape: survey
---

# CI/CD systems as job-graph executors for build, test, deploy

**Scope.** What CI/CD systems teach a generic job system, from the catalog's sources. Covers
CircleCI, GitLab CI, Tekton, Argo CD, and Buildkite; the corpus also holds GitHub Actions,
Jenkins, and Drone (not synthesized here).

## Key claims (cited)

- **The pipeline is a job graph.** In CircleCI a **workflow** is a set of rules defining a
  collection of jobs and their run order — it **defines which jobs run, in what order, and
  under what conditions**, and manages **dependencies between jobs** [c77db9833].
- **The domain is build/test/deploy.** CI/CD is a continuous method of software development
  where you continuously **build, test, deploy, and monitor** iterative code changes
  [c395fcb65].
- **Concurrency + agents.** Buildkite Pipelines scale builds with **massive concurrency and
  flexible compute types** [ce6e977f8].
- **Kubernetes-native, entity-based.** Tekton is open-source (a CD Foundation / Linux
  Foundation project); **Tekton Pipelines defines entities** such as `Task` (a series of
  steps) [c130f57e1].
- **Delivery via GitOps.** Argo CD is a **declarative, GitOps continuous delivery tool for
  Kubernetes** [c29364912].

## Convergent vs contested

- **Convergent:** A CI/CD pipeline is the same **scheduler → executor → worker** pattern as
  workflow orchestration, specialized to software delivery: a declarative graph of jobs with
  **run order, conditions, and dependencies**, executed by agents/runners. The reusable
  patterns are exactly the job-system primitives — DAG ordering, conditional execution,
  concurrency, and agent pools.
- **Contested / differentiating:** Two sub-domains. **CI** (CircleCI, GitLab CI, Buildkite,
  Tekton) runs build/test job graphs triggered by code changes. **CD/GitOps** (Argo CD) is
  declarative, version-controlled *delivery* — reconciling deployed state to git, a different
  loop from running a build pipeline. (Tekton's Tasks/Pipelines span build *or* delivery, so it
  straddles both.) Tekton and Argo CD are Kubernetes-native; the others are hosted/agent-based.

## Implications for the system

- CI/CD validates the **job-graph + executor** model the orchestration core already targets:
  steal the proven shape — declarative jobs, explicit dependency ordering, conditional/filtered
  execution, agent/runner pools, and concurrency limits.
- Keep **trigger** (event/code-change/schedule) decoupled from **execution** (the agent pool),
  mirroring how CI/CD separates pipeline definition from runners.

## Gaps found → re-scan
- GitHub Actions (matrix, reusable workflows, runners), Jenkins (agents, queue), Drone — not synthesized.
- Caching/artifacts and fan-out (matrix) patterns; agent autoscaling.
- GitOps reconciliation-loop mechanics (Argo CD) vs imperative pipeline runs.
