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
- Orchestrate
- Set up pipelines and workflows

# Workflow orchestration

[9 days ago](https://github.com/circleci/circleci-docs/commit/5f6e263507270f8007f8735d7da5c418f27ad918)

Cloud

Server v4+


Markdown

- [View markdown](https://circleci.com/docs/guides/orchestrate/workflows/index.md)
- Copy markdown


### On This Page

- [Workflow capabilities and benefits](https://circleci.com/docs/guides/orchestrate/workflows/#overview)
- [Workflows configuration examples](https://circleci.com/docs/guides/orchestrate/workflows/#workflows-configuration-examples)
- [Concurrent job execution](https://circleci.com/docs/guides/orchestrate/workflows/#concurrent-job-execution)
- [Sequential job execution](https://circleci.com/docs/guides/orchestrate/workflows/#sequential-job-execution)
- [Fan-out/fan-in workflow](https://circleci.com/docs/guides/orchestrate/workflows/#fan-outfan-in-workflow)
- [Flexible job dependency](https://circleci.com/docs/guides/orchestrate/workflows/#flexible-job-dependency)
- [Ignore the outcome of an upstream job](https://circleci.com/docs/guides/orchestrate/workflows/#ignore-the-outcome-of-an-upstream-job)
- [Run a command when the previous job is cancelled](https://circleci.com/docs/guides/orchestrate/workflows/#run-a-command-when-the-previous-job-is-cancelled)
- [Hold a workflow for a manual approval](https://circleci.com/docs/guides/orchestrate/workflows/#holding-a-workflow-for-a-manual-approval)
- [Configure an approval job](https://circleci.com/docs/guides/orchestrate/workflows/#configure-an-approval-job)
- [Approve a job](https://circleci.com/docs/guides/orchestrate/workflows/#approve-a-job)
- [Identify the user who approved a job](https://circleci.com/docs/guides/orchestrate/workflows/#identify-the-user-who-approved-a-job)
- [Cancel a job](https://circleci.com/docs/guides/orchestrate/workflows/#cancel-a-job)
- [Scheduling a workflow](https://circleci.com/docs/guides/orchestrate/workflows/#scheduling-a-workflow)
- [Example: Build every night](https://circleci.com/docs/guides/orchestrate/workflows/#nightly-example)
- [Schedule requirements and syntax](https://circleci.com/docs/guides/orchestrate/workflows/#specifying-a-valid-schedule)
- [Scheduling and dynamic configuration](https://circleci.com/docs/guides/orchestrate/workflows/#scheduling-and-dynamic-configuration)
- [Scheduled workflows and billing](https://circleci.com/docs/guides/orchestrate/workflows/#scheduled-workflows-and-billing)
- [Using contexts to share and secure environment variables](https://circleci.com/docs/guides/orchestrate/workflows/#using-job-contexts-to-share-environment-variables)
- [Use conditional logic in workflows](https://circleci.com/docs/guides/orchestrate/workflows/#use-conditional-logic-in-workflows)
- [Using filters in your workflows](https://circleci.com/docs/guides/orchestrate/workflows/#using-filters-in-your-workflows)
- [Branch-level job execution](https://circleci.com/docs/guides/orchestrate/workflows/#branch-level-job-execution)
- [Executing workflows for a git tag](https://circleci.com/docs/guides/orchestrate/workflows/#executing-workflows-for-a-git-tag)
- [Using regular expressions to filter tags and branches](https://circleci.com/docs/guides/orchestrate/workflows/#using-regular-expressions-to-filter-tags-and-branches)
- [Using workspaces to share data between jobs](https://circleci.com/docs/guides/orchestrate/workflows/#using-workspaces-to-share-data-between-jobs)
- [Rerunning a workflow’s failed jobs](https://circleci.com/docs/guides/orchestrate/workflows/#rerunning-a-workflows-failed-jobs)
- [Rerun limit](https://circleci.com/docs/guides/orchestrate/workflows/#rerun-limit)
- [Workflow states](https://circleci.com/docs/guides/orchestrate/workflows/#states)
- [Troubleshooting](https://circleci.com/docs/guides/orchestrate/workflows/#troubleshooting)
- [What happens if I do not configure any workflows in my configuration file?](https://circleci.com/docs/guides/orchestrate/workflows/#what-happens-if-i-do-not-configure-any-workflows-in-my-configuration-file)
- [Workflow and subsequent jobs do not trigger](https://circleci.com/docs/guides/orchestrate/workflows/#workflow-and-subsequent-jobs-do-not-trigger)
- [Rerunning workflows fails](https://circleci.com/docs/guides/orchestrate/workflows/#rerunning-workflows-fails)
- [Workflows waiting for status in GitHub](https://circleci.com/docs/guides/orchestrate/workflows/#workflows-waiting-for-status-in-github)
- [See also](https://circleci.com/docs/guides/orchestrate/workflows/#see-also)

Use workflows to orchestrate jobs in CircleCI. A workflow defines which jobs run, in what order, and under what conditions. This page shows you how to configure workflows to control job execution, manage dependencies between jobs, schedule builds, and apply filters to run different jobs for different branches or tags.

## Workflow capabilities and benefits

A **workflow** is a set of rules for defining a collection of jobs and their run order. Create workflows to orchestrate your jobs using the options described on this page.

With workflows, you can:

- Run and troubleshoot jobs independently with real-time status feedback.

- Schedule workflows for jobs that only run periodically.

- Fan-out to run multiple jobs concurrently for efficient version testing.

- Fan-in to deploy to multiple platforms.

- Catch failures in real-time and rerun only failed jobs.


## Workflows configuration examples

The following examples demonstrate common workflow patterns including concurrent execution, sequential dependencies, and fan-out/fan-in structures. Use these patterns to orchestrate your jobs based on your project’s needs.

|     |     |
| --- | --- |
|  | For a full specification of the `workflows` key, see the [Workflows](https://circleci.com/docs/reference/configuration-reference/#workflows) section of the configuration reference. |

### Concurrent job execution

The example in this section shows the default workflow orchestration model of concurrent jobs. Concurrent jobs are defined as follows:

- Use the `workflows` key.

- Name the workflow, in this case, `build_and_test`.

- Nest the `jobs` key with a list of job names that are defined in the configuration file. In this example the jobs have no dependencies defined, so they run concurrently.


|     |     |
| --- | --- |
|  | **Using Docker?** Authenticating Docker pulls from image registries is recommended when using the Docker execution environment. Authenticated pulls allow access to private Docker images, and may also grant higher rate limits, depending on your registry provider. For further information, see [Using Docker authenticated pulls](https://circleci.com/docs/guides/execution-managed/private-images/). |

```
jobs:
  build:
    docker:
      - image: cimg/base:2023.06
    steps:
      - checkout
      - run: <command>
  test:
    docker:
      - image: cimg/base:2023.06
    steps:
      - checkout
      - run: <command>
workflows:
  build_and_test:
    jobs:
      - build
      - test
```

yaml

See the [Sample concurrent workflow config](https://github.com/CircleCI-Public/circleci-demo-workflows/blob/parallel-jobs/.circleci/config.yml) for a full example.

When using workflows, note the following best practices:

- Move the quickest jobs up to the start of your workflow. For example, lint or syntax checking happens before longer-running, more computationally expensive jobs.

- Using a "setup" job at the _start_ of a workflow can be helpful to do some preflight checks and populate a workspace for all the following jobs.


|     |     |
| --- | --- |
|  | Refer to the [Optimization Reference](https://circleci.com/docs/guides/optimize/optimizations/) for tips to improve your configuration. |

### Sequential job execution

This example shows a workflow with four sequential jobs. Each job waits to start until the "required" job finishes successfully, as illustrated in the following diagram:

![Sequential Job Execution Workflow](https://circleci.com/docs/guides/_images/sequential_workflow.png)

Figure 1. Sequential Job Execution Workflow

This configuration snippet is an example of a workflow configured for sequential jobs:

```
workflows:
  build-test-and-deploy:
    jobs:
      - build  # First job runs immediately
      - test1:
          requires:
            - build  # test1 waits for build to complete successfully
      - test2:
          requires:
            - test1  # test2 waits for test1 to complete successfully
      - deploy:
          requires:
            - test2  # deploy runs last, after all tests pass
```

yaml

Define job dependencies using the `requires` key. A job must wait until all upstream jobs in the dependency graph have run. In this example, the `deploy` job runs when the `build`, `test1` and `test2` jobs complete successfully:

- The `deploy` job waits for the `test2` job.

- The `test2` job waits for the `test1` job.

- The `test1` job waits for the `build` job.


See the [Sample Sequential Workflow config](https://github.com/CircleCI-Public/circleci-demo-workflows/blob/sequential-branch-filter/.circleci/config.yml) for a full example.

### Fan-out/fan-in workflow

This example workflow has a fan-out/fan-in structure, as follows:

- A common build job is run.

- The workflow fans-out to run a set of acceptance test jobs concurrently.

- The workflow fans-in to run a common deploy job.


![Fan-out and Fan-in Workflow](https://circleci.com/docs/guides/_images/fan-out-in.png)

Figure 2. Fan-out and Fan-in Workflow

This configuration snippet is an example of a workflow configured for fan-out/fan-in job execution:

```
workflows:
  build_accept_deploy:
    jobs:
      - build  # Single build job runs first
      - acceptance_test_1:  # Fan-out: all acceptance tests run concurrently
          requires:
            - build
      - acceptance_test_2:
          requires:
            - build
      - acceptance_test_3:
          requires:
            - build
      - acceptance_test_4:
          requires:
            - build
      - deploy:  # Fan-in: deploy waits for all acceptance tests to succeed
          requires:
            - acceptance_test_1
            - acceptance_test_2
            - acceptance_test_3
            - acceptance_test_4
```

yaml

In this example, as soon as the `build` job finishes successfully, all four acceptance test jobs start. The `deploy` job waits for all four acceptance test jobs to succeed before it starts.

See the [Sample Fan-in/Fan-out Workflow config](https://github.com/CircleCI-Public/circleci-demo-workflows/tree/fan-in-fan-out) for a full example.

### Flexible job dependency

Using flexible requires with the `requires` key, you can build complex dependency maps and fan in/out scenarios.

The following example is a configuration snippet of a workflow with four sequential jobs. Each job waits until the "required" job attains a specified status:

```
workflows:
  build-and-deploy:
    jobs:
      - build
      - deploy:
          requires:
            - build  # deploy waits for build to succeed
      - release:
          requires:
            - deploy  # release waits for deploy to succeed
      - rollback:
          requires:
            - release:  # rollback runs only if release fails or is canceled
              - failed
              - canceled
```

yaml

A job must wait until all upstream jobs in the dependency graph have attained either of the statuses specified under the corresponding `requires` key. In this example, the following dependencies are configured:

- The `rollback` job waits for the `release` job, and only runs if the `release` job fails or is canceled.

- The `release` job waits for the `deploy` job, and only runs if the `deploy` job is successful.

- The `deploy` job waits for the `build` job, and only runs if the `build` job is successful.


![Flexible Job Execution Workflow - Example 1](https://circleci.com/docs/guides/_images/workflow-using-requires-example-1.png)

Figure 3. Workflow execution when the `release` job is successful

![Flexible Job Execution Workflow - Example 2](https://circleci.com/docs/guides/_images/workflow-using-requires-example-2.png)

Figure 4. Workflow execution when the `release` job fails:

#### Ignore the outcome of an upstream job

You may want to configure job dependencies that ignore the status/outcome of an upstream job, for example running a job regardless of the status/outcome of an upstream job.

In the following example, the dependent job runs once the upstream job attains a terminal state, regardless of the status/outcome:

Use flexible requires to ignore outcome of a job

```
workflows:
  test-and-cleanup:
    jobs:
      - build
      - test:
          requires:
            - build
      - cleanup:
          requires:
            - test: terminal
```

yaml

- The `test` job waits for the `build` job, and only runs if the `build` job is successful.

- The `cleanup` job waits for the `test` job, and runs regardless of whether the `test` job succeeds, fails, is canceled, unauthorized, or is not run.


#### Run a command when the previous job is cancelled

You can use flexible requires to run a specific job only when the previous job is cancelled. Running a command when a job is cancelled is useful for notifications, cleanup tasks, or logging when a deployment or long-running job is manually cancelled.

In the following example, a notification job runs only when a deployment is cancelled:

Run a job when the previous job is cancelled

```
workflows:
  deploy-with-notifications:
    jobs:
      - build
      - deploy:
          requires:
            - build
      - notify-cancelled:
          requires:
            - deploy:
              - canceled
```

yaml

In this example:

- The `deploy` job waits for the `build` job, and only runs if the `build` job is successful.

- The `notify-cancelled` job waits for the `deploy` job, and only runs if the `deploy` job is cancelled.


This pattern is useful when you want to send alerts, clean up resources, or log information specifically when a job is manually cancelled by a team member.

|     |     |
| --- | --- |
|  | Refer to the [Requires](https://circleci.com/docs/reference/configuration-reference/#requires) section of the configuration reference. |

## Hold a workflow for a manual approval

Use an `approval` job to configure a workflow to wait for manual approval before continuing. Anyone who has push access to the repository can approve the job to continue the workflow or cancel to end the workflow. Approve or Cancel either by using the buttons in the CircleCI web app, or via the API.

Some things to keep in mind when using manual approval in a workflow:

- `approval` is a special job type that is configured when listing jobs under the `workflows` key. You do not need to define an `approval` type job in the `jobs` section of your configuration. If you do configure steps for a job that is given the `approval` type in the workflows section, the steps for that job will not be run. An `approval` job is _only_ used to _hold_ the workflow for approval, not to run any work.

- The `approval` job name must be unique and not used by any other job in your configuration.

- The name of the approval job is arbitrary. For example, an approval job can be named `hold`, `wait`, `pause`, etc.

- All jobs that run _after_ a manual approval job **must**`require` the name of the `approval` job.

- Jobs run in the order defined in the workflow.

- When the workflow encounters a job with `type: approval`, the workflow pauses until action is taken to approve or cancel.

- If approval is granted, the workflow continues to process jobs in the order defined in the configuration file.

- If cancel is granted, the downstream jobs are not run.

- Jobs downstream of an `approval` job can be restricted by adding a [Restricted Context](https://circleci.com/docs/guides/security/contexts/#approve-jobs-that-use-restricted-contexts) to those downstream jobs.


The following screenshot demonstrates:

- A workflow that needs approval.

- The approval popup.

- The workflow graph after approval.


![A three section image showing workflow graph with "Needs approval" job](https://circleci.com/docs/guides/_images/approval-workflow-map.png)

Figure 5. Workflow graph with "Needs approval" job, the approval popup, and the workflow graph

By clicking on the `approval` job’s name (`hold`, in the screenshot above), an approval dialog box appears. You can approve, cancel, or close the popup without approving.

### Configure an approval job

To set up a manual approval workflow, add a job to the `jobs` list in your workflow with `type: approval`. For example:

```
# ...
# << your config for the build, test1, test2, and deploy jobs >>
# ...

workflows:
  build-test-and-approval-deploy:
    jobs:
      - build  # your custom job from your config, that builds your code
      - test1: # your custom job; runs test suite 1
          requires: # test1 will not run until the `build` job is completed.
            - build
      - test2: # another custom job; runs test suite 2,
          requires: # test2 is dependent on the success of job `test1`
            - test1
      - hold: # Approval job pauses the workflow and waits for manual action
          type: approval # This type makes the workflow wait for manual approval in the CircleCI web app
          requires: # We only run the "hold" job when test2 has succeeded
           - test2
      # On approval of the `hold` job, any successive job that requires the `hold` job will run.
      # In this case, a user is manually triggering the deploy job.
      - deploy:  # Deploy only runs after manual approval of the hold job
          requires:
            - hold  # This requires the approval job, not test2, ensuring manual gate before deployment
```

yaml

In this example, the `deploy` job will not run until the `hold` job is approved.

### Approve a job

To approve a job follow these steps:

- CircleCI web app

- API


1. Select the `hold` job in the **Workflows** page of the CircleCI web app.

2. Select **Approve**.


|     |     |
| --- | --- |
|  | **Using server?** If you are using CircleCI server, replace `https://circleci.com` with your server hostname when interacting with the CircleCI API. |

1. Set up your API authentication. Steps are available in the [API Developers Guide](https://circleci.com/docs/guides/toolkit/api-developers-guide/#add-an-api-token).

2. You need your workflow ID and the `approval_request_id` (which is the job ID for the job requiring approval) to make the API POST request. Depending on your use case, you might be configuring an approval job in a pipeline, or using an external service to approve a job. You can get the required parameters using [Pipeline Values or Environment Variables](https://circleci.com/docs/reference/variables/), or by receiving [Webhooks](https://circleci.com/docs/guides/integration/outbound-webhooks/) or polling the API. To approve a job, use the [approve a job](https://circleci.com/docs/api/v2/index.html#operation/approvePendingApprovalJobById) endpoint, for example:





```
curl --request POST \
     --url https://circleci.com/api/v2/workflow/<workflow-ID>/approve/<approval_request_id> \
     --header "Circle-Token: ${CIRCLE_TOKEN}" \
     --header 'content-type: application/json' \
```



shell


### Identify the user who approved a job

To identify the user who approved a job, you can use the CircleCI web app or the API.

- CircleCI web app

- API


- If the user signed up via GitHub, the (non-clickable) avatar of the GitHub user appears next to the approval job. Hovering over that avatar brings up a tooltip with the user’s name as specified in their GitHub/Bitbucket account settings.

- If the user signed up via email, the anonymous avatar appears next to the approval job; hovering over that avatar brings up a tooltip with the user’s email address.


1. Set up your API authentication. Steps are available in the [API Developers Guide](https://circleci.com/docs/guides/toolkit/api-developers-guide/#add-an-api-token).

2. You need the workflow ID so you can use the [get a workflow’s jobs](https://circleci.com/docs/api/v2/index.html#operation/listWorkflowJobs) endpoint to get the user ID. You can get the workflow ID using [Pipeline Values or Environment Variables](https://circleci.com/docs/reference/variables/), or by receiving [Webhooks](https://circleci.com/docs/guides/integration/outbound-webhooks/) or [polling the API](https://circleci.com/docs/api/v2/index.html#tag/Pipeline/operation/listWorkflowsByPipelineId).





```
curl --request GET \
     --url https://circleci.com/api/v2/workflow/<workflow-ID>/job \
     --header "Circle-Token: ${CIRCLE_TOKEN}" \
     --header 'content-type: application/json' \
```



shell

3. In the JSON response, take note of the value associated with the `approved_by` key. This is the user ID of the user who approved the job.





```
    "name" : "hold",
    "project_slug" : "gh/<org>/<project>",
    "approved_by" : "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx",
    "type" : "approval",
    "status" : "success",
```



json

4. Then use the [user information](https://circleci.com/docs/api/v2/index.html#operation/getUser) endpoint to get the username or email address.





```
curl --request GET \
     --url https://circleci.com/api/v2/user/<user-ID> \
     --header "Circle-Token: ${CIRCLE_TOKEN}" \
     --header 'content-type: application/json' \
```



shell







   - If the user who approved the job signed up via GitHub or Bitbucket, the response from the user information endpoint will have the following format:





     ```
      {
        "name" : "User’s name as specified in their VCS account settings",
        "login" : "VCS username",
        "id" : "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
      }
     ```



     json

   - If the user who approved the job signed up via email, the response from the user information endpoint will have the following format:





     ```
      {
        "name" : "Email address",
        "login" : "Email address",
        "id" : "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
      }
     ```



     json


|     |     |
| --- | --- |
|  | You can find detailed instructions in [this support article](https://support.circleci.com/hc/en-us/articles/360044820493-How-to-Find-hold-Step-Approver-in-a-Workflow) |

### Cancel a job

To Cancel a job, follow these steps:

- CircleCI web app

- API


1. Select the `hold` job in the **Workflows** page of the CircleCI web app.

2. Select **Cancel**.


1. Set up your API authentication. Steps are available in the [API Developers Guide](https://circleci.com/docs/guides/toolkit/api-developers-guide/#add-an-api-token).

2. You need your job ID (which is the job ID for the job requiring approval) to make the API POST request. Depending on your use case, you might be configuring an approval job in a pipeline, or using an external service to approve a job. You can get the required parameters using [Pipeline Values or Environment Variables](https://circleci.com/docs/reference/variables/), or by receiving [Webhooks](https://circleci.com/docs/guides/integration/outbound-webhooks/) or polling the API. To cancel a job, use the [cancel a job](https://circleci.com/docs/api/v2/index.html#operation/cancelJobByJobID) endpoint, for example:





```
curl --request POST \
     --url https://circleci.com/api/v2/jobs/<job-ID>/cancel \
     --header "Circle-Token: ${CIRCLE_TOKEN}" \
     --header 'content-type: application/json' \
```



shell


In this example, the purpose of the `hold` job is to wait for approval to begin deployment. A job can be approved for up to 90 days after it starts.

## Scheduling a workflow

|     |     |
| --- | --- |
|  | For new scheduled pipelines, use [Schedule Triggers](https://circleci.com/docs/guides/orchestrate/schedule-triggers/) instead of scheduled workflows. Schedule triggers offer improved control. Scheduled workflows are documented here for reference and for teams that cannot yet migrate to schedule triggers. See the [Migration Guide](https://circleci.com/docs/guides/orchestrate/migrate-scheduled-workflows-to-schedule-triggers/) to move to schedule triggers. |

Scheduled workflows allow you to run jobs at specific times rather than on every pipeline trigger. Running a workflow for every commit for every branch can be inefficient and expensive. Scheduling is useful for resource-intensive jobs, nightly builds, or generating reports on a regular cadence, without triggering on every code change. A scheduled workflow runs on a schedule only. A scheduled workflow will **not** be run on commits to your code.

By default, a workflow runs on every push, or based on the event rules you have set up for your trigger (**Project settings** **Triggers** or **Project settings** **Project Setup**). To trigger a workflow on a schedule, add the `triggers` key to the workflow and specify a `schedule` including cron syntax and branch filters. Scheduled workflows use the `cron` syntax to represent Coordinated Universal Time (UTC). See [Example: Build every night](https://circleci.com/docs/guides/orchestrate/workflows/#nightly-example) for an basic example.

Scheduled workflows are **not** available for GitHub App, GitLab or Bitbucket Data Center pipelines.

### Example: Build every night

In the example below, the `nightly` workflow is configured to run every day at 12:00am UTC. The `cron` key is specified using POSIX `crontab` syntax. See the [crontab man page](https://www.unix.com/man-page/POSIX/1posix/crontab/) for `cron` syntax basics. The workflow runs on the `main` and `beta` branches.

|     |     |
| --- | --- |
|  | Scheduled workflows may be delayed by up to 15 minutes. This delay is to maintain reliability during busy times, such as 12:00am UTC. Do not assume that scheduled workflows start with to-the-minute accuracy. |

```
workflows:
  # the commit workflow runs on every pipeline trigger
  commit:
    jobs:
      - test
      - deploy
  # the nightly workflow runs on the specified schedule on the main branch and any branch that starts with `release/
  nightly: `
    triggers:
      - schedule:
          cron: "0 0 * * *"
          filters:
            branches:
              only:
                - main
                - /^release\/.*/
    jobs:
      - coverage
```

yaml

In the above example:

- The `commit` workflow has no `triggers` key and runs on every `git push`.

- The `nightly` workflow has a `triggers` key and runs on the specified `schedule`, which is daily, and only runs on the `main` branch, as well as any branch that starts `release/`.


### Schedule requirements and syntax

A valid `schedule` requires:

- A `cron` key.

- A `filters` key.

- The `branches` filter must be present.


The value of the `cron` key must be a [valid crontab entry](https://crontab.guru/).

The following are **not** supported:

- Cron step syntax (for example, `*/1`, `*/20`).

- Range elements within comma-separated lists of elements.

- Range elements for days (for example, `Tue-Sat`).


Use comma-separated digits instead.

Example **invalid** cron range syntax

```
    triggers:
      - schedule:
          cron: "5 4 * * 1,3-5,6" # < the range separator with `-` is invalid
          filters:
            branches:
              only:
                - main
```

yaml

Example **valid** cron range syntax

```
    triggers:
      - schedule:
          cron: "5 4 * * 1,3,4,5,6"
          filters:
            branches:
              only:
                - main
```

yaml

The value of the `filters` key must be a map that defines rules for execution on specific branches.

For more details, see the `branches` section of the [Configuration Reference](https://circleci.com/docs/reference/configuration-reference/#schedule-branches).

For a full configuration example, see the [Sample Scheduled Workflows configuration](https://github.com/CircleCI-Public/circleci-demo-workflows/blob/try-schedule-workflow/.circleci/config.yml).

### Scheduling and dynamic configuration

Scheduled workflows do not support [Dynamic Configuration](https://circleci.com/docs/guides/orchestrate/dynamic-config/). If you use dynamic configuration you will need to use [Schedule Triggers](https://circleci.com/docs/guides/orchestrate/schedule-triggers/). More information can be found in this [support article](https://support.circleci.com/hc/en-us/articles/360060833331-Support-for-Scheduled-Workflows-in-Dynamic-Configurations-Setup-Workflows).

### Scheduled workflows and billing

When you schedule a workflow, the workflow will be counted as an individual active user. For more information, see the [User Types and Registration](https://circleci.com/docs/guides/plans-pricing/user-types-and-registration/#active-users) guide.

## Using contexts to share and secure environment variables

In a workflow, you can use a context to securely provide environment variables to specific jobs.
Contexts allow you to define environment variables at the organization level and control access to them through security restrictions.
Using contexts, sensitive data like API keys or credentials are securely shared with only the jobs that require them. Sensitive data in contexts will not be exposed in your config file.

The following example shows a workflow with four sequential jobs that each use a context to access environment variables. See the [Contexts](https://circleci.com/docs/guides/security/contexts/) page for detailed instructions on this setting in the application.

The following `config.yml` snippet is an example of a sequential job workflow configured to use the environment variables defined in the `org-global` context:

```
workflows:
  build-test-and-deploy:
    jobs:
      - build
      - test1:
          requires:
            - build
          context: org-global
      - test2:
          requires:
            - test1
          context: org-global
      - deploy:
          requires:
            - test2
```

yaml

The `test1` and `test2` jobs have access to environment variables stored in the `org-global` context if the pipeline meets the restrictions set for the context, for example:

- Was the pipeline triggered by a user who has access (is in the relevant org/security group etc.)? See the [Security Group Restrictions](https://circleci.com/docs/guides/security/contexts/#security-group-restrictions) page for more information.

- Does the project have access to the context? By default all projects in an organization have access to contexts set for that organization, but restrictions on project access can be configured. See the [Project Restrictions](https://circleci.com/docs/guides/security/contexts/#project-restrictions) guide for more information.

- Does the pipeline meet the requirements of any expression restrictions set up for the context? See the [Expression Restrictions](https://circleci.com/docs/guides/security/contexts/#expression-restrictions) guide for more information.


## Use conditional logic in workflows

You may use a `when` clause (the inverse clause `unless` is also supported) under a workflow declaration with a [Logic Statements](https://circleci.com/docs/reference/configuration-reference/#logic-statements) to determine whether or not to run that workflow.

Workflows are always run unless there is a `when` or `unless` filter that prevents the workflow from being run. If you want a workflow to run in **every** pipeline, do **not** add a when or unless filter.

The example configuration below uses a pipeline parameter, `run_integration_tests` to drive the `integration_tests` workflow.

```
version: 2.1

parameters:
  run_integration_tests:
    type: boolean
    default: false

workflows:
  integration_tests:
    when: << pipeline.parameters.run_integration_tests >>
    jobs:
      - mytestjob

jobs:
```

yaml

This example prevents the workflow `integration_tests` from running unless the `run_integration_tests` pipeline parameter is `true`. For example, when the pipeline is triggered with the following in the `POST` body:

```
{
    "parameters": {
        "run_integration_tests": true
    }
}
```

json

For more examples of using conditional logic in your workflows, see the [Orchestration Cookbook](https://circleci.com/docs/guides/orchestrate/orchestration-cookbook/).

If you want to conditionally run workflows based on trigger event types, consider splitting your workflows into separate YAML files and leveraging GitHub trigger event options.

For further details see the following guides:

- [Set up Multiple Configuration Files for a Project](https://circleci.com/docs/guides/orchestrate/set-up-multiple-configuration-files-for-a-project/).

- [GitHub Trigger Event Options](https://circleci.com/docs/guides/orchestrate/github-trigger-event-options/).


## Using filters in your workflows

Filters control which branches or tags trigger specific jobs in your workflows. Use filters to run different sets of jobs for development branches versus production tags, or to limit expensive jobs to specific branches. The following sections provide examples for using filters in your workflows to manage job execution.

You can filter workflows by branch, git tag, or neither. Workflow filters for branches and tags have the keys `only` and `ignore`:

- Any branches/tags that match `only` will run the job.

- Any branches/tags that match `ignore` will not run the job.

- If neither `only` nor `ignore` are specified then the job is skipped for all branches/tags.

- If both `only` and `ignore` are specified the `only` is considered before `ignore`.


If **both branch and tag** filtering is configured and a push to your code includes both branch and tag information, the **branch** filters take precedence. In this scenario, if there are no branch filters configured, tag `ignore` filters are used, if they exist.

### Branch-level job execution

The following example has one workflow that is configured to run different sets of jobs for different branches:

- The `test_dev` job is run on the `dev` branch and any branch that begins `user-`.

- The `test_stage` job is run on the `stage` branch.

- The `test_pre-prod` job is run on any branch starting `pre-prod` including any suffix added to the branch name using a hyphen.


|     |     |
| --- | --- |
|  | Workflows ignore `branches` keys used in the `jobs` declaration. If you use the deprecated [Job-level Branches Key](https://circleci.com/docs/reference/configuration-reference/#branches), replace them with workflow filters. |

|     |     |
| --- | --- |
|  | This example shows how to provide strings and lists of strings when configuring workflow filters. |

```
workflows:
  dev_stage_pre-prod:
    jobs:
      - test_dev:
          filters:  # using regex filters requires the entire branch to match
            branches:
              only:  # only branches matching the below regex filters will run
                - dev
                - /user-.*/
      - test_stage:
          filters:
            branches:
              only: stage
      - test_pre-prod:
          filters:
            branches:
              only: /pre-prod(?:-.+)?$/
```

yaml

This setup can be illustrated as follows:

![Branch-Level Job Execution](https://circleci.com/docs/guides/_images/branch_level.png)

Figure 6. Branch-Level Job Execution

For more information on regular expressions, see the [Using Regular Expressions to Filter Tags And Branches](https://circleci.com/docs/guides/orchestrate/workflows/#using-regular-expressions-to-filter-tags-and-branches) section below.

For a full example of workflows, see the [configuration file](https://github.com/CircleCI-Public/circleci-demo-workflows/blob/sequential-branch-filter/.circleci/config.yml) for the Sample Sequential Workflow With Branching project.

### Executing workflows for a git tag

|     |     |
| --- | --- |
|  | Webhook payloads are capped at 25 MB and for some events a maximum of 3 tags. If you push several tags at once, CircleCI may not receive them all. |

CircleCI does not run workflows for tags unless you explicitly specify tag filters using regular expressions. Both lightweight and annotated tags are supported.

If you have configured a job to run on a git tag you must also specify tag filters for any dependent jobs. Use [regular expressions](https://circleci.com/docs/guides/orchestrate/workflows/#using-regular-expressions-to-filter-tags-and-branches) to specify tag filters for a job.

* * *

In the example below, two workflows are defined:

- `untagged-build` runs the `build` job for all branches.

- `tagged-build` runs `build` for all branches **and** all tags starting with `v`.


```
workflows:
  untagged-build:
    jobs:
      - build
  tagged-build:
    jobs:
      - build:
          filters:
            tags:
              only: /^v.*/
```

yaml

* * *

In the example below, two jobs are configured within the `build-deploy` workflow:

- The `build` job runs for all branches and all tags.

- The `deploy` job runs for all branches and only for tags starting with 'v'.


```
workflows:
  build-deploy:
    jobs:
      - build:
          filters:  # required since `deploy` has tag filters AND requires `build`
            tags:
              only: /.*/
      - deploy:
          requires:
            - build
          filters:
            tags:
              only: /^v.*/
```

yaml

* * *

In the example below, three jobs are configured for the `build-test-deploy` workflow:

- The `build` job runs for all branches and only tags starting with 'config-test'.

- The `test` job runs once the `build` job completes for all branches and only tags starting with 'config-test'.

- The `deploy` job runs once the `test` job completes for no branches and only tags starting with 'config-test'.


```
workflows:
  build-test-deploy:
    jobs:
      - build:
          filters:  # required since `test` has tag filters AND requires `build`
            tags:
              only: /^config-test.*/
      - test:
          requires:
            - build
          filters:  # required since `deploy` has tag filters AND requires `test`
            tags:
              only: /^config-test.*/
      - deploy:
          requires:
            - test
          filters:
            tags:
              only: /^config-test.*/
            branches:
              ignore: /.*/
```

yaml

* * *

In the example below, two jobs are defined (`test` and `deploy`) and three workflows use those jobs:

- The `build` workflow runs for all branches except `main` and is not run on tags.

- The `staging` workflow will only run on the `main` branch and is not run on tags.

- The `production` workflow runs for no branches and only for tags starting with `v.`.


```
workflows:
  build: # This workflow will run on all branches except 'main' and will not run on tags
    jobs:
      - test:
          filters:
            branches:
              ignore: main
  staging: # This workflow will only run on 'main' and will not run on tags
    jobs:
      - test:
          filters: &filters-staging # this yaml anchor is setting these values to "filters-staging"
            branches:
              only: main
      - deploy:
          requires:
            - test
          filters:
            <<: *filters-staging # this is calling the previously set yaml anchor
  production: # This workflow will only run on tags (specifically starting with 'v.') and will not run on branches
    jobs:
      - test:
          filters: &filters-production # this yaml anchor is setting these values to "filters-production"
            branches:
              ignore: /.*/
            tags:
              only: /^v.*/
      - deploy:
          requires:
            - test
          filters:
            <<: *filters-production # this is calling the previously set yaml anchor
```

yaml

### Using regular expressions to filter tags and branches

CircleCI branch and tag filters support the Java variant of regex pattern matching. When writing filters, CircleCI matches exact regular expressions.

For example, `only: /^config-test/` only matches the `config-test` tag. To match all tags starting with `config-test`, use `only: /^config-test.*/` instead.

Using tags for semantic versioning is a common use case. To match patch versions 3-7 of a 2.1 release, you can write `/^version-2\.1\.[3-7]/`.

For full details on pattern-matching rules, see the [`java.util.regex` documentation](https://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html).

## Using workspaces to share data between jobs

Each workflow has an associated [Workspace](https://circleci.com/docs/reference/configuration-reference/#persisttoworkspace) for transferring files to downstream jobs as a workflow progresses.

Configuration options are available to:

- Persist files to the workspace using the [Workspace](https://circleci.com/docs/reference/configuration-reference/#persisttoworkspace) key.





```
- persist_to_workspace:
    root: /tmp/workspace
    paths:
      - target/application.jar
      - build/*
```

yaml

- Attach a workflow’s [Workspace](https://circleci.com/docs/reference/configuration-reference/#attachworkspace) to a container.





```
- attach_workspace:
    at: /tmp/workspace
```

yaml

For further information on workspaces and their configuration see the [Using Workspaces to Share Data Between Jobs](https://circleci.com/docs/guides/orchestrate/workspaces/) doc.

## Rerunning a workflow’s failed jobs

Workflows help to speed up your ability to respond to failures. One way to do this is to only rerun failed jobs rather than a whole workflow.

The steps detailed in this section show how to manually rerun only a workflow’s failed jobs. You can also set up automatic reruns for failed jobs. For more information, see the [Automatic Reruns](https://circleci.com/docs/guides/orchestrate/automatic-reruns/) page.

To rerun only a workflow’s failed jobs, follow these steps:

1. In the [CircleCI web app](https://app.circleci.com/home/) select your organization.

2. Select **Pipelines** in the sidebar.

3. Use the filters to find your project and pipeline.

4. Find the row in the pipeline view for the workflow you would like to rerun from failed and select the **Rerun from failed** icon. This option is also available in the workflow view using the rerun dropdown menu, which you can access by clicking on the workflow name or badge.


- Rerun from the pipelines page

- Rerun from the workflows page


![Rerun a workflow from failed from the pipelines page](https://circleci.com/docs/guides/_images/orchestrate-and-trigger/rerun-from-failed-pipelines-page.png)

Figure 7. Rerun a workflow from failed from the pipelines page

![Rerun a workflow from failed from the workflows page](https://circleci.com/docs/guides/_images/orchestrate-and-trigger/rerun-from-failed-workflows-page.png)

Figure 8. Rerun a workflow from failed from the workflows page

|     |     |
| --- | --- |
|  | If you rerun a workflow containing a job that was previously re-run with SSH, the new workflow runs with SSH enabled for that job, even after SSH capability is disabled at the project level. |

### Rerun limit

Individual workflows in a pipeline have a hard limit of 100 reruns. This limit includes reruns of reruns. If you reach this limit for a workflow in a pipeline you will need to trigger a new pipeline to rerun the workflow.

## Workflow states

The following state diagram shows the possible states and transitions of a workflow:

stateDiagram-v2
\[\*\] --\> running

running --> success

running --> failing

running --> on\_hold
on\_hold --> canceled
on\_hold --> running : approval job
on\_hold --> success

running --> canceled
failing --> failed
failing --> canceled

running --> failed
running --> error
running --> unauthorized

running --> queued
queued --> running: queued as part of a serial group

success --> \[\*\]
canceled --> \[\*\]
failed --> \[\*\]
error --> \[\*\]
unauthorized --> \[\*\]

Figure 9. CircleCI Cloud workflow states

stateDiagram-v2
\[\*\] --\> running

running --> success

running --> failing

running --> on\_hold
on\_hold --> canceled
on\_hold --> running : approval job
on\_hold --> success

running --> canceled
failing --> failed
failing --> canceled

running --> failed
running --> error
running --> not\_run
running --> unauthorized

running --> queued
queued --> running: queued as part of a serial group

success --> \[\*\]
canceled --> \[\*\]
failed --> \[\*\]
error --> \[\*\]
unauthorized --> \[\*\]
not\_run --> \[\*\]

Figure 10. CircleCI Server workflow states

Workflows may have one of the following states:

| State | Description | Terminal state |
| --- | --- | --- |
| RUNNING | Workflow is in progress | No |
| CANCELED | Workflow canceled before it finished | Yes |
| FAILING | A job in the workflow failed, but others are still running or yet to be approved | No |
| FAILED | One or more jobs in the workflow failed | Yes |
| SUCCESS | All jobs in the workflow completed successfully | Yes |
| NEEDS APPROVAL (UI) / ON HOLD | A job in the workflow is waiting for approval | No |
| ERROR | We experienced an internal error starting a job in the workflow | Yes |
| UNAUTHORIZED | One or more of the jobs terminated with a `unauthorized` job status. The user who triggered the pipeline or approved an approval job does not have access to a required restricted context. | Yes |
| QUEUED | The workflow is queued due to being part of a serial group. For more information, see the [Controlling Serial Execution Across Your Organization](https://circleci.com/docs/guides/orchestrate/controlling-serial-execution-across-your-organization/) guide. | No |

|     |     |
| --- | --- |
|  | After 90 days non-terminal workflows are automatically canceled by CircleCI. |

## Troubleshooting

This section describes common problems and solutions for workflows.

### What happens if I do not configure any workflows in my configuration file?

We recommend you configure at least one workflow in your configuration file. If you do not configure any workflows and you have a single job named `build`, an implicit workflow is generated and used for you.

If you have a working configuration with a single job named `build` and you then configure a scheduled workflow, for example, the implicit workflow is no longer run. If you want to build on every pipeline trigger as well as on the schedule in this case, you must add a (non-scheduled) workflow to your configuration file.

### Workflow and subsequent jobs do not trigger

If you do not see your workflows running, check for configuration errors that may be preventing the workflow from starting. Navigate to your [project’s pipelines](https://app.circleci.com/pipelines/) and find your workflow name to locate the failure.

### Rerunning workflows fails

Failures may happen before a workflow runs during pipeline processing. Re-running the workflow in this case will fail. Push a change to the project repository or use the trigger pipeline option to rerun the pipeline.

|     |     |
| --- | --- |
|  | You cannot rerun jobs and workflows that are >= 90 days. |

### Workflows waiting for status in GitHub

If you have workflows configured on a protected branch and the status check never completes, check the `ci/circleci` status key. `ci/circleci` is related to a deprecated check and must be deselected.

![Uncheck GitHub Status Keys](https://circleci.com/docs/guides/_images/github_branches_status.png)

Figure 11. Uncheck GitHub Status Keys

Go to **Settings** **Branches** in GitHub and select **Edit** on the protected branch to deselect the settings, for example: `https://github.com/your-org/project/settings/branches`.

## See also

- See the [Workflows](https://circleci.com/docs/reference/faq/#workflows) section of the FAQ.

- For workflow configuration examples, see the [CircleCI Demo Workflows](https://github.com/CircleCI-Public/circleci-demo-workflows) page on GitHub.


### On This Page

- [Workflow capabilities and benefits](https://circleci.com/docs/guides/orchestrate/workflows/#overview)
- [Workflows configuration examples](https://circleci.com/docs/guides/orchestrate/workflows/#workflows-configuration-examples)
- [Concurrent job execution](https://circleci.com/docs/guides/orchestrate/workflows/#concurrent-job-execution)
- [Sequential job execution](https://circleci.com/docs/guides/orchestrate/workflows/#sequential-job-execution)
- [Fan-out/fan-in workflow](https://circleci.com/docs/guides/orchestrate/workflows/#fan-outfan-in-workflow)
- [Flexible job dependency](https://circleci.com/docs/guides/orchestrate/workflows/#flexible-job-dependency)
- [Ignore the outcome of an upstream job](https://circleci.com/docs/guides/orchestrate/workflows/#ignore-the-outcome-of-an-upstream-job)
- [Run a command when the previous job is cancelled](https://circleci.com/docs/guides/orchestrate/workflows/#run-a-command-when-the-previous-job-is-cancelled)
- [Hold a workflow for a manual approval](https://circleci.com/docs/guides/orchestrate/workflows/#holding-a-workflow-for-a-manual-approval)
- [Configure an approval job](https://circleci.com/docs/guides/orchestrate/workflows/#configure-an-approval-job)
- [Approve a job](https://circleci.com/docs/guides/orchestrate/workflows/#approve-a-job)
- [Identify the user who approved a job](https://circleci.com/docs/guides/orchestrate/workflows/#identify-the-user-who-approved-a-job)
- [Cancel a job](https://circleci.com/docs/guides/orchestrate/workflows/#cancel-a-job)
- [Scheduling a workflow](https://circleci.com/docs/guides/orchestrate/workflows/#scheduling-a-workflow)
- [Example: Build every night](https://circleci.com/docs/guides/orchestrate/workflows/#nightly-example)
- [Schedule requirements and syntax](https://circleci.com/docs/guides/orchestrate/workflows/#specifying-a-valid-schedule)
- [Scheduling and dynamic configuration](https://circleci.com/docs/guides/orchestrate/workflows/#scheduling-and-dynamic-configuration)
- [Scheduled workflows and billing](https://circleci.com/docs/guides/orchestrate/workflows/#scheduled-workflows-and-billing)
- [Using contexts to share and secure environment variables](https://circleci.com/docs/guides/orchestrate/workflows/#using-job-contexts-to-share-environment-variables)
- [Use conditional logic in workflows](https://circleci.com/docs/guides/orchestrate/workflows/#use-conditional-logic-in-workflows)
- [Using filters in your workflows](https://circleci.com/docs/guides/orchestrate/workflows/#using-filters-in-your-workflows)
- [Branch-level job execution](https://circleci.com/docs/guides/orchestrate/workflows/#branch-level-job-execution)
- [Executing workflows for a git tag](https://circleci.com/docs/guides/orchestrate/workflows/#executing-workflows-for-a-git-tag)
- [Using regular expressions to filter tags and branches](https://circleci.com/docs/guides/orchestrate/workflows/#using-regular-expressions-to-filter-tags-and-branches)
- [Using workspaces to share data between jobs](https://circleci.com/docs/guides/orchestrate/workflows/#using-workspaces-to-share-data-between-jobs)
- [Rerunning a workflow’s failed jobs](https://circleci.com/docs/guides/orchestrate/workflows/#rerunning-a-workflows-failed-jobs)
- [Rerun limit](https://circleci.com/docs/guides/orchestrate/workflows/#rerun-limit)
- [Workflow states](https://circleci.com/docs/guides/orchestrate/workflows/#states)
- [Troubleshooting](https://circleci.com/docs/guides/orchestrate/workflows/#troubleshooting)
- [What happens if I do not configure any workflows in my configuration file?](https://circleci.com/docs/guides/orchestrate/workflows/#what-happens-if-i-do-not-configure-any-workflows-in-my-configuration-file)
- [Workflow and subsequent jobs do not trigger](https://circleci.com/docs/guides/orchestrate/workflows/#workflow-and-subsequent-jobs-do-not-trigger)
- [Rerunning workflows fails](https://circleci.com/docs/guides/orchestrate/workflows/#rerunning-workflows-fails)
- [Workflows waiting for status in GitHub](https://circleci.com/docs/guides/orchestrate/workflows/#workflows-waiting-for-status-in-github)
- [See also](https://circleci.com/docs/guides/orchestrate/workflows/#see-also)

#### Suggest an edit to this page

- [Make a contribution](https://github.com/circleci/circleci-docs/edit/main/docs/guides/modules/orchestrate/pages/workflows.adoc)
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

    - [Concepts](https://circleci.com/docs/guides/about-circleci/concepts/)

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

      - Workflow orchestration

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

reCAPTCHA