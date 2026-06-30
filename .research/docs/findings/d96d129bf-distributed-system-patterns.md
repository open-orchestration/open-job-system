---
id: d96d129bf
topic: gap-fill
title: "Distributed-System Patterns: Claim-Check and Strangler-Fig"
status: draft
shape: survey
---

# Distributed-System Patterns: Claim-Check and Strangler-Fig

Survey of distributed-system patterns relevant to a job/queue platform, drawn strictly from the cited source bodies. Each pattern's claims carry only its own source; no cross-attribution.

## Claim-Check (Store in Library): large-payload handling

The Content Enricher addresses messages missing required data, and the Content Filter removes uninteresting data items, but sometimes fields should be removed only temporarily [c2f4da0bd]. A message may contain data items needed later in the message flow yet unnecessary for all intermediate processing steps, and carrying all that information through each step can cause performance degradation and makes debugging harder because so much extra data is carried [c2f4da0bd]. The pattern frames the problem as: how to reduce the data volume of a message sent across the system without sacrificing information content [c2f4da0bd].

Mechanism: store message data in a persistent store and pass a Claim Check to subsequent components, which can use the Claim Check to retrieve the stored information [c2f4da0bd]. The steps are: a message with data arrives; a "Check Luggage" component generates a unique key that will serve as the Claim Check; the component extracts the data and stores it in a persistent store such as a file or a database, associating the stored data with the key; it removes the persisted data from the message and adds the Claim Check; and another component can use a Content Enricher to retrieve the data based on the Claim Check [c2f4da0bd]. The source likens this to checking luggage at an airport counter and receiving a reference number that uniquely identifies each checked piece [c2f4da0bd]. For a job/queue platform, this is the mechanism for handling large message payloads: the source's stated goal is reducing the data volume carried across the system while preserving information content [c2f4da0bd].

## Strangler-Fig: incremental migration

The term "Strangler Fig" describes a gradual approach to legacy modernization [cdb0541dc]. Software systems are often built over decades with patch upon patch, each patch making future change harder, until people realize they can no longer patch and need a wholesale modernization [cdb0541dc]. The source warns that treating this as a simple replacement — building a new system that does exactly what the old one does in better technology — has been seen to "go down in flames most of the time": replacing a serious IT system takes a long time, users cannot wait for new features, existing behavior is hard to specify in detail, and much of that behavior is unwanted so rebuilding it is waste [cdb0541dc].

Mechanism: a gradual process of modernization that, like the fig, begins with small additions — often new features — built on top of yet separate to the legacy code base, while bits of behavior are moved from the legacy system into the new code base [cdb0541dc]. The source cites four high-level activities defined by Ian Cartwright, Rob Horn, and James Lewis — understand the outcomes you want, decide how to break the problem into smaller parts, successfully deliver the parts, and change the organization to allow this on an ongoing basis — noting the ordering does not imply a sequence [cdb0541dc]. Breaking the system down involves identifying seams that can be inserted to split it, and extracting individual business needs into new components [cdb0541dc]. Replacing small components carries less risk, lets the business reap value and earlier return on investment, and yields learning that improves later decisions [cdb0541dc]. The approach often requires transitional architecture so the new and legacy systems can coexist — code that goes away once modernization is complete — and broader organizational change in recognition of Conway's Law [cdb0541dc]. For a job/queue platform migration, the source's framing is incremental displacement: investment and returns occur gradually and visibly rather than via a single big-bang replacement [cdb0541dc].

## Dropped sources

- **c9a0d88a5** (intended: AWS Prescriptive Guidance — DLQ redrive). Dropped: the file body is the AWS Prescriptive Guidance "Cloud design patterns, architectures, and implementations" *introduction* page — introductory prose on microservices modernization, targeted business outcomes, and a navigation list of patterns. The body does not describe the dead-letter-queue redrive mechanism (moving messages from a DLQ back to the source queue), so no DLQ-redrive claim can be anchored to it. Per the no-fabrication / body-only rules, the DLQ-redrive section is omitted.
