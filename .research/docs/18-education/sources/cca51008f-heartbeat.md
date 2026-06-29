[![](https://martinfowler.com/mf-name-white.png)](https://martinfowler.com/)

- [Refactoring](https://refactoring.com/)
- [Agile](https://martinfowler.com/agile.html)
- [Architecture](https://martinfowler.com/architecture)
- [About](https://martinfowler.com/aboutMe.html)
- [Thoughtworks](https://www.thoughtworks.com/engineering)
- [feed](https://martinfowler.com/feed.atom "feed")
- [Twitter stream](https://www.twitter.com/martinfowler "Twitter stream")
- [Mastodon stream](https://toot.thoughtworks.com/@mfowler "Mastodon stream")
- [LinkedIn](https://www.linkedin.com/in/martin-fowler-com/ "LinkedIn")
- [BlueSky](https://bsky.app/profile/martinfowler.com "BlueSky")

## Topics

[Architecture](https://martinfowler.com/architecture)

[Refactoring](https://refactoring.com/)

[Agile](https://martinfowler.com/agile.html)

[Delivery](https://martinfowler.com/delivery.html)

[Microservices](https://martinfowler.com/microservices)

[Data](https://martinfowler.com/data)

[Testing](https://martinfowler.com/testing)

[DSL](https://martinfowler.com/dsl.html)

## about me

[About](https://martinfowler.com/aboutMe.html)

[Books](https://martinfowler.com/books)

[FAQ](https://martinfowler.com/faq.html)

## content

[Videos](https://martinfowler.com/videos.html)

[Content Index](https://martinfowler.com/tags)

[Fragments](https://martinfowler.com/fragments)

[Board Games](https://martinfowler.com/boardgames)

[Photography](https://martinfowler.com/photos)

## Thoughtworks

[Home](https://thoughtworks.com/)

[Insights](https://thoughtworks.com/insights)

[Careers](https://thoughtworks.com/careers)

[Radar](https://thoughtworks.com/radar)

[Engineering](https://www.thoughtworks.com/engineering)

## follow

[RSS](https://martinfowler.com/feed.atom)

[Mastodon](https://toot.thoughtworks.com/@mfowler)

[LinkedIn](https://www.linkedin.com/in/martin-fowler-com/)

[Bluesky](https://bsky.app/profile/martinfowler.com)

[X](https://www.twitter.com/martinfowler)

[BGG](https://boardgamegeek.com/blog/13064/martins-7th-decade)

# HeartBeat

Show a server is available by periodically sending a message to all the other servers.

## Problem

When multiple servers form a cluster, each server is responsible for storing some portion of the data, based on the partitioning and replication schemes used.
Timely detection of server failures is important for taking corrective actions
by making some other server responsible for handling requests for the data on a failed server.


## Solution

![](https://martinfowler.com/articles/patterns-of-distributed-systems/index/Heartbeat.svg)

Periodically send a request to all the other servers indicating liveness of the sending server.
Select the request interval to be more than the network round trip time between the servers.
All the listening servers wait for the timeout interval, which is a multiple of the request interval.
In general,


for more details go to [Chapter 07](https://learning.oreilly.com/library/view/patterns-of-distributed/9780138222246/ch07.xhtml) of the online ebook at oreilly.com

[![](https://martinfowler.com/books/joshi.jpg)](https://martinfowler.com/articles/patterns-of-distributed-systems/)

This pattern is part of [Patterns of Distributed Systems](https://martinfowler.com/articles/patterns-of-distributed-systems/)

[Unmesh Joshi](https://twitter.com/unmeshjoshi)

23 November 2023

## Topics

[Architecture](https://martinfowler.com/architecture)

[Refactoring](https://refactoring.com/)

[Agile](https://martinfowler.com/agile.html)

[Delivery](https://martinfowler.com/delivery.html)

[Microservices](https://martinfowler.com/microservices)

[Data](https://martinfowler.com/data)

[Testing](https://martinfowler.com/testing)

[DSL](https://martinfowler.com/dsl.html)

## about me

[About](https://martinfowler.com/aboutMe.html)

[Books](https://martinfowler.com/books)

[FAQ](https://martinfowler.com/faq.html)

## content

[Videos](https://martinfowler.com/videos.html)

[Content Index](https://martinfowler.com/tags)

[Fragments](https://martinfowler.com/fragments)

[Board Games](https://martinfowler.com/boardgames)

[Photography](https://martinfowler.com/photos)

## Thoughtworks

[Home](https://thoughtworks.com/)

[Insights](https://thoughtworks.com/insights)

[Careers](https://thoughtworks.com/careers)

[Radar](https://thoughtworks.com/radar)

[Engineering](https://www.thoughtworks.com/engineering)

## follow

[RSS](https://martinfowler.com/feed.atom)

[Mastodon](https://toot.thoughtworks.com/@mfowler)

[LinkedIn](https://www.linkedin.com/in/martin-fowler-com/)

[Bluesky](https://bsky.app/profile/martinfowler.com)

[X](https://www.twitter.com/martinfowler)

[BGG](https://boardgamegeek.com/blog/13064/martins-7th-decade)

[![](https://martinfowler.com/thoughtworks_white.png)](https://www.thoughtworks.com/engineering)

© Martin Fowler \| [Disclosures](https://martinfowler.com/aboutMe.html#disclosures)