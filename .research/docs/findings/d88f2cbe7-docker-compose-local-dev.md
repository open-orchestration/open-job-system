---
id: d88f2cbe7
topic: local-dev
title: "Docker Compose for Local Multi-Container Job Development"
status: draft
shape: synthesis
---

# Docker Compose for Local Multi-Container Job Development

## What Compose is

Docker Compose is a tool for defining and running multi-container applications [cf07b08f2]. The overview frames it as "the key to unlocking a streamlined and efficient development and deployment experience" [cf07b08f2]. For a job system — where a worker process typically runs alongside a queue/broker, a datastore, and supporting services — this is the multi-container case Compose is built to define and run [cf07b08f2].

## The model: one YAML file, one command

Compose simplifies the control of your entire application stack, making it easy to manage services, networks, and volumes in a single YAML configuration file [cf07b08f2]. Then, with a single command, you create and start all the services from your configuration file [cf07b08f2]. So the local dev model is: declare the whole job-system stack (its services, networks, and volumes) once in YAML, then bring it all up with one command rather than starting each container by hand [cf07b08f2].

## Lifecycle commands

Compose has commands for managing the whole lifecycle of your application [cf07b08f2]. The overview names these lifecycle capabilities:

- Start, stop, and rebuild services [cf07b08f2]
- View the status of running services [cf07b08f2]
- Stream the log output of running services [cf07b08f2]
- Run a one-off command on a service [cf07b08f2]

For job-system development these map directly to common needs: rebuilding a worker service after a code change, checking which services are running, tailing log output across the stack, and running a one-off command (e.g. against a single service) without disturbing the rest [cf07b08f2].

## Environments the body names

Compose works in all environments — production, staging, development, testing — as well as CI workflows [cf07b08f2]. Because the same Compose configuration spans these environments, the stack a developer runs locally can be the same one used for testing and CI [cf07b08f2].

## Open questions

The body lists lifecycle capabilities in prose but does not name the specific CLI invocations (e.g. the exact `up`/`down` subcommands) or the `services` top-level key — those would need the Compose CLI reference or Compose file reference, not this overview [cf07b08f2].
