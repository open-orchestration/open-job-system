[HTCondor Manual](https://htcondor.readthedocs.io/en/latest/index.html)

latest

25.x

25.0

24.x

24.0

23.0

v9\_0

v8\_8

v10\_0

main

lts


Quick start guides

- [Users’ Quick Start Guide](https://htcondor.readthedocs.io/en/latest/users-manual/quick-start-guide.html)
- [Downloading and Installing](https://htcondor.readthedocs.io/en/latest/getting-htcondor/index.html)
- [Overview](https://htcondor.readthedocs.io/en/latest/overview/index.html)

Reference Manuals

- [Users’ Manual](https://htcondor.readthedocs.io/en/latest/users-manual/index.html#)
  - [Introduction to HTCondor](https://htcondor.readthedocs.io/en/latest/users-manual/welcome-to-htcondor.html)
  - [Running a Job: the Steps To Take](https://htcondor.readthedocs.io/en/latest/users-manual/running-a-job-steps.html)
  - [Submitting a Job](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html)
  - [Submitting Jobs Without a Shared File System: HTCondor’s File Transfer Mechanism](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html)
  - [Managing a Job](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html)
  - [Automatically managing a job](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html)
  - [Troubleshooting HTCondor Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/troubleshooting.html)
  - [Choosing an HTCondor Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html)
  - [Environment and services for a running job](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html)
  - [Job Scheduling](https://htcondor.readthedocs.io/en/latest/users-manual/job-scheduling.html)
  - [Job Sets](https://htcondor.readthedocs.io/en/latest/users-manual/job-sets.html)
  - [Self-Checkpointing Applications](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html)
  - [Submitting to a Remote AP](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-remote-job.html)
  - [Chirp: custom updates to the AP](https://htcondor.readthedocs.io/en/latest/users-manual/chirp.html)
  - [Special Environment Considerations](https://htcondor.readthedocs.io/en/latest/users-manual/special-environment-considerations.html)
  - [Bringing Your Own Resources](https://htcondor.readthedocs.io/en/latest/users-manual/bringing-your-own-resources.html)
- [Administrators’ Manual](https://htcondor.readthedocs.io/en/latest/admin-manual/index.html)
- [ClassAds](https://htcondor.readthedocs.io/en/latest/classads/index.html)
- [DAGMan Workflows](https://htcondor.readthedocs.io/en/latest/automated-workflows/index.html)
- [Python Bindings](https://htcondor.readthedocs.io/en/latest/apis/python-bindings/index.html)

Additional Docs

- [Cloud Computing](https://htcondor.readthedocs.io/en/latest/cloud-computing/index.html)
- [Grid Computing](https://htcondor.readthedocs.io/en/latest/grid-computing/index.html)
- [Platform-Specific Information](https://htcondor.readthedocs.io/en/latest/platform-specific/index.html)
- [Recipes, Examples, and Other Answers](https://htcondor.readthedocs.io/en/latest/faq/index.html)
- [Version History and Release Notes](https://htcondor.readthedocs.io/en/latest/version-history/index.html)

Reference, Glossary and Index

- [Commands Reference (man pages)](https://htcondor.readthedocs.io/en/latest/man-pages/index.html)
- [ClassAd Attributes](https://htcondor.readthedocs.io/en/latest/classad-attributes/index.html)
- [Codes and Other Needed Values](https://htcondor.readthedocs.io/en/latest/codes-other-values/index.html)
- [Glossary](https://htcondor.readthedocs.io/en/latest/codes-other-values/glossary.html)
- [Index](https://htcondor.readthedocs.io/en/latest/genindex.html)

[HTCondor Manual](https://htcondor.readthedocs.io/en/latest/index.html)

- [Home](https://htcondor.readthedocs.io/en/latest/index.html)
- Users’ Manual
- [Edit on GitHub](https://github.com/htcondor/htcondor/blob/main/docs/users-manual/index.rst)

* * *

# Users’ Manual [](https://htcondor.readthedocs.io/en/latest/users-manual/index.html\#users-manual "Link to this heading")

- [Introduction to HTCondor](https://htcondor.readthedocs.io/en/latest/users-manual/welcome-to-htcondor.html)
- [Running a Job: the Steps To Take](https://htcondor.readthedocs.io/en/latest/users-manual/running-a-job-steps.html)
- [Submitting a Job](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html)
  - [Sample submit description files](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#sample-submit-description-files)
  - [Submitting many similar jobs with one queue command](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#submitting-many-similar-jobs-with-one-queue-command)
  - [Variables in the Submit Description File](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#variables-in-the-submit-description-file)
  - [Including Submit Commands Defined Elsewhere](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#including-submit-commands-defined-elsewhere)
  - [Using Conditionals in the Submit Description File](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#using-conditionals-in-the-submit-description-file)
  - [Function Macros in the Submit Description File](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#function-macros-in-the-submit-description-file)
  - [About Requirements and Rank](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#about-requirements-and-rank)
  - [Submitting Jobs Using a Shared File System](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#submitting-jobs-using-a-shared-file-system)
  - [Jobs That Require Credentials](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#jobs-that-require-credentials)
  - [Jobs That Require GPUs](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#jobs-that-require-gpus)
  - [Interactive Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#interactive-jobs)
  - [Submitting Lots of Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#submitting-lots-of-jobs)
  - [Heterogeneous Submit: Execution on Differing Architectures](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html#heterogeneous-submit-execution-on-differing-architectures)
- [Submitting Jobs Without a Shared File System: HTCondor’s File Transfer Mechanism](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html)
  - [Specifying If and When to Transfer Files](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html#specifying-if-and-when-to-transfer-files)
  - [Specifying What Files to Transfer](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html#specifying-what-files-to-transfer)
  - [File Paths for File Transfer](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html#file-paths-for-file-transfer)
  - [Dataflow Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html#dataflow-jobs)
  - [Public Input Files](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html#public-input-files)
  - [Behavior for Error Cases](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html#behavior-for-error-cases)
  - [File Transfer Using a URL](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html#file-transfer-using-a-url)
- [Managing a Job](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html)
  - [Checking on the progress of jobs](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#checking-on-the-progress-of-jobs)
  - [Peeking in on a running job’s output files](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#peeking-in-on-a-running-job-s-output-files)
  - [Starting an interactive shell next to a running job on a remote machine](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#starting-an-interactive-shell-next-to-a-running-job-on-a-remote-machine)
  - [Removing a job from the queue](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#removing-a-job-from-the-queue)
  - [Placing a job on hold](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#placing-a-job-on-hold)
  - [Changing the priority of jobs](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#changing-the-priority-of-jobs)
  - [Job in the Hold State](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#job-in-the-hold-state)
  - [In the Job Event Log File](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#in-the-job-event-log-file)
  - [Job Termination](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#job-termination)
  - [Job Completion](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#job-completion)
  - [Summary of all HTCondor users and their jobs](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html#summary-of-all-htcondor-users-and-their-jobs)
- [Automatically managing a job](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html)
  - [Automatically rerunning a failed job](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html#automatically-rerunning-a-failed-job)
  - [Automatically rerunning a job that used too much memory](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html#automatically-rerunning-a-job-that-used-too-much-memory)
  - [Automatically removing a job in the queue](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html#automatically-removing-a-job-in-the-queue)
  - [Automatically placing a job on hold](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html#automatically-placing-a-job-on-hold)
  - [Automatically releasing a held job](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html#automatically-releasing-a-held-job)
  - [Automatically evicting a running job](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html#automatically-evicting-a-running-job)
  - [Holding a completed job](https://htcondor.readthedocs.io/en/latest/users-manual/automatic-job-management.html#holding-a-completed-job)
- [Troubleshooting HTCondor Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/troubleshooting.html)
  - [How To Debug a Held Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/troubleshooting.html#how-to-debug-a-held-jobs)
  - [How To Debug an Always Idle Job](https://htcondor.readthedocs.io/en/latest/users-manual/troubleshooting.html#how-to-debug-an-always-idle-job)
- [Choosing an HTCondor Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html)
  - [Vanilla Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#vanilla-universe)
  - [Grid Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#grid-universe)
  - [Java Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#java-universe)
  - [Scheduler Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#scheduler-universe)
  - [Local Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#local-universe)
  - [Parallel Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#parallel-universe)
  - [VM Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#vm-universe)
  - [Docker Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#docker-universe)
  - [Container Universe](https://htcondor.readthedocs.io/en/latest/users-manual/choosing-an-htcondor-universe.html#container-universe)
- [Environment and services for a running job](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html)
  - [Services for Running Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html#services-for-running-jobs)
  - [Container Universe Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html#container-universe-jobs)
  - [Docker Universe Applications](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html#docker-universe-applications)
  - [Virtual Machine Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html#virtual-machine-jobs)
  - [Parallel Jobs (Including MPI Jobs)](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html#parallel-jobs-including-mpi-jobs)
  - [Java jobs](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html#java-jobs)
  - [NFS](https://htcondor.readthedocs.io/en/latest/users-manual/env-of-job.html#nfs)
- [Job Scheduling](https://htcondor.readthedocs.io/en/latest/users-manual/job-scheduling.html)
  - [Priorities and Preemption](https://htcondor.readthedocs.io/en/latest/users-manual/job-scheduling.html#priorities-and-preemption)
  - [Time Scheduling for Job Execution](https://htcondor.readthedocs.io/en/latest/users-manual/job-scheduling.html#time-scheduling-for-job-execution)
  - [Matchmaking with ClassAds](https://htcondor.readthedocs.io/en/latest/users-manual/job-scheduling.html#matchmaking-with-classads)
- [Job Sets](https://htcondor.readthedocs.io/en/latest/users-manual/job-sets.html)
  - [Submitting a job set](https://htcondor.readthedocs.io/en/latest/users-manual/job-sets.html#submitting-a-job-set)
  - [Listing job sets](https://htcondor.readthedocs.io/en/latest/users-manual/job-sets.html#listing-job-sets)
  - [Checking on the progress of job sets](https://htcondor.readthedocs.io/en/latest/users-manual/job-sets.html#checking-on-the-progress-of-job-sets)
  - [Removing a job set](https://htcondor.readthedocs.io/en/latest/users-manual/job-sets.html#removing-a-job-set)
- [Self-Checkpointing Applications](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html)
  - [How To Run Self-Checkpointing Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html#how-to-run-self-checkpointing-jobs)
  - [Requirements](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html#requirements)
  - [Using checkpoint\_exit\_code](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html#using-checkpoint-exit-code)
  - [How Frequently to Checkpoint](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html#how-frequently-to-checkpoint)
  - [Debugging Self-Checkpointing Jobs](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html#debugging-self-checkpointing-jobs)
  - [Working Around the Assumptions](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html#working-around-the-assumptions)
  - [Other Options](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html#other-options)
  - [Signals](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html#signals)
- [Submitting to a Remote AP](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-remote-job.html)
  - [Submitting a job to a remote Access Point](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-remote-job.html#submitting-a-job-to-a-remote-access-point)
  - [File transfer with remote submission](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-remote-job.html#file-transfer-with-remote-submission)
- [Chirp: custom updates to the AP](https://htcondor.readthedocs.io/en/latest/users-manual/chirp.html)
- [Special Environment Considerations](https://htcondor.readthedocs.io/en/latest/users-manual/special-environment-considerations.html)
  - [Job Leases](https://htcondor.readthedocs.io/en/latest/users-manual/special-environment-considerations.html#job-leases)
- [Bringing Your Own Resources](https://htcondor.readthedocs.io/en/latest/users-manual/bringing-your-own-resources.html)
  - [Recipes](https://htcondor.readthedocs.io/en/latest/users-manual/bringing-your-own-resources.html#recipes)
  - [`htcondor annex` Overview](https://htcondor.readthedocs.io/en/latest/users-manual/bringing-your-own-resources.html#htcondor-annex-overview)
  - [Details](https://htcondor.readthedocs.io/en/latest/users-manual/bringing-your-own-resources.html#details)

[Previous](https://htcondor.readthedocs.io/en/latest/overview/support-downloads-bug-reports.html "Support, Downloads and Bug Reporting") [Next](https://htcondor.readthedocs.io/en/latest/users-manual/welcome-to-htcondor.html "Introduction to HTCondor")

* * *

© Copyright 1990-2026, Center for High Throughput Computing, Computer Sciences Department, University of Wisconsin-Madison, Madison, WI, US. Licensed under the Apache License, Version 2.0..

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org/).


![Read the Docs](<Base64-Image-Removed>)latest
Versions**[latest](https://htcondor.readthedocs.io/en/latest/users-manual/)**[25.x](https://htcondor.readthedocs.io/en/25.x/users-manual/)[25.0](https://htcondor.readthedocs.io/en/25.0/users-manual/)[24.x](https://htcondor.readthedocs.io/en/24.x/users-manual/)[24.0](https://htcondor.readthedocs.io/en/24.0/users-manual/)[23.0](https://htcondor.readthedocs.io/en/23.0/users-manual/)[v9\_0](https://htcondor.readthedocs.io/en/v9_0/users-manual/)[v8\_8](https://htcondor.readthedocs.io/en/v8_8/users-manual/)[v10\_0](https://htcondor.readthedocs.io/en/v10_0/users-manual/)[main](https://htcondor.readthedocs.io/en/main/users-manual/)[lts](https://htcondor.readthedocs.io/en/lts/users-manual/)Downloads[PDF](https://htcondor.readthedocs.io/_/downloads/en/latest/pdf/)[HTML](https://htcondor.readthedocs.io/_/downloads/en/latest/htmlzip/)[EPUB](https://htcondor.readthedocs.io/_/downloads/en/latest/epub/)On Read the Docs[Project Home](https://app.readthedocs.org/projects/htcondor/?utm_source=htcondor&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/htcondor/builds/?utm_source=htcondor&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=htcondor&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=htcondor&utm_content=flyout)