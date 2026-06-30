---
id: d919ebeeb
topic: container-batch
title: "Batch and HPC Scheduler Landscape: Ray, Volcano, and Nomad"
status: draft
shape: survey
---

# Batch and HPC Scheduler Landscape: Ray, Volcano, and Nomad

A survey of three systems for distributed and batch job execution. Each tool's
claims are drawn strictly from that tool's own source documentation; nothing is
shared or cross-attributed across tools.

## Ray

Ray Core is a distributed computing framework that provides a small set of
essential primitives — tasks, actors, and objects — for building and scaling
distributed applications [c1b3281f7]. The walk-through introduces these core
concepts with examples that demonstrate how to transform Python functions and
classes into distributed Ray tasks and actors and how to work with Ray objects
[c1b3281f7].

Tasks are the simplest way to parallelize Python functions across a Ray cluster
[c1b3281f7]. To create a task, you decorate a function with `@ray.remote` to
indicate it should run remotely, call the function with `.remote()` instead of a
normal function call, and use `ray.get()` to retrieve the result from the
returned future (a Ray object reference) [c1b3281f7].

While tasks are stateless, Ray actors allow you to create stateful workers that
maintain their internal state between method calls [c1b3281f7]. When an actor is
instantiated, Ray starts a dedicated worker process somewhere in the cluster,
the actor's methods run on that specific worker and can access and modify its
state, and the actor executes method calls serially in the order it receives
them, preserving consistency [c1b3281f7].

Ray's distributed object store manages data across the cluster, and there are
three main ways to work with objects [c1b3281f7]. With implicit creation, values
returned by tasks and actors are automatically stored in the object store,
returning object references that can later be retrieved [c1b3281f7]. With
explicit creation, `ray.put()` directly places objects in the store [c1b3281f7].
Object references can also be passed to other tasks and actors, avoiding
unnecessary data copying and enabling lazy execution [c1b3281f7].

## Volcano

Volcano is a cloud native system for high-performance workloads, accepted by the
Cloud Native Computing Foundation (CNCF) as its first and only official
container batch scheduling project [ca3f81a0e]. It supports computing frameworks
such as Spark, TensorFlow, PyTorch, Flink, Argo, MindSpore, PaddlePaddle, and
Ray [ca3f81a0e]. Volcano inherits the design of Kubernetes APIs, allowing
applications that require high-performance computing to run on Kubernetes
[ca3f81a0e].

Among its scheduling policies is gang scheduling, which ensures all tasks of a
job start simultaneously and is suited to distributed training and big data
scenarios [ca3f81a0e]. Volcano supports custom plugins and actions to implement
more scheduling algorithms [ca3f81a0e].

## Nomad

Nomad is a highly available, distributed, data-center aware cluster and
application scheduler designed to support the modern datacenter, with support
for long-running services, batch jobs, and much more [c224959d6].

## Dropped sources

- **c4991bc3d (HTCondor overview)** — dropped. The captured page is TOC/chrome
  only: navigation link text, a version switcher, and a copyright/build footer,
  with no definitional body prose ("HTCondor is a ..." or equivalent). No
  factual claim could be sourced from body text.
