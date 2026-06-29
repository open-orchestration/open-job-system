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

# Pattern: Messaging [§](https://microservices.io/patterns/communication-style/messaging.html\#undefined)

[pattern](https://microservices.io/tags/pattern)[inter-service communication](https://microservices.io/tags/inter-service%20communication)[service api](https://microservices.io/tags/service%20api)[service design](https://microservices.io/tags/service%20design)

* * *

## Context [§](https://microservices.io/patterns/communication-style/messaging.html\#context)

You have applied the [Microservice architecture pattern](https://microservices.io/patterns/microservices.html).
Services must handle requests from the application’s clients.
Furthermore, services often collaborate to handle those requests.
Consequently, they must use an inter-process communication protocol.

## Forces [§](https://microservices.io/patterns/communication-style/messaging.html\#forces)

- Services often need to collaborate
- Synchronous communicate results in tight runtime coupling, both the client and service must be available for the duration of the request

## Problem [§](https://microservices.io/patterns/communication-style/messaging.html\#problem)

How do services in a microservice architecture communicate?

## Solution [§](https://microservices.io/patterns/communication-style/messaging.html\#solution)

Use asynchronous messaging for inter-service communication.
Services communicating by exchanging messages over messaging channels.

There are several different styles of asynchronous communication:

- Request/response - a service sends a request message to a recipient and expects to receive a reply message promptly
- Notifications - a sender sends a message a recipient but does not expect a reply. Nor is one sent.
- Request/asynchronous response - a service sends a request message to a recipient and expects to receive a reply message eventually
- Publish/subscribe - a service publishes a message to zero or more recipients
- Publish/asynchronous response - a service publishes a request to one or recipients, some of whom send back a reply

## Examples [§](https://microservices.io/patterns/communication-style/messaging.html\#examples)

There are numerous examples of asynchronous messaging technologies

- [Apache Kafka](http://kafka.apache.org/)
- [RabbitMQ](https://www.rabbitmq.com/)

`OrderService` from the [FTGO Example application](https://github.com/microservices-patterns/ftgo-application) publishes an `Order Created` event when it creates an `Order`.

```
public class OrderService {

  ...

  public Order createOrder(long consumerId, long restaurantId,
                           List<MenuItemIdAndQuantity> lineItems) {
    Restaurant restaurant = restaurantRepository.findById(restaurantId)
            .orElseThrow(() -> new RestaurantNotFoundException(restaurantId));

    List<OrderLineItem> orderLineItems = makeOrderLineItems(lineItems, restaurant);

    ResultWithDomainEvents<Order, OrderDomainEvent> orderAndEvents =
            Order.createOrder(consumerId, restaurant, orderLineItems);

    Order order = orderAndEvents.result;
    orderRepository.save(order);

    orderAggregateEventPublisher.publish(order, orderAndEvents.events);

    OrderDetails orderDetails = new OrderDetails(consumerId, restaurantId, orderLineItems, order.getOrderTotal());

    CreateOrderSagaState data = new CreateOrderSagaState(order.getId(), orderDetails);
    createOrderSagaManager.create(data, Order.class, order.getId());

    meterRegistry.ifPresent(mr -> mr.counter("placed_orders").increment());

    return order;
  }
```

## Resulting context [§](https://microservices.io/patterns/communication-style/messaging.html\#resulting-context)

This pattern has the following benefits:

- Loose runtime coupling since it decouples the message sender from the consumer
- Improved availability since the message broker buffers messages until the consumer is able to process them
- Supports a variety of communication patterns including request/reply, notifications, request/async response, publish/subscribe, publish/async response etc

This pattern has the following drawbacks:

- Additional complexity of message broker, which must be highly available

This pattern has the following issues:

- Request/reply-style communication is more complex

## Related patterns [§](https://microservices.io/patterns/communication-style/messaging.html\#related-patterns)

- The [Saga pattern](https://microservices.io/patterns/data/saga.html) and [CQRS pattern](https://microservices.io/patterns/data/cqrs.html) use messaging
- The [Transactional Outbox pattern](https://microservices.io/patterns/data/transactional-outbox.html) enables messages to be sent as part of a database transaction
- The [Externalized configuration pattern](https://microservices.io/patterns/externalized-configuration.html) supplies the (logical) message channel names and the location of the message broker
- The [Domain-specific protocol](https://microservices.io/patterns/communication-style/domain-specific.html) pattern is an alternative pattern
- The [RPI](https://microservices.io/patterns/communication-style/rpi.html) pattern is an alternative pattern

## See also [§](https://microservices.io/patterns/communication-style/messaging.html\#see-also)

- My book [Microservices patterns](https://microservices.io/book) describes inter-communication in depth
- [Enterprise Integration Patterns](http://www.enterpriseintegrationpatterns.com/) \- a comprehensive set of message patterns
- The [Eventuate Tram framework](http://eventuate.io/), which implements transaction messaging for microservices

* * *

[pattern](https://microservices.io/tags/pattern)[inter-service communication](https://microservices.io/tags/inter-service%20communication)[service api](https://microservices.io/tags/service%20api)[service design](https://microservices.io/tags/service%20design)

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