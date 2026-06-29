[![](https://blog.rajpoot.dev/img/personal/profile.jpg)AlzyWelzy](https://blog.rajpoot.dev/ "AlzyWelzy \(Alt + H\)")
  * [Posts](https://blog.rajpoot.dev/posts/ "Posts")
  * [Cheatsheets](https://blog.rajpoot.dev/cheatsheets/ "Cheatsheets")
  * [Textbooks](https://blog.rajpoot.dev/textbooks/ "Textbooks")
  * [System Design](https://blog.rajpoot.dev/system-design/ "System Design")
  * [Archive](https://blog.rajpoot.dev/archives/ "Archive")
  * [Tags](https://blog.rajpoot.dev/tags/ "Tags")
  * [Search](https://blog.rajpoot.dev/search/ "Search \(Alt + /\)")
  * [About](https://blog.rajpoot.dev/about/ "About")

[Home](https://blog.rajpoot.dev/) [All Posts](https://blog.rajpoot.dev/posts/) [Backend Engineering](https://blog.rajpoot.dev/posts/backend/)
# Temporal and Durable Execution in 2026 — The Reliability Layer
What durable execution is, why Temporal won the workflow engine market in 2026, and how to use it for reliable agents, payments, and long-running processes.
April 30, 2026 · 7 min · 1329 words · Manvendra Rajpoot |  [Suggest an edit](https://github.com/AlzyWelzy/blog/edit/main/content/posts/backend/temporal-durable-execution-2026.md)
Table of Contents
  * [What durable execution is](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#what-durable-execution-is)
  * [How it actually works](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#how-it-actually-works)
  * [When to reach for Temporal](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#when-to-reach-for-temporal)
  * [A working example (Python SDK)](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#a-working-example-python-sdk)
  * [The saga pattern, simplified](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#the-saga-pattern-simplified)
  * [Temporal for AI agents](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#temporal-for-ai-agents)
  * [Temporal vs alternatives](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#temporal-vs-alternatives)
  * [Operating Temporal](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#operating-temporal)
  * [Common mistakes](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#common-mistakes)
    * [1. Doing I/O in workflow code](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#1-doing-io-in-workflow-code)
    * [2. Using datetime.now()](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#2-using-datetimenow)
    * [3. No retry policy](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#3-no-retry-policy)
    * [4. Workflow code that grows unbounded history](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#4-workflow-code-that-grows-unbounded-history)
    * [5. Treating it as a queue](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#5-treating-it-as-a-queue)
  * [When I’d reach for it day one](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#when-id-reach-for-it-day-one)
  * [Read this next](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#read-this-next)


By 2026 “workflow engine” is becoming as standard as “message queue” in production stacks. **Temporal** leads the category — $5B valuation in February, OpenAI / Block / Yum running it for mission-critical paths, and a model called **durable execution** that’s quietly reshaping how we build reliable systems.
This post is the working knowledge.
## What durable execution is[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#what-durable-execution-is)
Most application code looks like:

```
def process_order(order_id):
    charge = stripe.charge(order_id)
    inventory.reserve(order_id)
    shipping.schedule(order_id)
    notifier.send_confirmation(order_id)

```
pythoncopy
Now ask: what happens if the process crashes between `stripe.charge` and `inventory.reserve`? Charged but no inventory reserved. You write retries. You write compensations. You write idempotency keys. You build a state machine in Postgres. You debug it for six months.
Durable execution flips this. **The platform persists every step.** If a worker crashes mid-flow, another worker resumes exactly where it left off. Your code looks like a regular function — the platform handles the durability:

```
@workflow.defn
class OrderWorkflow:
    @workflow.run
    async def run(self, order_id: str):
        await workflow.execute_activity(stripe_charge, order_id, schedule_to_close_timeout=60)
        await workflow.execute_activity(reserve_inventory, order_id, schedule_to_close_timeout=30)
        await workflow.execute_activity(schedule_shipping, order_id, schedule_to_close_timeout=30)
        await workflow.execute_activity(send_confirmation, order_id, schedule_to_close_timeout=10)

```
pythoncopy
This function runs **once and to completion** , even if the process running it dies a hundred times.
## How it actually works[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#how-it-actually-works)
Temporal records an **event history** for each workflow:

```
1. WorkflowTaskScheduled
2. WorkflowTaskStarted        → worker picked up
3. ActivityTaskScheduled      → "stripe_charge"
4. ActivityTaskCompleted      → result: { charge_id: "..." }
5. WorkflowTaskCompleted
6. ActivityTaskScheduled      → "reserve_inventory"
   ... worker dies here ...
7. ActivityTaskTimeOut
8. ActivityTaskScheduled      → retry
9. ActivityTaskCompleted
10. ...

```
fallbackcopy
When a worker resumes a workflow, it **replays the history** to rebuild the in-memory state. From the application’s perspective, time skipped forward; the function picks up after the last completed step.
The key constraint: **workflow code must be deterministic**. No `datetime.now()`, no `random.random()`, no I/O. Use `workflow.now()`, `workflow.uuid4()`, `workflow.execute_activity()` — Temporal-provided primitives that produce the same result on replay.
## When to reach for Temporal[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#when-to-reach-for-temporal)
Strong fits:
  * **Payments + side effects.** Charge, reserve, fulfill, notify. Each step matters.
  * **Agent orchestration.** AI agent calls tools across systems with retries, timeouts, human-in-the-loop. (See [AI Agents with LangGraph](https://blog.rajpoot.dev/posts/ai/ai-agents-with-langgraph-tutorial/) .)
  * **Long-running flows.** Subscription renewals, fraud reviews that span days, multi-step ML training.
  * **Sagas.** Multi-service operations with compensations on failure.
  * **Periodic jobs that must complete.** Replace cron + queue + retry logic with one workflow definition.


Weak fits:
  * Stateless request/response APIs.
  * Pure data pipelines (use Airflow / Dagster).
  * High-throughput simple jobs (a million-per-second event processor — use Kafka + plain consumers).


## A working example (Python SDK)[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#a-working-example-python-sdk)

```
# activities.py
from temporalio import activity
from typing import TypedDict


class ChargeResult(TypedDict):
    charge_id: str
    amount: int


@activity.defn
async def stripe_charge(order_id: str) -> ChargeResult:
    # Real call to Stripe; raises on error → Temporal retries per policy
    ...


@activity.defn
async def reserve_inventory(order_id: str) -> None:
    ...


@activity.defn
async def refund_charge(charge_id: str) -> None:
    ...

```
pythoncopy

```
# workflow.py
from datetime import timedelta
from temporalio import workflow
from temporalio.common import RetryPolicy

with workflow.unsafe.imports_passed_through():
    from .activities import stripe_charge, reserve_inventory, refund_charge


@workflow.defn
class OrderWorkflow:
    @workflow.run
    async def run(self, order_id: str) -> str:
        retry = RetryPolicy(maximum_attempts=5, initial_interval=timedelta(seconds=1))

        charge = await workflow.execute_activity(
            stripe_charge, order_id,
            start_to_close_timeout=timedelta(seconds=60),
            retry_policy=retry,
        )

        try:
            await workflow.execute_activity(
                reserve_inventory, order_id,
                start_to_close_timeout=timedelta(seconds=30),
                retry_policy=retry,
            )
        except Exception as e:
            # Compensation — refund the charge
            await workflow.execute_activity(
                refund_charge, charge["charge_id"],
                start_to_close_timeout=timedelta(seconds=30),
            )
            raise

        return f"order {order_id} fulfilled"

```
pythoncopy

```
# worker.py
import asyncio
from temporalio.client import Client
from temporalio.worker import Worker
from .workflow import OrderWorkflow
from .activities import stripe_charge, reserve_inventory, refund_charge


async def main():
    client = await Client.connect("temporal:7233")
    worker = Worker(
        client,
        task_queue="orders",
        workflows=[OrderWorkflow],
        activities=[stripe_charge, reserve_inventory, refund_charge],
    )
    await worker.run()


if __name__ == "__main__":
    asyncio.run(main())

```
pythoncopy

```
# starter (e.g. from FastAPI)
client = await Client.connect("temporal:7233")
handle = await client.start_workflow(
    OrderWorkflow.run,
    order_id,
    id=f"order-{order_id}",
    task_queue="orders",
)
result = await handle.result()

```
pythoncopy
That’s a complete durable order pipeline. **The crash story is free** — kill the worker mid-flow, restart, the workflow continues.
## The saga pattern, simplified[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#the-saga-pattern-simplified)
The “if step 3 fails, compensate steps 2 and 1” pattern that takes hundreds of lines without a workflow engine becomes a `try/except` with `await workflow.execute_activity(compensate_X, ...)` calls in the except block. Temporal makes the compensation logic indistinguishable from happy-path logic.
I covered the principle in [Idempotency, Retries, and Exactly-Once Illusions](https://blog.rajpoot.dev/posts/backend/idempotency-retries-exactly-once/) . Temporal automates 80% of the boilerplate.
## Temporal for AI agents[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#temporal-for-ai-agents)
Agentic workflows are perfect for Temporal:
  * Long-running (LLM calls take seconds; workflows take minutes/hours).
  * Multi-step with branches.
  * Tool calls that fail and need retries.
  * Human-in-the-loop pauses.



```
@workflow.defn
class ResearchAgent:
    @workflow.run
    async def run(self, question: str) -> str:
        plan = await workflow.execute_activity(
            llm_plan, question, start_to_close_timeout=timedelta(seconds=30),
        )

        results = []
        for step in plan["steps"]:
            r = await workflow.execute_activity(
                run_tool, step,
                start_to_close_timeout=timedelta(seconds=60),
                retry_policy=RetryPolicy(maximum_attempts=3),
            )
            results.append(r)

            if step.get("require_approval"):
                # Pause until external signal
                await workflow.wait_condition(lambda: self._approved or self._rejected)
                if self._rejected:
                    return "user rejected"

        answer = await workflow.execute_activity(
            llm_synthesize, {"question": question, "results": results},
            start_to_close_timeout=timedelta(seconds=60),
        )
        return answer

    @workflow.signal
    def approve(self):
        self._approved = True

    @workflow.signal
    def reject(self):
        self._rejected = True

    _approved: bool = False
    _rejected: bool = False

```
pythoncopy
This single workflow has:
  * LLM planning step.
  * Tool execution loop with retries.
  * Human approval (signal-based) for risky tool calls.
  * Final synthesis.


If the worker crashes during step 3 of 7, a fresh worker resumes at step 3. State, including which tools have run, is reconstructed from the event history.
## Temporal vs alternatives[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#temporal-vs-alternatives)  
|   | Temporal  | Airflow  | AWS Step Functions  | Inngest  | Restate  |  
| --- | --- | --- | --- | --- | --- |  
| Code-first  | Yes  | Python DSL  | Visual / JSON  | Yes  | Yes  |  
| Long-running  | Excellent  | Limited  | Excellent  | Excellent  | Excellent  |  
| Self-host  | Yes  | Yes  | No  | Yes (cloud + OSS)  | Yes  |  
| AI agent fit  | Excellent  | Mediocre  | Mediocre  | Strong  | Strong  |  
| SDKs  | Go, Java, Python, TS, .NET, Ruby, PHP  | Python  | Many  | TS first  | Multi-language  |  
| Maturity  | High  | High  | High  | Mid  | Newer  |  
Pick:
  * **Temporal** for serious production workflows that span services and time.
  * **Airflow / Dagster** for batch data pipelines (ETL).
  * **Step Functions** if you’re fully on AWS and prefer managed.
  * **Inngest** for TS-first lightweight workflows.
  * **Restate** for the newest, simpler durable execution model with deeper distributed transactions story.


## Operating Temporal[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#operating-temporal)
You can run Temporal three ways:
  1. **Temporal Cloud** — managed. ~$200+/month minimum but no ops.
  2. **Self-hosted on Kubernetes** — Helm chart works. Cassandra or Postgres backend.
  3. **Temporalite / dev server** — for local dev only.


Operationally:
  * **Scaling.** Workers are horizontal; servers depend on the persistence backend.
  * **Observability.** Built-in UI shows every workflow execution. Add OpenTelemetry for cross-service traces — see [OpenTelemetry End-to-End](https://blog.rajpoot.dev/posts/devops/opentelemetry-end-to-end-observability/) .
  * **Versioning.** Long-running workflows are sensitive to code changes. Use `workflow.patched()` or “Versioning” to evolve workflow code safely.
  * **Retention.** Configure how long completed workflow histories are kept. Default 30 days.


## Common mistakes[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#common-mistakes)
### 1. Doing I/O in workflow code[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#1-doing-io-in-workflow-code)

```
@workflow.run
async def run(self):
    response = httpx.get("https://...")        # ⛔ I/O in workflow

```
pythoncopy
Workflow code must be deterministic. I/O goes in activities. Activities can do anything.
### 2. Using `datetime.now()`[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#2-using-datetimenow)

```
now = datetime.now()                           # ⛔
now = workflow.now()                           # ✅

```
pythoncopy
Workflow code must produce the same values on replay. Use Temporal-provided primitives.
### 3. No retry policy[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#3-no-retry-policy)

```
await workflow.execute_activity(act, ...)      # default = no retry

```
pythoncopy
Set `retry_policy=RetryPolicy(...)`. Otherwise transient failures kill the workflow.
### 4. Workflow code that grows unbounded history[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#4-workflow-code-that-grows-unbounded-history)
A loop that runs forever creates an infinite event history. Use **Continue-As-New** to checkpoint and start fresh:

```
if iteration > 1000:
    workflow.continue_as_new(...)

```
pythoncopy
### 5. Treating it as a queue[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#5-treating-it-as-a-queue)
A workflow per HTTP request creates serious overhead. Use Temporal for orchestration of _multi-step_ work; for single-job fire-and-forget use a real queue. See [Background Jobs in Python](https://blog.rajpoot.dev/posts/python/background-jobs-python-arq-dramatiq-taskiq-2026/) .
## When I’d reach for it day one[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#when-id-reach-for-it-day-one)
  * Building a payments product (subscriptions, refunds, partial fulfillment).
  * Building an AI agent platform (multi-step, tool-using).
  * Replacing a tangle of Celery + cron + state-in-Postgres that broke too often.


For a small SaaS without these shapes, defer adopting Temporal until you feel the pain it solves. Don’t add infrastructure pre-emptively.
## Read this next[#](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#read-this-next)
  * [Idempotency, Retries, and Exactly-Once Illusions](https://blog.rajpoot.dev/posts/backend/idempotency-retries-exactly-once/) — the fundamentals Temporal automates.
  * [Distributed Systems Fundamentals](https://blog.rajpoot.dev/system-design/distributed-systems-fundamentals/)
  * [AI Agents with LangGraph in 2026](https://blog.rajpoot.dev/posts/ai/ai-agents-with-langgraph-tutorial/) — the agent orchestration alternative.
  * [Background Jobs in Python](https://blog.rajpoot.dev/posts/python/background-jobs-python-arq-dramatiq-taskiq-2026/)


If you want a small Temporal + FastAPI starter that wires up a saga + AI agent workflow with OTel tracing, it’s at **[rajpoot.dev](https://rajpoot.dev/) **.
* * *
_Building something AI-, backend-, or data-heavy and want a second pair of eyes? I do consulting and freelance work — see my projects and ways to reach me at**[rajpoot.dev](https://rajpoot.dev/) **._
  * [Backend](https://blog.rajpoot.dev/tags/backend/)
  * [Temporal](https://blog.rajpoot.dev/tags/temporal/)
  * [Workflows](https://blog.rajpoot.dev/tags/workflows/)
  * [Distributed Systems](https://blog.rajpoot.dev/tags/distributed-systems/)
  * [Reliability](https://blog.rajpoot.dev/tags/reliability/)

![Manvendra Rajpoot](https://blog.rajpoot.dev/img/personal/profile.jpg)
Manvendra Rajpoot
Backend engineer who writes about Python, Django, FastAPI, PostgreSQL, Go, Rust, and AI engineering — with the occasional detour into fitness and reflection. See projects and résumé at [rajpoot.dev](https://rajpoot.dev/).
[**Portfolio · rajpoot.dev**](https://rajpoot.dev/) · [About](https://blog.rajpoot.dev/about/) · [GitHub](https://github.com/AlzyWelzy) · [Twitter](https://twitter.com/AlzyWelzy) · [RSS](https://blog.rajpoot.dev/index.xml)
[« Prev Zig in 2026 — A Backend Developer's Look at the Language Bun Was Built In ](https://blog.rajpoot.dev/posts/backend/zig-language-backend-developers-2026/)[Next » DuckDB in Production — Embedded Analytics Eating the Data World](https://blog.rajpoot.dev/posts/backend/duckdb-analytics-data-engineering-2026/)
  * [](https://x.com/intent/tweet/?text=Temporal%20and%20Durable%20Execution%20in%202026%20%e2%80%94%20The%20Reliability%20Layer&url=https%3a%2f%2fblog.rajpoot.dev%2fposts%2fbackend%2ftemporal-durable-execution-2026%2f&hashtags=Backend%2cTemporal%2cWorkflows%2cDistributedSystems%2cReliability)
  * [](https://www.linkedin.com/shareArticle?mini=true&url=https%3a%2f%2fblog.rajpoot.dev%2fposts%2fbackend%2ftemporal-durable-execution-2026%2f&title=Temporal%20and%20Durable%20Execution%20in%202026%20%e2%80%94%20The%20Reliability%20Layer&summary=Temporal%20and%20Durable%20Execution%20in%202026%20%e2%80%94%20The%20Reliability%20Layer&source=https%3a%2f%2fblog.rajpoot.dev%2fposts%2fbackend%2ftemporal-durable-execution-2026%2f)
  * [](https://reddit.com/submit?url=https%3a%2f%2fblog.rajpoot.dev%2fposts%2fbackend%2ftemporal-durable-execution-2026%2f&title=Temporal%20and%20Durable%20Execution%20in%202026%20%e2%80%94%20The%20Reliability%20Layer)
  * [](https://facebook.com/sharer/sharer.php?u=https%3a%2f%2fblog.rajpoot.dev%2fposts%2fbackend%2ftemporal-durable-execution-2026%2f)
  * [](https://api.whatsapp.com/send?text=Temporal%20and%20Durable%20Execution%20in%202026%20%e2%80%94%20The%20Reliability%20Layer%20-%20https%3a%2f%2fblog.rajpoot.dev%2fposts%2fbackend%2ftemporal-durable-execution-2026%2f)
  * [](https://telegram.me/share/url?text=Temporal%20and%20Durable%20Execution%20in%202026%20%e2%80%94%20The%20Reliability%20Layer&url=https%3a%2f%2fblog.rajpoot.dev%2fposts%2fbackend%2ftemporal-durable-execution-2026%2f)
  * [](https://news.ycombinator.com/submitlink?t=Temporal%20and%20Durable%20Execution%20in%202026%20%e2%80%94%20The%20Reliability%20Layer&u=https%3a%2f%2fblog.rajpoot.dev%2fposts%2fbackend%2ftemporal-durable-execution-2026%2f)


## Related posts
  * [backend ·Apr 28, 2026 Idempotency, Retries, and the Exactly-Once Illusion Production patterns for idempotency keys, retry strategies, the outbox pattern, and the truth about exactly-once delivery. The patterns …](https://blog.rajpoot.dev/posts/backend/idempotency-retries-exactly-once/)
  * [backend ·May 2, 2026 Distributed Transactions in 2026 — Sagas, 2PC, and What Actually Works Practical distributed transactions: why 2PC rarely fits, sagas (orchestration vs choreography), outbox + CDC, idempotency, and the …](https://blog.rajpoot.dev/posts/backend/saga-vs-2pc-2026/)
  * [backend ·May 2, 2026 Circuit Breakers in 2026 — Patterns, Pitfalls, and When They Save You Practical circuit breakers: the closed/open/half-open state machine, threshold tuning, fallback strategies, libraries (resilience4j, …](https://blog.rajpoot.dev/posts/backend/circuit-breaker-2026/)
  * [backend ·Apr 30, 2026 Health Checks That Don't Lie — Liveness, Readiness, and Startup Probes in 2026 Why most health checks lie, the difference between liveness and readiness, dependency-aware checks, startup probes for slow boots, and the …](https://blog.rajpoot.dev/posts/backend/healthchecks-readiness-liveness-2026/)

© Manvendra Rajpoot · Portfolio: [rajpoot.dev](https://rajpoot.dev/) · Powered by [Hugo](https://gohugo.io/?utm_source=papermod) & [PaperMod](https://github.com/adityatelange/hugo-PaperMod/)[ ](https://blog.rajpoot.dev/posts/backend/temporal-durable-execution-2026/#top "Go to Top \(Alt + G\)")

