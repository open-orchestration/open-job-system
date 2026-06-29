[Sitemap](https://medium.com/sitemap/sitemap.xml)
[Open in app](https://play.google.com/store/apps/details?id=com.medium.reader&referrer=utm_source%3DmobileNavBar&source=post_page---top_nav_layout_nav-----------------------------------------)
Sign up
[Sign in](https://medium.com/m/signin?operation=login&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&source=post_page---top_nav_layout_nav-----------------------global_nav------------------)
[Medium Logo](https://medium.com/?source=post_page---top_nav_layout_nav-----------------------------------------)
Get app
[Write](https://medium.com/m/signin?operation=register&redirect=https%3A%2F%2Fmedium.com%2Fnew-story&source=---top_nav_layout_nav-----------------------new_post_topnav------------------)
[Search](https://medium.com/search?source=post_page---top_nav_layout_nav-----------------------------------------)
Sign up
[Sign in](https://medium.com/m/signin?operation=login&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&source=post_page---top_nav_layout_nav-----------------------global_nav------------------)
![Unknown user](https://miro.medium.com/v2/resize:fill:32:32/1*dmbNkD5D-u45r44go_cf0g.png)
## [Vymo Engineering](https://medium.com/vymo-engineering?source=post_page---publication_nav-76baa618c16f-1176b7a4968b---------------------------------------)
·
Follow publication
[![Vymo Engineering](https://miro.medium.com/v2/resize:fill:38:38/1*s4eI4_InG2u4x-iUqvBmNg.png)](https://medium.com/vymo-engineering?source=post_page---post_publication_sidebar-76baa618c16f-1176b7a4968b---------------------------------------)
Vymo is a Sales Acceleration Platform of choice for leading Financial Institutions. Used by 350k+ salespeople across 60+ enterprises.
Follow publication
# Scaling Temporal: Load Testing with Postgres, Cassandra & Elasticsearch, Monitoring & Alerting
[![Bharat Pidikiti](https://miro.medium.com/v2/da:true/resize:fill:32:32/0*IFVftzlVdvmU-pRN)](https://medium.com/@bharat.pidikiti?source=post_page---byline--1176b7a4968b---------------------------------------)
[Bharat Pidikiti](https://medium.com/@bharat.pidikiti?source=post_page---byline--1176b7a4968b---------------------------------------)
Follow
9 min read
·
Mar 10, 2025
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fvymo-engineering%2F1176b7a4968b&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&user=Bharat+Pidikiti&userId=400414ac0414&source=---header_actions--1176b7a4968b---------------------clap_footer------------------)
15
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Frepost%2Fp%2F1176b7a4968b&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&user=Bharat+Pidikiti&userId=400414ac0414&source=---header_actions--1176b7a4968b---------------------repost_header------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fbookmark%2Fp%2F1176b7a4968b&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&source=---header_actions--1176b7a4968b---------------------bookmark_footer------------------)
[Listen](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2Fplans%3Fdimension%3Dpost_audio_button%26postId%3D1176b7a4968b&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&source=---header_actions--1176b7a4968b---------------------post_audio_button------------------)
Share
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*wmickhBI7EzpPoG0CYAEFQ.png)
**Introduction**
Temporal is a powerful workflow orchestration engine, but ensuring its scalability and performance in production requires rigorous load testing and robust monitoring. As part of our evaluation at Vymo, we conducted extensive benchmarking of Temporal with different configurations using PostgreSQL, Cassandra, and Elasticsearch (ES). Additionally, we implemented alerting and monitoring to ensure system reliability and proactive issue detection. Our goal was to understand how each setup performed under high workloads and determine the best approach for scaling and maintaining Temporal in our infrastructure.
In this article, We won’t go into the details of how Temporal works, as its official documentation already covers that extensively. Instead, the focus here is on **load testing, scaling recommendations, alerts, and monitoring strategies** to ensure optimal performance.
**Test Setup**
To test the performance of our system, we introduced a new API service specifically for load testing. This service exposes an API and emits a hardcoded payload to Temporal, acting as a controlled source of traffic.
Service code:

```
const express = require('express');  
const { Connection, Client } = require('@temporalio/client');  
const nanoid = require("nanoid");  
  
const app = express();  
app.use(express.json());  
  
const WORKFLOW_ID = '';  
const TASK_QUEUE = 'TQ1';  
const temporal_host = 'localhost:7233';  
  
let connection, client;  
  
async function init() {  
    connection = await Connection.connect({address: temporal_host});  
    console.log("initialized temporal connection with host: " + temporal_host);  
    client = new Client({  
        connection: connection,  
        namespace: "default"  
    })  
}  
  
init().then(() => {  
    app.post('/start-workflow', async (req, res) => {  
        try {  
            const handle = client.workflow.start("EventHandler", {  
                taskQueue: TASK_QUEUE,  
                args: [req.body],  
                workflowId: "LOAD_TEST_" + nanoid.nanoid(),  
                workflowExecutionTimeout: 10000  
            })  
              
            handle.then(async (handlerResponse) => {  
                const result = await handlerResponse.result();  
                res.status(200).send({ workflowId: result.workflowId, response: result });  
            });  
        } catch (error) {  
            console.error('Error starting workflow:', error);  
            res.status(500).send({ error: error.message });  
        }  
    });  
  
    app.listen(3000, () => {  
        console.log('Server is running on port 3000');  
    });  
  
}); 
```

We used **k6** to run load tests, experimenting with different message sizes, varying loads, and adjusting the number of virtual users (VUs) and test durations. K6 code:

```
import http from 'k6/http';  
import { check } from 'k6';  
  
export const options = {  
    vus: 100, // Number of virtual users  
    duration: '10s', // Duration of the test  
};  
  
const payload = JSON.stringify(<your json payload goes here>);  
  
const params = {  
    headers: {  
        'Content-Type': 'application/json',  
    }  
};  
  
export default function () {  
    const res = http.post('http://localhost:3000/start-workflow', payload, params);  
    console.log(res.status);  
    check(res, {  
        'is status 200': (r) => r.status === 200  
    });  
}
```

Since Node.js is single-threaded, we used **pm2** to scale the API service and ensure it was not a bottleneck. On the processing side, we had a fleet of workers built with Temporal’s TypeScript SDK. These workers executed workflows and returned success messages without performing any additional processing.
The primary goal of this setup was to determine the optimal throughput while keeping latency to a minimum.
**Key Things to Consider:**
Temporal consists of multiple underlying components, and we needed to ensure that none of them became a bottleneck during our tests. In our case, the key components to monitor were:
  1. **API Service** — Responsible for emitting events to Temporal.
  2. **Matching Service** — A core component of Temporal that routes tasks to appropriate workers.
  3. **History Service** — Manages workflow execution history within Temporal.
  4. **Frontend Service** — The entry point for API requests to Temporal.
  5. **Persistence Database** (PostgreSQL/Cassandra) — Stores workflow execution data.
  6. **Visibility Database** (PostgreSQL/Elasticsearch) — Enables querying workflow states and history.
  7. **Workers** — Process events and return responses.


To maintain optimal performance, each of these components needed to operate efficiently, without encountering load, CPU, or memory constraints that could introduce bottlenecks or failures.
Beyond infrastructure, one of the most critical components for scaling in Temporal is the **persistence database**. It plays a key role in storing workflow execution data, ensuring reliability, and handling high-throughput workloads efficiently.
Scaling in Temporal also depends heavily on **the number of shards** and **configured concurrency limits**. Shards distribute workflow executions across multiple database partitions, reducing contention and improving performance. Properly tuning the number of shards ensures that the system can handle increased load without overwhelming any single database node. Similarly, concurrency limits help control resource utilization, preventing excessive load on the system while maintaining smooth workflow execution.
Optimizing these factors is essential to achieving scalability and avoiding bottlenecks in high-traffic environments.
**Key Findings**
We initially started with **PostgreSQL** as the sole database for both **persistence and visibility** , but it quickly proved inadequate. Even with small event bursts of around **100 RPS** , the load on the PostgreSQL instance spiked beyond **120** , leading to **failures and shard issues** whenever traffic increased. It became clear that this setup wasn’t suitable for production.
Temporal’s official documentation also states that **PostgreSQL is not ideal for medium-to-large-scale systems**. Based on this, we restructured our database setup by **separating persistence and visibility** — using **Cassandra for persistence** and **PostgreSQL for visibility**. While this improved performance, PostgreSQL still became a bottleneck under high load. Since **horizontal scaling for PostgreSQL was not an option** , we opted to switch the **visibility database to Elasticsearch**.
This final setup — **Cassandra for persistence and Elasticsearch for visibility** — provided the best **throughput and scalability** , making it the most suitable choice for our needs. We also found that using **premium SSDs** with higher **IOPS** for database storage significantly improved **throughput** , reduced **p99 latencies** , and minimized **failures** under high load.
### Supporting Data:
8 core Cassandra — Best throughput scenario
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*f1wnVxj4EBGHHtYZvIj5eA.png)

```
  
50 vus - k6 run load_test_server.js  
  
          /\      |‾‾| /‾‾/   /‾‾/     
     /\  /  \     |  |/  /   /  /      
    /  \/    \    |     (   /   ‾‾\    
   /          \   |  |\  \ |  (‾)  |   
  / __________ \  |__| \__\ \_____/ .io  
     execution: local  
        script: load_test_server_1lead.js  
        output: -  
     scenarios: (100.00%) 1 scenario, 50 max VUs, 45s max duration (incl. graceful stop):  
              * default: 50 looping VUs for 15s (gracefulStop: 30s)  
     ✓ is status 200  
     checks.........................: 100.00% ✓ 10021      ✗ 0      
     data_received..................: 5.8 MB  387 kB/s  
     data_sent......................: 51 MB   3.4 MB/s  
     http_req_blocked...............: avg=14.07µs min=1.9µs   med=2.9µs   max=7.56ms   p(90)=4.1µs   p(95)=4.7µs     
     http_req_connecting............: avg=3.27µs  min=0s      med=0s      max=6.62ms   p(90)=0s      p(95)=0s        
     http_req_duration..............: avg=74.73ms min=37.5ms  med=71.5ms  max=489.35ms p(90)=93.02ms p(95)=102.45ms  
       { expected_response:true }...: avg=74.73ms min=37.5ms  med=71.5ms  max=489.35ms p(90)=93.02ms p(95)=102.45ms  
     http_req_failed................: 0.00%   ✓ 0          ✗ 10021  
     http_req_receiving.............: avg=60.94µs min=21.9µs  med=52.9µs  max=1.8ms    p(90)=84.1µs  p(95)=104.4µs   
     http_req_sending...............: avg=96.02µs min=46.6µs  med=77.8µs  max=7.01ms   p(90)=115.6µs p(95)=151.6µs   
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s      max=0s       p(90)=0s      p(95)=0s        
     http_req_waiting...............: avg=74.57ms min=37.29ms med=71.35ms max=489.23ms p(90)=92.87ms p(95)=102.3ms   
     http_reqs......................: 10021   665.294899/s  
     iteration_duration.............: avg=74.97ms min=37.68ms med=71.75ms max=489.52ms p(90)=93.3ms  p(95)=102.7ms   
     iterations.....................: 10021   665.294899/s  
     vus............................: 50      min=50       max=50   
     vus_max........................: 50      min=50       max=50   
running (15.1s), 00/50 VUs, 10021 complete and 0 interrupted iterations  
default ✓ [======================================] 50 VUs  15s
```

16 core Cassandra — Best throughput scenario
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*1SgdLcisxy2LnZk239tNPw.png)

```
#k6 run load_test_server.js  
   
          /\      |‾‾| /‾‾/   /‾‾/     
     /\  /  \     |  |/  /   /  /      
    /  \/    \    |     (   /   ‾‾\    
   /          \   |  |\  \ |  (‾)  |   
  / __________ \  |__| \__\ \_____/ .io  
     execution: local  
        script: load_test_server_1lead.js  
        output: -  
     scenarios: (100.00%) 1 scenario, 100 max VUs, 45s max duration (incl. graceful stop):  
              * default: 100 looping VUs for 15s (gracefulStop: 30s)  
     ✓ is status 200  
     checks.........................: 100.00% ✓ 18646       ✗ 0      
     data_received..................: 11 MB   720 kB/s  
     data_sent......................: 95 MB   6.3 MB/s  
     http_req_blocked...............: avg=6.8µs   min=1.8µs   med=3µs     max=13.42ms  p(90)=4.2µs    p(95)=4.97µs    
     http_req_connecting............: avg=2.52µs  min=0s      med=0s      max=12.59ms  p(90)=0s       p(95)=0s        
     http_req_duration..............: avg=80.42ms min=32.64ms med=72.34ms max=614.95ms p(90)=113.53ms p(95)=134.03ms  
       { expected_response:true }...: avg=80.42ms min=32.64ms med=72.34ms max=614.95ms p(90)=113.53ms p(95)=134.03ms  
     http_req_failed................: 0.00%   ✓ 0           ✗ 18646  
     http_req_receiving.............: avg=61.68µs min=22.4µs  med=51.7µs  max=2.81ms   p(90)=83.7µs   p(95)=109.4µs   
     http_req_sending...............: avg=92.22µs min=44.5µs  med=79.3µs  max=5.85ms   p(90)=121.5µs  p(95)=158.75µs  
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s      max=0s       p(90)=0s       p(95)=0s        
     http_req_waiting...............: avg=80.26ms min=32.52ms med=72.2ms  max=614.83ms p(90)=113.38ms p(95)=133.83ms  
     http_reqs......................: 18646   1236.942364/s  
     iteration_duration.............: avg=80.65ms min=32.81ms med=72.59ms max=615.14ms p(90)=113.79ms p(95)=134.26ms  
     iterations.....................: 18646   1236.942364/s  
     vus............................: 100     min=100       max=100  
     vus_max........................: 100     min=100       max=100  
running (15.1s), 000/100 VUs, 18646 complete and 0 interrupted iterations  
default ✓ [======================================] 100 VUs  15s
```

32 core cassandra best throughput scenario:
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*PDs3Us3Hkjr-fWKYttKdpA.png)

```
k6 run load_test_server.js  
   
          /\      |‾‾| /‾‾/   /‾‾/     
     /\  /  \     |  |/  /   /  /      
    /  \/    \    |     (   /   ‾‾\    
   /          \   |  |\  \ |  (‾)  |   
  / __________ \  |__| \__\ \_____/ .io  
     execution: local  
        script: load_test_server_1lead.js  
        output: -  
     scenarios: (100.00%) 1 scenario, 100 max VUs, 45s max duration (incl. graceful stop):  
              * default: 100 looping VUs for 15s (gracefulStop: 30s)  
     ✓ is status 200  
     checks.........................: 100.00% ✓ 27002       ✗ 0      
     data_received..................: 16 MB   1.0 MB/s  
     data_sent......................: 138 MB  9.2 MB/s  
     http_req_blocked...............: avg=11.2µs   min=1.7µs   med=3.5µs   max=12.16ms  p(90)=4.3µs    p(95)=5.2µs     
     http_req_connecting............: avg=4.36µs   min=0s      med=0s      max=6.62ms   p(90)=0s       p(95)=0s        
     http_req_duration..............: avg=55.33ms  min=35.56ms med=50.61ms max=256.65ms p(90)=75.23ms  p(95)=86.68ms   
       { expected_response:true }...: avg=55.33ms  min=35.56ms med=50.61ms max=256.65ms p(90)=75.23ms  p(95)=86.68ms   
     http_req_failed................: 0.00%   ✓ 0           ✗ 27002  
     http_req_receiving.............: avg=67.41µs  min=21µs    med=52.8µs  max=6.25ms   p(90)=89.6µs   p(95)=133.09µs  
     http_req_sending...............: avg=110.32µs min=43.3µs  med=84µs    max=12.71ms  p(90)=141.39µs p(95)=188.2µs   
     http_req_tls_handshaking.......: avg=0s       min=0s      med=0s      max=0s       p(90)=0s       p(95)=0s        
     http_req_waiting...............: avg=55.15ms  min=35.42ms med=50.44ms max=256.53ms p(90)=74.99ms  p(95)=86.47ms   
     http_reqs......................: 27002   1793.405991/s  
     iteration_duration.............: avg=55.6ms   min=35.77ms med=50.86ms max=256.83ms p(90)=75.67ms  p(95)=86.94ms   
     iterations.....................: 27002   1793.405991/s  
     vus............................: 100     min=100       max=100  
     vus_max........................: 100     min=100       max=100  
running (15.1s), 000/100 VUs, 27002 complete and 0 interrupted iterations  
default ✓ [======================================] 100 VUs  15s
```

Impact of event size:
Throughput drops significantly as message size increases. To maximize performance, it’s crucial to keep payloads as small as possible. Refer:
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*RO07AM8L3Su8NDX6dgf0Xg.png)
**Final Recommendations for small sized payloads with Cassandra & ES:**
## Get Bharat Pidikiti’s stories in your inbox
Join Medium for free to get updates from this writer.
Subscribe
Subscribe
Remember me for faster sign in
Based on our learnings, we’ve created a recommended configuration table for **small-sized payloads**. If you’re aiming for similar throughputs in the range of **500–2000 RPS** with minimal latency, you can use the table below as a reference.
Press enter or click to view image in full size
![](https://miro.medium.com/v2/resize:fit:700/1*VDdTnZKL_UbDtBgGypEqbA.png)
## Monitoring & Alerting
Effective monitoring and alerting are crucial to ensure the **health, stability, and performance** of your Temporal-based system, especially under high load. Based on our setup and learnings, here are key areas to focus on:
### 1. Key Metrics to Monitor
**Application & API Service Metrics:**
  * **Request Rate (RPS)** — Monitor incoming request rates to identify spikes and bottlenecks.
  * **Response Time (P95/P99 Latencies)** — Keep track of response times for both API and Temporal workflow executions.
  * **Error Rate** — Watch for HTTP 5xx responses or Temporal failures to detect anomalies early.
  * **Queue Backlog** — If the API service cannot push events quickly, workflows may queue up.


**Temporal Metrics:**
  * **Workflow Execution Rate** — Number of workflows started per second.
  * **Task Queue Depth** — High queue depth could indicate that workers are overwhelmed.
  * **Workflow Execution Latency** — Delays in workflow execution could mean performance bottlenecks in Temporal services.
  * **Shard Distribution & Load** — Temporal shards should be evenly distributed; uneven load could mean a misconfigured setup.
  * Few temporal prometheus metrics to monitor:  
— persistence_latency_bucket  
— temporal_workflow_endtoend_latency_bucket  
— lock_latency_bucket  
— temporal_activity_execution_latency_bucket


**Database Metrics:**
  * **Read/Write Latency** — High read/write times on **Cassandra or PostgreSQL/Elasticsearch** can slow down workflows.
  * **CPU & Memory Usage** — Monitor resource usage for signs of database stress.
  * **IOPS (Disk Performance)** — Ensure **premium SSDs** with high IOPS are keeping up with demand.


**Infrastructure & System Metrics:**
  * **CPU & Memory Usage on Workers** — Ensure workers have enough resources and are not over-utilized.
  * **Network Throughput** — Monitor data transfer rates to detect bottlenecks.
  * **Instance Scaling** — Keep an eye on auto-scaling behavior to ensure the system adapts to load changes.


### 2. Alerts & Thresholds
Set up alerts to catch issues before they impact performance. Recommended alert thresholds:
  * **High Response Times** (> P99 latency of X ms)
  * **Task Queue Backlog Exceeding Limit** (> Y pending tasks for Z minutes)
  * **Workflow Failure Rate** (> 0.1% failure rate over 5 minutes)
  * **Database Load Spike** (CPU > 80%, Read/Write Latency > N ms)
  * **Worker CPU Saturation** (> 85% CPU usage for X minutes)
  * **Shard Imbalance** (Uneven shard distribution causing delays)


### 3. Tools Used for Monitoring & Alerting
We used a combination of **open-source and cloud-native** monitoring tools:
  * **Prometheus + Grafana** — To collect and visualize Temporal, API, and database metrics.
  * **Zenduty —** For alerting
  * **Loki** — For log aggregation and querying historical execution data.
  * **Slack Alerts** — To notify the team when critical thresholds are breached.


### 4. Learnings & Best Practices
  * **Proactive Monitoring** — Dashboards should show trends over time, not just current stats.
  * **Fine-Tuned Alerting** — Avoid too many noisy alerts; focus on critical failures and early warning signs.
  * **Log Aggregation** — Centralized logs make debugging easier.
  * **Auto-Scaling Rules** — Set up rules to scale **workers and API services dynamically** based on queue depth and CPU usage.


Authors:  
Bharat Pidikiti — <https://www.linkedin.com/in/bharath0428/>  
Daya Shankar — <https://www.linkedin.com/in/daya-shankar-namana-67009695/>
[Temporal](https://medium.com/tag/temporal?source=post_page-----1176b7a4968b---------------------------------------)
[Load Testing](https://medium.com/tag/load-testing?source=post_page-----1176b7a4968b---------------------------------------)
[Monitoring](https://medium.com/tag/monitoring?source=post_page-----1176b7a4968b---------------------------------------)
[Fine Tuning](https://medium.com/tag/fine-tuning?source=post_page-----1176b7a4968b---------------------------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fvymo-engineering%2F1176b7a4968b&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&user=Bharat+Pidikiti&userId=400414ac0414&source=---footer_actions--1176b7a4968b---------------------clap_footer------------------)
15
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fvote%2Fvymo-engineering%2F1176b7a4968b&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&user=Bharat+Pidikiti&userId=400414ac0414&source=---footer_actions--1176b7a4968b---------------------clap_footer------------------)
15
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Frepost%2Fp%2F1176b7a4968b&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&user=Bharat+Pidikiti&userId=400414ac0414&source=---footer_actions--1176b7a4968b---------------------repost_footer------------------)
[](https://medium.com/m/signin?actionUrl=https%3A%2F%2Fmedium.com%2F_%2Fbookmark%2Fp%2F1176b7a4968b&operation=register&redirect=https%3A%2F%2Fmedium.com%2Fvymo-engineering%2Fscaling-temporal-load-testing-with-postgres-cassandra-elasticsearch-monitoring-alerting-1176b7a4968b&source=---footer_actions--1176b7a4968b---------------------bookmark_footer------------------)
[![Vymo Engineering](https://miro.medium.com/v2/resize:fill:48:48/1*s4eI4_InG2u4x-iUqvBmNg.png)](https://medium.com/vymo-engineering?source=post_page---post_publication_info--1176b7a4968b---------------------------------------)
[![Vymo Engineering](https://miro.medium.com/v2/resize:fill:64:64/1*s4eI4_InG2u4x-iUqvBmNg.png)](https://medium.com/vymo-engineering?source=post_page---post_publication_info--1176b7a4968b---------------------------------------)
Follow
## [Published in Vymo Engineering](https://medium.com/vymo-engineering?source=post_page---post_publication_info--1176b7a4968b---------------------------------------)
[17 followers](https://medium.com/vymo-engineering/followers?source=post_page---post_publication_info--1176b7a4968b---------------------------------------)
·[Last published Jun 30, 2025](https://medium.com/vymo-engineering/the-vymo-web-platform-engineering-scale-and-efficiency-with-a-custom-monorepo-architecture-760d9843b90f?source=post_page---post_publication_info--1176b7a4968b---------------------------------------)
Vymo is a Sales Acceleration Platform of choice for leading Financial Institutions. Used by 350k+ salespeople across 60+ enterprises.
Follow
[![Bharat Pidikiti](https://miro.medium.com/v2/resize:fill:48:48/0*IFVftzlVdvmU-pRN)](https://medium.com/@bharat.pidikiti?source=post_page---post_author_info--1176b7a4968b---------------------------------------)
[![Bharat Pidikiti](https://miro.medium.com/v2/resize:fill:64:64/0*IFVftzlVdvmU-pRN)](https://medium.com/@bharat.pidikiti?source=post_page---post_author_info--1176b7a4968b---------------------------------------)
Follow
## [Written by Bharat Pidikiti](https://medium.com/@bharat.pidikiti?source=post_page---post_author_info--1176b7a4968b---------------------------------------)
[1 follower](https://medium.com/@bharat.pidikiti/followers?source=post_page---post_author_info--1176b7a4968b---------------------------------------)
·[1 following](https://medium.com/@bharat.pidikiti/following?source=post_page---post_author_info--1176b7a4968b---------------------------------------)
Follow
[Help](https://help.medium.com/hc/en-us?source=post_page-----1176b7a4968b---------------------------------------)
[Status](https://status.medium.com/?source=post_page-----1176b7a4968b---------------------------------------)
[About](https://medium.com/about?autoplay=1&source=post_page-----1176b7a4968b---------------------------------------)
[Careers](https://medium.com/jobs-at-medium/work-at-medium-959d1a85284e?source=post_page-----1176b7a4968b---------------------------------------)
Press
[Blog](https://blog.medium.com/?source=post_page-----1176b7a4968b---------------------------------------)
[Store](https://medium.com/store)
[Privacy](https://policy.medium.com/medium-privacy-policy-f03bf92035c9?source=post_page-----1176b7a4968b---------------------------------------)
[Rules](https://policy.medium.com/medium-rules-30e5502c4eb4?source=post_page-----1176b7a4968b---------------------------------------)
[Terms](https://policy.medium.com/medium-terms-of-service-9db0094a1e0f?source=post_page-----1176b7a4968b---------------------------------------)
[Text to speech](https://speechify.com/medium?source=post_page-----1176b7a4968b---------------------------------------)

