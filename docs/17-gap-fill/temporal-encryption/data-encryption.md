[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781566256201

userId:

deviceId: b8d3df36-2e2a-4878-80d2-1914930892bc

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/production-deployment/data-encryption#__docusaurus_skipToContent_fallback)

[![Temporal logo](https://docs.temporal.io/img/assets/temporal-logo-dark.svg)](https://temporal.io/)[Home](https://docs.temporal.io/) [Courses](https://learn.temporal.io/getting_started/) [SDKs](https://docs.temporal.io/develop) [AI Cookbook](https://docs.temporal.io/ai-cookbook) [Code Exchange](https://temporal.io/code-exchange) [Temporal Cloud](https://docs.temporal.io/cloud)

Ask AI

Search`Ctrl`  `K`

- [Home](https://docs.temporal.io/)
- [Quickstarts](https://docs.temporal.io/quickstarts)
- [Evaluate](https://docs.temporal.io/evaluate/)

- [Develop](https://docs.temporal.io/develop/)

- [Temporal Cloud](https://docs.temporal.io/cloud)

- [Deploy to production](https://docs.temporal.io/production-deployment)

  - [Self-host](https://docs.temporal.io/self-hosted-guide)

  - [Worker deployments](https://docs.temporal.io/production-deployment/worker-deployments)

  - [Codecs and Encryption](https://docs.temporal.io/production-deployment/data-encryption)
- [CLI (temporal)](https://docs.temporal.io/cli)

- [References](https://docs.temporal.io/references/)

- [Troubleshooting](https://docs.temporal.io/troubleshooting/)

- [Best practices](https://docs.temporal.io/best-practices/)

- [Encyclopedia](https://docs.temporal.io/encyclopedia/)

- [Interactive Demos](https://docs.temporal.io/production-deployment/data-encryption#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Deploy to production](https://docs.temporal.io/production-deployment)
- Codecs and Encryption

On this page

# Codecs and Encryption

Copy

The Temporal Service persists data from your Workflow Executions, including inputs, outputs, and results. To protect
sensitive data, use a [Payload Codec](https://docs.temporal.io/payload-codec) to encrypt payloads before they reach the Temporal Service. With
encryption enabled, data exists unencrypted only on the Client and the Worker process, on hosts that you control.

The following data is persisted in the Event History and can be encrypted:

- Inputs and outputs/results in your [Workflow](https://docs.temporal.io/workflow-execution), [Activity](https://docs.temporal.io/activity-execution), and [Child Workflow](https://docs.temporal.io/child-workflows)
- [Signal](https://docs.temporal.io/sending-messages#sending-signals) inputs
- [Memo](https://docs.temporal.io/workflow-execution#memo)
- Headers (verify if applicable to your SDK)
- [Query](https://docs.temporal.io/sending-messages#sending-queries) inputs and results
- Results of [Local Activities](https://docs.temporal.io/local-activity) and [Side Effects](https://docs.temporal.io/workflow-execution/event#side-effect)
- [Application errors and failures](https://docs.temporal.io/references/failures).
Failure messages and call stacks are not encoded as codec-capable Payloads by default; you must explicitly enable
encoding these common attributes on failures. For more details, see [Failure Converter](https://docs.temporal.io/failure-converter).

To view encrypted data in the Web UI and CLI, set up a [Codec Server](https://docs.temporal.io/codec-server). The following sections cover how
to set up a Codec Server and configure the Web UI and CLI to use it.

For encryption implementation examples, see the following samples:

- [Go](https://github.com/temporalio/samples-go/tree/main/encryption)
- [Java](https://github.com/temporalio/samples-java/tree/main/core/src/main/java/io/temporal/samples/encryptedpayloads)
- [Python](https://github.com/temporalio/samples-python/tree/main/encryption)
- [TypeScript](https://github.com/temporalio/samples-typescript/tree/main/encryption)
- [.NET](https://github.com/temporalio/samples-dotnet/tree/main/src/Encryption)

## Codec Server setup [​](https://docs.temporal.io/production-deployment/data-encryption\#codec-server-setup "Direct link to Codec Server setup")

Use a Codec Server to programmatically decode your encoded [payloads](https://docs.temporal.io/dataconversion#payload).

A Codec Server is an HTTP server that uses your custom Codec logic to decode your data remotely.
The Codec Server is independent of the Temporal Service and decodes your encrypted payloads through predefined endpoints. You create, operate, and manage access to your Codec Server in your own environment.
When you configure a Codec Server endpoint in the Web UI or CLI, the Web UI and CLI use the remote endpoint to send and receive payloads from the Codec Server.
See [API contract requirements](https://docs.temporal.io/production-deployment/data-encryption#api-contract-specifications).

Decoded payloads can then be displayed in the Workflow Execution Event History on the Web UI. When you use a Codec Server, the decoded payloads are decoded and returned on the client side only. Payloads on the Temporal Service (whether on Temporal Cloud or self-hosted) remain encrypted.

Because you create, operate, and manage access to your Codec Server in your controlled environment, ensure that you consider the following:

- When you register a Codec Server endpoint with your Web UI, expect the Codec Server to receive multiple requests per Workflow Execution.
- Ensure that you secure access to your Codec Server. For details, see [Authorization](https://docs.temporal.io/production-deployment/data-encryption#authorization). You might need some form of [Key management infrastructure](https://docs.temporal.io/key-management) for sharing your encryption keys between the Workers and your Codec Server.
- You will need to enable [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) on the HTTP/HTTPS endpoints in your Codec Server to receive requests from the Temporal Web UI.
- You may introduce latency in the Web UI when sending and receiving payloads to the Codec Server.

Your Codec Server should share logic with the custom [Payload Codec](https://docs.temporal.io/payload-codec) used elsewhere in your application.

### API contract specifications [​](https://docs.temporal.io/production-deployment/data-encryption\#api-contract-specifications "Direct link to API contract specifications")

When you create your Codec Server to handle requests from the Web UI, the following requirements must be met.

#### Endpoints [​](https://docs.temporal.io/production-deployment/data-encryption\#endpoints "Direct link to Endpoints")

The Web UI and CLI send POST requests to the following endpoints on your Codec Server:

- `/decode` passes incoming payloads to the decode method in your Payload Codec.
- `/encode` passes incoming payloads to the encode method in your Payload Codec.
- `/download` retrieves and decodes payloads from [External Storage](https://docs.temporal.io/external-storage). This endpoint is only needed if
your Workers use External Storage. See [Codec Server with External Storage](https://docs.temporal.io/codec-server#external-storage) for
details.

For examples on how to create your Codec Server, see the following Codec Server implementation samples:

- [Go](https://github.com/temporalio/samples-go/tree/main/codec-server)
- [Java](https://github.com/temporalio/sdk-java/tree/master/temporal-remote-data-encoder)
- [Python](https://github.com/temporalio/samples-python/blob/main/encryption/codec_server.py)
- [TypeScript](https://github.com/temporalio/samples-typescript/blob/main/encryption/src/codec-server.ts)
- [.NET](https://github.com/temporalio/samples-dotnet/blob/main/src/Encryption/CodecServer/Program.cs)

You can also add a [verification step](https://docs.temporal.io/production-deployment/data-encryption#authorization) to check whether the incoming request has the required authorization to access the decode logic in your Payload Codec.

#### Headers [​](https://docs.temporal.io/production-deployment/data-encryption\#headers "Direct link to Headers")

Each request from the Web UI to your Codec Server includes the following headers:

- `Content-Type: application/json`: Ensure that your Codec Server can accommodate this [MIME type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types).

- `X-Namespace: {namespace}`: This is a custom HTTP Header. Ensure that the [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) configuration in your Codec Server includes this header.

- \[Optional\] `Authorization: <credentials>`: Include this in your CORS configuration when enabling authorization with your Codec Server.


For details on setting up authorization, see [Authorization](https://docs.temporal.io/production-deployment/data-encryption#authorization).

#### Request body [​](https://docs.temporal.io/production-deployment/data-encryption\#request-body "Direct link to Request body")

The general specification for the `POST` request body contains payloads.
By default, all field values in your payload are base64 encoded, regardless of whether they are encrypted by your custom codec implementation.

The following example shows a sample `POST` request body with base64 encoding.

```json
{

  "payloads": [{\
\
    "metadata": {\
\
      "encoding": <base64EncodedEncodingHint>\
\
    },\
\
    "data": <encryptedPayloadData>\
\
  }, ...]

}
```

#### CORS [​](https://docs.temporal.io/production-deployment/data-encryption\#cors "Direct link to CORS")

By default, in cross-origin Fetch/XHR invocations, browsers will not send credentials.
Enable [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) requests on your Codec Server to receive HTTP/HTTPS requests from the Temporal Web UI.

At a minimum, enable the following responses from your Codec Server to allow requests coming from the Temporal Web UI:

- `Access-Control-Allow-Origin`
- `Access-Control-Allow-Methods`
- `Access-Control-Allow-Headers`

For example, for Temporal Cloud Web UI hosted at [https://cloud.temporal.io](https://cloud.temporal.io/), enable the following in your Codec Server:

- `Access-Control-Allow-Origin: https://cloud.temporal.io`
- `Access-Control-Allow-Methods: POST, GET, OPTIONS`
- `Access-Control-Allow-Headers: X-Namespace, Content-Type`

For details on what a sample request/response looks like from the Temporal Web UI, see [Sample Request/Response](https://docs.temporal.io/production-deployment/data-encryption#sample-requestresponse).
If setting authorization, include `Authorization` in your `Access-Control-Allow-Headers`.
For details on setting up authorization, see [Authorization](https://docs.temporal.io/production-deployment/data-encryption#authorization).

#### Authorization [​](https://docs.temporal.io/production-deployment/data-encryption\#authorization "Direct link to Authorization")

It is important to establish how you will provide access to your Codec Server.
Because it is designed to decode potentially sensitive data with a single API call, access to a production Codec Server should be restricted.

Depending on your infrastructure and risk levels, it might be sufficient to restrict HTTP ingress to your Codec Server (such as by using a VPN like [WireGuard](https://www.wireguard.com/)).
The Temporal Web UI can communicate with a Codec Server that is only accessible on `localhost`, so this is a legitimate security pattern.
However, if your Codec Server is exposed to the internet at all, you will likely need an authentication solution.

If you are already using an organization-wide authentication provider, you should integrate it with your Codec Server. Remember, a Codec Server is just a standalone HTTP server, so you can use existing libraries for OAuth, [Auth0](https://auth0.com/), or any other protocol.
[This repository](https://github.com/pvsone/codec-cors-credentials) contains an example of using Auth0 to handle browser-based auth to a Codec Server.

To enable authorization from the Web UI (for both a self-hosted Temporal Service and Temporal Cloud), your Codec Server must be an HTTPS Server.

**Temporal Cloud**

The Temporal Cloud UI provides an option to pass access tokens (JWT) to your Codec Server endpoints.
Use the access tokens to validate access and then return decoded payloads from the Codec Server.

You can enable this by selecting **Pass access token** in your Codec Server endpoint interface where you add your endpoint.
Enabling this option in the Temporal Cloud UI adds an authorization header to each request sent to the Codec Server endpoint that you set.

In your Codec Server implementation, verify the signature on this access token (in your authorization header) against [our JWKS endpoint](https://login.tmprl.cloud/.well-known/jwks.json).

The token provided from Temporal Cloud UI contains the email identifier of the person requesting access to the payloads.
Based on the permissions you have provided to the user in your access control systems, set conditions in your Codec Server whether to return decoded payloads or just return the original encoded payloads.

**Self-hosted Temporal Service**

On a self-hosted Temporal Service, configure [authorization in the Web UI configuration](https://docs.temporal.io/references/web-ui-configuration#auth) in your Temporal Service setup.

With this enabled, you can pass access tokens to your Codec Server and validate the requests from the Web UI to the Codec Server endpoints that you set.
Note that with a self-hosted Temporal Service, you must explicitly configure authorization specifications for the Web UI and CLI.

#### Sample request/response [​](https://docs.temporal.io/production-deployment/data-encryption\#sample-requestresponse "Direct link to Sample request/response")

Consider the following sample request/response when creating and hosting a Codec Server with the following specifications:

- Scheme: `https`
- Host: `dev.mydomain.com/codec`
- Path: `/decode`

```json
HTTP/1.1 POST /decode

Host: https://dev.mydomain.com/codec

Content-Type: application/json

X-Namespace: myapp-dev.acctid123

Authorization: Bearer <token>

{"payloads":[{"metadata":{"encoding":"anNvbi9wcm90b2J1Zg==","messageType":"dGVtcG9yYWxfc2hvcC5vcmNoZXN0cmF0aW9ucy52MS5TdGFydFNob3BwaW5nQ2FydFJlcXVlc3Q="},"data":"eyJjYXJ0SWQiOiJleGFtcGxlLWNhcnQiLCJzaG9wcGVySWQiOiJ5b3VyLXNob3BwZXItaWQtZXhhbXBsZSIsImVtYWlsIjoieW91ci1lbWFpbEBkb21haW4uY29tIn0"}]}

200 OK

Content-Type: application/json

{

  "payloads": [{\
\
    "metadata":{\
\
      "encoding": "json/protobuf",\
\
      "messageType": "temporal_shop.orchestrations.v1.StartShoppingCartRequest"\
\
    },\
\
    "data":{\
\
      "cartId":"example-cart",\
\
      "shopperId":"your-shopper-id-example",\
\
      "email":"your-email@domain.com"\
\
    }}]

}
```

You can also perform remote encoding on an `/encode` endpoint, which looks the same in reverse:

- Scheme: `https`
- Host: `dev.mydomain.com/codec`
- Path: `/encode`

```json
HTTP/1.1 POST /encode

Host: https://dev.mydomain.com/codec

Content-Type: application/json

X-Namespace: myapp-dev.acctid123

Authorization: Bearer <token>

{"payloads":[{"metadata":{"encoding":"json/protobuf","messageType":"temporal_shop.orchestrations.v1.StartShoppingCartRequest"},"data":{"cartId":"example-cart","shopperId":"your-shopper-id-example","email":"your-email@domain.com"}}]}

200 OK

Content-Type: application/json

{

  "payloads": [\
\
    {\
\
      "metadata": {\
\
        "encoding": "anNvbi9wcm90b2J1Zg==",\
\
        "messageType": "dGVtcG9yYWxfc2hvcC5vcmNoZXN0cmF0aW9ucy52MS5TdGFydFNob3BwaW5nQ2FydFJlcXVlc3Q="\
\
      },\
\
      "data": "eyJjYXJ0SWQiOiJleGFtcGxlLWNhcnQiLCJzaG9wcGVySWQiOiJ5b3VyLXNob3BwZXItaWQtZXhhbXBsZSIsImVtYWlsIjoieW91ci1lbWFpbEBkb21haW4uY29tIn0"\
\
    }\
\
  ]

}
```

### Set your Codec Server endpoints with Web UI and CLI [​](https://docs.temporal.io/production-deployment/data-encryption\#set-your-codec-server-endpoints-with-web-ui-and-cli "Direct link to Set your Codec Server endpoints with Web UI and CLI")

After you create your Codec Server and expose the requisite endpoints, set the endpoints in your Web UI and CLI.

#### Web UI [​](https://docs.temporal.io/production-deployment/data-encryption\#web-ui "Direct link to Web UI")

On Temporal Cloud and self-hosted Temporal Service, you can configure a Codec Server endpoint to be used for a Namespace in the Web UI.

![Codec Server endpoint Namespace setting](https://docs.temporal.io/img/info/set-codec-endpoint-form.png)

Codec Server endpoint Namespace setting

caution

If your Codec Server is on a private network, your browser may block Temporal Web UI from accessing it. On Chrome, your browser may prompt you to allow access to the Codec Server endpoint. Make sure to allow access to the Codec Server endpoint. Refer to the [Chrome for Developers blog: New permission prompt for Local Network Access](https://developer.chrome.com/blog/local-network-access/) for details on this permission prompt.

If your browser has blocked Temporal's access to your Codec Server, refer to [Chrome documentation](https://support.google.com/chrome/answer/114662) for details on how to change the site settings. In **Site settings**, look for the **Local network** setting and change it to **Allow** to only change this setting for Temporal without affecting other sites.

To set a Codec Server endpoint on a Namespace, do the following.

1. In the Web UI, go to Namespaces, select the Namespace where you want to configure the Codec Server endpoint, and click **Edit**.
2. In the **Codec Server** section on the Namespace configuration page, enter your Codec Server endpoint and port number.
3. Optional: If your Codec Server is configured to [authenticate requests](https://docs.temporal.io/production-deployment/data-encryption#authorization) from Temporal Web UI, enable **Pass access token** to send a JWT access token with the HTTPS requests.
4. Optional: If your Codec Server is configured to [verify origins of requests](https://docs.temporal.io/production-deployment/data-encryption#cors), enable **Include cross-origin credentials**.

On Temporal Cloud, you must have [Namespace Admin privileges](https://docs.temporal.io/cloud/manage-access/roles-and-permissions#namespace-level-permissions) to add a Codec Server endpoint on the Namespace. Setting a Codec Server endpoint on a Cloud Namespace enables it for all users on the Namespace.

Setting a Codec Server endpoint on a self-hosted Temporal Service enables it for the entire Temporal Service. You can use a single Codec Server to handle different encoding and decoding routes for each namespace.

You can also override the global Codec Server setting at the browser level. This can be useful when developing, testing, or troubleshooting encoding functionality.

![Codec Server endpoint browser setting](https://docs.temporal.io/img/info/data-encoder-button.png)

Codec Server endpoint browser setting

To set a browser override for the Namespace-level endpoint, do the following.

1. Navigate to **Workflows** in your Namespace.
2. In the top-right corner, select **Configure Codec Server**.
3. Select whether you want to use the Namespace-level (or Temporal Service-level for self-hosted Temporal Service) or the browser-level Codec Endpoint setting as the default for your browser.
In Temporal Cloud:
   - **Use Namespace-level settings, where available. Otherwise, use my browser setting.**
     Uses the Namespace-level Codec Server endpoint by default.
     If no endpoint is set on the Namespace, your browser setting is applied.
   - **Use my browser setting and ignore Namespace-level setting.**
     Applies your browser-level setting by default, overriding the Namespace-level Codec Server endpoint.
4. Enter your Codec Server endpoint and port number.
5. Optional: If your Codec Server is configured to [authenticate requests](https://docs.temporal.io/production-deployment/data-encryption#authorization) from Temporal Web UI, enable **Pass access token** to send a JWT access token with the HTTPS requests.
6. Optional: If your Codec Server is configured to [verify origins of requests](https://docs.temporal.io/production-deployment/data-encryption#cors), enable **Include cross-origin credentials**.

In a self-hosted Temporal Service with dedicated UI Server configuration, you can also set the codec endpoint in the UI server [configuration file](https://docs.temporal.io/references/web-ui-configuration#codec):

```yaml
codec:

    endpoint: {{ default .Env.TEMPORAL_CODEC_ENDPOINT "{namespace}"}}
```

#### CLI [​](https://docs.temporal.io/production-deployment/data-encryption\#cli "Direct link to CLI")

You can configure a Codec Server endpoint with the Temporal CLI using the `--codec-endpoint` flag.

For example, if you are running your Codec Server on `http://localhost:8888`, you can use `env set` to set the endpoint globally:

```bash
temporal env set --codec-endpoint "http://localhost:8888"
```

If your Codec Server endpoint is not set globally, provide the `--codec-endpoint` option with each command.
For example, to see the decoded output of the Workflow Execution "yourWorkflow" in the Namespace "yourNamespace", run:

```bash
temporal --codec-endpoint "http://localhost:8888" --namespace "yourNamespace" workflow show --workflow-id "yourWorkflow"  --run-id "<yourRunId>" --output "table"
```

For details, see the [CLI reference](https://docs.temporal.io/cli/).

If your Codec Server requires authentication, the Temporal CLI will also accept a `--codec-auth` parameter to supply an
authorization header:

```shell
temporal workflow show \

   --workflow-id converters_workflowID \

   --codec-endpoint 'http://localhost:8081/{namespace}' \

   --codec-auth 'auth-header'
```

### Working with large payloads [​](https://docs.temporal.io/production-deployment/data-encryption\#working-with-large-payloads "Direct link to Working with large payloads")

If your payloads exceed the Temporal Service's size limits, use [External Storage](https://docs.temporal.io/external-storage) to offload large
payloads to an external store like Amazon S3. The Web UI displays a claim reference instead of the payload content for
externally stored payloads. When External Storage is configured on your Codec Server, the Codec Server can retrieve
and decode these payloads for viewing in the Web UI and CLI. See
[Codec Server with External Storage](https://docs.temporal.io/codec-server#external-storage) for details.

### Temporal Nexus [​](https://docs.temporal.io/production-deployment/data-encryption\#temporal-nexus "Direct link to Temporal Nexus")

The Data Converter works the same for a Nexus Operation as it does for other payloads sent between a Worker and Temporal Cloud.
Both the caller and handler Workers must use compatible Data Converters to pass operation inputs and results between them.

See [Nexus Payload Encryption & Data Converter](https://docs.temporal.io/nexus/security#payload-encryption-data-converter) for details.

**Tags:**

- [Temporal Service](https://docs.temporal.io/tags/temporal-service)
- [Self-hosting](https://docs.temporal.io/tags/self-hosting)
- [Security](https://docs.temporal.io/tags/security)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Self-hosted setup](https://docs.temporal.io/production-deployment/worker-deployments/serverless-workers/self-hosted-setup) [Next\\
\\
Temporal CLI](https://docs.temporal.io/cli)

- [Codec Server setup](https://docs.temporal.io/production-deployment/data-encryption#codec-server-setup)
  - [API contract specifications](https://docs.temporal.io/production-deployment/data-encryption#api-contract-specifications)
    - [Endpoints](https://docs.temporal.io/production-deployment/data-encryption#endpoints)
    - [Headers](https://docs.temporal.io/production-deployment/data-encryption#headers)
    - [Request body](https://docs.temporal.io/production-deployment/data-encryption#request-body)
    - [CORS](https://docs.temporal.io/production-deployment/data-encryption#cors)
    - [Authorization](https://docs.temporal.io/production-deployment/data-encryption#authorization)
    - [Sample request/response](https://docs.temporal.io/production-deployment/data-encryption#sample-requestresponse)
  - [Set your Codec Server endpoints with Web UI and CLI](https://docs.temporal.io/production-deployment/data-encryption#set-your-codec-server-endpoints-with-web-ui-and-cli)
    - [Web UI](https://docs.temporal.io/production-deployment/data-encryption#web-ui)
    - [CLI](https://docs.temporal.io/production-deployment/data-encryption#cli)
  - [Working with large payloads](https://docs.temporal.io/production-deployment/data-encryption#working-with-large-payloads)
  - [Temporal Nexus](https://docs.temporal.io/production-deployment/data-encryption#temporal-nexus)

- [GitHub](https://github.com/temporalio)
- [Twitter](https://x.com/temporalio)
- [YouTube](https://www.youtube.com/c/Temporalio)
- [About the docs](https://github.com/temporalio/documentation/blob/main/README.md)

- [Temporal Cloud](https://temporal.io/cloud)
- [Meetups](https://temporal.io/community#events)
- [Support forum](https://community.temporal.io/)
- [Ask an expert](https://pages.temporal.io/ask-an-expert)

- [Learn Temporal](https://learn.temporal.io/)
- [Blog](https://temporal.io/blog)
- [Use cases](https://temporal.io/in-use)
- [Newsletter signup](https://pages.temporal.io/newsletter-subscribe)

- [Security](https://docs.temporal.io/security)
- [Privacy policy](https://temporal.io/global-privacy-policy)
- [Terms of service](https://temporal.io/terms-of-service)
- [We're hiring](https://temporal.io/careers)

[![Temporal logo](https://docs.temporal.io/img/favicon.png)](https://temporal.io/)

Copyright © 2026 Temporal Technologies Inc.

Feedback

reCAPTCHA

Recaptcha requires verification.

protected by **reCAPTCHA**