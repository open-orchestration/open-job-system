---
id: d8432d7e0
topic: workflow-orchestration
title: "Workflow-automation platforms: Kestra, n8n, and Windmill"
status: draft
shape: survey
---

# Workflow-automation platforms: Kestra, n8n, and Windmill

A survey of three open-source workflow-automation / general workflow-engine
platforms, each described in the project's own definitional body prose. Two
candidates were dropped because their pages carry no definitional body prose
about what the tool is (only navigation, index links, or trademark/footer
chrome): Apache DolphinScheduler (`c2aaa51b8`) and Node-RED (`c023d8cc3`); they
are not cited here.

## Kestra

Kestra's documentation frames the unit of work as a "flow," and directs users
after the quickstart to "begin orchestrating your applications, microservices,
and processes" through plugins that integrate with external systems [c25b85154].
The
platform is distributed as a server: a single `docker run` command starts Kestra
on port 8080 with an embedded H2 database, and its UI is used to create and
execute flows [c25b85154].

## n8n

n8n is "a fair-code licensed workflow automation tool that combines AI
capabilities with business process automation" [c87e53ec2]. Its own
documentation states that "n8n supports building AI functionality and tools"
alongside its automation features [c87e53ec2].

## Windmill

Windmill defines itself as "a fast, open-source workflow engine and developer
platform," positioned as "an alternative to the likes of Retool, Superblocks,
n8n, Airflow, Prefect, Kestra and Temporal," and "designed to build
comprehensive internal tools (endpoints, workflows, UIs)" [cc6584b00]. It
supports coding in TypeScript, Python, Go, PHP, Bash, C#, SQL, Rust, Ruby and R,
or any Docker image, "alongside intuitive low-code builders" [cc6584b00]. Its
architecture combines an execution runtime for function execution across a
worker fleet, an orchestrator for assembling those functions into flows via a
low-code builder or YAML, a low-code app editor, and a full-code app builder for
React or Svelte frontends [cc6584b00]. The project summarizes itself as "an
open-source, self-hostable platform that marries the flexibility of code with
the speed of low-code solutions, enabling seamless automation of repetitive
tasks" [cc6584b00].
