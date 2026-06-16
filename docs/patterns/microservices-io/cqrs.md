#### [Microservice Architecture](https://microservices.io/index.html)

**Supported by [Kong](https://konghq.com/)**

- [Patterns](https://microservices.io/patterns/index.html)
- [Articles](https://microservices.io/articles/index.html)
- [Presentations](https://microservices.io/presentations/index.html)
- [Adopt](https://microservices.io/adopt/index.html)
- [Refactoring](https://microservices.io/refactoring/index.html)
- [Testing](https://microservices.io/testing/index.html)
- [Modernization Help](https://chrisrichardson.net/)

- [About](https://microservices.io/about.html)

# Pattern: Command Query Responsibility Segregation (CQRS) [§](https://microservices.io/patterns/data/cqrs.html\#undefined)

[pattern](https://microservices.io/tags/pattern)[service collaboration](https://microservices.io/tags/service%20collaboration)[implementing queries](https://microservices.io/tags/implementing%20queries)

* * *

## Want to learn more about this pattern? [§](https://microservices.io/patterns/data/cqrs.html\#undefined)

Take a look at my [self-paced, online bootcamp](https://chrisrichardson.net/virtual-bootcamp-distributed-data-management.html) that teaches you how to use the Saga, API Composition, and CQRS patterns to design operations that span multiple services.


The regular price is $395/person but use coupon OFFEFKCW to sign up for $95 (valid until Sept 30th, 2025)


[![](https://microservices.io/i/Microservices_IO_Logo_White.png)](https://chrisrichardson.net/virtual-bootcamp-distributed-data-management.html)

## Context [§](https://microservices.io/patterns/data/cqrs.html\#context)

You have applied the [Microservices architecture pattern](https://microservices.io/patterns/microservices.html) and the [Database per service pattern](https://microservices.io/patterns/data/database-per-service.html).
As a result, it is no longer straightforward to implement queries that join data from multiple services.
Also, if you have applied the [Event sourcing pattern](https://microservices.io/patterns/data/event-sourcing.html) then the data is no longer easily queried.

## Problem [§](https://microservices.io/patterns/data/cqrs.html\#problem)

How to implement a query that retrieves data from multiple services in a microservice architecture?

## Solution [§](https://microservices.io/patterns/data/cqrs.html\#solution)

Define a view database, which is a read-only ‘replica’ that is designed specifically to support that query, or a group related queries.
The application keeps the database up to date by subscribing to [Domain events](https://microservices.io/patterns/data/domain-event.html) published by the service that own the data.
The type of database and its schema are optimized for the query or queries.
It’s often a NoSQL database, such as a document database or a key-value store.

![](https://microservices.io/i/patterns/data/QuerySideService.png)

## Examples [§](https://microservices.io/patterns/data/cqrs.html\#examples)

- My book’s FTGO example application has the [`Order History Service`](https://github.com/microservices-patterns/ftgo-application#chapter-7-implementing-queries-in-a-microservice-architecture), which implements this pattern.

- There are [several Eventuate-based example applications](http://eventuate.io/exampleapps.html) that illustrate how to use this pattern.


## Resulting context [§](https://microservices.io/patterns/data/cqrs.html\#resulting-context)

This pattern has the following benefits:

- Supports multiple denormalized views that are scalable and performant
- Improved separation of concerns = simpler command and query models
- Necessary in an event sourced architecture

This pattern has the following drawbacks:

- Increased complexity
- Potential code duplication
- Replication lag/eventually consistent views

## Related patterns [§](https://microservices.io/patterns/data/cqrs.html\#related-patterns)

- The [Database per Service pattern](https://microservices.io/patterns/data/database-per-service.html) creates the need for this pattern
- The [API Composition pattern](https://microservices.io/patterns/data/api-composition.html) is an alternative solution
- The [Domain event](https://microservices.io/patterns/data/domain-event.html) pattern generates the events
- CQRS is often used with [Event sourcing](https://microservices.io/patterns/data/event-sourcing.html)

## See also [§](https://microservices.io/patterns/data/cqrs.html\#see-also)

- [Eventuate](http://eventuate.io/), which is a platform for developing transactional business applications.

## Learn more [§](https://microservices.io/patterns/data/cqrs.html\#learn-more)

- My book [Microservices patterns](https://microservices.io/book) describes this pattern in a lot more detail
- Take a look at my [self-paced, online bootcamp](https://chrisrichardson.net/virtual-bootcamp-distributed-data-management.html) that teaches you how to use the Saga, API Composition, and CQRS patterns to design operations that span multiple services.

* * *

[pattern](https://microservices.io/tags/pattern)[service collaboration](https://microservices.io/tags/service%20collaboration)[implementing queries](https://microservices.io/tags/implementing%20queries)

* * *

* * *

[Modernization Help](https://chrisrichardson.net/)

Copyright © 2026 Chris Richardson • All rights reserved • Supported by [Kong](https://konghq.com/).

Disqus Recommendations

We were unable to load Disqus Recommendations. If you are a moderator please see our [troubleshooting guide](https://docs.disqus.com/help/83/).

Disqus Comments

We were unable to load Disqus. If you are a moderator please see our [troubleshooting guide](https://docs.disqus.com/help/83/).

#### About Microservices.io

![](https://gravatar.com/avatar/a290a8643359e2495e1c6312e662012f)

Microservices.io is created by [Chris Richardson](https://microservices.io/about.html), software architect, creator of the original CloudFoundry.com, and author of _Microservices Patterns_. Chris advises organizations on modernization, architecture, and building systems that avoid becoming modern legacy systems.


#### Need help modernizing your architecture?

Avoid the trap of creating a modern legacy system — a new architecture with the same old problems.

Contact me to discuss your modernization goals.


[Get Help](https://www.linkedin.com/in/pojos/)

#### Microservices Patterns, 2nd edition

![](https://microservices.io/i/posts/mp2e-book-cover.png)

I am very excited to announce that the MEAP for the second edition of my book, Microservices Patterns is now available!


[Learn more](https://microservices.io/post/architecture/2025/06/26/announcing-meap-microservices-patterns-2nd-edition.html)

#### ASK CHRIS

?

Got a question about microservices?

Fill in [this form](https://forms.gle/ppYDAF1JxHGec8Kn9). If I can, I'll write a blog post that answers your question.

#### NEED HELP?

![](https://microservices.io/i/posts/cxo-wondering.webp)

I help organizations improve agility and competitiveness through better software architecture.


Learn more about my [consulting engagements](https://chrisrichardson.net/consulting.html), and [training workshops](https://chrisrichardson.net/training.html).


#### PREMIUM CONTENT

![](https://microservices.io/i/posts/premium-logo.png)
Premium content now available for paid subscribers at [premium.microservices.io](https://premium.microservices.io/).



#### MICROSERVICES WORKSHOPS

![](https://microservices.io/i/workshop-kata_small.jpg)

Chris teaches [comprehensive workshops](http://chrisrichardson.net/training.html) for architects and developers that will enable your organization use microservices effectively.


Avoid the pitfalls of adopting microservices and learn essential topics, such as service decomposition and design and how to refactor a monolith to microservices.


[Learn more](http://chrisrichardson.net/training.html)

#### Remote consulting session

![](https://microservices.io/i/posts/zoom-consulting.webp)

Got a specific microservice architecture-related question? For example:

- Wondering whether your organization should adopt microservices?
- Want to know how to migrate your monolith to microservices?
- Facing a tricky microservice architecture design problem?

Consider signing up for a [two hour, highly focussed, consulting session.](https://chrisrichardson.net/consulting-office-hours.html)

#### ASSESS your architecture

Assess your application's microservice architecture and identify what needs to be improved. [Engage Chris](http://www.chrisrichardson.net/consulting.html) to conduct an architect review.

#### LEARN about microservices

Chris offers numerous other resources for learning the microservice architecture.

#### Get the book: Microservices Patterns

Read Chris Richardson's book:

[![](https://microservices.io/i/Microservices-Patterns-Cover-published.png)](https://microservices.io/book)

* * *

#### Example microservices applications

Want to see an example? Check out Chris Richardson's example applications.
[See code](http://eventuate.io/exampleapps.html)

#### Virtual bootcamp: Distributed data patterns in a microservice architecture

![](https://microservices.io/i/Chris_Speaking_Mucon_2018_a.jpg)

My virtual bootcamp, distributed data patterns in a microservice architecture, is now open for enrollment!

It covers the key distributed data management patterns including Saga, API Composition, and CQRS.

It consists of video lectures, code labs, and a weekly ask-me-anything video conference repeated in multiple timezones.

The regular price is $395/person but use coupon OFFEFKCW to sign up for $95 (valid until Sept 30th, 2025).
There are deeper discounts for buying multiple seats.


[Learn more](https://chrisrichardson.net/virtual-bootcamp-distributed-data-management.html)

#### Learn how to create a service template and microservice chassis

Take a look at my [Manning LiveProject](https://microservices.io/post/patterns/2022/03/15/service-template-chassis-live-project.html) that teaches you how to develop a service template and microservice chassis.


![](https://microservices.io/i/patterns/microservice-template-and-chassis/Microservice_chassis.png)

[Signup for the newsletter](http://visitor.r20.constantcontact.com/d.jsp?llr=ula8akwab&p=oi&m=1123470377332&sit=l6ktajjkb&f=15d9bba9-b33d-491f-b874-73a41bba8a76)

For Email Marketing you can trust.

#### BUILD microservices

Ready to start using the microservice architecture?



#### Consulting services

[Engage Chris](http://www.chrisrichardson.net/consulting.html) to create a microservices adoption roadmap and help you define your microservice architecture,

* * *

#### The Eventuate platform

Use the [Eventuate.io platform](https://eventuate.io/) to tackle distributed data management challenges in your microservices architecture.

[![](https://eventuate.io/i/logo.gif)](https://eventuate.io/)

Eventuate is Chris's latest startup. It makes it easy to use the Saga pattern to manage transactions and the CQRS pattern to implement queries.

* * *

Join the [microservices google group](https://groups.google.com/forum/#!forum/microservices)