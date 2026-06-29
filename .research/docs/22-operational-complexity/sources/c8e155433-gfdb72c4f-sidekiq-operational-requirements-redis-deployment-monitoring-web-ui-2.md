Toggle navigation [Sidekiq](https://sidekiq.org/)Simple, efficient background jobs for Ruby.
  * [Pro](https://sidekiq.org/products/pro)
  * [Enterprise](https://sidekiq.org/products/enterprise)
  * [Wiki](https://sidekiq.org/wiki/Home)
  * [Support](https://sidekiq.org/support)
  * [Your Account](https://billing.stripe.com/p/login/6oEdUD7M86Wg42QeUU)


# Monitoring
Last synchronized at 2026-06-10T22:44:32Z
I recommend using a tool to monitor your Sidekiq processes in production to ensure they are always up and aren’t using too much memory or CPU. My recommendations:
  1. Use [Systemd](https://github.com/sidekiq/sidekiq/tree/main/examples/systemd) to start/stop Sidekiq. This ensures if the Ruby VM crashes, the process will respawn immediately.
  2. Sidekiq Enterprise has [multi-process](https://sidekiq.org/wiki/Ent-Multi-Process) mode which can monitor memory usage and restart bloated worker processes.


# Web UI
Sidekiq comes with a web application that can display the current state of a Sidekiq installation.
## Rails
Add the following to your `config/routes.rb`:

```
require 'sidekiq/web'
# or require 'sidekiq/pro/web'
# or require 'sidekiq-ent/web'

Myapp::Application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  ...
end

```

It must be mounted within the `draw` block so it can reuse the same Rails session. If you still get a session error, it’s possible your Rails app is API-only. You must [enable sessions in an API-only Rails app](https://guides.rubyonrails.org/api_app.html#using-session-middlewares).
## Standalone
Here’s sample code to run Sidekiq::Web by itself. Note we are configuring a cookie store for the session.

```
# This is sidekiq_web.ru
# Run with `bundle exec rackup sidekiq_web.ru` or similar.

require "securerandom"
require "rack/session"
require "sidekiq/web"

# In a multi-process deployment, all Web UI instances should share
# this secret key so they can all decode the encrypted browser cookies
# and provide a working session.
# Rails does this in /config/initializers/secret_token.rb
secret_key = SecureRandom.hex(32)
use Rack::Session::Cookie, secret: secret_key, same_site: true, max_age: 86400
run Sidekiq::Web

```

## Proxying the Web UI
If you put nginx in front of Sidekiq’s Web UI, make sure you set `X-Script-Name` to the root location so that the Web UI can properly construct URLs to the necessary CSS/JS assets:

```
location /myapp/admin/sidekiq {
  proxy_set_header X-Script-Name /myapp/admin/sidekiq;
  proxy_pass http://myapp.example.com/sidekiq;

  proxy_set_header Host $host;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Scheme $scheme;
  proxy_set_header X-Real-IP $remote_addr;
}

```

### Authentication
In a production application you’ll likely want to protect access to this information. You can use the constraints feature of routing (in the _config/routes.rb_ file) to accomplish this:
#### Devise
Allow any authenticated `User`

```
# config/routes.rb
authenticate :user do
  mount Sidekiq::Web => '/sidekiq'
end

```

Same as above but also ensures that `User#admin?` returns true

```
# config/routes.rb
authenticate :user, lambda { |u| u.admin? } do
  mount Sidekiq::Web => '/sidekiq'
end

```

#### Clearance
Clearance provides [routing constraints](https://github.com/thoughtbot/clearance#access-control) to restrict access to routes.

```
Blog::Application.routes.draw do
  # Restricts access to all authenticated users
  constraints Clearance::Constraints::SignedIn.new do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  # Restricts access to all authenticated admins
  constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end
end

```

#### Authlogic

```
# lib/admin_constraint.rb
class AdminConstraint
  def self.matches?(request)
    return false unless request.cookie_jar['user_credentials'].present?
    user = User.find_by_persistence_token(request.cookie_jar['user_credentials'].split(':')[0])
    user && user.admin?
  end
end

# config/routes.rb
require "admin_constraint"
mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new

```

##### Authlogic 4+
Since Authlogic 4.0.0 turned on secure cookies then AdminConstraint reading ‘user_credentials’ from cookies will fail in default developer setup. Instead you can read it from session directly.

```
# lib/admin_constraint.rb
class AdminConstraint
  def matches?(request)
    return false unless request.session.has_key?(:user_credentials)

    user = User.find_by_persistence_token(request.session.fetch(:user_credentials))
    user && user.admin?
  end
end

```

#### Restful Authentication or Sorcery
Checks a `User` model instance that responds to `admin?`

```
# lib/admin_constraint.rb
class AdminConstraint
  def matches?(request)
    return false unless request.session[:user_id]
    user = User.find request.session[:user_id]
    user && user.admin?
  end
end

# config/routes.rb
require 'sidekiq/web'
require 'admin_constraint'
mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new

```

#### Custom External Authentication

```
class AuthConstraint
  def self.admin?(request)
    return false unless (cookie = request.cookie_jar['auth'])

    Rails.cache.fetch(cookie['user'], :expires_in => 1.minute) do
      auth_data = JSON.parse(Base64.decode64(cookie['data']))
      response = HTTParty.post(Auth.validate_url, :query => auth_data)

      response.code == 200 && JSON.parse(response.body)['roles'].to_a.include?('Admin')
    end
  end
end

# config/routes.rb
constraints lambda {|request| AuthConstraint.admin?(request) } do
  mount Sidekiq::Web => '/admin/sidekiq'
end

```

#### Rails with Google authentication
@jonhyman breaks down [how Appboy uses Google to protect access to Sidekiq](https://github.com/sidekiq/sidekiq/issues/2460#issuecomment-125694743).
#### Github authentication with `warden/github`
See [Gist](https://gist.github.com/badosu/5a6bb42cc0c0a7ae6e9b01313c61a5b9) from the creator of the rack-based `Sidekiq::Web` UI (since Sidekiq 4.2.0)
#### Rails HTTP Basic Auth from Routes

```
# config/routes.rb
require "sidekiq/web"
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  # Protect against timing attacks:
  # - See https://codahale.com/a-lesson-in-timing-attacks/
  # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
  # - Use & (do not use &&) so that it doesn't short circuit.
  # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
end if Rails.env.production?
mount Sidekiq::Web, at: "/sidekiq"

```

If you get an `ActionDispatch::Request::Session` error, you’ve hit an incompatibility between Rails and Rack. See [this comment](https://github.com/rails/rails/issues/15843#issuecomment-125784043) for a workaround.
If you use Warden and set `failure_app` globally (such as in `application.rb` of a Rails project), you won’t see the browser HTTP Basic prompt as Warden will intercept the 401 and invoke your `failed_app` proc. To bypass this, you can define something like this:

```
class AllowBasicAuthPrompt
  def initialize(app); @app = app; end
  def call(env)
    # Tell Warden to not intercept the 401
    env['warden'].custom_failure!; @app.call(env)
  end
end
Sidekiq::Web.use AllowBasicAuthPrompt
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ...
end

```

One click standalone app deploy on Heroku: [![Heroku Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/honeypotio/sidekiq_dashboard)
You can mount sidekiq to existing Rack application as well:

```
require 'your_app'

require 'sidekiq/web'
run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)

```

### Rack session and protection against web attacks
Note that Sidekiq::Web requires a valid Rack session to work. If you see a `Forbidden` error when clicking a button in the Web UI, it’s because the Rack session is not configured correctly. Sidekiq cannot configure a session for you. If you do not know how to set up a valid session in your system, your best option is to search StackOverflow or post a question there with the code you are using to run the Web UI.
If you have wildcard domains with your Rails app and want to access the Web UI from all of them, you will want to configure the `domain` option of your cookiestore.
#### Rails API Application Session Configuration
To access the Web UI from a Rails API application, you may need to configure sessions for Sidekiq specifically.
Update `config/application.rb` to configure the cookie session store:

```
config.session_store :cookie_store, key: '_interslice_session'

```

Update `config/routes.rb` to set up session middleware for `Sidekiq::Web` prior to calling `mount Sidekiq::Web`:

```
require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use Rails.application.config.session_store, Rails.application.config.session_options

Myapp::Application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  # ...
end

```

* * *
If you do everything right, you should see this in your browser:
![Web UI](https://github.com/sidekiq/sidekiq/blob/07acfad11df40b15f1408748be50a4d182daf5e6/examples/web-ui.png)
## Standalone with Basic Auth

```
# this code goes in your config.ru
require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

require 'sidekiq/web'
map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end

  run Sidekiq::Web
end

```

# Nagios
Below is a collection of nagios checks that includes [check_sidekiq_queue](https://github.com/wanelo/nagios-checks/blob/master/check_sidekiq_queue) script, which validates that a given queue depth is within a particular range. It’s a simple shell script that uses redis-cli command line tool, and does not have any dependency on ruby.
<https://github.com/wanelo/nagios-checks>
# Scout
[Scout](http://scoutapp.com), a Rails app monitoring service, provides:
  1. Key metrics for each Sidekiq worker (mean and 95th percentile execution time, latency, error rate, etc).
  2. GitHub-enhanced transaction traces of both timing and memory allocations for individual jobs.


[Scout Sidekiq Monitoring](https://scoutapm.com/blog/monitor-sidekiq-jobs)
# Datadog
[Datadog](https://www.datadoghq.com/), a monitoring service, provides:
  1. [A Sidekiq integration which collects Sidekiq metrics through Datadog’s Dogstatsd Ruby client.](https://docs.datadoghq.com/integrations/sidekiq/)
  2. [An APM integration which will trace job queuing and executions respectively.](https://docs.datadoghq.com/tracing/setup/ruby/#sidekiq)


# Pingdom Server Monitoring
[Pingdom Server Monitoring](http://server-monitor.pingdom.com/) has a [plugin](https://server-monitor.pingdom.com/plugin_urls/7111-sidekiq-monitor) for monitoring Sidekiq workers.
This plugin monitors enqueued, failed, and processed job counts, as well as scheduled jobs and retries. You can also set up alerts for the available metrics.
# Monitoring Queue Backlog
You can use a simple HTTP endpoint with Pingdom to check the size of your Sidekiq ‘default’ queue backlog. Put this in `config/routes.rb`:

```
require 'sidekiq/api'
match "queue-status" => proc { [200, {"Content-Type" => "text/plain"}, [Sidekiq::Queue.new.size < 100 ? "OK" : "UHOH" ]] }, via: :get

```

Now when you hit http://example.com/queue-status, the body of the response will be either ‘OK’ or ‘UHOH’. We have a Pingdom check every minute which fires off an email if the response == ‘UHOH’.
# Monitoring Queue Latency
## Using a custom end-point
If you throw a lot of jobs into the queue, you can get false positives when monitoring the queue backlog. Instead, monitor the queue latency. Queue latency is the difference between when the oldest job was pushed onto the queue versus the current time. This code will check that jobs don’t spend more than 30 seconds enqueued. Put this in `config/routes.rb`:

```
require 'sidekiq/api'
match "queue-latency" => proc { [200, {"Content-Type" => "text/plain"}, [Sidekiq::Queue.new.latency < 30 ? "OK" : "UHOH" ]] }, via: :get

```

Now when you hit http://example.com/queue-latency, the body of the response will be either ‘OK’ or ‘UHOH’.
## Using the Web UI
The Web UI provides overall system data at `/stats`:
`% curl http://localhost:3000/sidekiq/stats`

```
{
  "sidekiq": {
    "processed": 12345,
    "failed": 56,
    "busy": 25,
    "enqueued": 178,
    "scheduled": 0,
    "retries": 0,
    "default_latency": 12
  },
  "redis": {
    "connected_clients": "120",
    "uptime_in_days": "35",
    "used_memory_human": "602.31M",
    "used_memory_peak_human": "1.01G"
  }
}

```

…and provides queue size data at `/stats/queues`:
`% curl http://localhost:3000/sidekiq/stats/queues`

```
{
  "default": 0,
  "bulk": 1234,
  "critical": 1
}

```

## `sidekiqmon`
Sidekiq 6.0 ships with a new `sidekiqmon` binary which will print out basic stats to your terminal. Use REDIS_URL to point `sidekiqmon` to your Redis instance.

```
> sidekiqmon # uses localhost:6379
...
> REDIS_URL=redis://redis.example.com:6380/5 sidekiqmon
...

```

### Forbidden
**This is only relevant for Sidekiq >=4.2.0, <6.2**
If you receive a `Forbidden` error and see `attack prevented by Rack::Protection::AuthenticityToken` in your logs when trying to submit a form, you do not have a valid session configured. A valid session is required to prevent CSRF attacks. You must configure the webapp to share the same session with Rails. Try putting this in your initializer:

```
require 'sidekiq/web' # Require at the top of the initializer

# Rails < 4:
Sidekiq::Web.set :session_secret, Rails.configuration.secret_token
# 5.2 > Rails >= 4:
Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
# Rails ~> 5.2:
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]
# Rails >= 6.0:
Sidekiq::Web.set :session_secret, Rails.application.secret_key_base

```

Previous: [Deployment](https://sidekiq.org/wiki/Deployment) Next: [API](https://sidekiq.org/wiki/API)
[← Miscellaneous-Features](https://sidekiq.org/wiki/Miscellaneous-Features)
[Pro-API →](https://sidekiq.org/wiki/Pro-API)
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

