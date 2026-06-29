[ Skip to main content ](https://temporal.io/#main-content)
[New features for faster build and reliable AI | See what you missed at Replay 2026 › ](https://temporal.io/replay/2026) [About](https://temporal.io/about)[Careers](https://temporal.io/careers)[Talk to Sales](https://pages.temporal.io/contact-us)
[![Temporal Logo](https://temporal.io/images/logos/logo-temporal-with-copy-white-text.svg)](https://temporal.io/)
  * Platform 
    * [Overview](https://temporal.io/product)
    * [How Temporal Works](https://temporal.io/how-it-works)
    * [Temporal Cloud](https://temporal.io/cloud)
    * [Security](https://temporal.io/security)
  * Platform 
  * [Docs](https://docs.temporal.io)
  * [Pricing](https://temporal.io/pricing)
  * Use Cases 
    * [Customer Stories](https://temporal.io/in-use)
    * By Industry
      * [AI](https://temporal.io/solutions/ai)
      * [Financial Services](https://temporal.io/solutions/financial-services)
    * By Audience
      * [Platform Engineering](https://temporal.io/solutions/platform-engineering)
      * [Startups](https://temporal.io/startup)
      * [Partners](https://temporal.io/partners)
  * Use Cases 
  * Resources 
    * [Resource Library](https://temporal.io/resources)
    * [Learn Temporal](https://learn.temporal.io)
    * [Community](https://temporal.io/community)
    * [Code Exchange](https://temporal.io/code-exchange)
    * [Blog](https://temporal.io/blog)
    * [Changelog](https://temporal.io/changelog)
  * Resources 


[](https://github.com/temporalio)
[ Try Free ](https://temporal.io/get-cloud)[ Log In ](https://cloud.temporal.io/)
#  The world’s best AI runs on Temporal
Build applications the way OpenAI, Lovable, Replit, Cursor, and Retool do with our open-source platform. Add agentic capabilities to any application with your framework of choice.
[ Get Started for Free ](https://temporal.io/get-cloud)[ Run Locally ](https://docs.temporal.io/quickstarts)

```
@workflow.defn
class AgentWorkflow:
    @workflow.run
    async def run(self, goal: str) -> str:
        messages = [{"role": "user", "content": goal}]
        while True: # Agent loops until it decides it's done
            # LLM calls automatically retry on failure
            response = await workflow.execute_activity(
                call_llm, args=[messages, tools],
                start_to_close_timeout=timedelta(seconds=60))

            if not response.tool_calls: return response.content  # Agent is done

            # Tool execution is durable - survives crashes
            result = await workflow.execute_activity(
                run_tool, args=[response.tool_call],
                start_to_close_timeout=timedelta(minutes=5))

            # Add LLM response and Tool result to the agent context
            messages.append(response.message)
            messages.append({"role": "tool", "content": result})
        
```

```
@workflow.defn
class AgentWorkflow:
    @workflow.run
    async def run(self, goal: str) -> str:
        messages = [{"role": "user", "content": goal}]
        while True: # Agent loops until it decides it's done
            # LLM calls automatically retry on failure
            response = await workflow.execute_activity(
                call_llm, args=[messages, tools],
                start_to_close_timeout=timedelta(seconds=60))

            if not response.tool_calls: return response.content  # Agent is done

            # Tool execution is durable - survives crashes
            result = await workflow.execute_activity(
                run_tool, args=[response.tool_call],
                start_to_close_timeout=timedelta(minutes=5))

            # Add LLM response and Tool result to the agent context
            messages.append(response.message)
            messages.append({"role": "tool", "content": result})
        
```

PYTHONGOTYPESCRIPTRUBYC#JAVAPHP
![Qualtrics logo - light](https://images.ctfassets.net/0uuz8ydxyd9p/6KZIJ1pQc69qo9o3bDzKni/58f2725df8b11b5f5c8dfd97b7d5fe90/Qualtrics_logo_-_light.svg)![REA Group Logo](https://images.ctfassets.net/0uuz8ydxyd9p/4Nb7RDUkk1NqP0txn7aNAq/efa0b817fa07d52b2911b911027816a4/Group.svg)![Snap logomark - light](https://images.ctfassets.net/0uuz8ydxyd9p/5gs6C1JatS1f04dKDqqOdd/d33d8b2c9bf114b03833507f165661a0/Snap_logomark_-_light.svg)![Macquarie Logo](https://images.ctfassets.net/0uuz8ydxyd9p/3VToqFWm1KL9yTWqJPFMi1/506650011cdaac612134a1d2bf4b31a6/MQG.AX_BIG.D.svg) ![anz logo](https://images.ctfassets.net/0uuz8ydxyd9p/5VM05HeGpG9o34Y7XXYFDs/c9a396dada848476d463cb58a8f51b21/anz-logo-white.png?fm=png&q=80&h=24)![OpenAI logo](https://images.ctfassets.net/0uuz8ydxyd9p/2Xq5FiEWchOgLZ4q20XAVS/71fc3d4ed874bf6935a9054014045c7b/Group__4_.svg)![Yum! Brand Logo](https://images.ctfassets.net/0uuz8ydxyd9p/76t50FAZNldtoeNOxrszrx/205e7f935074091f32043ed919bc9fd2/g2503.svg) ![Gray lowercase letters 'd' and 'c' connected in a modern, minimalist logo design on white background.](https://images.ctfassets.net/0uuz8ydxyd9p/4QOY0W93CBtLK0HbffHljE/5bb5fb35159014ce5008f34d84662b2a/kotak.png?fm=png&q=80&h=24)![Vodafone Logo](https://images.ctfassets.net/0uuz8ydxyd9p/71dlhPtA8tJxVW6xfmW5TO/e59f54f0cb7aa88e991b34a6e57c7d24/Vodafone_2017_logo_1.svg)![Cloudflare Logo](https://images.ctfassets.net/0uuz8ydxyd9p/2Kw3v1c4ExNMaferYM6Wbn/7ecc3a519ed1206f6cd44d781536b6a8/NET_BIG.W.svg)![GitLab Logo](https://images.ctfassets.net/0uuz8ydxyd9p/t6vElMorqJb728juRdtWG/b21edde0e2ba3f374818a312751bc78e/LOGO__1_.svg)![Remitly Logo](https://images.ctfassets.net/0uuz8ydxyd9p/4GDIW1m1EuLnPnRVo7ZU8n/99a6af8482d8e686d35cfd6debd6fea5/Remitly_logo_-_light.svg) ![Light gray or white blank rectangular background with no visible content or elements.](https://images.ctfassets.net/0uuz8ydxyd9p/2hOL3iDASXRPZcrpgEOO9K/f5e8ab54cc0a546c6ee9161852e386bd/alaskaAirlinesWhite.png?fm=png&q=80&h=24)![Bentley Systems Logo](https://images.ctfassets.net/0uuz8ydxyd9p/55CawRvmiIwzfh3dfMpIbs/0f5ef6fb3263fc906b07611be9b33d32/bentley-logo-white-400x100-1.svg)![Bestseller Logo](https://images.ctfassets.net/0uuz8ydxyd9p/5BnK9hlwx1j7pqnb7tgK2a/3021eb16cde9887c1e17c1b30783e807/path3384.svg)![Deloitte](https://images.ctfassets.net/0uuz8ydxyd9p/3gJ8sBPuYbrK1h3qxIfdZx/33cf10c9f035ce0ebd8489c871c12507/Deloitte.svg) ![White or light gray blank rectangular background with no visible content or elements.](https://images.ctfassets.net/0uuz8ydxyd9p/tHMcuiabjlHCsPDPN1nVb/ae0b75ce528ed89de8120d8e425dd6a7/godaddy-logo-2048x515.png?fm=png&q=80&h=24)![Doordash Logo](https://images.ctfassets.net/0uuz8ydxyd9p/4fLTm2EneQaAy01Dolb70T/f93405cfc9b46705f96ea53db3e88cae/DASH_BIG.D.svg) ![Light gray textured background with subtle variations in tone creating a minimalist, neutral surface.](https://images.ctfassets.net/0uuz8ydxyd9p/1kgD0Yz7rFq5f8LAD1FSl6/18a5c8a7f2971d6e83cad362ab0c8fd7/retoolw.png?fm=png&q=80&h=24)![Checkr Logo](https://images.ctfassets.net/0uuz8ydxyd9p/4hjC77Y1Wv8BshJxBKYWdZ/00c62f50c0b6635a2a34b7247278d981/checkr_BIG.D.svg)![Turo logo - light](https://images.ctfassets.net/0uuz8ydxyd9p/34vCpXmfPW6VxvojJtpNtX/2748544c6f679b2f4566efdeaadfe3f5/Turo_logo_-_light.svg)![Mollie Logo](https://images.ctfassets.net/0uuz8ydxyd9p/2ADYihv1lhL9pfq1wvMHDW/bac315dbf13f4a540cf9a5e4ce4d83e2/Mollie-Logo-White-2023.svg)![Lovable AI Logo](https://images.ctfassets.net/0uuz8ydxyd9p/7bFW3ITvDpfU49XZTgHhQb/0de077c51dbac333f658a4372f836a1e/Clip_path_group.svg)![Abridge logo](https://images.ctfassets.net/0uuz8ydxyd9p/3D6ob5I7jvjVspHwAG39gG/01796d5db75620aaea98e106d54a528a/Simplification.svg)![Hebbia logo](https://images.ctfassets.net/0uuz8ydxyd9p/2OUxIdQlIRZd7Yeb0hhReW/0f6f15d2064719216874d84f09191de5/Hebbia_Logo_0.svg)
![Qualtrics logo - light](https://images.ctfassets.net/0uuz8ydxyd9p/6KZIJ1pQc69qo9o3bDzKni/58f2725df8b11b5f5c8dfd97b7d5fe90/Qualtrics_logo_-_light.svg)![REA Group Logo](https://images.ctfassets.net/0uuz8ydxyd9p/4Nb7RDUkk1NqP0txn7aNAq/efa0b817fa07d52b2911b911027816a4/Group.svg)![Snap logomark - light](https://images.ctfassets.net/0uuz8ydxyd9p/5gs6C1JatS1f04dKDqqOdd/d33d8b2c9bf114b03833507f165661a0/Snap_logomark_-_light.svg)![Macquarie Logo](https://images.ctfassets.net/0uuz8ydxyd9p/3VToqFWm1KL9yTWqJPFMi1/506650011cdaac612134a1d2bf4b31a6/MQG.AX_BIG.D.svg) ![anz logo](https://images.ctfassets.net/0uuz8ydxyd9p/5VM05HeGpG9o34Y7XXYFDs/c9a396dada848476d463cb58a8f51b21/anz-logo-white.png?fm=png&q=80&h=24)![OpenAI logo](https://images.ctfassets.net/0uuz8ydxyd9p/2Xq5FiEWchOgLZ4q20XAVS/71fc3d4ed874bf6935a9054014045c7b/Group__4_.svg)![Yum! Brand Logo](https://images.ctfassets.net/0uuz8ydxyd9p/76t50FAZNldtoeNOxrszrx/205e7f935074091f32043ed919bc9fd2/g2503.svg) ![Gray lowercase letters 'd' and 'c' connected in a modern, minimalist logo design on white background.](https://images.ctfassets.net/0uuz8ydxyd9p/4QOY0W93CBtLK0HbffHljE/5bb5fb35159014ce5008f34d84662b2a/kotak.png?fm=png&q=80&h=24)![Vodafone Logo](https://images.ctfassets.net/0uuz8ydxyd9p/71dlhPtA8tJxVW6xfmW5TO/e59f54f0cb7aa88e991b34a6e57c7d24/Vodafone_2017_logo_1.svg)![Cloudflare Logo](https://images.ctfassets.net/0uuz8ydxyd9p/2Kw3v1c4ExNMaferYM6Wbn/7ecc3a519ed1206f6cd44d781536b6a8/NET_BIG.W.svg)![GitLab Logo](https://images.ctfassets.net/0uuz8ydxyd9p/t6vElMorqJb728juRdtWG/b21edde0e2ba3f374818a312751bc78e/LOGO__1_.svg)![Remitly Logo](https://images.ctfassets.net/0uuz8ydxyd9p/4GDIW1m1EuLnPnRVo7ZU8n/99a6af8482d8e686d35cfd6debd6fea5/Remitly_logo_-_light.svg) ![Light gray or white blank rectangular background with no visible content or elements.](https://images.ctfassets.net/0uuz8ydxyd9p/2hOL3iDASXRPZcrpgEOO9K/f5e8ab54cc0a546c6ee9161852e386bd/alaskaAirlinesWhite.png?fm=png&q=80&h=24)![Bentley Systems Logo](https://images.ctfassets.net/0uuz8ydxyd9p/55CawRvmiIwzfh3dfMpIbs/0f5ef6fb3263fc906b07611be9b33d32/bentley-logo-white-400x100-1.svg)![Bestseller Logo](https://images.ctfassets.net/0uuz8ydxyd9p/5BnK9hlwx1j7pqnb7tgK2a/3021eb16cde9887c1e17c1b30783e807/path3384.svg)![Deloitte](https://images.ctfassets.net/0uuz8ydxyd9p/3gJ8sBPuYbrK1h3qxIfdZx/33cf10c9f035ce0ebd8489c871c12507/Deloitte.svg) ![White or light gray blank rectangular background with no visible content or elements.](https://images.ctfassets.net/0uuz8ydxyd9p/tHMcuiabjlHCsPDPN1nVb/ae0b75ce528ed89de8120d8e425dd6a7/godaddy-logo-2048x515.png?fm=png&q=80&h=24)![Doordash Logo](https://images.ctfassets.net/0uuz8ydxyd9p/4fLTm2EneQaAy01Dolb70T/f93405cfc9b46705f96ea53db3e88cae/DASH_BIG.D.svg) ![Light gray textured background with subtle variations in tone creating a minimalist, neutral surface.](https://images.ctfassets.net/0uuz8ydxyd9p/1kgD0Yz7rFq5f8LAD1FSl6/18a5c8a7f2971d6e83cad362ab0c8fd7/retoolw.png?fm=png&q=80&h=24)![Checkr Logo](https://images.ctfassets.net/0uuz8ydxyd9p/4hjC77Y1Wv8BshJxBKYWdZ/00c62f50c0b6635a2a34b7247278d981/checkr_BIG.D.svg)![Turo logo - light](https://images.ctfassets.net/0uuz8ydxyd9p/34vCpXmfPW6VxvojJtpNtX/2748544c6f679b2f4566efdeaadfe3f5/Turo_logo_-_light.svg)![Mollie Logo](https://images.ctfassets.net/0uuz8ydxyd9p/2ADYihv1lhL9pfq1wvMHDW/bac315dbf13f4a540cf9a5e4ce4d83e2/Mollie-Logo-White-2023.svg)![Lovable AI Logo](https://images.ctfassets.net/0uuz8ydxyd9p/7bFW3ITvDpfU49XZTgHhQb/0de077c51dbac333f658a4372f836a1e/Clip_path_group.svg)![Abridge logo](https://images.ctfassets.net/0uuz8ydxyd9p/3D6ob5I7jvjVspHwAG39gG/01796d5db75620aaea98e106d54a528a/Simplification.svg)![Hebbia logo](https://images.ctfassets.net/0uuz8ydxyd9p/2OUxIdQlIRZd7Yeb0hhReW/0f6f15d2064719216874d84f09191de5/Hebbia_Logo_0.svg)
What you missed at Replay 2026
###  New features for faster build and reliable AI
At Replay 2026, we announced Serverless Workers, Standalone Activities, Workflow Streams, and new integrations with Google ADK and OpenAI Agents SDK. Check it out. Your production environment will thank you.
[ Read Announcement ](https://temporal.io/blog/replay-2026-product-announcements)
![Temporal Replay 2026 graphic](https://images.ctfassets.net/0uuz8ydxyd9p/46mPZcKA5D2pzZWbbva3uO/ba420978fb74dfea431ec662a481e2a5/temporal-banner-replay-photo__1_.webp?fm=jpg&q=80&w=320&h=194)
###  Write code as if failure doesn’t exist
Distributed systems break, APIs fail, networks flake, and services crash. That’s not your problem anymore. Managing reliability shouldn’t mean constant firefighting.
Temporal Workflows automatically capture state at every step, and in the event of failure, can pick up exactly where they left off.
No lost progress, no orphaned processes, and no manual recovery required.
![Purple laptop displaying a green pixelated smiley face on dark screen, surrounded by colorful geometric shapes and icons.](https://images.ctfassets.net/0uuz8ydxyd9p/1YiCTIWs5UYzTv98YKzyK/6362b8f447f3ef62e8dd9a67d744b4dd/Happy_Laptop__2_.png?fm=png&q=80&w=320&h=110)
###  You have to see it to believe it
Temporal doesn’t work like anything you’ve used before. Watch how we guarantee the Durable Execution of your code in the face of any failure.
[ Watch a Demo ](https://youtu.be/dNVmRfWsNkM)
![Magic Graphic](https://images.ctfassets.net/0uuz8ydxyd9p/4CPlZLoV4BIvyRXCe7ISPd/7b0ce8673455f064f2b05a5ca1cae215/magic-new.svg)
How It Works
###  Create failproof apps using our SDKs
Write your business logic in the programming languages you already use with our native SDKs. Your days of writing reconciliation logic or boilerplate code are over.
![Temporal SDKs Graphic](https://images.ctfassets.net/0uuz8ydxyd9p/1lQl33YaXWjGZHGCft4Ofs/189f974e93fdbd87e1a32d2a364289c1/Group_1000002002.svg)
###  Build Workflows that handle failures for you
Write your business logic as code as a Temporal Workflow. Workflows might involve moving money between bank accounts, processing orders, deploying cloud infrastructure, training an AI model, or something else entirely.
Because the full running state of a Workflow is durable and fault tolerant by default, your business logic can be recovered, replayed, or paused at any point.
![Workflow Graphic](https://images.ctfassets.net/0uuz8ydxyd9p/63LUyUOjLIba5sPuJWis9B/350ec813d63fbaa4e6360a6a95098545/Group_1000001977.svg)
###  Write Activities to handle and retry failure-prone logic
APIs fail, networks time out, and users abandon sessions.
Temporal treats these interactions as Activities: functions that retry automatically and recover seamlessly.
![Activities Graphic](https://images.ctfassets.net/0uuz8ydxyd9p/1Kx9Mb2lNos2PEbvIjy7S1/2957716a519e5c8923385f09fce67eea/Group_1000001988.svg)
###  Replace your brittle state machines
The Temporal Service persists the state of your application and has built-in retries, task queues, signals, and timers, to make sure your code always picks up where it left off.
Host the Temporal Service yourself as part of the [open-source project](https://docs.temporal.io/develop/), or let us host it for you with [Temporal Cloud](https://temporal.io/cloud).
![State Machine Graphic](https://images.ctfassets.net/0uuz8ydxyd9p/65SSC5QL4KNrKD8cWZUv6H/c4fc6fe75e17a556325b2bacbc3f801c/Group_1000001864.svg)
###  Get full visibility into your running code
No more wasting time sifting through logs. Get visibility into the exact state of each of your Workflow executions.
Common patterns and use cases
Agents, MCP, & AI Pipelines
Develop agents that survive real-world chaos, reliable MCP & orchestrate training pipelines.
Humans-in-the-Loop
No more duct-taping Workflows around human input: just clean, durable orchestration.
Compensating Patterns (Saga)
Make Saga easy: what if Saga was simply a try...catch?
Long-running Workflows
Run Workflows for days, weeks, or months without losing progress or adding complexity.
Order Fulfillment
One bad service shouldn’t break the cart. Temporal keeps the order moving.
Durable Ledgers
Track transactions with code you can trust down to the last cent.
CI/CD
Deploy with confidence. Temporal gives you clean retries, rollbacks, and visibility.
Customer Acquisition
Route leads, onboard users, and engage customers without dropped steps or hacks.
DAG
Don’t glue together DAGs with bash and hope. Temporal does it right.
Global enterprises and top startups choose Temporal 
![Video thumbnail showing code for while loops in Temporal with a green play button overlay and presenter on right side](https://images.ctfassets.net/0uuz8ydxyd9p/2X1lvfUWi59DvET3X43p31/91f73704371cb6068b8344ea99908a5c/thumb_nvidia_2x.png?fit=fill&fm=png&q=80&w=640&h=360)
NVIDIA manages their GPU fleet across clouds with Temporal
[ Watch NVIDIA's talk ](https://www.youtube.com/watch?v=HqGtUPLc_qI&t=1s)
![Video player showing code editor with green play button overlay, titled Background Heartbeats with Salesforce cloud logo](https://images.ctfassets.net/0uuz8ydxyd9p/75M93uxPuJBR8caSzVTAB6/2fe1abef95c43086ae978a98b9749164/thumb_salesforce_2x.png?fit=fill&fm=png&q=80&w=640&h=360)
Salesforce migrated their monolith to Temporal
[ Watch Salesforce's talk ](https://www.youtube.com/watch?v=1TDX9WEJRMA&t=1s)
![Video thumbnail with green play button and text reading Temporal Blessed Technology on purple gradient background](https://images.ctfassets.net/0uuz8ydxyd9p/1yfJdPJJMQ1e2q8s3dSk3q/2e0cbd03d801f7a2ef6e7d85c496cc0a/thumb-twilio_2x.png?fit=fill&fm=png&q=80&w=640&h=360)
Twilio left their homegrown systems for Temporal Cloud
[ Watch Twilio's talk ](https://youtu.be/H7Vh3PPyeTw?si=L3PW2zKpjr7csOCX&t=1)
![Video thumbnail showing a man wearing glasses and an olive green shirt with a green play button overlay in the center.](https://images.ctfassets.net/0uuz8ydxyd9p/2Dk5WryzZWG8vM4wPlnhB0/51b8c269f95e5d34bcc4e4f44f760677/thumb_descript_2x.png?fit=fill&fm=png&q=80&w=640&h=360)
Descript improved their AI uptime with Temporal
[ Watch Descript's talk ](https://www.youtube.com/watch?v=4EaZZhmk9zg&t=0s)
Durable execution is a core requirement for modern AI systems, and Temporal offers a compelling platform to help build it in from the start. As AI systems become more complex and long-running, durability is as important as performance. Temporal plays a role in how we think about reliable execution at scale, supporting teams in focusing on product development.
![Venkat Venkataramani, VP of App Infrastructure at OpenAI • Former CEO & Co-founder of Rockset](https://images.ctfassets.net/0uuz8ydxyd9p/1xusBACnh8z4e18hW7rauM/09d401e9d1358818c36fd0e4ff00f156/Venkat.jpeg?fm=jpg&q=80&w=56&h=56)
Venkat Venkataramani
VP of App Infrastructure, OpenAI • Former CEO & Co-founder of Rockset
![OpenAI • Former CEO & Co-founder of Rockset](https://images.ctfassets.net/0uuz8ydxyd9p/4XSvO97YhQ6aen5cnBpFoO/bc9bda968b7a9f95c7828086c2a29268/OpenAI_Logo.svg)
Temporal's technology satisfied all of these requirements out of the box and allowed our developers to focus on business logic.
Without Temporal's technology, we would've spent a significant amount of time rebuilding Temporal and would've very likely done a worse job.
![Mitchell Hashimoto, Co-founder at Hashicorp](https://images.ctfassets.net/0uuz8ydxyd9p/5DKr4Le66oqIonKUzZC0cA/5774165e77d157ad777141476f782e28/mitchell-hashimoto.png?fm=png&q=80&w=56&h=56)
Mitchell Hashimoto
Co-founder, Hashicorp
![Hashicorp](https://images.ctfassets.net/0uuz8ydxyd9p/7Bk8auMRdp1TkfTLCh3G8J/3f8ea1401439e4b1b5015e86c60dd2f5/Hashicorp_logo_-_dark.svg)
Committed to the open-source community
###  100% open-source
MIT-licensed, built in the open, and backed by a thriving developer community.
![Open Source Initiative Logo](https://temporal.io/images/open-source-initiative.svg) [ 21,313 Stars ](https://github.com/temporalio/temporal)
![Open Source Graphic](https://images.ctfassets.net/0uuz8ydxyd9p/5URCP7ImlCFTve3Y00zFxx/4cdcce402d6322e27b3f3c0b60161de6/Open_Source_Image.svg)
As Reliable as Gravity
###  Fully battle tested, 9 years in production
Temporal was built with over 20 years of development from the minds behind AWS SQS, AWS SWF, Azure Durable functions, and the Cadence project that powers Uber.
![Battle Tested Graphic](https://images.ctfassets.net/0uuz8ydxyd9p/1vkSkyOrLKPghmTI6oAWlf/7b140d3724c5a96251f2269762227e52/Frame_22.svg)
Deploy it your way
###  One platform, two great hosting paths
Temporal is an open-source project that you are free to use and host in your own environment. You can also let us host the Temporal Service for you with Temporal Cloud. Either way, we never see your code.
[Sign up for Temporal Cloud and get $1,000 in free credits ›](https://temporal.io/get-cloud)
![Self-Hosted vs. Cloud Graphic](https://images.ctfassets.net/0uuz8ydxyd9p/7895g0MQaAct8ptqNaQUr7/84435f682e26b6085aa4d09e74537c16/Group_1000002050.svg)
Build invincible applications
It sounds like magic, we promise it's not.
[ Documentation ](https://docs.temporal.io/)[ Code Base ](https://github.com/temporalio)[ Samples ](https://learn.temporal.io/examples/)
[ALL SYSTEMS OPERATIONAL ](https://status.temporal.io/)
Sign up for our newsletter
Email Address
Discover
[Overview](https://temporal.io/product)[How Temporal Works](https://temporal.io/how-it-works)[Temporal Cloud](https://temporal.io/cloud)[Pricing](https://temporal.io/pricing)[Security](https://temporal.io/security)[Trust Center](https://trust.temporal.io)[Startups](https://temporal.io/startup)
Explore
[Customer Stories](https://temporal.io/in-use)[Project-based tutorials](https://learn.temporal.io/tutorials/)[Example applications](https://learn.temporal.io/examples/)[Code Exchange](https://temporal.io/code-exchange)[Replay 2026 Recap](https://temporal.io/replay/2026)[Ask an expert](https://pages.temporal.io/ask-an-expert)[Blog](https://temporal.io/blog)
Developers
[Getting Started with Temporal](https://docs.temporal.io/quickstarts)[Start building your next app](https://docs.temporal.io/develop)[Temporal Cloud docs](https://docs.temporal.io/cloud)[Production deployments](https://docs.temporal.io/production-deployment)[Temporal 101](https://learn.temporal.io/courses/temporal_101/)[Temporal 102](https://learn.temporal.io/courses/temporal_102/)[Introduction to Temporal Cloud](https://learn.temporal.io/courses/intro_to_temporal_cloud/)
Community
[Join our Slack group](https://t.mp/slack)[Find a meetup near you](https://temporal.io/community)[Community forum](https://community.temporal.io/)[Events](https://temporal.io/events)
Company
[About](https://temporal.io/about)[Careers](https://temporal.io/careers)[News](https://temporal.io/news)[Contact us](https://pages.temporal.io/contact-us)[Partners](https://temporal.io/partners)
2026 © Temporal Technologies. All Rights Reserved.
[Privacy Policy](https://temporal.io/global-privacy-policy) [Candidate Privacy Policy](https://temporal.io/candidate-privacy-policy) [Terms of Service](https://temporal.io/terms-of-service) [Code of Conduct](https://temporal.io/code-of-conduct) [Sitemap](https://temporal.io/sitemap) Your Privacy Choices
[](https://www.youtube.com/temporalio) [](https://twitter.com/temporalio) [](https://github.com/temporalio) [](https://www.linkedin.com/company/temporal-technologies) [](https://t.mp/slack)
Cookie Policy
We use cookies and similar technologies to help personalize content, tailor and measure ads, and provide a better experience. By clicking Accept, you agree to this as outlined in our [cookie policy](https://temporal.io/temporal-cookie-policy).
Do not sell or share my personal information.
Accept Decline

