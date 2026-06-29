> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](https://docs.prefect.io/llms.txt)
>
> Use this file to discover all available pages before exploring further.

[Skip to main content](https://docs.prefect.io/v3/get-started#content-area)

[Prefect home page![light logo](https://mintcdn.com/prefect-bd373955/2_4m_dDmEdgqK7r9/logos/logo-wordmark-dark.svg?fit=max&auto=format&n=2_4m_dDmEdgqK7r9&q=85&s=076c95a93dbe29192ba9129faefcc878)![dark logo](https://mintcdn.com/prefect-bd373955/2_4m_dDmEdgqK7r9/logos/logo-wordmark-light.svg?fit=max&auto=format&n=2_4m_dDmEdgqK7r9&q=85&s=46ef25a1069c303ca7d9e24ec801e760)](https://docs.prefect.io/)

Search...

Ctrl KAsk Assistant

- [PrefectHQ/Prefect\\
\\
22,613](https://github.com/PrefectHQ/Prefect "PrefectHQ/Prefect")
- [PrefectHQ/Prefect\\
\\
22,613](https://github.com/PrefectHQ/Prefect "PrefectHQ/Prefect")

Search...

Navigation

Get started

Introduction

[Getting Started](https://docs.prefect.io/v3/get-started) [Concepts](https://docs.prefect.io/v3/concepts) [How-to Guides](https://docs.prefect.io/v3/how-to-guides) [Advanced](https://docs.prefect.io/v3/advanced) [Examples](https://docs.prefect.io/v3/examples) [Integrations](https://docs.prefect.io/integrations/integrations) [API Reference](https://docs.prefect.io/v3/api-ref) [Contribute](https://docs.prefect.io/contribute) [Release Notes](https://docs.prefect.io/v3/release-notes)

### Get started

- [Welcome](https://docs.prefect.io/v3/get-started)
- [Install Prefect](https://docs.prefect.io/v3/get-started/install)
- [Quickstart](https://docs.prefect.io/v3/get-started/quickstart)

## On this page

- [Essential features](https://docs.prefect.io/v3/get-started#essential-features)
- [Quickstart](https://docs.prefect.io/v3/get-started#quickstart)
- [AI assistants and MCP](https://docs.prefect.io/v3/get-started#ai-assistants-and-mcp)
- [How-to guides](https://docs.prefect.io/v3/get-started#how-to-guides)
- [Advanced](https://docs.prefect.io/v3/get-started#advanced)
- [Examples](https://docs.prefect.io/v3/get-started#examples)
- [Mini-history of Prefect](https://docs.prefect.io/v3/get-started#mini-history-of-prefect)
- [Join our community](https://docs.prefect.io/v3/get-started#join-our-community)
- [LLM-friendly formats](https://docs.prefect.io/v3/get-started#llm-friendly-formats)

Get started

# Introduction

Prefect is an open-source orchestration engine that turns your Python functions into production-grade data pipelines with minimal friction. You can build and schedule workflows in pure Python—no DSLs or complex config files—and run them anywhere you can run Python. Prefect handles the heavy lifting for you out of the box: automatic state tracking, failure handling, real-time monitoring, and more.

### [​](https://docs.prefect.io/v3/get-started\#essential-features)  Essential features

| Feature | Description |
| --- | --- |
| **Pythonic** | Write workflows in native Python—no DSLs, YAML, or special syntax. Full support for type hints, async/await, and modern Python patterns. Use your existing IDE, debugger, and testing tools. |
| **State & Recovery** | Robust state management that tracks success, failure, and retry states. Resume interrupted runs from the last successful point, and cache expensive computations to avoid unnecessary rework. |
| **Flexible & Portable Execution** | Start flows locally for easy development, then deploy them anywhere—from a single process to containers, Kubernetes, or cloud services—without locking into a vendor. Infrastructure is defined by code (not just configuration), making it simple to scale or change environments. |
| **Event-Driven** | Trigger flows on schedules, external events, or via API. Pause flows for human intervention or approval. Chain flows together based on states, conditions, or any custom logic. |
| **Dynamic Runtime** | Create tasks dynamically at runtime based on actual data or conditions. Easily spawn new tasks and branches during execution for truly data-driven workflows. |
| **Modern UI** | Real-time flow run monitoring, logging, and state tracking through an intuitive interface. View dependency graphs and DAGs automatically—just run your flow and open the UI. |
| **CI/CD First** | Test and simulate flows like normal Python code, giving you fast feedback during development. Integrate seamlessly into your existing CI/CD pipeline for automated testing and deployment. |

## [​](https://docs.prefect.io/v3/get-started\#quickstart)  Quickstart

[**Quickstart** \\
\\
Quickly create your first deployable workflow tracked by Prefect.](https://docs.prefect.io/v3/get-started/quickstart)

[**Install Prefect** \\
\\
Install Prefect and get connected to Prefect Cloud or a self-hosted server.](https://docs.prefect.io/v3/get-started/install)

[**Connect AI assistants** \\
\\
Set up the Prefect MCP server for read-only diagnostics and built-in docs access.](https://docs.prefect.io/v3/how-to-guides/ai/use-prefect-mcp-server#client-setup)

[**Upgrade to Prefect 3** \\
\\
Upgrade from Prefect 2 to Prefect 3 to get the latest features and performance enhancements.](https://docs.prefect.io/v3/how-to-guides/migrate/upgrade-to-prefect-3)

## [​](https://docs.prefect.io/v3/get-started\#ai-assistants-and-mcp)  AI assistants and MCP

Use the Prefect MCP server to connect assistants like Claude Code, Cursor, Codex CLI, and Gemini CLI to your Prefect environment.

[**Set up the server** \\
\\
Install once to inspect deployments, flow runs, task runs, and logs while using integrated docs search.](https://docs.prefect.io/v3/how-to-guides/ai/use-prefect-mcp-server)

[**Review security model** \\
\\
Understand read-only MCP behavior, RBAC scope, and how MCP client capabilities differ from server tools.](https://github.com/PrefectHQ/prefect-mcp-server/blob/main/SECURITY.md)

## [​](https://docs.prefect.io/v3/get-started\#how-to-guides)  How-to guides

[**Build workflows** \\
\\
Learn how to write and customize your Prefect workflows with tasks and flows.](https://docs.prefect.io/v3/how-to-guides/workflows/write-and-run)

[**Deploy workflows** \\
\\
Deploy and manage your workflows as Prefect deployments.](https://docs.prefect.io/v3/how-to-guides/deployments/create-deployments)

[**Configure infrastructure** \\
\\
Deploy your workflows to specific infrastructure platforms.](https://docs.prefect.io/v3/how-to-guides/deployment_infra/managed)

[**Set up automations** \\
\\
Work with events, triggers, and automations to build reactive workflows.](https://docs.prefect.io/v3/how-to-guides/automations/creating-automations)

[**Configure Prefect** \\
\\
Configure your Prefect environment, secrets, and variables.](https://docs.prefect.io/v3/how-to-guides/configuration/manage-settings)

[**Use Prefect Cloud** \\
\\
Set up and manage your Prefect Cloud account.](https://docs.prefect.io/v3/how-to-guides/cloud/connect-to-cloud)

## [​](https://docs.prefect.io/v3/get-started\#advanced)  Advanced

[**Interactive workflows** \\
\\
Build interactive workflows that can pause and receive input.](https://docs.prefect.io/v3/advanced/interactive)

[**Platform engineering** \\
\\
Use Prefect as a platform for your teams’ data pipelines.](https://docs.prefect.io/v3/advanced/infrastructure-as-code)

[**Extend Prefect** \\
\\
Extend Prefect with custom blocks and API integrations.](https://docs.prefect.io/v3/advanced/api-client)

## [​](https://docs.prefect.io/v3/get-started\#examples)  Examples

Check out the gallery of [examples](https://docs.prefect.io/v3/examples/index) to see Prefect in action.

## [​](https://docs.prefect.io/v3/get-started\#mini-history-of-prefect)  Mini-history of Prefect

**2018-2021:** Our story begins in 2018, when we introduced the idea that workflow orchestration should be Pythonic.
Inspired by distributed tools like Dask, and building on the experience of our founder, Jeremiah Lowin (a PMC member of Apache Airflow), we created a system based on simple Python decorators for tasks and flows.
But what made Prefect truly special was our introduction of task mapping—a feature that would later become foundational to our dynamic execution capabilities (and eventually imitated by other orchestration SDKs).**2022:** Prefect’s 2.0 release became inevitable once we recognized that real-world workflows don’t always fit into neat, pre-planned DAG structures: sometimes you need to update a job definition based on runtime information, for example by skipping a branch of your workflow.
So we removed a key constraint that workflows be written explicitly as DAGs, fully embracing native Python control flow—if/else conditionals, while loops-everything that makes Python…Python.**2023-present:** With our release of Prefect 3.0 in 2024, we fully embraced these dynamic patterns by open-sourcing our events and automations backend, allowing users to natively represent event-driven workflows and gain additional observability into their execution.
Prefect 3.0 also unlocked a leap forward in performance, improving the runtime overhead of Prefect by up to 90%.

## [​](https://docs.prefect.io/v3/get-started\#join-our-community)  Join our community

Join Prefect’s vibrant [community of nearly 30,000 engineers](https://docs.prefect.io/contribute/index) to learn with others and share your knowledge!

## [​](https://docs.prefect.io/v3/get-started\#llm-friendly-formats)  LLM-friendly formats

The docs are also available in [llms.txt format](https://llmstxt.org/):

- [llms.txt](https://docs.prefect.io/llms.txt) \- A sitemap listing all documentation pages
- [llms-full.txt](https://docs.prefect.io/llms-full.txt) \- The entire documentation in one file (may exceed context windows)

Any page can be accessed as markdown by appending `.md` to the URL. For example, this page becomes `https://docs.prefect.io/v3/get-started.md`.You can also copy any page as markdown by pressing “Cmd+C” (or “Ctrl+C” on Windows) on your keyboard.

Was this page helpful?

YesNo

[Install Prefect](https://docs.prefect.io/v3/get-started/install)

Ctrl+I

[github](https://github.com/PrefectHQ/prefect) [linkedin](https://www.linkedin.com/company/prefect/mycompany) [slack](https://prefect.io/slack) [twitter](https://x.com/prefectio) [youtube](https://www.youtube.com/c/PrefectIO)

Assistant

Responses are generated using AI and may contain mistakes.