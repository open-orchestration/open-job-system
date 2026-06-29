Toggle navigation [Sidekiq](https://sidekiq.org/)Simple, efficient background jobs for Ruby.
  * [Pro](https://sidekiq.org/products/pro)
  * [Enterprise](https://sidekiq.org/products/enterprise)
  * [Wiki](https://sidekiq.org/wiki/Home)
  * [Support](https://sidekiq.org/support)
  * [Your Account](https://billing.stripe.com/p/login/6oEdUD7M86Wg42QeUU)


# Pro Reliability Client
Last synchronized at 2026-06-10T22:44:32Z
When the Sidekiq client pushes a job to Redis, it just assumes the network call will work. There’s no error handling so any exception will trickle up into your app and cause a 500 error. The Sidekiq Pro client offers additional reliability by locally enqueueing the job for delivery once the network connection is successfully re-established.
There are a few limitations:
  * the local queue is per-process and in-memory so if the client process is restarted, the jobs are lost.
  * only the last 1,000 pushes are saved (by default), to prevent a long-lasting outage from filling all memory
  * the local queue doesn’t work with Batches so any Redis network issues when creating a batch will still cause an exception and fail.
  * the local queue is drained the next time a job is pushed. If a push fails and then the process is idle for hours, that job will be unexpectedly delayed. Ideally your production system has enough traffic to ensure timely drainage.


You can activate “reliable push” in your sidekiq initializer:

```
# This should not go in a Sidekiq.configure_{client,server} block.
Sidekiq::Client.reliable_push! unless Rails.env.test?

```

You don’t want reliable push during testing because you don’t want it to swallow unexpected errors and cause your test suite to pass despite problems.
[← Pro-Metrics](https://sidekiq.org/wiki/Pro-Metrics)
[Pro-Reliability-Server →](https://sidekiq.org/wiki/Pro-Reliability-Server)
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

