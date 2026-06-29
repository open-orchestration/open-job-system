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

# Pattern: Event sourcing [§](https://microservices.io/patterns/data/event-sourcing.html\#undefined)

[pattern](https://microservices.io/tags/pattern)

* * *

## Context [§](https://microservices.io/patterns/data/event-sourcing.html\#context)

A service command typically needs to create/update/delete [aggregates](https://microservices.io/patterns/data/aggregate.html) in the database **and** send messages/events to a message broker.
For example, a service that participates in a [saga](https://microservices.io/patterns/data/saga.html) needs to update business entities and send messages/events.
Similarly, a service that publishes a [domain event](https://microservices.io/patterns/data/domain-event.html) must update an [aggregate](https://microservices.io/patterns/data/aggregate.html) and publish an event.

The command must atomically update the database and send messages in order to avoid data inconsistencies and bugs.
However, it is not viable to use a traditional distributed transaction (2PC) that spans the database and the message broker
The database and/or the message broker might not support 2PC.
And even if they do, it’s often undesirable to couple the service to both the database and the message broker.

But without using 2PC, sending a message in the middle of a transaction is not reliable.
There’s no guarantee that the transaction will commit.
Similarly, if a service sends a message after committing the transaction there’s no guarantee that it won’t crash before sending the message.

In addition, messages must be sent to the message broker in the order they were sent by the service.
They must usually be delivered to each consumer in the same order although that’s outside the scope of this pattern.
For example, let’s suppose that an aggregate is updated by a series of transactions `T1`, `T2`, etc.
This transactions might be performed by the same service instance or by different service instances.
Each transaction publishes a corresponding event: `T1 -> E1`, `T2 -> E2`, etc.
Since `T1` precedes `T2`, event `E1` must be published before `E2`.

## Problem [§](https://microservices.io/patterns/data/event-sourcing.html\#problem)

How to atomically update the database and send messages to a message broker?

## Forces [§](https://microservices.io/patterns/data/event-sourcing.html\#forces)

- 2PC is not an option. The database and/or the message broker might not support 2PC. Also, it’s often undesirable to couple the service to both the database and the message broker.
- If the database transaction commits then the messages must be sent. Conversely, if the database rolls back, the messages must not be sent
- Messages must be sent to the message broker in the order they were sent by the service. This ordering must be preserved across multiple service instances that update the same aggregate.

## Solution [§](https://microservices.io/patterns/data/event-sourcing.html\#solution)

A good solution to this problem is to use event sourcing.
Event sourcing persists the state of a business entity such an Order or a Customer as a sequence of state-changing events.
Whenever the state of a business entity changes, a new event is appended to the list of events.
Since saving an event is a single operation, it is inherently atomic.
The application reconstructs an entity’s current state by replaying the events.

Applications persist events in an event store, which is a database of events.
The store has an API for adding and retrieving an entity’s events.
The event store also behaves like a message broker.
It provides an API that enables services to subscribe to events.
When a service saves an event in the event store, it is delivered to all interested subscribers.

Some entities, such as a Customer, can have a large number of events.
In order to optimize loading, an application can periodically save a snapshot of an entity’s current state.
To reconstruct the current state, the application finds the most recent snapshot and the events that have occurred since that snapshot.
As a result, there are fewer events to replay.

## Example [§](https://microservices.io/patterns/data/event-sourcing.html\#example)

[Customers and Orders](https://github.com/eventuate-examples/eventuate-examples-java-customers-and-orders) is an example of an application that is built using Event Sourcing and [CQRS](https://microservices.io/patterns/data/cqrs.html).
The application is written in Java, and uses Spring Boot.
It is built using [Eventuate](http://eventuate.io/), which is an application platform based on event sourcing and CQRS.

The following diagram shows how it persist orders.

![](https://microservices.io/i/storingevents.png)

Instead of simply storing the current state of each order as a row in an `ORDERS` table, the application persists each `Order` as a sequence of events.
The `CustomerService` can subscribe to the order events and update its own state.

Here is the `Order` aggregate:

```
public class Order extends ReflectiveMutableCommandProcessingAggregate<Order, OrderCommand> {

  private OrderState state;
  private String customerId;

  public OrderState getState() {
    return state;
  }

  public List<Event> process(CreateOrderCommand cmd) {
    return EventUtil.events(new OrderCreatedEvent(cmd.getCustomerId(), cmd.getOrderTotal()));
  }

  public List<Event> process(ApproveOrderCommand cmd) {
    return EventUtil.events(new OrderApprovedEvent(customerId));
  }

  public List<Event> process(RejectOrderCommand cmd) {
    return EventUtil.events(new OrderRejectedEvent(customerId));
  }

  public void apply(OrderCreatedEvent event) {
    this.state = OrderState.CREATED;
    this.customerId = event.getCustomerId();
  }

  public void apply(OrderApprovedEvent event) {
    this.state = OrderState.APPROVED;
  }

  public void apply(OrderRejectedEvent event) {
    this.state = OrderState.REJECTED;
  }
```

Here is an example of an event handler in the `CustomerService` that subscribes to `Order` events:

```
@EventSubscriber(id = "customerWorkflow")
public class CustomerWorkflow {

  @EventHandlerMethod
  public CompletableFuture<EntityWithIdAndVersion<Customer>> reserveCredit(
          EventHandlerContext<OrderCreatedEvent> ctx) {
    OrderCreatedEvent event = ctx.getEvent();
    Money orderTotal = event.getOrderTotal();
    String customerId = event.getCustomerId();
    String orderId = ctx.getEntityId();

    return ctx.update(Customer.class, customerId, new ReserveCreditCommand(orderTotal, orderId));
  }

}
```

It processes an `OrderCreated` event by attempting to reserve credit for the orders customer.

There are [several example applications](http://eventuate.io/exampleapps.html) that illustrate how to use event sourcing.

## Resulting context [§](https://microservices.io/patterns/data/event-sourcing.html\#resulting-context)

Event sourcing has several benefits:

- It solves one of the key problems in implementing an event-driven architecture and makes it possible to reliably publish events whenever state changes.
- Because it persists events rather than domain objects, it mostly avoids the object‑relational impedance mismatch problem.
- It provides a 100% reliable [audit log](https://microservices.io/patterns/observability/audit-logging) of the changes made to a business entity
- It makes it possible to implement temporal queries that determine the state of an entity at any point in time.
- Event sourcing-based business logic consists of loosely coupled business entities that exchange events. This makes it a lot easier to migrate from a monolithic application to a microservice architecture.

Event sourcing also has several drawbacks:

- It is a different and unfamiliar style of programming and so there is a learning curve.
- The event store is difficult to query since it requires typical queries to reconstruct the state of the business entities. That is likely to be complex and inefficient.
As a result, the application must use [Command Query Responsibility Segregation (CQRS)](https://microservices.io/patterns/data/cqrs.html) to implement queries.
This in turn means that applications must handle eventually consistent data.

## Related patterns [§](https://microservices.io/patterns/data/event-sourcing.html\#related-patterns)

- The [Saga](https://microservices.io/patterns/data/saga.html) and [Domain event](https://microservices.io/patterns/data/domain-event.html) patterns create the need for this pattern.
- The [CQRS](https://microservices.io/patterns/data/cqrs.html) must often be used with event sourcing.
- Event sourcing implements the [Audit logging](https://microservices.io/patterns/observability/audit-logging) pattern.

## See also [§](https://microservices.io/patterns/data/event-sourcing.html\#see-also)

- [Eventuate](http://eventuate.io/), which is a platform for developing applications with Event Sourcing and CQRS
- [Articles about event sourcing and CQRS](http://eventuate.io/articles.html)
- [How Eventuate implements snapshots](https://blog.eventuate.io/2017/03/07/eventuate-local-now-supports-snapshots/)

* * *

[pattern](https://microservices.io/tags/pattern)

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