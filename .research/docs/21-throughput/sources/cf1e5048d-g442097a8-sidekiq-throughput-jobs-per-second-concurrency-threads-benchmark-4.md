[Skip to main content](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#skipTarget) [Go to GitLab Docs homepage](https://docs.gitlab.com/)
`/`
[What's new?](https://about.gitlab.com/releases/whats-new/)
English
  * Language
  * English
  * 日本語


v19.2
Select theme and layout
  * Light mode
  * Dark mode
  * Auto


  * Fixed width
  * Fluid width


[What's new?](https://about.gitlab.com/releases/whats-new/) [Get free trial](https://gitlab.com/-/trial_registrations/new?glm_source=docs.gitlab.com&amp;glm_content=navigation-cta-docs)
Toggle menu
  * [Use GitLab](https://docs.gitlab.com/user/)
  * [GitLab Duo](https://docs.gitlab.com/user/gitlab_duo/)
  * [Orbit](https://docs.gitlab.com/orbit/)
  * [Extend](https://docs.gitlab.com/api/)
  * [Install](https://docs.gitlab.com/install/)
  * [Administer](https://docs.gitlab.com/administration/)
  * [Subscribe](https://docs.gitlab.com/subscriptions/)
  * [Contribute](https://docs.gitlab.com/development/)
  * [Solutions](https://docs.gitlab.com/solutions/)


Select a topicUse GitLab GitLab Duo Orbit Extend Install Administer Subscribe Contribute Solutions
[Getting started](https://docs.gitlab.com/administration/get_started/)
[Configure GitLab](https://docs.gitlab.com/administration/configure/)
[Admin area](https://docs.gitlab.com/administration/admin_area/)
[GitLab Relay (KAS)](https://docs.gitlab.com/administration/clusters/kas/)
[Application cache interval](https://docs.gitlab.com/administration/application_settings_cache/)
[Cells](https://docs.gitlab.com/administration/cells/)
[CI/CD](https://docs.gitlab.com/administration/cicd/)
[ClickHouse for analytics](https://docs.gitlab.com/administration/analytics/)
[Consul](https://docs.gitlab.com/administration/consul/)
[Cron](https://docs.gitlab.com/topics/cron/)
[Custom HTML header tags](https://docs.gitlab.com/administration/custom_html_header_tags/)
[Environment variables](https://docs.gitlab.com/administration/environment_variables/)
[File hooks](https://docs.gitlab.com/administration/file_hooks/)
[Geo](https://docs.gitlab.com/administration/geo/)
[Disaster recovery (Geo)](https://docs.gitlab.com/administration/geo/disaster_recovery/)
[Geo sites](https://docs.gitlab.com/administration/geo_sites/)
[Git LFS administration](https://docs.gitlab.com/administration/lfs/)
[Git protocol v2](https://docs.gitlab.com/administration/git_protocol/)
[Health check](https://docs.gitlab.com/administration/monitoring/health_check/)
[Host the product documentation](https://docs.gitlab.com/administration/docs_self_host/)
[Incoming email](https://docs.gitlab.com/administration/incoming_email/)
[Instance limits](https://docs.gitlab.com/administration/instance_limits/)
[Instance review](https://docs.gitlab.com/administration/instance_review/)
[Invalidate Markdown cache](https://docs.gitlab.com/administration/invalidate_markdown_cache/)
[Issue closing pattern](https://docs.gitlab.com/administration/issue_closing_pattern/)
[Labels](https://docs.gitlab.com/administration/labels/)
[Load balancer](https://docs.gitlab.com/administration/load_balancer/)
[Log system](https://docs.gitlab.com/administration/logs/)
[Merge request approvals](https://docs.gitlab.com/administration/merge_requests_approvals/)
[Merge request diffs storage](https://docs.gitlab.com/administration/merge_request_diffs/)
[NFS](https://docs.gitlab.com/administration/nfs/)
[Object storage](https://docs.gitlab.com/administration/object_storage/)
[Packages](https://docs.gitlab.com/administration/packages/)
[Postfix](https://docs.gitlab.com/administration/reply_by_email_postfix_setup/)
[PostgreSQL](https://docs.gitlab.com/administration/postgresql/)
[Redis](https://docs.gitlab.com/administration/redis/)
[Reply by email](https://docs.gitlab.com/administration/reply_by_email/)
[Repository storage](https://docs.gitlab.com/administration/repository_storage_paths/)
[Secrets Manager](https://docs.gitlab.com/administration/secrets_manager/)
[Server hooks](https://docs.gitlab.com/administration/server_hooks/)
[Sidekiq](https://docs.gitlab.com/administration/sidekiq/)
[Multiple Sidekiq processes](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/)
[Processing specific job classes](https://docs.gitlab.com/administration/sidekiq/processing_specific_job_classes/)
[Configuration for imports](https://docs.gitlab.com/administration/sidekiq/configuration_for_imports/)
[Sidekiq MemoryKiller](https://docs.gitlab.com/administration/sidekiq/sidekiq_memory_killer/)
[Sidekiq health check](https://docs.gitlab.com/administration/sidekiq/sidekiq_health_check/)
[Sidekiq job migration](https://docs.gitlab.com/administration/sidekiq/sidekiq_job_migration/)
[Sidekiq job size limits](https://docs.gitlab.com/administration/settings/sidekiq_job_limits/)
[Troubleshooting](https://docs.gitlab.com/administration/sidekiq/sidekiq_troubleshooting/)
[Snippets](https://docs.gitlab.com/administration/snippets/)
[S/MIME signing](https://docs.gitlab.com/administration/smime_signing_email/)
[Static objects external storage](https://docs.gitlab.com/administration/static_objects_external_storage/)
[Terraform limits](https://docs.gitlab.com/administration/settings/terraform_limits/)
[Terraform state](https://docs.gitlab.com/administration/terraform_state/)
[Terraform state settings](https://docs.gitlab.com/administration/settings/terraform_state_settings/)
[Timezone](https://docs.gitlab.com/administration/timezone/)
[Uploads](https://docs.gitlab.com/administration/uploads/)
[Web terminals](https://docs.gitlab.com/administration/integration/terminal/)
[What's new](https://docs.gitlab.com/administration/whats-new/)
[Wikis](https://docs.gitlab.com/administration/wikis/)
[Configure GitLab Duo](https://docs.gitlab.com/administration/gitlab_duo/configure/)
[Update your settings](https://docs.gitlab.com/administration/settings/)
[Enable features behind feature flags](https://docs.gitlab.com/administration/feature_flags/)
[Maintain GitLab](https://docs.gitlab.com/administration/operations/)
[Monitor GitLab](https://docs.gitlab.com/administration/monitoring/)
[Secure GitLab](https://docs.gitlab.com/security/)
[Administer users](https://docs.gitlab.com/administration/administer_users/)
[Administer GitLab Dedicated](https://docs.gitlab.com/administration/dedicated/)
[Administer GitLab Runner](https://docs.gitlab.com/runner/)
/ 
  1. [GitLab Docs](https://docs.gitlab.com/)
  2. [Administer](https://docs.gitlab.com/administration/)
  3. [Configure GitLab](https://docs.gitlab.com/administration/configure/)
  4. [Sidekiq](https://docs.gitlab.com/administration/sidekiq/)
  5. [Multiple Sidekiq processes](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/)


* * *
# Run multiple Sidekiq processes
  * Tier: Free, Premium, Ultimate
  * Offering: GitLab Self-Managed


GitLab allows you to start multiple Sidekiq processes to process background jobs at a higher rate on a single instance. By default, Sidekiq starts one worker process and only uses a single core.
The information in this page applies only to Linux package installations.
## Start multiple processes[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#start-multiple-processes "Permalink")
When starting multiple processes, the number of processes should at most equal (and not exceed) the number of CPU cores you want to dedicate to Sidekiq. The Sidekiq worker process uses no more than one CPU core.
To start multiple processes, use the `sidekiq['queue_groups']` array setting to specify how many processes to create using `sidekiq-cluster` and which queues they should handle. Each item in the array equates to one additional Sidekiq process, and values in each item determine the queues it works on. In the vast majority of cases, all processes should listen to all queues (see [processing specific job classes](https://docs.gitlab.com/administration/sidekiq/processing_specific_job_classes/) for more details).
For example, to create four Sidekiq processes, each listening to all available queues:
  1. Edit `/etc/gitlab/gitlab.rb`:
ruby

```
sidekiq['queue_groups'] = ['*'] * 4
```

  2. Save the file and reconfigure GitLab:
shell

```
sudo gitlab-ctl reconfigure
```



To view the Sidekiq processes in GitLab:
  1. In the upper-right corner, select **Admin**.
  2. In the left sidebar, select **Monitoring** > **Background jobs**.


## Concurrency[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#concurrency "Permalink")
By default each process defined under `sidekiq` starts with a number of threads that equals the number of queues, plus one spare thread, up to a maximum of 50. For example, a process that handles all queues uses 50 threads by default.
These threads run inside a single Ruby process, and each process can only use a single CPU core. The usefulness of threading depends on the work having some external dependencies to wait on, like database queries or HTTP requests. Most Sidekiq deployments benefit from this threading.
## Database connection planning[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#database-connection-planning "Permalink")
Before increasing Sidekiq processes or concurrency, consider the database connection impact on your PostgreSQL `max_connections` setting.
For detailed connection planning and calculations, see the [Tune PostgreSQL](https://docs.gitlab.com/administration/postgresql/tune/) page.
### Manage thread counts explicitly[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#manage-thread-counts-explicitly "Permalink")
The correct maximum thread count (also called concurrency) depends on the workload. Typical values range from `5` for highly CPU-bound tasks to `15` or higher for mixed low-priority work. A reasonable starting range is `15` to `25` for a non-specialized deployment.
The values vary according to the work each specific deployment of Sidekiq does. Any other specialized deployments with processes dedicated to specific queues should have the concurrency tuned according to:
  * The CPU usage of each type of process.
  * The throughput achieved.


Each thread requires a Redis connection, so adding threads may increase Redis latency and potentially cause client timeouts. See the [Sidekiq documentation about Redis](https://github.com/mperham/sidekiq/wiki/Using-Redis) for more details.
#### Manage thread counts with concurrency field[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#manage-thread-counts-with-concurrency-field "Permalink")
History
  * [Introduced](https://gitlab.com/gitlab-org/gitlab/-/issues/439687) in GitLab 16.9.


In GitLab 16.9 and later, you can set the concurrency by setting `concurrency`. This value explicitly sets each process with this amount of concurrency.
For example, to set the concurrency to `20`:
  1. Edit `/etc/gitlab/gitlab.rb`:
ruby

```
sidekiq['concurrency'] = 20
```

  2. Save the file and reconfigure GitLab:
shell

```
sudo gitlab-ctl reconfigure
```



## Modify the check interval[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#modify-the-check-interval "Permalink")
To modify the Sidekiq health check interval for the additional Sidekiq processes:
  1. Edit `/etc/gitlab/gitlab.rb`:
ruby

```
sidekiq['interval'] = 5
```

The value can be any integer number of seconds.
  2. Save the file and reconfigure GitLab:
shell

```
sudo gitlab-ctl reconfigure
```



## Troubleshoot using the CLI[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#troubleshoot-using-the-cli "Permalink")
It’s recommended to use `/etc/gitlab/gitlab.rb` to configure the Sidekiq processes. If you experience a problem, you should contact GitLab support. Use the command line at your own risk.
For debugging purposes, you can start extra Sidekiq processes by using the command `/opt/gitlab/embedded/service/gitlab-rails/bin/sidekiq-cluster`. This command takes arguments using the following syntax:
shell

```
/opt/gitlab/embedded/service/gitlab-rails/bin/sidekiq-cluster [QUEUE,QUEUE,...] [QUEUE, ...]
```

The `--dryrun` argument allows viewing the command to be executed without actually starting it.
Each separate argument denotes a group of queues that have to be processed by a Sidekiq process. Multiple queues can be processed by the same process by separating them with a comma instead of a space.
Instead of a queue, a queue namespace can also be provided, to have the process automatically listen on all queues in that namespace without needing to explicitly list all the queue names. For more information about queue namespaces, see the relevant section in the Sidekiq development part of the GitLab development documentation.
### Monitor the `sidekiq-cluster` command[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#monitor-the-sidekiq-cluster-command "Permalink")
The `sidekiq-cluster` command does not terminate once it has started the desired amount of Sidekiq processes. Instead, the process continues running and forwards any signals to the child processes. This allows you to stop all Sidekiq processes as you send a signal to the `sidekiq-cluster` process, instead of having to send it to the individual processes.
If the `sidekiq-cluster` process crashes or receives a `SIGKILL`, the child processes terminate themselves after a few seconds. This ensures you don’t end up with zombie Sidekiq processes.
This allows you to monitor the processes by hooking up `sidekiq-cluster` to your supervisor of choice (for example, runit).
If a child process died the `sidekiq-cluster` command signals all remaining process to terminate, then terminate itself. This removes the need for `sidekiq-cluster` to re-implement complex process monitoring/restarting code. Instead you should make sure your supervisor restarts the `sidekiq-cluster` process whenever necessary.
### PID files[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#pid-files "Permalink")
The `sidekiq-cluster` command can store its PID in a file. By default no PID file is written, but this can be changed by passing the `--pidfile` option to `sidekiq-cluster`. For example:
shell

```
/opt/gitlab/embedded/service/gitlab-rails/bin/sidekiq-cluster --pidfile /var/run/gitlab/sidekiq_cluster.pid process_commit
```

Keep in mind that the PID file contains the PID of the `sidekiq-cluster` command and not the PIDs of the started Sidekiq processes.
### Environment[](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#environment "Permalink")
The Rails environment can be set by passing the `--environment` flag to the `sidekiq-cluster` command, or by setting `RAILS_ENV` to a non-empty value. The default value can be found in `/opt/gitlab/etc/gitlab-rails/env/RAILS_ENV`.
Was this page helpful?YesNo
Edit this page
  *     * [ View page sourceEdit this file only. ](https://gitlab.com/gitlab-org/gitlab/-/blob/master/doc/administration/sidekiq/extra_sidekiq_processes.md)
    * [ Open in Web IDEEdit multiple files. ](https://gitlab.com/-/ide/project/gitlab-org/gitlab/edit/master/-/doc/administration/sidekiq/extra_sidekiq_processes.md)
    * [ Create an issueSuggest improvements. ](https://gitlab.com/gitlab-org/gitlab/-/issues/new?issuable_template=Documentation)


Copy for LLM
  * [Start multiple processes](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#start-multiple-processes)
  * [Concurrency](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#concurrency)
  * [Database connection planning](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#database-connection-planning)
  * [Manage thread counts explicitly](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#manage-thread-counts-explicitly)
  * [Manage thread counts with concurrency field](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#manage-thread-counts-with-concurrency-field)
  * [Modify the check interval](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#modify-the-check-interval)
  * [Troubleshoot using the CLI](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#troubleshoot-using-the-cli)
  * [Monitor the sidekiq-cluster command](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#monitor-the-sidekiq-cluster-command)
  * [PID files](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#pid-files)
  * [Environment](https://docs.gitlab.com/administration/sidekiq/extra_sidekiq_processes/#environment)


[![GitLab Docs logo](https://docs.gitlab.com/gitlab-logo-footer.svg)](https://docs.gitlab.com/)
  * [Facebook](https://www.facebook.com/gitlab)
  * [LinkedIn](https://www.linkedin.com/company/gitlab-com)
  * [Twitter](https://twitter.com/gitlab)
  * [YouTube](https://www.youtube.com/channel/UCnMGQ8QHMAnVIsI3xJrihhg)

[![Creative Commons License](https://docs.gitlab.com/by-sa.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
Company
  * [About GitLab](https://about.gitlab.com/company/)
  * [View pricing](https://about.gitlab.com/pricing/)
  * [Try GitLab for free](https://about.gitlab.com/free-trial/)


Feedback
  * [View page source](https://gitlab.com/gitlab-org/gitlab/-/blob/master/doc/administration/sidekiq/extra_sidekiq_processes.md)
  * [Edit in Web IDE](https://gitlab.com/-/ide/project/gitlab-org/gitlab/edit/master/-/doc/administration/sidekiq/extra_sidekiq_processes.md)
  * [Contribute to GitLab](https://about.gitlab.com/community/contribute/)
  * [Suggest updates](https://gitlab.com/gitlab-org/gitlab/-/issues/new?issuable_template=Documentation)


Help & Community
  * [Get certified](https://university.gitlab.com/pages/certifications)
  * [Get support](https://about.gitlab.com/support/)
  * [Post on the GitLab forum](https://forum.gitlab.com/new-topic?title=topic%20title&body=topic%20body&tags=docs-feedback)


Resources
  * [Terms](https://about.gitlab.com/terms/)
  * [Privacy statement](https://about.gitlab.com/privacy/)
  * [Use of generative AI](https://docs.gitlab.com/legal/use_generative_ai/)
  * [Acceptable use of user licenses](https://docs.gitlab.com/legal/licensing_policy/)


![](https://cdn.bizible.com/ipv?_biz_r=&_biz_h=800054037&_biz_u=35915f37515d478dfd51172559cd5ee8&_biz_l=https%3A%2F%2Fdocs.gitlab.com%2Fadministration%2Fsidekiq%2Fextra_sidekiq_processes%2F&_biz_t=1782758443285&_biz_i=Run%20multiple%20Sidekiq%20processes%20%7C%20GitLab%20Docs&_biz_n=0&rnd=31864&cdn_o=a&_biz_z=1782758443285)![](https://cdn.bizibly.com/u?_biz_u=35915f37515d478dfd51172559cd5ee8&_biz_l=https%3A%2F%2Fdocs.gitlab.com%2Fadministration%2Fsidekiq%2Fextra_sidekiq_processes%2F&_biz_t=1782758443286&_biz_i=Run%20multiple%20Sidekiq%20processes%20%7C%20GitLab%20Docs&rnd=444357&cdn_o=a&_biz_z=1782758443286)

