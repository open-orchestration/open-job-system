---
id: d3653056c
topic: patterns
title: "Microservice and Distributed-System Patterns: Messaging, API Composition, and Avoiding Fallback"
status: draft
shape: survey
---

# Microservice and Distributed-System Patterns: Messaging, API Composition, and Avoiding Fallback

Survey of distributed-system patterns relevant to a job & workflow platform. Each pattern's claims carry only its own source id.

## Messaging

Applies after the Microservice architecture pattern; services must handle requests from the application's clients, and services often collaborate to handle those requests, so they must use an inter-process communication protocol [c290494f5]. The problem it answers: how do services in a microservice architecture communicate? [c290494f5]. The driving forces: services often need to collaborate, and synchronous communication results in tight runtime coupling because both the client and service must be available for the duration of the request [c290494f5]. Solution: use asynchronous messaging for inter-service communication, with services communicating by exchanging messages over messaging channels [c290494f5]. The body enumerates several styles of asynchronous communication: request/response (sender expects a reply promptly), notifications (sender expects no reply and none is sent), request/asynchronous response (sender expects a reply eventually), publish/subscribe (a service publishes a message to zero or more recipients), and publish/asynchronous response (publish a request to one or more recipients, some of whom reply) [c290494f5]. Resulting benefits: loose runtime coupling because it decouples the message sender from the consumer; improved availability because the message broker buffers messages until the consumer is able to process them; and support for a variety of communication patterns including request/reply, notifications, request/async response, publish/subscribe, and publish/async response [c290494f5]. Drawback: the additional complexity of a message broker, which must be highly available [c290494f5]. Open issue: request/reply-style communication is more complex [c290494f5].

## API Composition

Context: you have applied the Microservices architecture pattern and the Database per service pattern, so it is no longer straightforward to implement queries that join data from multiple services [cb7874314]. The problem: how to implement queries in a microservice architecture? [cb7874314]. Solution: implement a query by defining an *API Composer*, which invokes the services that own the data and performs an in-memory join of the results [cb7874314]. Benefit: it is a simple way to query data in a microservice architecture [cb7874314]. Drawback: some queries would result in inefficient, in-memory joins of large datasets [cb7874314].

## Avoiding fallback

The article distinguishes strategy categories — among them retry, failover ("perform the activity again against a different copy of the endpoint, or, preferably, perform multiple, parallel copies of the activity to raise the odds of at least one of them succeeding"), and fallback ("use a different mechanism to achieve the same result") — and states that it "covers fallback strategies and why we almost never use them at Amazon" [cfe9dcaec]. Critical failures prevent a service from producing useful results; for example, if a database query for product information fails, an ecommerce website cannot display the product page successfully [cfe9dcaec].

Single-machine framing: C code that calls `malloc()` and exits on `NULL` does not gracefully recover; on a single machine, if malloc fails the machine is probably out of memory, so there are bigger problems than one malloc call failing, which is why developers often ignore such failures [cfe9dcaec]. Adding a second method `malloc2` as a fallback looks reasonable but introduces problems: fallback logic can place unpredictable load on the system — even logging an error with a stack trace can turn a CPU-bound application into an I/O-bound one if the error rate spikes — and the fallback strategy will likely manifest as a latent bug because it rarely triggers in production, possibly taking years to fire [cfe9dcaec].

Distributed framing — the core argument: "distributed fallback has all the same problems, and more, when it comes to critical system failures" [cfe9dcaec]. Distributed fallback strategies are harder to test because multiple machines and downstream services play a part in the failures, and overload-type failure modes are hard to replicate; distributed fallback strategies themselves can fail [cfe9dcaec]. The body's worked example: falling back to direct database queries worked for months, but when the caches all failed around the same time every web server hit the database directly, locking up the database, blocking all web server processes, and spreading the outage to fulfillment centers worldwide [cfe9dcaec]. The load-bearing verdict: "the fallback strategy itself amplified the problem and was worse than no fallback strategy at all" — it turned a partial outage (not displaying shipping speeds) into a full-site outage [cfe9dcaec]. The reasoning behind that fallback was called illogical: "If hitting the database directly was more reliable than going through the cache, why bother with the cache in the first place?" [cfe9dcaec].

Recommended alternatives ("we now almost always prefer alternatives to fallback") [cfe9dcaec]:
- **Improve the reliability of non-fallback cases** — a service is much more available if the main (non-fallback) code is made more robust; e.g., invest in a database with higher inherent availability such as Amazon DynamoDB instead of implementing fallback logic between two data stores [cfe9dcaec].
- **Let the caller handle errors** — rather than fall back, let the calling system handle the failure (for example by retrying); AWS CLIs and SDKs already have built-in retry logic [cfe9dcaec].
- **Push data proactively** — reduce moving parts so data needed to fulfill a request is already present locally; IAM proactively pushes signed, rotated credentials to every EC2 instance, valid for many hours, so requests keep working even if the push mechanism is disrupted [cfe9dcaec].
- **Convert fallback into failover** — exercise both the fallback and non-fallback logic continuously and treat the fallback as an equally valid source of data (e.g., randomly choosing between responses); at that point the strategy is no longer fallback but failover [cfe9dcaec].
- **Ensure that retries and timeouts don't become fallback** — retries are powerful against transient and random errors but easy to get wrong, so the team maintains metrics on overall retry rates and alarms; proactive retry (hedging / parallel requests), built into quorum reads or writes, follows the design pattern of constant work so no extra load is added as the need for redundant requests increases [cfe9dcaec].

Conclusion: "At Amazon, we avoid fallback in our systems because it's difficult to prove and its effectiveness is hard to test"; fallback introduces an operational mode entered only in the most chaotic moments where things begin to break, and switching to it only increases the chaos [cfe9dcaec]. The favored approach is code paths exercised in production continuously rather than rarely, improving the availability of primary systems (e.g., pushing data instead of pulling), and watching for subtle behavior that flips code into a fallback-like mode such as performing too many retries; if fallback is essential, it should be exercised as often as possible in production so it behaves as reliably and predictably as the primary mode [cfe9dcaec].

## Workflow state machines

Dropped — see below.

## Dropped sources

- **c399aec44** (AWS Builder Library — workflow / state-machine article): the captured file contains no article body. It is the AWS "Sorry, this URL does not exist or is no longer available" error page wrapped in cookie-consent and global-navigation chrome — keyword scans of the body return zero hits for "state machine", "transition", or "long-running". No claim about workflow state machines can be anchored to its body, so per the body-prose-only rule the entire pattern section and source are dropped.
