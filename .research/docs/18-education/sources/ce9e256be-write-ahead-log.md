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

# Write-Ahead Log

Provide durability guarantee without the storage data structures to be flushed to disk,
by persisting every state change as a command to the append only log.

aka: Commit Log

## Problem

Strong durability guarantee is needed even in the case of the server machines storing
data failing. Once a server agrees to perform an action, it should do so even if it
fails and restarts losing all of its in-memory state.

## Solution

Store each state change as a command in a file on a hard disk.

![](https://martinfowler.com/articles/patterns-of-distributed-systems/index/wal.svg)

for more details go to [Chapter 03](https://learning.oreilly.com/library/view/patterns-of-distributed/9780138222246/ch03.xhtml) of the online ebook at oreilly.com

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