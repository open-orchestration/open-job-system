Toggle navigation [Sidekiq](https://sidekiq.org/)Simple, efficient background jobs for Ruby.
  * [Pro](https://sidekiq.org/products/pro)
  * [Enterprise](https://sidekiq.org/products/enterprise)
  * [Wiki](https://sidekiq.org/wiki/Home)
  * [Support](https://sidekiq.org/support)
  * [Your Account](https://billing.stripe.com/p/login/6oEdUD7M86Wg42QeUU)


# Deployment
Last synchronized at 2026-06-10T22:44:32Z
## Overview
To safely shut down Sidekiq, you need to send it the TSTP signal as **early** as possible in your deploy process and the TERM signal as **late** as possible. TSTP tells Sidekiq to stop pulling new work and finish all current work. TERM tells Sidekiq to exit within N seconds, where N is set by the `-t` timeout option and defaults to 25. Using TSTP+TERM in your deploy process gives your jobs the maximum amount of time to finish before exiting.
If any jobs are still running when the timeout is up, Sidekiq **will** push those jobs back to Redis so they can be rerun later.
Your deploy scripts **must** give Sidekiq N+5 seconds to shutdown cleanly after the TERM signal. For example, if you send TERM and then send KILL 10 seconds later, you can lose jobs (if using Sidekiq) or see duplicate job execution (if using Sidekiq Pro’s super_fetch).
[![Deployment](http://img.youtube.com/vi/50nm6pY2gwg/0.jpg)](https://www.youtube.com/watch?v=50nm6pY2gwg&list=PLjeHh2LSCFrWGT5uVjUuFKAcrcj5kSai1)
## Network Architecture
I recommend running 1 or more Sidekiq processes per app server in your production cluster. At a previous employer, I ran two Sidekiq processes on three app servers, for six total processes. With a concurrency of 10, this gives you 60 worker threads. All six processes talked to the same Redis server and we used `high`, `default` and `low` queues to keep queue management and job priority as simple as possible.
Running separate machines for Sidekiq or using many different queues adds complexity where it was not needed for us.
## Heroku
[Heroku](https://sidekiq.org/wiki/Heroku) has its own page now.
## Running your own Process
If you want to run Sidekiq on your own server, use systemd to start Sidekiq as a system service. This will ensure the process is restarted if Sidekiq crashes.
Here’s an example [systemd unit file](https://github.com/sidekiq/sidekiq/tree/main/examples/systemd). The systemd documentation has sections on [the .service file](http://0pointer.de/public/systemd-man/systemd.service.html) and [executing processes](http://0pointer.de/public/systemd-man/systemd.exec.html). **Every developer who uses Linux should read these pages many times**.

```
systemctl stop sidekiq
systemctl start sidekiq
systemctl restart sidekiq
systemctl kill -s TSTP sidekiq # quiet

```

Sidekiq Enterprise’s [`sidekiqswarm`](https://sidekiq.org/wiki/Ent-Multi-Process) binary makes it trivial to start N Sidekiq processes with a single systemd service. Take a look at [Foreman](https://github.com/ddollar/foreman) for a useful tool to automate your application processes in development and production.
## Capistrano
Use the `capistrano-sidekiq` gem ([github](https://github.com/seuros/capistrano-sidekiq)). Integrated support has been removed. Warning: Capistrano uses daemonization by default so if the Sidekiq process crashes, it will not restart automatically.
## Events
Sidekiq fires process lifecycle events when starting up and shutting down:

```
Sidekiq.configure_server do |config|
  # runs after your app has finished initializing but before any jobs are dispatched.
  config.on(:startup) do
    make_some_singleton
  end
  config.on(:quiet) do
    puts "Got TSTP, stopping further job processing..."
  end
  config.on(:shutdown) do
    puts "Got TERM, shutting down process..."
    stop_the_world
  end
end

```

This can be useful if you want to start/stop your own threads/actors.
Long running jobs (jobs running longer than the default 25 second timeout) can lead to job loss or duplicate execution. We strongly urge these jobs to use the `Sidekiq::Job#interrupted?` method or the [Iteration](https://sidekiq.org/wiki/Iteration) pattern (both available in 7.3+) to ensure they work well with Sidekiq.

```
# some_job.rb
def perform
  # This job might process 1000s of items and take an hour.
  # Have each iteration check for shutdown. big_list_of_items
  # should only return unprocessed items so the loop will continue
  # where it left off.
  big_list_of_items.find_each do |item|
    process(item)
    # Sidekiq will restart the job immediately on process restart
    raise Sidekiq::Shutdown if interrupted?
  end
end

```

Previous: [Deployment](https://sidekiq.org/wiki/Deployment) Next: [Monitoring](https://sidekiq.org/wiki/Monitoring)
[← Delayed-extensions](https://sidekiq.org/wiki/Delayed-extensions)
[Devise →](https://sidekiq.org/wiki/Devise)
  * [API](https://sidekiq.org/wiki/API)
  * [Active-Job](https://sidekiq.org/wiki/Active-Job)
  * [Advanced-Options](https://sidekiq.org/wiki/Advanced-Options)
  * [Batches](https://sidekiq.org/wiki/Batches)
  * [Best-Practices](https://sidekiq.org/wiki/Best-Practices)
  * [Build-vs-Buy](https://sidekiq.org/wiki/Build-vs-Buy)
  * [Bulk-Queueing](https://sidekiq.org/wiki/Bulk-Queueing)
  * [Comm-Installation](https://sidekiq.org/wiki/Comm-Installation)
  * [Commercial-FAQ](https://sidekiq.org/wiki/Commercial-FAQ)
  * [Commercial-Support](https://sidekiq.org/wiki/Commercial-Support)
  * [Commercial-collaboration](https://sidekiq.org/wiki/Commercial-collaboration)
  * [Complex-Job-Workflows-with-Batches](https://sidekiq.org/wiki/Complex-Job-Workflows-with-Batches)
  * [Delayed-extensions](https://sidekiq.org/wiki/Delayed-extensions)
  * [Deployment](https://sidekiq.org/wiki/Deployment)
  * [Devise](https://sidekiq.org/wiki/Devise)
  * [Embedding](https://sidekiq.org/wiki/Embedding)
  * [Ent-Encryption](https://sidekiq.org/wiki/Ent-Encryption)
  * [Ent-Historical-Metrics](https://sidekiq.org/wiki/Ent-Historical-Metrics)
  * [Ent-Leader-Election](https://sidekiq.org/wiki/Ent-Leader-Election)
  * [Ent-Multi-Process](https://sidekiq.org/wiki/Ent-Multi-Process)
  * [Ent-Periodic-Jobs](https://sidekiq.org/wiki/Ent-Periodic-Jobs)
  * [Ent-Rate-Limiting](https://sidekiq.org/wiki/Ent-Rate-Limiting)
  * [Ent-Rolling-Restarts](https://sidekiq.org/wiki/Ent-Rolling-Restarts)
  * [Ent-Unique-Jobs](https://sidekiq.org/wiki/Ent-Unique-Jobs)
  * [Ent-Web-UI](https://sidekiq.org/wiki/Ent-Web-UI)
  * [Error-Handling](https://sidekiq.org/wiki/Error-Handling)
  * [FAQ](https://sidekiq.org/wiki/FAQ)
  * [Getting-Started](https://sidekiq.org/wiki/Getting-Started)
  * [Heroku](https://sidekiq.org/wiki/Heroku)
  * [Home](https://sidekiq.org/wiki/Home)
  * [Iteration](https://sidekiq.org/wiki/Iteration)
  * [Job-Format](https://sidekiq.org/wiki/Job-Format)
  * [Job-Lifecycle](https://sidekiq.org/wiki/Job-Lifecycle)
  * [Kubernetes](https://sidekiq.org/wiki/Kubernetes)
  * [Logging](https://sidekiq.org/wiki/Logging)
  * [Memory](https://sidekiq.org/wiki/Memory)
  * [Metrics](https://sidekiq.org/wiki/Metrics)
  * [Middleware](https://sidekiq.org/wiki/Middleware)
  * [Miscellaneous-Features](https://sidekiq.org/wiki/Miscellaneous-Features)
  * [Monitoring](https://sidekiq.org/wiki/Monitoring)
  * [Pro-API](https://sidekiq.org/wiki/Pro-API)
  * [Pro-Expiring-Jobs](https://sidekiq.org/wiki/Pro-Expiring-Jobs)
  * [Pro-Metrics](https://sidekiq.org/wiki/Pro-Metrics)
  * [Pro-Reliability-Client](https://sidekiq.org/wiki/Pro-Reliability-Client)
  * [Pro-Reliability-Server](https://sidekiq.org/wiki/Pro-Reliability-Server)
  * [Pro-Web-UI](https://sidekiq.org/wiki/Pro-Web-UI)
  * [Problems-and-Troubleshooting](https://sidekiq.org/wiki/Problems-and-Troubleshooting)
  * [Profiling](https://sidekiq.org/wiki/Profiling)
  * [Really-Complex-Workflows-with-Batches](https://sidekiq.org/wiki/Really-Complex-Workflows-with-Batches)
  * [Related-Projects](https://sidekiq.org/wiki/Related-Projects)
  * [Reliability](https://sidekiq.org/wiki/Reliability)
  * [Scaling](https://sidekiq.org/wiki/Scaling)
  * [Scheduled-Jobs](https://sidekiq.org/wiki/Scheduled-Jobs)
  * [Sharding](https://sidekiq.org/wiki/Sharding)
  * [Signals](https://sidekiq.org/wiki/Signals)
  * [Testimonials](https://sidekiq.org/wiki/Testimonials)
  * [Testing](https://sidekiq.org/wiki/Testing)
  * [The-Basics](https://sidekiq.org/wiki/The-Basics)
  * [Using-Dragonfly](https://sidekiq.org/wiki/Using-Dragonfly)
  * [Using-Redis](https://sidekiq.org/wiki/Using-Redis)


#### Questions, comments, & concerns?info@contribsys.com
Sidekiq[![](https://sidekiq.org/img/hero-award.svg)](https://rubyheroes.com/)[![](https://sidekiq.org/img/rookie-award.png)](https://www.blackducksoftware.com/open-source-rookies/2012-recipients)
[![](https://sidekiq.org/img/cs-footer-logo.png)](https://contribsys.com/)
* * *
[About](https://sidekiq.org/about)  
[Pro](https://sidekiq.org/products/pro)  
[Enterprise](https://sidekiq.org/products/enterprise)
[Wiki](https://sidekiq.org/wiki/Home)  
[Support](https://sidekiq.org/support)  
[Source ](https://github.com/sidekiq/sidekiq/)
[Status ](https://status.sidekiq.org)  
[On Mastodon ](https://ruby.social/@sidekiq)  
[At Rubyconf ](https://confreaks.com/videos/1290-rubyconf2012-asynchronous-processing-for-fun-and-profit)
Copyright © Contributed Systems LLC.  
Made with care in Portland, OR.  
[Site Source](https://github.com/sidekiq/site) (PRs welcome!) 

