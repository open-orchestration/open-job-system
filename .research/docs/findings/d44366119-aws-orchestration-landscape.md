---
id: d44366119
topic: cloud-aws
title: AWS managed orchestration and integration service landscape
status: draft
shape: survey
---

# AWS managed orchestration and integration service landscape

AWS offers several distinct managed services in the orchestration/integration space; each targets a different workload, and AWS's own "What is / Welcome" pages define them in terms that let a reader choosing an orchestration approach tell them apart.

## AWS Batch — managed batch computing

AWS Batch is a fully managed batch computing service that plans, schedules, and runs containerized batch ML, simulation, and analytics workloads across the full range of AWS compute offerings, such as Amazon ECS, Amazon EKS, AWS Fargate, and Spot or On-Demand Instances [c6ac0dfc5]. It runs those workloads on top of AWS managed container orchestration services, Amazon ECS and Amazon EKS [c6ac0dfc5].

## Amazon EventBridge — serverless event bus

EventBridge is a serverless service that uses events to connect application components together, making it easier to build scalable event-driven applications [cb3dbff3c]. Event-driven architecture, the style it supports, is a style of building loosely-coupled software systems that work together by emitting and responding to events [cb3dbff3c]. In addition, EventBridge provides EventBridge Scheduler, a serverless scheduler that allows you to create, run, and manage tasks from one central, managed service [cb3dbff3c].

## AWS Glue — serverless data integration / ETL

AWS Glue is a serverless data integration service for analytics users to discover, prepare, move, and integrate data from multiple sources, usable for analytics, machine learning, and application development [cbde547a8]. With Glue you can discover and connect to more than 70 diverse data sources and manage data in a centralized data catalog, and visually create, run, and monitor extract, transform, and load (ETL) pipelines to load data into your data lakes [cbde547a8].

## Amazon MWAA — managed Apache Airflow

Amazon Managed Workflows for Apache Airflow is a managed service for Apache Airflow, used to set up and run data pipelines in the cloud at scale [ce12ad49a]. Apache Airflow itself is an open-source tool used to create, schedule, and monitor workflows, and with Amazon MWAA you use Apache Airflow and Python to create workflows without managing the underlying infrastructure for scalability, availability, and security [ce12ad49a].

## Amazon SWF — workflow / task-coordination service

With Amazon Simple Workflow Service (Amazon SWF) you can build, run, and scale background jobs that have parallel or sequential steps, coordinating work across distributed components and tracking the state of tasks [cdbd8c0c0]. In Amazon SWF a task represents a logical unit of work performed by a component of your application, and SWF lets you control and coordinate tasks — managing inter-task dependencies, scheduling, and concurrency — without handling underlying complexities such as tracking progress and maintaining task state [cdbd8c0c0]. SWF stores tasks and assigns them to workers (which can run on cloud infrastructure such as Amazon EC2 or on premises) when they are ready, and maintains an application's execution state durably so the application is resilient to individual component failures [cdbd8c0c0].

## EventBridge Scheduler — scheduled invocation of targets (e.g. ECS tasks)

EventBridge Scheduler is a serverless scheduler that allows you to create, run, and manage tasks from one central managed service, independent of event buses and rules [cb331285a]. It offers improved scalability over EventBridge scheduled rules, with a wider set of target API operations and AWS services, and provides rate-based, cron-based, and one-time schedules that you configure for your tasks [cb331285a]. You can schedule your Amazon ECS tasks using Amazon EventBridge Scheduler [cb331285a].
