---
id: d2855df07
topic: cloud-aws
title: Step Functions Map state: Inline vs Distributed mode
status: draft
shape: comparison
---

# Step Functions Map state: Inline vs Distributed mode

## What the Map state does

The `Map` state runs a set of workflow steps for each item in a dataset, and its iterations run in parallel, which makes it possible to process a dataset quickly [c6c9cf97a]. `Map` states can use a variety of input types, including a JSON array, a list of Amazon S3 objects, or a CSV file [c6c9cf97a]. Step Functions provides two types of processing modes for using the `Map` state: Inline mode and Distributed mode, and the mode you should use depends on how you want to process the items in a dataset [c6c9cf97a].

## Inline mode

Inline is a limited-concurrency mode in which each iteration of the `Map` state runs in the context of the workflow that contains the `Map` state, and Step Functions adds the execution history of these iterations to the parent workflow's execution history [c6c9cf97a]. By default, `Map` states run in Inline mode [c6c9cf97a]. In this mode, the `Map` state accepts only a JSON array as input, and the mode supports up to 40 concurrent iterations [c6c9cf97a]. Inline mode enforces a limit of 256 KiB on the input payload size and 25,000 entries in the execution event history [c6c9cf97a]. You can review the workflow's execution history from the console or by invoking the `GetExecutionHistory` API action, and you can also view the execution history through CloudWatch and X-Ray [c6c9cf97a].

You should use the `Map` state in Inline mode if your workflow's execution history won't exceed 25,000 entries, or if you don't require more than 40 concurrent iterations [c6c9cf97a].

## Distributed mode

Distributed is a high-concurrency mode in which the `Map` state runs each iteration as a child workflow execution, which enables high concurrency of up to 10,000 parallel child workflow executions [c6c9cf97a]. Each child workflow execution has its own, separate execution history from that of the parent workflow [c6c9cf97a]. In this mode, the `Map` state can accept either a JSON array or an Amazon S3 data source, such as a CSV file, as its input [c6c9cf97a]. Distributed mode lets you run up to 10,000 parallel child workflow executions to process millions of data items at one time [c6c9cf97a].

Distributed mode lets you overcome the payload size limitation because the `Map` state can read input directly from Amazon S3 data sources, and you can also overcome execution history limitations because the child workflow executions started by the `Map` state maintain their own, separate execution histories from the parent workflow's execution history [c6c9cf97a].

When you run a `Map` state in Distributed mode, Step Functions creates a Map Run resource, which refers to a set of child workflow executions that a Distributed Map state starts [c6c9cf97a]. You can view a Map Run in the Step Functions console, you can also invoke the `DescribeMapRun` API action, and a Map Run also emits metrics to CloudWatch [c6c9cf97a].

## Supported data sources

In Inline mode, the `Map` state accepts a JSON array passed from a previous step in the workflow as input [c6c9cf97a]. In Distributed mode, the `Map` state accepts the following data sources as input: a JSON array passed from a previous step in the workflow, a JSON file in an Amazon S3 bucket that contains an array, a CSV file in an Amazon S3 bucket, an Amazon S3 object list, and an Amazon S3 inventory [c6c9cf97a].

## When to use Distributed mode

Use the `Map` state in Distributed mode when you need to orchestrate large-scale parallel workloads that meet any combination of the following conditions: the size of your dataset exceeds 256 KiB, the workflow's execution event history would exceed 25,000 entries, or you need a concurrency of more than 40 concurrent iterations [c6c9cf97a].
