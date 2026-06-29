[Skip to main content](https://docs.gitlab.com/ci/#skipTarget) [Go to GitLab Docs homepage](https://docs.gitlab.com/)

`/`

[What's new?](https://about.gitlab.com/releases/whats-new/)

English

- Language
- English
- 日本語

v19.1

- [19.1 (not yet released)](https://docs.gitlab.com/ci/)
- [19.0 (recently released)](https://docs.gitlab.com/19.0/ci/)
- [18.11](https://docs.gitlab.com/18.11/ci/)
- [18.10](https://archives.docs.gitlab.com/18.10/ci/)
- [18.11](https://docs.gitlab.com/18.11/ci/)
- [17.11](https://archives.docs.gitlab.com/17.11/ci/)
- [Archives](https://docs.gitlab.com/archives)

Select theme and layout

- Light mode
- Dark mode
- Auto

- Fixed width
- Fluid width

[What's new?](https://about.gitlab.com/releases/whats-new/) [Get free trial](https://gitlab.com/-/trial_registrations/new?glm_source=docs.gitlab.com&amp;glm_content=navigation-cta-docs)

Toggle menu

- [Use GitLab](https://docs.gitlab.com/user/)
- [GitLab Duo](https://docs.gitlab.com/user/gitlab_duo/)
- [Orbit](https://docs.gitlab.com/orbit/)
- [Extend](https://docs.gitlab.com/api/)
- [Install](https://docs.gitlab.com/install/)
- [Administer](https://docs.gitlab.com/administration/)
- [Subscribe](https://docs.gitlab.com/subscriptions/)
- [Contribute](https://docs.gitlab.com/development/)
- [Solutions](https://docs.gitlab.com/solutions/)

Select a topicUse GitLabGitLab DuoOrbitExtendInstallAdministerSubscribeContributeSolutions

[Getting started](https://docs.gitlab.com/user/get_started/)

[Tutorials](https://docs.gitlab.com/tutorials/)

[Manage your organization](https://docs.gitlab.com/topics/set_up_organization/)

[Organize work with projects](https://docs.gitlab.com/user/project/organize_work_with_projects/)

[Plan and track work](https://docs.gitlab.com/topics/plan_and_track/)

[Manage authentication and authorization](https://docs.gitlab.com/auth/)

[Use Git](https://docs.gitlab.com/topics/git/)

[Manage your code](https://docs.gitlab.com/topics/manage_code/)

[Use CI/CD to build your application](https://docs.gitlab.com/topics/build_your_application/)

[Getting started](https://docs.gitlab.com/ci/)

[Tutorials](https://docs.gitlab.com/tutorials/build_application/)

[CI/CD YAML syntax reference](https://docs.gitlab.com/ci/yaml/)

[Runners](https://docs.gitlab.com/ci/runners/)

[Pipelines](https://docs.gitlab.com/ci/pipelines/)

[Jobs](https://docs.gitlab.com/ci/jobs/)

[CI/CD components](https://docs.gitlab.com/ci/components/)

[CI/CD inputs](https://docs.gitlab.com/ci/inputs/)

[CI/CD variables](https://docs.gitlab.com/ci/variables/)

[Pipeline security](https://docs.gitlab.com/ci/pipeline_security/)

[GitLab Secrets Manager](https://docs.gitlab.com/ci/secrets/secrets_manager/)

[External secrets](https://docs.gitlab.com/ci/secrets/)

[Debugging](https://docs.gitlab.com/ci/debugging/)

[Auto DevOps](https://docs.gitlab.com/topics/autodevops/)

[Testing](https://docs.gitlab.com/ci/testing/)

[Google Cloud integration](https://docs.gitlab.com/ci/gitlab_google_cloud_integration/)

[Migrate to GitLab CI/CD](https://docs.gitlab.com/ci/migration/plan_a_migration/)

[External repository integrations](https://docs.gitlab.com/ci/ci_cd_for_external_repos/)

[Mobile DevOps](https://docs.gitlab.com/ci/mobile_devops/)

[Secure your application](https://docs.gitlab.com/user/application_security/secure_your_application/)

[Deploy and release your application](https://docs.gitlab.com/topics/release_your_application/)

[Manage your infrastructure](https://docs.gitlab.com/user/infrastructure/)

[Monitor your application](https://docs.gitlab.com/operations/)

[Analyze GitLab usage](https://docs.gitlab.com/user/analytics/)

[Release notes](https://docs.gitlab.com/releases/)

[Feature support](https://docs.gitlab.com/policy/development_stages_support/)

[Find your GitLab version](https://docs.gitlab.com/user/version/)

/

1. Show more breadcrumbs











   - [GitLab Docs](https://docs.gitlab.com/)
   - [Use GitLab](https://docs.gitlab.com/user/)
   - [Use CI/CD to build your …](https://docs.gitlab.com/topics/build_your_application/)

2. [Getting started](https://docs.gitlab.com/ci/)

* * *

# Get started with GitLab CI/CD

- Tier: Free, Premium, Ultimate
- Offering: GitLab.com, GitLab Self-Managed, GitLab Dedicated

CI/CD is a continuous method of software development, where you continuously build,
test, deploy, and monitor iterative code changes.

This iterative process helps reduce the chance that you develop new code based on
buggy or failed previous versions. GitLab CI/CD can catch bugs early in the development cycle,
and help ensure that the code deployed to production complies with your established code standards.

This process is part of a larger workflow:

![GitLab DevSecOps lifecycle with stages for Plan, Create, Verify, Secure, Release, and Monitor.](https://docs.gitlab.com/ci/img/get_started_cicd_v16_11.png)

## Step 1: Configure your pipeline [Permalink](https://docs.gitlab.com/ci/\#step-1-configure-your-pipeline "Permalink")

To use GitLab CI/CD, you start with a `.gitlab-ci.yml` file at the root of your project.
This file specifies the stages, jobs, and scripts to be executed during your CI/CD pipeline.
It is a YAML file with its own custom syntax.

The filename must be `.gitlab-ci.yml` and is case-sensitive, but you can [configure a different filename](https://docs.gitlab.com/ci/pipelines/settings/#specify-a-custom-cicd-configuration-file).

In this file, you define variables, dependencies between jobs, and specify when
and how each job should be executed.

A pipeline is defined in the `.gitlab-ci.yml` file,
and executes when the file runs on a runner.

Pipelines are made up of stages and jobs:

- Stages define the order of execution. Typical stages might be `build`, `test`, and `deploy`.
- Jobs specify the tasks to be performed in each stage. For example, a job can compile or test code.

Pipelines can be triggered by various events, like commits or merges, or can be on schedule.
In your pipeline, you can integrate with a wide range of tools and platforms.

For more information, see:

- [Tutorial: Create and run your first GitLab CI/CD pipeline](https://docs.gitlab.com/ci/quick_start/)
- [Pipelines](https://docs.gitlab.com/ci/pipelines/)

## Step 2: Find or create runners [Permalink](https://docs.gitlab.com/ci/\#step-2-find-or-create-runners "Permalink")

Runners are the agents that run your jobs. These agents can run on physical machines or virtual instances.
In your `.gitlab-ci.yml` file, you can specify a container image you want to use when running the job.
The runner loads the image, clones your project, and runs the job either locally or in the container.

If you use GitLab.com, runners on Linux, Windows, and macOS are already available for use.
If needed, you can also register your own runners.

If you don’t use GitLab.com, you can:

- Register runners or use runners already registered for your GitLab Self-Managed instance.
- Create a runner on your local machine.

For more information, see:

- [Create, register, and run your own project runner](https://docs.gitlab.com/tutorials/create_register_first_runner/)

## Step 3: Use CI/CD variables and expressions [Permalink](https://docs.gitlab.com/ci/\#step-3-use-cicd-variables-and-expressions "Permalink")

GitLab CI/CD variables are key-value pairs you use to store and pass configuration settings
and sensitive information, like passwords or API keys, to jobs in a pipeline.

GitLab CI/CD expressions allow you to inject data dynamically into your pipeline configuration.
The data available depends on the expression context.
For example, the `inputs` context allows you to access information passed into the
configuration file from a parent file or when a pipeline is run.

### CI/CD variables [Permalink](https://docs.gitlab.com/ci/\#cicd-variables "Permalink")

Use CI/CD variables to customize jobs by making values defined elsewhere accessible to jobs.
You can hard-code CI/CD variables in your `.gitlab-ci.yml` file, set them in your project settings,
or generate them dynamically. You can define them for the project, group, or instance.

The following types of variables are available:

- Custom variables: Variables that you create and manage in the UI, API, or configuration files.
- Predefined variables: Variables that GitLab automatically sets to provide information about the current job, pipeline, and environment.

You can configure variables with security settings:

- Protected variables: Restrict access to jobs running on protected branches or tags.
- Masked variables: Hide variable values in job logs to prevent sensitive information from being exposed.

For more information, see:

- [CI/CD variables](https://docs.gitlab.com/ci/variables/)

### CI/CD expressions [Permalink](https://docs.gitlab.com/ci/\#cicd-expressions "Permalink")

CI/CD expressions use the `$[[ ]]` syntax and are validated when you create a pipeline.
You can also validate expressions in the pipeline editor before committing changes.

Expressions enable dynamic configuration based on different contexts:

- **Inputs context** (`$[[ inputs.INPUT_NAME ]]`): Access typed parameters passed into configuration files with `include:inputs` or when a new pipeline is run
- **Matrix context** (`$[[ matrix.IDENTIFIER ]]`): Access matrix values in job dependencies to create 1:1 mappings between matrix jobs

For more information, see:

- [CI expressions](https://docs.gitlab.com/ci/yaml/expressions/)

## Step 4: Use CI/CD components [Permalink](https://docs.gitlab.com/ci/\#step-4-use-cicd-components "Permalink")

A CI/CD component is a reusable pipeline configuration unit.
Use a CI/CD component to compose an entire pipeline configuration or a small part of a larger pipeline.

You can add a component to your pipeline configuration with `include:component`.

Reusable components help reduce duplication, improve maintainability, and promote consistency across projects.
Create a component project and publish it to the CI/CD Catalog to share your component across multiple projects.

GitLab also has CI/CD component templates for common tasks and integrations.

For more information, see:

- [CI/CD components](https://docs.gitlab.com/ci/components/)

Was this page helpful?YesNo

Edit this page

- [View page sourceEdit this file only.](https://gitlab.com/gitlab-org/gitlab/-/blob/master/doc/ci/_index.md)
- [Open in Web IDEEdit multiple files.](https://gitlab.com/-/ide/project/gitlab-org/gitlab/edit/master/-/doc/ci/_index.md)
- [Create an issueSuggest improvements.](https://gitlab.com/gitlab-org/gitlab/-/issues/new?issuable_template=Documentation)

Copy for LLM

- [Step 1: Configure your pipeline](https://docs.gitlab.com/ci/#step-1-configure-your-pipeline)
- [Step 2: Find or create runners](https://docs.gitlab.com/ci/#step-2-find-or-create-runners)
- [Step 3: Use CI/CD variables and expressions](https://docs.gitlab.com/ci/#step-3-use-cicd-variables-and-expressions)
- [CI/CD variables](https://docs.gitlab.com/ci/#cicd-variables)
- [CI/CD expressions](https://docs.gitlab.com/ci/#cicd-expressions)
- [Step 4: Use CI/CD components](https://docs.gitlab.com/ci/#step-4-use-cicd-components)

[![GitLab Docs logo](https://docs.gitlab.com/gitlab-logo-footer.svg)](https://docs.gitlab.com/)

- [Facebook](https://www.facebook.com/gitlab)
- [LinkedIn](https://www.linkedin.com/company/gitlab-com)
- [Twitter](https://twitter.com/gitlab)
- [YouTube](https://www.youtube.com/channel/UCnMGQ8QHMAnVIsI3xJrihhg)

[![Creative Commons License](https://docs.gitlab.com/by-sa.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

Company

- [About GitLab](https://about.gitlab.com/company/)
- [View pricing](https://about.gitlab.com/pricing/)
- [Try GitLab for free](https://about.gitlab.com/free-trial/)

Feedback

- [View page source](https://gitlab.com/gitlab-org/gitlab/-/blob/master/doc/ci/_index.md)
- [Edit in Web IDE](https://gitlab.com/-/ide/project/gitlab-org/gitlab/edit/master/-/doc/ci/_index.md)
- [Contribute to GitLab](https://about.gitlab.com/community/contribute/)
- [Suggest updates](https://gitlab.com/gitlab-org/gitlab/-/issues/new?issuable_template=Documentation)

Help & Community

- [Get certified](https://university.gitlab.com/pages/certifications)
- [Get support](https://about.gitlab.com/support/)
- [Post on the GitLab forum](https://forum.gitlab.com/new-topic?title=topic%20title&body=topic%20body&tags=docs-feedback)

Resources

- [Terms](https://about.gitlab.com/terms/)
- [Privacy statement](https://about.gitlab.com/privacy/)
- [Use of generative AI](https://docs.gitlab.com/legal/use_generative_ai/)
- [Acceptable use of user licenses](https://docs.gitlab.com/legal/licensing_policy/)

reCAPTCHA

Recaptcha requires verification.

protected by **reCAPTCHA**