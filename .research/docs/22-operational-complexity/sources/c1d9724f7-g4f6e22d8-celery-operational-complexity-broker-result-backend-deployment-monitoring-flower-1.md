### Navigation
  * [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
  * [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") |
  * [next](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/rabbitmq.html "Using RabbitMQ") |
  * [previous](https://docs.celeryq.dev/en/stable/getting-started/introduction.html "Introduction to Celery") |
  * [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
  * [Getting Started](https://docs.celeryq.dev/en/stable/getting-started/index.html) »
  * [Backends and Brokers](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/)


This document describes the current stable version of Celery (5.6). For development docs, [go here](https://docs.celeryq.dev/en/main/getting-started/backends-and-brokers/index.html). 
# Backends and Brokers[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#backends-and-brokers "Link to this heading") 

Release: 
    
5.6 

Date: 
    
Mar 26, 2026
Celery supports several message transport alternatives.
## Broker Instructions[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#broker-instructions "Link to this heading")
  * [Using RabbitMQ](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/rabbitmq.html)
  * [Using Redis](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/redis.html)
  * [Using Amazon SQS](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/sqs.html)
  * [Using Kafka](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/kafka.html)
  * [Using Google Pub/Sub](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/gcpubsub.html)


## Broker Overview[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#broker-overview "Link to this heading")
This is comparison table of the different transports supports, more information can be found in the documentation for each individual transport (see [Broker Instructions](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#broker-toc)).  
| **Name**  | **Status**  | **Monitoring**  | **Remote Control**  |  
| --- | --- | --- | --- |  
| _RabbitMQ_  | Stable  | Yes  | Yes  |  
| _Redis_  | Stable  | Yes  | Yes  |  
| _Amazon SQS_  | Stable  | No  | No  |  
| _Zookeeper_  | Experimental  | No  | No  |  
| _Kafka_  | Experimental  | No  | No  |  
| _GC PubSub_  | Experimental  | Yes  | Yes  |  
Experimental brokers may be functional but they don’t have dedicated maintainers.
Missing monitor support means that the transport doesn’t implement events, and as such Flower, celery events, celerymon and other event-based monitoring tools won’t work.
Remote control means the ability to inspect and manage workers at runtime using the celery inspect and celery control commands (and other tools using the remote control API).
## Summaries[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#summaries "Link to this heading")
_Note: This section is not comprehensive of backends and brokers._
Celery has the ability to communicate and store with many different backends (Result Stores) and brokers (Message Transports).
### Redis[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#redis "Link to this heading")
Redis can be both a backend and a broker.
**As a Broker:** Redis works well for rapid transport of small messages. Large messages can congest the system.
[See documentation for details](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/redis.html#broker-redis)
**As a Backend:** Redis is a super fast K/V store, making it very efficient for fetching the results of a task call. As with the design of Redis, you do have to consider the limit memory available to store your data, and how you handle data persistence. If result persistence is important, consider using another DB for your backend.
### RabbitMQ[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#rabbitmq "Link to this heading")
RabbitMQ is a broker.
**As a Broker:** RabbitMQ handles larger messages better than Redis, however if many messages are coming in very quickly, scaling can become a concern and Redis or SQS should be considered unless RabbitMQ is running at very large scale.
[See documentation for details](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/rabbitmq.html#broker-rabbitmq)
**As a Backend:** RabbitMQ can store results via `rpc://` backend. This backend creates separate temporary queue for each client.
_Note: RabbitMQ (as the broker) and Redis (as the backend) are very commonly used together. If more guaranteed long-term persistence is needed from the result store, consider using PostgreSQL or MySQL (through SQLAlchemy), Cassandra, or a custom defined backend._
### SQS[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#sqs "Link to this heading")
SQS is a broker.
If you already integrate tightly with AWS, and are familiar with SQS, it presents a great option as a broker. It is extremely scalable and completely managed, and manages task delegation similarly to RabbitMQ. It does lack some of the features of the RabbitMQ broker such as `worker remote control commands`.
[See documentation for details](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/sqs.html#broker-sqs)
### SQLAlchemy[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#sqlalchemy "Link to this heading")
SQLAlchemy is a backend.
It allows Celery to interface with MySQL, PostgreSQL, SQlite, and more. It is an ORM, and is the way Celery can use a SQL DB as a result backend.
[See documentation for details](https://docs.celeryq.dev/en/stable/userguide/configuration.html#conf-database-result-backend)
### GCPubSub[¶](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/#gcpubsub "Link to this heading")
Google Cloud Pub/Sub is a broker.
If you already integrate tightly with Google Cloud, and are familiar with Pub/Sub, it presents a great option as a broker. It is extremely scalable and completely managed, and manages task delegation similarly to RabbitMQ.
[See documentation for details](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/gcpubsub.html#broker-gcpubsub)
[ ![Logo of Celery](https://docs.celeryq.dev/en/stable/_static/celery_512.png) ](https://docs.celeryq.dev/en/stable/index.html)
### Donations
Please help support this community project with a donation.
[ ![](https://opencollective.com/celery/donate/button@2x.png?color=blue) ](https://opencollective.com/celery/donate)
#### Previous topic
[Introduction to Celery](https://docs.celeryq.dev/en/stable/getting-started/introduction.html "previous chapter")
#### Next topic
[Using RabbitMQ](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/rabbitmq.html "next chapter")
### This Page
  * [Show Source](https://docs.celeryq.dev/en/stable/_sources/getting-started/backends-and-brokers/index.rst.txt)


### Quick search
### Navigation
  * [index](https://docs.celeryq.dev/en/stable/genindex.html "General Index")
  * [modules](https://docs.celeryq.dev/en/stable/py-modindex.html "Python Module Index") |
  * [next](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/rabbitmq.html "Using RabbitMQ") |
  * [previous](https://docs.celeryq.dev/en/stable/getting-started/introduction.html "Introduction to Celery") |
  * [Celery 5.6.3 documentation](https://docs.celeryq.dev/en/stable/index.html) »
  * [Getting Started](https://docs.celeryq.dev/en/stable/getting-started/index.html) »
  * [Backends and Brokers](https://docs.celeryq.dev/en/stable/getting-started/backends-and-brokers/)


© [Copyright](https://docs.celeryq.dev/en/stable/copyright.html) 2009-2023, Ask Solem & contributors. 

