[Sitemap](https://medium.com/sitemap/sitemap.xml)
[Open in app](https://play.google.com/store/apps/details?id=com.medium.reader&referrer=utm_source%3DmobileNavBar&source=post_page---top_nav_layout_nav-----------------------------------------)
Sign up
[Sign in](https://medium.com/m/signin?operation=login&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&source=post_page---top_nav_layout_nav-----------------------global_nav------------------)
[Medium Logo](https://medium.com/?source=post_page---top_nav_layout_nav-----------------------------------------)
Get app
[Write](https://medium.com/m/signin?operation=register&redirect=https%3A%2F%2Fmedium.com%2Fnew-story&source=---top_nav_layout_nav-----------------------new_post_topnav------------------)
[Search](https://medium.com/search?source=post_page---top_nav_layout_nav-----------------------------------------)
Sign up
[Sign in](https://medium.com/m/signin?operation=login&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&source=post_page---top_nav_layout_nav-----------------------global_nav------------------)
![Unknown user](https://miro.medium.com/v2/resize:fill:32:32/1*dmbNkD5D-u45r44go_cf0g.png)
Top highlight
# My Journey Self Hosting a Temporal Cluster
[![Zachary McDonnell](https://miro.medium.com/v2/resize:fill:32:32/1*IZUyKYjz9BWCfUL3S-iROQ.jpeg)](https://medium.com/@mailman966?source=post_page---byline--237fec22a5ec---------------------------------------)
[Zachary McDonnell](https://medium.com/@mailman966?source=post_page---byline--237fec22a5ec---------------------------------------)
Follow
4 min read
·
Jan 1, 2024
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fp%2F237fec22a5ec&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&user=Zachary+McDonnell&userId=2dddc0e5b43a&source=---header_actions--237fec22a5ec---------------------clap_footer------------------)
30
2
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Frepost%2Fp%2F237fec22a5ec&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&user=Zachary+McDonnell&userId=2dddc0e5b43a&source=---header_actions--237fec22a5ec---------------------repost_header------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fbookmark%2Fp%2F237fec22a5ec&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&source=---header_actions--237fec22a5ec---------------------bookmark_footer------------------)
[Listen](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2Fplans%3Fdimension%3Dpost_audio_button%26postId%3D237fec22a5ec&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&source=---header_actions--237fec22a5ec---------------------post_audio_button------------------)
Share
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*mXnyG8CwSKZ7qpsfb_C1jw.png)
Temporal
At my current company we decided to use [Temporal.io](https://temporal.io/) to help manage all of our backend processes. At [Hona](https://www.hona.com/) we sync a lot of data from different Case Management Systems (CMS) and once you start managing and tracking 2 or more systems it starts to create a lot of complexity that can leak into the rest of your infrastructure. With that in mind we were very curious about trying out Temporal because of it’s Durable Execution which could help manage the retry logic and give us the visibility to debug different ETL (Extract Transfer Load) jobs with our various partners.
## Self Hosted vs Cloud
The first choice provided once you get past the initial sales pitch and tech demos is whether you want to self-host or go with the Cloud provided solution. Self hosting is daunting. Temporal is not a single process with a single run command. It’s a persistent database and a cluster of multiple processes built on top of that database to provide the fully encapsulated solution called Temporal. If you don’t fancy yourself a Dev Ops engineer I highly recommend their cloud solution. The setup is simpler and you can get support from the Temporal team debugging any issues you might come across.
The cloud solution is definitely the Temporal Team’s preference that you choose the cloud version. It’s how they can actually make money from their Open Source solution. Going self hosted leaves you on your own to provision, manage, and troubleshoot any issues. There is a [community](https://temporal.io/slack) on slack which is really helpful and you can get some support that way but ultimately it’s up to you to fix your own stuff.
## Self Hosting on AWS
That said, if that doesn’t scare you away from trying a self hosted solution (like me). There are many [Helm Charts](https://docs.temporal.io/self-hosted-guide/setup#helm-charts) that you can use for reference and they have a decent guide on their website to describe what you should do to set it up. Ultimately this is what you need:
  1. Cassandra, Postgres, Mysql Database
  2. Somewhere to host the 4 unique [processes as docker containers](https://hub.docker.com/r/temporalio/server)


At Hona, we use Amazon Web Services (AWS) exclusively and use a lot of the managed solutions through them. So my goal was to use Relational Database Service (RDS) and Elastic Container Service (ECS) to run this cluster. I considered EKS or hosting our own Kubernetes Cluster but the one thing I abhor most is supporting multiple standards/platforms. It introduces complexity that increases onboarding time for new engineers and risk of mistakes from lack of knowledge. Our team was already using both of these services so I set out to make it work.
## Choosing a Database
From my research I initially went with MySQL and then transitioned to Postgres. I didn’t opt for Cassandra because from my research at the time (Q1 2023) it didn’t appear that Temporal was fully compatible with the Cassandra version of AWS (Amazon Keyspaces). Also Cassandra has a reputation requiring more maintenance to get it working. Overall I wasn’t excited on commiting to that investment so I went with Postgres to start.
## Get Zachary McDonnell’s stories in your inbox
Join Medium for free to get updates from this writer.
Subscribe
Subscribe
Remember me for faster sign in
Why Postgres? After looking at some performance metrics that showed Postgres was better with throughput for writes over MySQL I decided to switch to Postgres using Aurora Serverless V2 implementation. We’ve been running this database for several months now and have been very happy.
The other important decision with choosing a database is figuring out the shard count. There is a great [post](https://mikhail.io/2021/05/choose-the-number-of-shards-in-temporal-history-service/) by Mikhail Shilkov that gives perspective on shard count and what the Goldilocks number is. For us, we chose 256. As we grow we may spin up a new cluster with a larger number but for the time being this was good enough.
## Running Temporal on ECS
As for the docker containers we wanted to use ECS for provisioning. This proved difficult using the the temporal docker containers for hosting. After some debugging the hold up was determining the IP Address for services coming online. In short, each of the Temporal processes looks for it’s reference for itself from an environment variable. Once I figured out that was the issue I created a wrapper around the [temporalio/server](https://hub.docker.com/r/temporalio/server) docker container to detect and set the dynamic IP for the temporal service.
## Dockerfile

```
FROM temporalio/server:latest # Insert a specific version for production  
  
USER root  
  
USER temporal  
  
COPY start.sh start.sh  
  
ENTRYPOINT ["sh", "./start.sh"]
```

## start.sh

```
set -eu -o pipefail  
  
export TEMPORAL_BROADCAST_ADDRESS=$(hostname -i)  
export PROMETHEUS_ENDPOINT=$TEMPORAL_BROADCAST_ADDRESS:8233  
  
sh ./entrypoint.sh
```

From there it was as simple as starting the services in the same network and updating the security groups to make sure they could all talk to each other and the database. Presto!
## Would I do it again?
Probably. It did require a decent amount of devops skills to make it all work. Debugging at times was cryptic and took several day. I didn’t have anyone to hold my hand or ask questions. I reached out a couple of times on the Slack Community and their responses were very good however it was up to me to get it to work on our own infrastructure.
And maintenance? Upgrading [versions](https://github.com/temporalio/temporal/releases) has been easy. The migration updates are fairly straightforward and we haven’t had any issues there. The underlying hosts are all managed through AWS so we don’t have much patching responsibilities for the underlying hosts. Everything is hosted on our own private network so we didn’t need to setup a lot of the things required for the cloud version and I guess we gain some latency benefit by hosting our own cluster.
[Temporalio](https://medium.com/tag/temporalio?source=post_page-----237fec22a5ec---------------------------------------)
[Development](https://medium.com/tag/development?source=post_page-----237fec22a5ec---------------------------------------)
[Durable Functions](https://medium.com/tag/durable-functions?source=post_page-----237fec22a5ec---------------------------------------)
[AWS](https://medium.com/tag/aws?source=post_page-----237fec22a5ec---------------------------------------)
[DevOps](https://medium.com/tag/devops?source=post_page-----237fec22a5ec---------------------------------------)
[Some rights reserved](http://creativecommons.org/licenses/by/4.0/)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fp%2F237fec22a5ec&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&user=Zachary+McDonnell&userId=2dddc0e5b43a&source=---footer_actions--237fec22a5ec---------------------clap_footer------------------)
30
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fp%2F237fec22a5ec&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&user=Zachary+McDonnell&userId=2dddc0e5b43a&source=---footer_actions--237fec22a5ec---------------------clap_footer------------------)
30
2
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Frepost%2Fp%2F237fec22a5ec&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&user=Zachary+McDonnell&userId=2dddc0e5b43a&source=---footer_actions--237fec22a5ec---------------------repost_footer------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fbookmark%2Fp%2F237fec22a5ec&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40mailman966%2Fmy-journey-hosting-a-temporal-cluster-237fec22a5ec&source=---footer_actions--237fec22a5ec---------------------bookmark_footer------------------)
[![Zachary McDonnell](https://miro.medium.com/v2/resize:fill:48:48/1*IZUyKYjz9BWCfUL3S-iROQ.jpeg)](https://medium.com/@mailman966?source=post_page---post_author_info--237fec22a5ec---------------------------------------)
[![Zachary McDonnell](https://miro.medium.com/v2/resize:fill:64:64/1*IZUyKYjz9BWCfUL3S-iROQ.jpeg)](https://medium.com/@mailman966?source=post_page---post_author_info--237fec22a5ec---------------------------------------)
Follow
## [Written by Zachary McDonnell](https://medium.com/@mailman966?source=post_page---post_author_info--237fec22a5ec---------------------------------------)
[24 followers](https://medium.com/@mailman966/followers?source=post_page---post_author_info--237fec22a5ec---------------------------------------)
·[1 following](https://medium.com/@mailman966/following?source=post_page---post_author_info--237fec22a5ec---------------------------------------)
10+ years experience as a software engineer. Especially interested in Dev Ops, Machine Learning, and high quality System Architecture.
Follow
[Help](https://help.medium.com/hc/en-us?source=post_page-----237fec22a5ec---------------------------------------)
[Status](https://status.medium.com/?source=post_page-----237fec22a5ec---------------------------------------)
[About](https://medium.com/about?autoplay=1&source=post_page-----237fec22a5ec---------------------------------------)
[Careers](https://medium.com/jobs-at-medium/work-at-medium-959d1a85284e?source=post_page-----237fec22a5ec---------------------------------------)
Press
[Blog](https://blog.medium.com/?source=post_page-----237fec22a5ec---------------------------------------)
[Store](https://medium.com/store)
[Privacy](https://policy.medium.com/medium-privacy-policy-f03bf92035c9?source=post_page-----237fec22a5ec---------------------------------------)
[Rules](https://policy.medium.com/medium-rules-30e5502c4eb4?source=post_page-----237fec22a5ec---------------------------------------)
[Terms](https://policy.medium.com/medium-terms-of-service-9db0094a1e0f?source=post_page-----237fec22a5ec---------------------------------------)
[Text to speech](https://speechify.com/medium?source=post_page-----237fec22a5ec---------------------------------------)

