[ ![BullMQ Logo](https://bullmq.io/images/bullmq-logo.png) ](https://bullmq.io/)
[ BullMQ on GitHub ](https://github.com/taskforcesh/bullmq)
[ ![Slack Logo](https://bullmq.io/images/slack.png) ](https://join.slack.com/t/bullmq/shared_invite/zt-1nbtpk6mv-TItWpF9jf3k4yrCaS0PPZA)
[ BullMQ on X ](https://x.com/manast)
[Use Cases](https://bullmq.io/use-cases) [News](https://bullmq.io/news) [Articles](https://bullmq.io/articles) [Docs](https://docs.bullmq.io/) [Api](https://api.docs.bullmq.io/) [Pro](https://bullmq.io/#bullmq-pro) [Careers Hiring](https://bullmq.io/careers)
[ BullMQ on GitHub ](https://github.com/taskforcesh/bullmq)
[ ![Slack Logo](https://bullmq.io/images/slack.png) ](https://join.slack.com/t/bullmq/shared_invite/zt-1nbtpk6mv-TItWpF9jf3k4yrCaS0PPZA)
[ BullMQ on X ](https://x.com/bullmqhq)
Friday, January 30, 2026
#  BunJS vs NodeJS Benchmark for BullMQ 
![Cover for BunJS vs NodeJS Benchmark for BullMQ](https://bullmq.io/images/4YIgZvgPxh-640.jpeg)
[ Go back to articles](https://bullmq.io/articles)
![Manuel Astudillo avatar](https://avatars.githubusercontent.com/u/95200?v=4)
Manuel Astudillo
[@manast](https://twitter.com/manast)
[ Pluggable Redis Clients in BullMQ ![Cover for Pluggable Redis Clients in BullMQ](https://bullmq.io/images/RgijcSuxhG-200.jpeg) ](https://bullmq.io/articles/guides/pluggable-redis-clients/)
[ Valkey Performance: 7.2 vs 8.1 vs 9.0 on AWS ![Cover for Valkey Performance: 7.2 vs 8.1 vs 9.0 on AWS](https://bullmq.io/images/_IkWqoqTF8-200.jpeg) ](https://bullmq.io/articles/benchmarks/valkey-performance-across-versions/)
[ We benchmarked every Valkey version. It was the wrong question. ![Cover for We benchmarked every Valkey version. It was the wrong question.](https://bullmq.io/images/nZHwBkn3vP-200.jpeg) ](https://bullmq.io/highlights/wrong-question/)
Yesterday we managed to run the complete BullMQ testsuite on BunJS, and is now part of our continuous integration process to ensure compatibility with this new runtime. This is our way to ensure that it is supported and officially compatible with BullMQ.
[BunJS](https://bun.sh/) has experienced a lot of traction the last couple of years and has now reached a level of maturity comparable to NodeJS for many use cases, but with a focus on performance and developer experience.
In my early experiments with BunJS around a year ago, I found that while BunJS could run BullMQ quite reliably, it was not really that much faster than NodeJS, at least for synthetic benchmarks. Today I wanted to perform new benchmarks to see how things stand now that BunJS has matured, and compare it with the latest NodeJS version (v24.13.0 at the time of writing).
I am running the benchmarks on my local machine. This is not an ideal benchmark environment, but hopefully it can give us some idea of the performance differences between the two runtimes. My machine is a MacBook Pro with M2 Pro chip, 16GB RAM, running macOS Ventura 13.4.1, with a local Redis server running with default configuration on Docker.
I am not doing any fancy tests, just some of the most standard operations in BullMQ. You can find the repo with the benchmark code and instructions to run it yourself at [bullmq-bun-bench](https://github.com/taskforcesh/bullmq-bun-bench).
In real world scenarios we usually have a dedicated fleet of workers so in this benchmark we are just trying to ascertain what overhead results from the queue management itself, whereas the actual heavy duty of processing the job is what at the end of the day is going to limit how many jobs you can process per second. In this regard BunJS could be much faster depending on the type of workload.
## Benchmark Configuration[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#benchmark-configuration)
  * **Jobs per test:** 50,000
  * **Worker concurrency:** 100
  * **Redis:** Local Docker instance
  * **Results:** Best of 5 runs


## Benchmark Results (50,000 Jobs)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#benchmark-results-50000-jobs)
### Job Addition (Queue.add)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#job-addition-queueadd)
Adding 50,000 jobs individually using `Queue.add()`:
Node.js v24Bun 1.3.3020K40K60K80K54,11367,751
Jobs per second - Individual job addition (1,000 parallel batches)
Bun is about **25% faster** than Node.js for individual job additions in this test. Both runtimes benefit from ioredis's auto-pipelining which batches concurrent Redis commands. We run 1,000 parallel `add()` calls at a time to simulate realistic high-throughput scenarios.
### Bulk Job Addition (Queue.addBulk)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#bulk-job-addition-queueaddbulk)
Adding 50,000 jobs at once using `Queue.addBulk()`:
Node.js v24Bun 1.3.3015K30K45K60K45,29057,013
Jobs per second - Bulk job addition
For bulk operations, Bun is **26% faster**. The `addBulk` method explicitly batches Redis commands into pipelines, making it highly efficient. Interestingly, individual `add()` calls with auto-pipelining can match or slightly exceed `addBulk` performance when there's enough concurrency.
### Job Processing[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#job-processing)
Processing 50,000 jobs with a worker at concurrency 100:
Node.js v24Bun 1.3.308.5K17K26K34K30,10233,670
Jobs per second - Job processing (concurrency=100)
For pure job processing, Bun is about **12% faster** than Node.js. Job processing is heavily I/O bound (Redis round-trips), so the runtime's JavaScript performance matters less here.
### Job Processing with CPU Work[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#job-processing-with-cpu-work)
Processing 50,000 jobs that include CPU-intensive work (recursive Fibonacci calculation):
Node.js v24Bun 1.3.304K8K12K16K11,11614,810
Jobs per second - Processing with CPU work
When jobs include actual CPU work (recursive Fibonacci calculation), Bun is **33% faster**. This suggests that Bun's JavaScriptCore engine performs better than Node's V8 for this type of CPU-bound workload.
### Flow Producer[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#flow-producer)
Creating 16,666 flows, each with a parent job and 2 children (49,998 total jobs):
Node.js v24Bun 1.3.309.5K19K29K38K26,16336,022
Jobs per second - Flow producer (parent + 2 children)
Flow creation is **38% faster** with Bun. Creating flows involves multiple Redis operations per flow, so this benchmark tests both JavaScript execution and Redis client performance.
## Summary (50,000 Jobs)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#summary-50000-jobs)  
| Benchmark  | Node.js v24  | Bun 1.3.3  | Difference  |  
| --- | --- | --- | --- |  
| Job Addition  | 54,113/sec  | 67,751/sec  | +25%  |  
| Bulk Addition  | 45,290/sec  | 57,013/sec  | +26%  |  
| Job Processing  | 30,102/sec  | 33,670/sec  | +12%  |  
| CPU Work  | 11,116/sec  | 14,810/sec  | +33%  |  
| Flow Producer  | 26,163/sec  | 36,022/sec  | +38%  |  
## Scaling to 100,000 Jobs[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#scaling-to-100000-jobs)
To see how performance holds up at larger scale, we also ran benchmarks with 100,000 jobs:
### Job Addition (100K)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#job-addition-100k)
Node.js v24Bun 1.3.3020K40K60K80K36,76567,385
Jobs per second - Individual job addition (100K jobs)
At 100K jobs, Bun's advantage grows to **83%** for individual job additions. Node.js performance dropped noticeably at this scale.
### Bulk Addition (100K)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#bulk-addition-100k)
Node.js v24Bun 1.3.3015K30K45K60K44,15055,866
Jobs per second - Bulk job addition (100K jobs)
Bulk addition shows a **27% advantage** for Bun, similar to the 50K results.
### Job Processing (100K)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#job-processing-100k)
Node.js v24Bun 1.3.309K18K27K36K34,17634,364
Jobs per second - Job processing (100K jobs)
At 100K jobs, both runtimes perform **nearly identically** for job processing (~0.5% difference).
### CPU Work (100K)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#cpu-work-100k)
Node.js v24Bun 1.3.304K8K12K16K11,31914,817
Jobs per second - Processing with CPU work (100K jobs)
CPU-intensive work shows a **31% advantage** for Bun, consistent with the 50K results.
### Flow Producer (100K)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#flow-producer-100k)
Node.js v24Bun 1.3.309K18K27K36K23,88934,340
Jobs per second - Flow producer (100K jobs)
Flow creation is **44% faster** with Bun at larger scale.
## Summary (100,000 Jobs)[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#summary-100000-jobs)  
| Benchmark  | Node.js v24  | Bun 1.3.3  | Difference  |  
| --- | --- | --- | --- |  
| Job Addition  | 36,765/sec  | 67,385/sec  | +83%  |  
| Bulk Addition  | 44,150/sec  | 55,866/sec  | +27%  |  
| Job Processing  | 34,176/sec  | 34,364/sec  | ~same  |  
| CPU Work  | 11,319/sec  | 14,817/sec  | +31%  |  
| Flow Producer  | 23,889/sec  | 34,340/sec  | +44%  |  
### Understanding the 100K Results[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#understanding-the-100k-results)
The 100K benchmark reveals some interesting patterns worth discussing.
**Node.js Job Addition Slowdown** :
The most striking difference is Node.js dropping from 54K to 37K jobs/sec for individual job additions, while Bun maintains a consistent ~67K jobs/sec at both scales. I am not sure but I think this could be attributed to V8's garbage collection behavior, with 100K concurrent promises and job objects, maybe GC pauses become more frequent and impactful. Bun's JavaScriptCore engine on the other hand appears to handle memory pressure more gracefully in this scenario.
**Job Processing Convergence** :
Interestingly, job processing performance converges at 100K jobs (from 12% difference to essentially identical). This reinforces that job processing is fundamentally I/O bound, the longer the benchmark runs, the more Redis round-trip latency dominates, masking any runtime differences.
**Consistent CPU Performance** :
The CPU-intensive workload shows consistent ~30% advantage for Bun at both scales, suggesting this difference is inherent to the JavaScript engine performance rather than memory management.
## Conclusions[](https://bullmq.io/articles/benchmarks/bunjs-vs-nodejs/#conclusions)
In these benchmarks, Bun was faster than Node.js across most operations, with differences ranging from nearly identical up to 83% depending on the workload and scale.
Key findings:
  * **Job Addition** shows the largest variance. Bun maintains consistent performance at both scales while Node.js slows down significantly at 100K jobs (+25% at 50K, +83% at 100K)
  * **CPU-intensive work** consistently favors Bun by ~30-33% at both scales
  * **Job Processing** is nearly identical at larger scale, confirming it's I/O bound
  * **Flow Producer** shows 38-44% improvement with Bun


Just remember that these are synthetic benchmarks running on a local machine with Redis on Docker, so expect differences in a production environment where Redis network latency may play a bigger role and where most likely you will have dedicated workers. In any case, it seems you can get a bit more juice out of your machines when using BunJS as it stands right now, specially considering that BunJS is probably also faster at doing the actual work in the workers, not just the queue handling which is basically what we are testing here.
NodeJS has proved to be a stable and quite fast runtime all these years, but now with BunJS being more mature, BullMQ users now have another runtime option, which is always a good thing in my opinion. If you're already using Node.js and it works well for you, there's no pressing need to switch. But if you're starting a new project or curious about Bun, you can expect comparable or slightly better performance for BullMQ workloads.
If you try BullMQ with Bun, we'd be happy to hear about your experience!
Copyright 2018-2026 BullForce Labs AB and BullMQ Contributors | [Licensed as MIT](https://github.com/taskforcesh/bullmq/blob/master/LICENSE)
[ ![SOC 2 Type II Certified](https://bullmq.io/images/21972-312_SOC_NonCPA_Blk.png) ](https://trust.taskforce.sh "View our SOC 2 Type II compliance status") [ ![GDPR Compliant](https://bullmq.io/images/gdpr-compliant.6f6aef57.png) ](https://trust.taskforce.sh "GDPR Compliant")

