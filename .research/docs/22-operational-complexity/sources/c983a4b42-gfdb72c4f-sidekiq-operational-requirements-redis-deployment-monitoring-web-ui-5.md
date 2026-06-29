[Codakey](https://codakey.io/)[Browse](https://codakey.io/projects)[Trending](https://codakey.io/trending)[Rankings](https://codakey.io/rankings)
[](https://github.com/codakey/codakey)[Play](https://app.codakey.io)
[← Back to mperham/sidekiq](https://codakey.io/projects/mperham-sidekiq)
# How to Deploy & Use mperham/sidekiq
Copy Context to AI
# Sidekiq Deployment and Usage Guide
## Prerequisites
  * **Redis** : Redis 7.0+, Valkey 7.2+, or Dragonfly 1.27+
  * **Ruby** : MRI 3.2+ or JRuby 9.4+
  * **Rails** : Sidekiq 8.0 supports Rails and Active Job 7.0+
  * **Development Tools** : Bundler for Ruby gem management


## Installation
### Add Sidekiq to Your Ruby Application

```
bundle add sidekiq

```

### Clone the Repository (for development)

```
git clone https://github.com/sidekiq/sidekiq.git
cd sidekiq
bundle install

```

### Set Up Redis
Ensure Redis is installed and running on your system. You can install Redis using:

```
# On macOS with Homebrew
brew install redis

# On Ubuntu/Debian
sudo apt-get install redis-server

# On CentOS/RHEL
sudo yum install redis

```

Start Redis server:

```
redis-server

```

## Configuration
### Environment Variables
Sidekiq uses the following environment variables:
  * `REDIS_URL`: Redis connection URL (default: `redis://localhost:6379/0`)
  * `RAILS_ENV`: Rails environment (development, test, production)


### Configuration File
Create a `config/sidekiq.yml` file for advanced configuration:

```
:concurrency: 25
:queues:
  - [critical, 3]
  - [default, 2]
  - [low, 1]
:limits:
  critical: 50
  default: 10
  low: 5

```

### Redis Connection
Sidekiq automatically connects to Redis using the `REDIS_URL` environment variable. For custom Redis configurations, set:

```
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

```

## Build & Run
### Development
  1. **Start Sidekiq Worker**


```
bundle exec sidekiq

```

  1. **Run Rails Server (if using Rails)**


```
rails server

```

  1. **Create a Job Class**


```
# app/jobs/hard_job.rb
class HardJob
  include Sidekiq::Job
  sidekiq_options queue: 'critical', retry: 5

  def perform(*args)
    # do some work
  end
end

```

  1. **Enqueue Jobs**


```
HardJob.perform_async(1, 2, 3)

```

### Production
  1. **Configure Production Settings**


```
# config/sidekiq.yml
:concurrency: 10
:queues:
  - [critical, 3]
  - [default, 2]
  - [low, 1]
:limits:
  critical: 50
  default: 10
  low: 5

```

  1. **Start Sidekiq as a Service**


```
bundle exec sidekiq -C config/sidekiq.yml

```

  1. **Use Process Manager**


Use systemd, upstart, or a process manager like `foreman` to keep Sidekiq running:

```
# Procfile
web: bundle exec rails server
worker: bundle exec sidekiq -C config/sidekiq.yml

```

## Deployment
### Platform Options
Sidekiq can be deployed on various platforms:
#### Heroku
  1. Add Redis to your Heroku app:


```
heroku addons:create heroku-redis:hobby-dev

```

  1. Add Sidekiq to your Procfile:


```
web: bundle exec rails server
worker: bundle exec sidekiq -C config/sidekiq.yml

```

  1. Deploy:


```
git push heroku main

```

#### Docker
Create a `Dockerfile`:

```
FROM ruby:3.2

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

CMD ["bundle", "exec", "sidekiq", "-C", "config/sidekiq.yml"]

```

Build and run:

```
docker build -t my-sidekiq-app .
docker run -d my-sidekiq-app

```

#### Kubernetes
Create a deployment manifest:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sidekiq
spec:
  replicas: 2
  selector:
    matchLabels:
      app: sidekiq
  template:
    metadata:
      labels:
        app: sidekiq
    spec:
      containers:
      - name: sidekiq
        image: your-sidekiq-image
        command: ["bundle", "exec", "sidekiq", "-C", "config/sidekiq.yml"]
        env:
        - name: REDIS_URL
          value: "redis://redis-service:6379/0"

```

## Troubleshooting
### Common Issues and Solutions
#### Redis Connection Issues
**Problem** : Sidekiq cannot connect to Redis
**Solution** :
  * Ensure Redis is running: `redis-cli ping` should return `PONG`
  * Check Redis URL: `echo $REDIS_URL`
  * Verify network connectivity to Redis server


#### Job Processing Issues
**Problem** : Jobs are not being processed
**Solution** :
  * Check Sidekiq logs for errors
  * Verify Redis connection
  * Ensure jobs are being enqueued correctly
  * Check queue configuration matches job definitions


#### Performance Issues
**Problem** : Sidekiq is slow or CPU-bound
**Solution** :
  * Monitor Redis performance
  * Adjust concurrency settings in `config/sidekiq.yml`
  * Check for blocking operations in job code
  * Monitor memory usage


#### Web UI Access Issues
**Problem** : Cannot access Sidekiq web UI
**Solution** :
  * Ensure Sidekiq is running with web UI enabled
  * Check port configuration (default: 3000)
  * Verify authentication middleware if configured


#### Memory Leaks
**Problem** : Sidekiq process consumes increasing memory
**Solution** :
  * Monitor memory usage with tools like `htop` or `ps`
  * Check for memory leaks in job code
  * Consider using JRuby for better memory management
  * Implement proper cleanup in job code


#### Retry Issues
**Problem** : Jobs are not being retried
**Solution** :
  * Check `retry` option in job configuration
  * Verify error handling in job code
  * Check Redis connection for retry queue
  * Review retry backoff settings


### Useful Commands

```
# Check Sidekiq version
bundle exec sidekiq -v

# View Sidekiq processes
bundle exec sidekiqctl list

# Stop Sidekiq gracefully
bundle exec sidekiqctl stop tmp/pids/sidekiq.pid 60

# Monitor Sidekiq queues
bundle exec sidekiq api queues

```

### Monitoring and Metrics
Sidekiq provides built-in monitoring through the web UI and API. For production monitoring, consider:
  * **Sidekiq Pro** : Commercial extension with advanced monitoring
  * **Prometheus Integration** : Export metrics for monitoring systems
  * **Log Aggregation** : Use tools like Logstash or Papertrail for log analysis


### Upgrading Sidekiq

```
# Upgrade to latest version
bundle update sidekiq

# Check for breaking changes
# See docs/ directory for upgrade notes between versions

```

This guide provides a comprehensive overview of deploying and using Sidekiq in production environments. Always refer to the official documentation for the latest information and best practices.
[← Project overview](https://codakey.io/projects/mperham-sidekiq)[View alternatives to mperham/sidekiq →](https://codakey.io/projects/mperham-sidekiq/alternatives)
### Discover
  * [Browse Projects](https://codakey.io/projects)
  * [Trending](https://codakey.io/trending)
  * [Rankings](https://codakey.io/rankings)


### Platform
  * [Play Game](https://app.codakey.io)
  * [Submit Project](https://app.codakey.io/dashboard/submit)


### Community
  * [GitHub](https://github.com/codakey/codakey)


Codakey — Gamified open-source discovery
Built with Next.js

