[Sitemap](https://medium.com/sitemap/sitemap.xml)
[Open in app](https://play.google.com/store/apps/details?id=com.medium.reader&referrer=utm_source%3DmobileNavBar&source=post_page---top_nav_layout_nav-----------------------------------------)
Sign up
[Sign in](https://medium.com/m/signin?operation=login&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&source=post_page---top_nav_layout_nav-----------------------global_nav------------------)
[Medium Logo](https://medium.com/?source=post_page---top_nav_layout_nav-----------------------------------------)
Get app
[Write](https://medium.com/m/signin?operation=register&redirect=https%3A%2F%2Fmedium.com%2Fnew-story&source=---top_nav_layout_nav-----------------------new_post_topnav------------------)
[Search](https://medium.com/search?source=post_page---top_nav_layout_nav-----------------------------------------)
Sign up
[Sign in](https://medium.com/m/signin?operation=login&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&source=post_page---top_nav_layout_nav-----------------------global_nav------------------)
![Unknown user](https://miro.medium.com/v2/resize:fill:32:32/1*dmbNkD5D-u45r44go_cf0g.png)
# Kafka Delivery Semantics Explained: At-Most-Once, At-Least-Once & Exactly-Once
[![Priyanka Guha](https://miro.medium.com/v2/resize:fill:32:32/0*H-9XCAkeoLsHAif4.jpg)](https://medium.com/@priyankaguha.2012?source=post_page---byline--4311403f3659---------------------------------------)
[Priyanka Guha](https://medium.com/@priyankaguha.2012?source=post_page---byline--4311403f3659---------------------------------------)
Follow
8 min read
·
Nov 27, 2025
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fp%2F4311403f3659&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&user=Priyanka+Guha&userId=96296ae6ba88&source=---header_actions--4311403f3659---------------------clap_footer------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Frepost%2Fp%2F4311403f3659&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&user=Priyanka+Guha&userId=96296ae6ba88&source=---header_actions--4311403f3659---------------------repost_header------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fbookmark%2Fp%2F4311403f3659&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&source=---header_actions--4311403f3659---------------------bookmark_footer------------------)
[Listen](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2Fplans%3Fdimension%3Dpost_audio_button%26postId%3D4311403f3659&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&source=---header_actions--4311403f3659---------------------post_audio_button------------------)
Share
> [Old-School Kafka](https://medium.com/@priyankaguha.2012/old-school-kafka-a-terminal-first-approach-to-learning-distributed-streaming-1e9dcf5f5b1f), Part 6: The Reliability Trifecta of Message Delivery Guarantees
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*5g2N3WxVCTNhhMUcE53XsA.png)
In this series, we’ve been breaking down Kafka’s core concepts in a hands-on way. If you’re just joining us, you might want to check out the previous parts:
  * [**Part 1:** Terminal Guide to Your First Message](https://medium.com/@priyankaguha.2012/old-school-kafka-part-1-terminal-guide-to-your-first-message-ada914b53eed)
  * [**Part 2:** Diving into Partitions](https://medium.com/@priyankaguha.2012/part-2-partitions-the-key-to-kafkas-power-03f321f31382)
  * [**Part 3:** Understanding Message Keys and Ordering](https://medium.com/@priyankaguha.2012/old-school-kafka-part-3-kafka-message-keys-explained-how-to-preserve-order-in-distributed-event-ace26c6f0954)
  * [**Part 4:** Mastering Consumer Groups for Scalability](https://medium.com/@priyankaguha.2012/old-school-kafka-part-4-kafka-consumer-groups-how-rebalancing-powers-parallelism-36066f121f12)
  * [**Part 5** : Persistent Bookmark for Reliable Message Consumption](https://medium.com/@priyankaguha.2012/old-school-kafka-part-5-kafka-offsets-your-persistent-bookmark-for-reliable-message-consumption-368a34e28c7c?postPublishedType=repub)


In Part 5, we explored [**Kafka offsets** ](https://medium.com/@priyankaguha.2012/old-school-kafka-part-5-kafka-offsets-your-persistent-bookmark-for-reliable-message-consumption-368a34e28c7c)— persistent bookmarks that allow consumers to resume processing exactly where they left off. But understanding offsets alone isn’t enough.
The real question is:
> **_What happens if a consumer reads a message, processes it, and crashes before committing its offset?_**
Imagine this scenario:
> Should the message be delivered again?  
> Should it be skipped?  
> Should Kafka guarantee exactly once processing?
> Welcome to **Kafka delivery semantics** — the rules that define **how reliably messages are delivered and processed,** even in the presence of crashes, network issues, restarts, and operational chaos.
This post is the final chapter in our series, and we’ll end with real terminal proofs, a transactional producer in Java, and a crisp understanding of **how Kafka actually guarantees reliability**.
## The Core Question: How Many Times Is My Message Processed?
Kafka provides **three distinct delivery guarantees** , each determined by **when offsets are committed** :
  1. **At-Most-Once** → Offset committed _before_ processing → Fastest but Messages may be lost
  2. **At-Least-Once** → Offset committed _after_ processing → No data loss but Duplicates possible
  3. **Exactly-Once** → Transactions ensure atomicity → Perfect reliability but Requires special setup


And yes — we’ll prove each one with **real experiments** , not theory.
## Setup: A Clean Topic for Experiments

```
kafka-topics --bootstrap-server localhost:9092 \  
 --create --topic delivery-demo \  
 --partitions 1 --replication-factor 1
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*rVpvK02fHMJdFPVwIj9lbQ.png)
Open a producer:

```
kafka-console-producer --bootstrap-server localhost:9092 --topic delivery-demo
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*gDN_Z-ryrCjuZ_BkAg9AMg.png)
## 1. The Risky Fast Lane — At-Most-Once Delivery
> **Offsets are committed BEFORE processing.**  
>  If a crash happens between commit and processing → message is lost forever.
This happens when:
  * `enable.auto.commit=true`
  * Consumer commits offsets _every 5 seconds_
  * No manual commit after processing
  * Consumer crashes at the wrong time


### Step 1 — Start a Consumer With Auto-Commit (Default)

```
kafka-console-consumer \  
  --topic delivery-demo \  
  --bootstrap-server localhost:9092 \  
  --from-beginning \  
  --group at-most-once-group \  
  --property print.offset=true \  
  --property print.value=true
```

```
enable.auto.commit = true    
auto.commit.interval.ms = 5000 
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*8niZsH7pLlUDaHwxZlkV3g.png)
Every 5 seconds, Kafka commits the _latest offset read_ — regardless of whether processing succeeded.
###  **Step 2 —** Produce New Messages While Consumer Is Running
In another terminal:

```
kafka-console-producer \  
  --topic delivery-demo \  
  --bootstrap-server localhost:9092
```

Send:

```
Fast-1  
Fast-2  
Fast-3  
...
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*LcgGrQcXnB6F6MvGS3EelQ.png)
### Step 3 — Simulate Crash
> Wait for the consumer to print a few messages…
Then **Ctrl+C** to kill it _right after a commit but before processing finishes_.
Now restart

```
kafka-console-consumer \  
  --topic delivery-demo \  
  --bootstrap-server localhost:9092 \  
  --from-beginning \  
  --group at-most-once-group \  
  --property print.offset=true \  
  --property print.value=true
```

Try in two different terminals:
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*gZMZUqxDadhqxAhu2UGryg.png)
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*FQhMj9ya6eksWhHsrsaqog.png)
### Observation
> Some messages (e.g., `Fast-8`) never appear again.  
>  **They were committed but not processed. They are gone forever.**
Data Loss Confirmed.
### Lesson
At-most-once is blazing fast — minimum overhead.
But:
> Unreliable  
> Risky  
> Not acceptable for payments, billing, inventory, etc.
Great for:
  * Monitoring/statistics
  * Fire-and-forget workloads


## 2. The Reliability Default — At-Least-Once Delivery
> **Messages are NEVER lost** , but you may process some of them twice.
This is the _default model_ all Kafka clients use when you disable auto-commit and commit only after processing.
### Step 1 — Start Consumer With Auto-Commit Disabled

```
kafka-console-consumer \  
  --topic delivery-demo \  
  --bootstrap-server localhost:9092 \  
  --from-beginning \  
  --group at-least-once-group \  
  --property print.offset=true \  
  --property print.value=true \  
  --consumer-property enable.auto.commit=false
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*5vLi6L22R0FNB2-IPHPt8w.png)
In real consumers, you would:
  1. Read message
  2. Process message
  3. Commit offset


But for the console consumer, it doesn’t auto-commit at all — so we simulate.
### Step 2 — Produce Messages

```
Fast-A  
Fast-B  
Fast-C
```

### Step 3 — Crash Immediately
Let the consumer print some messages.  
Then **Ctrl+C** quickly — _before_ it commits anything.
## Get Priyanka Guha’s stories in your inbox
Join Medium for free to get updates from this writer.
Subscribe
Subscribe
Remember me for faster sign in
Restart:

```
kafka-console-consumer \  
  --topic delivery-demo \  
  --bootstrap-server localhost:9092 \  
  --from-beginning \  
  --group at-least-once-group \  
  --property print.offset=true \  
  --property print.value=true \  
  --consumer-property enable.auto.commit=false
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*Sckhx4_GejVfJlsfGIRggw.png)
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*PUkdHtenDC7yizjypGUKAg.png)
### Observation
> _Messages are reprocessed.  
>  You see duplicates._
**No data loss. But duplicates happen.**
### Lesson
At-least-once = **safe but not perfect**.
You must design processing to be **idempotent** , such as:
  * Upsert instead of insert
  * Check if event already processed
  * Store a hash of message ID


This is why most production Kafka systems **emphasize** :

```
idempotent consumers > exact-once systems
```

## 3. The Holy Grail — Exactly-Once Delivery
> No loss. No duplicates. Perfect processing.
But here’s the truth:
> We cannot produce real transactional messages using Kafka’s console producer.
Transactions require:
  * A real Kafka client
  * Idempotent producers
  * A transactional ID


So in this section, we’ll use:
  * Two terminal consumers
  * **A real Java transactional producer**
  * Actual isolation guarantees (`read_committed`)


### **Experiment Setup — Two Consumers, Two Realities**

```
Consumer A → Sees EVERYTHING (default isolation level)  
  
Consumer B → Sees ONLY committed messages (isolation.level=read_committed)
```

Using these two, we can “simulate” real transactional behavior.
### Step 1 — Create a Clean Topic

```
kafka-topics --bootstrap-server localhost:9092 \  
--create --topic eos-demo \  
--partitions 1 --replication-factor 1
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*BsbjjV4S1c79Fxa5BYNQIA.png)
### Step 2 — Start Consumer A (Reads All Messages)
This consumer represents a normal at-least-once consumer.

```
kafka-console-consumer --topic eos-demo \  
--bootstrap-server localhost:9092 \  
--from-beginning \  
--property print.offset=true \  
--property print.value=true
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*NiAvdFvNpQRrGBMyb1gwig.png)
Let this run.

```
kafka-console-consumer --topic eos-demo \  
--bootstrap-server localhost:9092 \  
--from-beginning \  
--isolation-level read_committed \  
--property print.offset=true \  
--property print.value=true
```

Leave this running side-by-side.
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*Gely2Aj-nccw4sOJY2EXTA.png)
This consumer **hides uncommitted messages.**
### Java Transactional Producer
Create a simple Maven project with:

```
package com.priyanka.kafka;  
  
import java.util.Properties;  
import org.apache.kafka.clients.producer.*;  
import org.apache.kafka.common.errors.ProducerFencedException;  
import org.apache.kafka.common.serialization.StringSerializer;  
  
public class Main {  
    public static void main(String[] args) {  
        Properties props = new Properties();  
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");  
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());  
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());  
        props.put(ProducerConfig.ACKS_CONFIG, "all");  
  
        props.put(ProducerConfig.TRANSACTIONAL_ID_CONFIG, "txn-producer-1");  
        props.put(ProducerConfig.ENABLE_IDEMPOTENCE_CONFIG, "true");  
  
  
        KafkaProducer<String, String> producer = new KafkaProducer<>(props);  
        producer.initTransactions();  
  
        try{  
            producer.beginTransaction();  
  
  
            producer.send(new ProducerRecord<>("eos-demo", "TXN-1"));  
            producer.send(new ProducerRecord<>("eos-demo", "TXN-2"));  
            producer.send(new ProducerRecord<>("eos-demo", "TXN-3"));  
            Thread.sleep(5000);  
  
            producer.commitTransaction();  
            System.out.println("Transaction Committed");  
        } catch(ProducerFencedException e) {  
            producer.abortTransaction();  
            System.out.println("Transaction Aborted (Fenced)");  
        } catch (Exception e) {  
            producer.abortTransaction();  
            System.out.println("Transaction Aborted");  
        }finally {  
            producer.close();  
        }  
    }  
}
```

Kafka will not expose the messages until commit.
### Run the Producer
Logs will confirm:
  * Transactional producer created
  * Coordinator found
  * ProducerId assigned
  * COMMIT executed


```
[main] INFO org.apache.kafka.clients.producer.KafkaProducer - [Producer clientId=producer-txn-producer-1, transactionalId=txn-producer-1] Instantiated a transactional producer.  
[main] INFO org.apache.kafka.common.utils.AppInfoParser - Kafka version: 3.5.1  
[main] INFO org.apache.kafka.common.utils.AppInfoParser - Kafka commitId: ***  
[main] INFO org.apache.kafka.common.utils.AppInfoParser - Kafka startTimeMs: 1764226138334  
[main] INFO org.apache.kafka.clients.producer.internals.TransactionManager - [Producer clientId=producer-txn-producer-1, transactionalId=txn-producer-1] Invoking InitProducerId ....  
::::::::::  
:::::::::  
Transaction Committed  
:::::::::  
::::::::
```

Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*N7K2Dds5h-DutG-LEwO2_Q.png)
Producer output
### Observe the Consumers
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*-ZakINlGSgeRE9lNXGwRVQ.png)
Well, I ran the producer twice 😀
> Perfect.  
>  Now let’s break the transaction.
Comment out commitTransaction in Java producer and see the difference.
Modify the code:

```
  
producer.send(new ProducerRecord<>("eos-demo", "TXN-4"));  
producer.send(new ProducerRecord<>("eos-demo", "TXN-5"));  
producer.send(new ProducerRecord<>("eos-demo", "TXN-6"));  
Thread.sleep(5000);  
  
// producer.commitTransaction();  
// System.out.println("Transaction Committed");
```

Run the producer again.
**What Happens?**
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*17kartBFuUDNigwzlOuoGA.png)
> Consumer A (default) => See the messages   
> Consumer B (read_committed) => No message - Uncommitted writes are invisible.
**Now let’s ABORT the transaction intentionally**
Modify the code again

```
       try{  
            producer.beginTransaction();  
  
            producer.send(new ProducerRecord<>("eos-demo", "TXN-7"));  
            producer.send(new ProducerRecord<>("eos-demo", "TXN-8"));  
            producer.send(new ProducerRecord<>("eos-demo", "TXN-9"));  
            Thread.sleep(5000);  
  
            if (true) {  
                throw new RuntimeException("Simulate failure");  
            }  
            producer.commitTransaction();  
            System.out.println("Transaction Committed");  
        } catch(ProducerFencedException e) {  
            producer.abortTransaction();  
            System.out.println("Transaction Aborted (Fenced)");  
        } catch (Exception e) {  
            producer.abortTransaction();  
            System.out.println("Transaction Aborted");  
        }
```

**What do the consumers see?**
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*ciLzKeGPS4mPVDYKtwqjAw.png)
> Consumer A (default) => See the messages again  
> Consumer B (read_committed) => No message — Aborted transactions vanish.
> **This is exactly-once in its purest form.**
## Final Lessons: Choosing the Right Delivery Guarantee
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*IfLhvJekkU1yGb7P3j_BjA.png)
Kafka gives you the freedom to choose the right model per workload.
## Ending the Old-School Kafka Series
This post wraps up our Old-School Kafka series.
We started with the basics.  
We moved through offsets, partitions, consumer groups, and debugging with nothing but a terminal.
And we end here — with the most misunderstood topic of all:  
**message delivery guarantees.**
The beauty of Kafka is not just that it scales —   
but that it gives you explicit control over correctness.
  * Choose performance.
  * Choose safety.
  * Choose perfection.


> Kafka supports all three — if you know how to use it.
Thanks for following the series.
[Kafka](https://medium.com/tag/kafka?source=post_page-----4311403f3659---------------------------------------)
[Distributed Systems](https://medium.com/tag/distributed-systems?source=post_page-----4311403f3659---------------------------------------)
[Messaging](https://medium.com/tag/messaging?source=post_page-----4311403f3659---------------------------------------)
[Software Engineering](https://medium.com/tag/software-engineering?source=post_page-----4311403f3659---------------------------------------)
[Programming](https://medium.com/tag/programming?source=post_page-----4311403f3659---------------------------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fp%2F4311403f3659&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&user=Priyanka+Guha&userId=96296ae6ba88&source=---footer_actions--4311403f3659---------------------clap_footer------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fp%2F4311403f3659&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&user=Priyanka+Guha&userId=96296ae6ba88&source=---footer_actions--4311403f3659---------------------clap_footer------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Frepost%2Fp%2F4311403f3659&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&user=Priyanka+Guha&userId=96296ae6ba88&source=---footer_actions--4311403f3659---------------------repost_footer------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fbookmark%2Fp%2F4311403f3659&operation=register&redirect=https%3A%2F%2Fmedium.com%2F%40priyankaguha.2012%2Fkafka-delivery-semantics-explained-at-most-once-at-least-once-exactly-once-4311403f3659&source=---footer_actions--4311403f3659---------------------bookmark_footer------------------)
[![Priyanka Guha](https://miro.medium.com/v2/resize:fill:48:48/0*H-9XCAkeoLsHAif4.jpg)](https://medium.com/@priyankaguha.2012?source=post_page---post_author_info--4311403f3659---------------------------------------)
[![Priyanka Guha](https://miro.medium.com/v2/resize:fill:64:64/0*H-9XCAkeoLsHAif4.jpg)](https://medium.com/@priyankaguha.2012?source=post_page---post_author_info--4311403f3659---------------------------------------)
Follow
## [Written by Priyanka Guha](https://medium.com/@priyankaguha.2012?source=post_page---post_author_info--4311403f3659---------------------------------------)
[12 followers](https://medium.com/@priyankaguha.2012/followers?source=post_page---post_author_info--4311403f3659---------------------------------------)
·[2 following](https://medium.com/@priyankaguha.2012/following?source=post_page---post_author_info--4311403f3659---------------------------------------)
Developer, tech enthusiast, and lifelong learner. Passionate about exploring new skills—whether it's coding or painting. Driven by progress, not competition.
Follow
[Help](https://help.medium.com/hc/en-us?source=post_page-----4311403f3659---------------------------------------)
[Status](https://status.medium.com/?source=post_page-----4311403f3659---------------------------------------)
[About](https://medium.com/about?autoplay=1&source=post_page-----4311403f3659---------------------------------------)
[Careers](https://medium.com/jobs-at-medium/work-at-medium-959d1a85284e?source=post_page-----4311403f3659---------------------------------------)
Press
[Blog](https://blog.medium.com/?source=post_page-----4311403f3659---------------------------------------)
[Store](https://medium.com/store)
[Privacy](https://policy.medium.com/medium-privacy-policy-f03bf92035c9?source=post_page-----4311403f3659---------------------------------------)
[Rules](https://policy.medium.com/medium-rules-30e5502c4eb4?source=post_page-----4311403f3659---------------------------------------)
[Terms](https://policy.medium.com/medium-terms-of-service-9db0094a1e0f?source=post_page-----4311403f3659---------------------------------------)
[Text to speech](https://speechify.com/medium?source=post_page-----4311403f3659---------------------------------------)

