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

# Pattern: Idempotent Consumer [§](https://microservices.io/patterns/communication-style/idempotent-consumer.html\#undefined)

[pattern](https://microservices.io/tags/pattern)

* * *

## Context [§](https://microservices.io/patterns/communication-style/idempotent-consumer.html\#context)

In an enterprise application, it’s usually a good idea to use a message broker that guarantees at-least once delivery.
At-least once delivery guarantees that a message broker will deliver a message to a consumer even if errors occur.
One side-effect, however, is that the consumer can be invoked repeatedly for the same message.
**Consequently, a consumer must be idempotent: the outcome of processing the same message repeatedly must be the same as processing the message once.**
If a consumer is not idempotent, multiple invocations can cause bugs.
For example, a consumer of an `AccountDebited` message that subtracts the debit amount from the current balance would calculate the incorrect balance.

## Problem [§](https://microservices.io/patterns/communication-style/idempotent-consumer.html\#problem)

How does a message consumer handle duplicate messages correctly?

## Solution [§](https://microservices.io/patterns/communication-style/idempotent-consumer.html\#solution)

Make a consumer idempotent by having it record the IDs of processed messages in the database.
When processing a message, a consumer can detect and discard duplicates by querying the database.
There are a couple of different places to store the message IDs.
One option is for the consumer to use a separate `PROCESSED_MESSAGES` table.
The other option is for the consumer to store the IDs in the business entities that it creates or updates.

Here’s how a consumer can use the `PROCESSED_MESSAGES` table:

![](https://microservices.io/i/IdempotentConsumer/IdempotentConsumer.png)

After starting the database transaction, the message handler inserts the message’s ID into the `PROCESSED_MESSAGE` table.
Since the `(subscriberId, messageID)` is the `PROCESSED_MESSAGE` table’s primary key the `INSERT` will fail if the message has been already processed successfully.
The message handler can then rollback the transaction and ignore the message.

## See also [§](https://microservices.io/patterns/communication-style/idempotent-consumer.html\#see-also)

- The [Eventuate framework](https://eventuate.io/) implements this pattern.
- This [blog post about this pattern](https://microservices.io/post/microservices/patterns/2020/10/16/idempotent-consumer.html)

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

- 4 comments
  - [1](https://disqus.com/home/notifications/)
  - [Login](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
    - [Disqus](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
    - [Facebook](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
    - [X (Twitter)](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
    - [Google](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
    - [Microsoft](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
    - [Apple](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

G

Join the discussion…

﻿

Comment

###### Log in with

###### or sign up with Disqus  or pick a name

### Disqus is a discussion network

- Don't be a jerk or do anything illegal. Everything is easier that way.

[Read full terms and conditions](https://docs.disqus.com/kb/terms-and-policies/)

This comment platform is hosted by Disqus, Inc. I authorize Disqus and its affiliates to:

- Use, sell, and share my information to enable me to use its comment services and for marketing purposes, including cross-context behavioral advertising, as described in our [Terms of Service](https://help.disqus.com/customer/portal/articles/466260-terms-of-service) and [Privacy Policy](https://disqus.com/privacy-policy), including supplementing that information with other data about me, such as my browsing and location data.
- Contact me or enable others to contact me by email with offers for goods or services
- Process any sensitive personal information that I submit in a comment. See our [Privacy Policy](https://disqus.com/privacy-policy) for more information

Acknowledge I am 18 or older

- [1](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Favorite this discussion")

  - ## Discussion Favorited!



    Favoriting means this is a discussion worth sharing. It gets shared to your followers' Disqus feeds, and gives the creator kudos!


     [Find More Discussions](https://disqus.com/home/?utm_source=disqus_embed&utm_content=recommend_btn)

[Share](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

  - Tweet this discussion
  - Share this discussion on Facebook
  - Share this discussion via email
  - Copy link to discussion

  - [Best](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
  - [Newest](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
  - [Oldest](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

- - [−](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Collapse")
  - [+](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Expand")
  - [Flag as inappropriate](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Flag as inappropriate")


T

[tharun](https://disqus.com/by/disqus_hWH3jmifOh/)[a year ago](https://microservices.io/patterns/communication-style/idempotent-consumer.html#comment-6675439785 "Sunday, March 23, 2025 9:18 PM")

1.Persist eventId with ‘inprogress’ state.

2.Process the event.

3.Update eventId with ‘complete’ state.

Steps (2) and (3) has to be transactional.

If we skip step 1, then we may end up processing the duplicate message since original message may not have been persisted yet.

see more

[0Press the down arrow key to see users who liked this](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Vote up") [0Press the down arrow key to see users who disliked this](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Vote down")

[Reply](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
[Share ›](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

[Show more replies](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

- - [−](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Collapse")
  - [+](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Expand")
  - [Flag as inappropriate](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Flag as inappropriate")


P

[PingPong](https://disqus.com/by/disqus_ERDXVGvJt1/)[5 years ago](https://microservices.io/patterns/communication-style/idempotent-consumer.html#comment-5421311627 "Tuesday, June 15, 2021 11:09 PM")

Could you please elaborate on this below using an example?

"The other option is for the consumer to store the IDs in the business entities that it creates"

I wonder if your book contains more code example for this pattern, or the same as the article.

see more

[0Press the down arrow key to see users who liked this](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Vote up") [0Press the down arrow key to see users who disliked this](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Vote down")

[Reply](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
[Share ›](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

  - - [−](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Collapse")
    - [+](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Expand")
    - [Flag as inappropriate](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Flag as inappropriate")


![Avatar for Chris Richardson](https://c.disquscdn.com/uploads/users/16696/3119/avatar92.jpg?1775169868)

[Chris Richardson](https://disqus.com/by/disqus_ceracm/)Mod[PingPong](https://microservices.io/patterns/communication-style/idempotent-consumer.html#comment-5421311627)[5 years ago](https://microservices.io/patterns/communication-style/idempotent-consumer.html#comment-5421336649 "Tuesday, June 15, 2021 11:37 PM")

See [https://github.com/microser...](https://github.com/microservices-patterns/ftgo-application/blob/cac2b209fa91c9908b38cef408c9efb38614a253/ftgo-order-history-service/src/main/java/net/chrisrichardson/ftgo/cqrs/orderhistory/dynamodb/OrderHistoryDaoDynamoDb.java#L71 "https://github.com/microservices-patterns/ftgo-application/blob/cac2b209fa91c9908b38cef408c9efb38614a253/ftgo-order-history-service/src/main/java/net/chrisrichardson/ftgo/cqrs/orderhistory/dynamodb/OrderHistoryDaoDynamoDb.java#L71") and/or read the CQRS chapter in my book.

see more

[0Press the down arrow key to see users who liked this](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Vote up") [0Press the down arrow key to see users who disliked this](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Vote down")

[Reply](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
[Share ›](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

    - - [−](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Collapse")
      - [+](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Expand")
      - [Flag as inappropriate](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Flag as inappropriate")


P

[PingPong](https://disqus.com/by/disqus_ERDXVGvJt1/)[Chris Richardson](https://microservices.io/patterns/communication-style/idempotent-consumer.html#comment-5421336649)[5 years ago](https://microservices.io/patterns/communication-style/idempotent-consumer.html#comment-5421730060 "Wednesday, June 16, 2021 10:00 AM")

Hi Chris,

Thanks for your prompt reply and the info.

I wonder if C# version of the example is available?

BTW, It seems a good book with code example. I still consider reading it if it is suitable.

see more

[0Press the down arrow key to see users who liked this](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Vote up") [0Press the down arrow key to see users who disliked this](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Vote down")

[Reply](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)
[Share ›](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

[Show more replies](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

[Show more replies](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

[Show more replies](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

[Load more comments](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default#)

- [SubscribeSubscribed](https://disqus.com/embed/comments/?base=default&f=microservices&t_u=https%3A%2F%2Fmicroservices.io%2Fpatterns%2Fcommunication-style%2Fidempotent-consumer.html&t_d=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&t_t=Pattern%3A%20Idempotent%20Consumer%C2%A0%C2%A7&s_o=default# "Subscribe and get email updates from this discussion")

- [Privacy](https://disqus.com/privacy-policy "Privacy")
- [Do Not Sell My Data](https://disqus.com/data-sharing-settings/)

[Powered by Disqus](https://disqus.com/ "Powered by Disqus")

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