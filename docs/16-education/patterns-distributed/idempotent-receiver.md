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

# Idempotent Receiver

Identify requests from clients uniquely so you can ignore duplicate requests when client retries

## Problem

Clients send requests to servers but might not get a response.
It's impossible for clients to know
if the response was lost or the server crashed before processing the request.
To make sure its request is processed, the client has to resend the request.


If a server had already processed the request and crashed after that,
servers will get duplicate requests from the client when it retries.


## Solution

Identify a client uniquely by assigning a unique ID to each client.


When the server receives a request, it checks if the request with the given request number from the same client
is already processed. If it finds a saved response, it returns the same response to the client,
without processing the request again.


for more details go to [Chapter 15](https://learning.oreilly.com/library/view/patterns-of-distributed/9780138222246/ch15.xhtml) of the online ebook at oreilly.com

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