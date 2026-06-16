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

# Leader and Followers

Have a single server to coordinate replication across a set of servers.

## Problem

To achieve fault tolerance in systems that manage data, the data
needs to be replicated on multiple servers.


It's also important to give some guarantee about consistency to clients.
When data is updated on multiple servers, you need to decide when to make it visible to clients.
Write and read [Majority Quorum](https://martinfowler.com/articles/patterns-of-distributed-systems/majority-quorum.html) is not sufficient, as some failure scenarios can cause clients to see data inconsistently.
Each individual server does not know about the state of data on the other servers in the quorum.
It's only when data is read from multiple servers, the inconsistencies can be resolved.
In some cases, this is not enough. Stronger guarantees are needed about the data sent to clients.


## Solution

Select one server in the cluster as a leader. The leader is responsible for taking
decisions on behalf of the entire cluster and propagating the decisions to all the other servers.


for more details go to [Chapter 06](https://learning.oreilly.com/library/view/patterns-of-distributed/9780138222246/ch06.xhtml) of the online ebook at oreilly.com

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