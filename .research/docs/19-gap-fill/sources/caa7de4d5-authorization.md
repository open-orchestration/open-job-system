[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781566247591

userId:

deviceId: 809c9622-9cda-4407-86fd-f1951ec2c0a5

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/self-hosted-guide/security#__docusaurus_skipToContent_fallback)

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

    - [Deployment](https://docs.temporal.io/self-hosted-guide/deployment)
    - [Embedded server](https://docs.temporal.io/self-hosted-guide/embedded-server)
    - [Production checklist](https://docs.temporal.io/self-hosted-guide/production-checklist)
    - [Configurable defaults](https://docs.temporal.io/self-hosted-guide/defaults)
    - [Namespaces](https://docs.temporal.io/self-hosted-guide/namespaces)
    - [Security](https://docs.temporal.io/self-hosted-guide/security)
    - [Monitoring](https://docs.temporal.io/self-hosted-guide/monitoring)
    - [Visibility](https://docs.temporal.io/self-hosted-guide/visibility)
    - [Upgrade server](https://docs.temporal.io/self-hosted-guide/upgrade-server)
    - [Archival](https://docs.temporal.io/self-hosted-guide/archival)
    - [Multi-Cluster Replication](https://docs.temporal.io/self-hosted-guide/multi-cluster-replication)
    - [Temporal Nexus](https://docs.temporal.io/production-deployment/self-hosted-guide/nexus)
    - [Server API](https://docs.temporal.io/self-hosted-guide/server-frontend-api-reference)
  - [Worker deployments](https://docs.temporal.io/production-deployment/worker-deployments)

  - [Codecs and Encryption](https://docs.temporal.io/production-deployment/data-encryption)
- [CLI (temporal)](https://docs.temporal.io/cli)

- [References](https://docs.temporal.io/references/)

- [Troubleshooting](https://docs.temporal.io/troubleshooting/)

- [Best practices](https://docs.temporal.io/best-practices/)

- [Encyclopedia](https://docs.temporal.io/encyclopedia/)

- [Interactive Demos](https://docs.temporal.io/self-hosted-guide/security#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Deploy to production](https://docs.temporal.io/production-deployment)
- [Self-host](https://docs.temporal.io/self-hosted-guide)
- Security

On this page

# Temporal Platform security features

Copy

General company security

For information about the general security habits of Temporal Technologies, see our [trust page](https://trust.temporal.io/).

Cloud security

For information about Temporal Cloud security features, see our [Cloud security page](https://docs.temporal.io/cloud/security)

The Temporal Platform is designed with security in mind, and there are many features that you can use to keep both the Platform itself and your user's data secure.

A secured Temporal Server has its network communication encrypted and has authentication and authorization protocols set up for API calls made to it.
Without these, your server could be accessed by unwanted entities.

What is documented on this page are the built-in opt-in security measures that come with Temporal.
However users may also choose to design their own security architecture with reverse proxies or run unsecured instances inside of a VPC environment.

### Server Samples [​](https://docs.temporal.io/self-hosted-guide/security\#server-samples "Direct link to Server Samples")

The [https://github.com/temporalio/samples-server](https://github.com/temporalio/samples-server) repo offers two examples, which are further explained below:

- **TLS:** how to configure Transport Layer Security (TLS) to secure network communication with and within a Temporal Service.
- **Authorizer:** how to inject a low-level authorizer component that can control access to all API calls.

### Encryption in transit with mTLS [​](https://docs.temporal.io/self-hosted-guide/security\#encryption-in-transit-with-mtls "Direct link to Encryption in transit with mTLS")

Temporal supports Mutual Transport Layer Security (mTLS) as a way of encrypting network traffic between the services of a Temporal Service and also between application processes and a Temporal Service.
Self-signed or properly minted certificates can be used for mTLS.
mTLS is set in Temporal's [TLS configuration](https://docs.temporal.io/references/configuration#tls).
The configuration includes two sections such that intra-Temporal Service and external traffic can be encrypted with different sets of certificates and settings:

- `internode`: Configuration for encrypting communication between nodes in the Temporal Service.
- `frontend`: Configuration for encrypting the Frontend's public endpoints.

A customized configuration can be passed using either the [WithConfig](https://docs.temporal.io/references/server-options#withconfig) or [WithConfigLoader](https://docs.temporal.io/references/server-options#withconfigloader) Server options.

See [TLS configuration reference](https://docs.temporal.io/references/configuration#tls) for more details.

### Authentication [​](https://docs.temporal.io/self-hosted-guide/security\#authentication "Direct link to Authentication")

There are a few authentication protocols available to prevent unwanted access such as authentication of servers, clients, and users.

### Servers [​](https://docs.temporal.io/self-hosted-guide/security\#servers "Direct link to Servers")

To prevent spoofing and [MITM attacks](https://en.wikipedia.org/wiki/Man-in-the-middle_attack) you can specify the `serverName` in the `client` section of your respective mTLS configuration.
This enables established connections to authenticate the endpoint, ensuring that the server certificate presented to any connecting Client has the appropriate server name in its CN property.
It can be used for both `internode` and `frontend` endpoints.

More guidance on mTLS setup can be found in [the `samples-server` repo](https://github.com/temporalio/samples-server/tree/main/tls) and you can reach out to us for further guidance.

### Client connections [​](https://docs.temporal.io/self-hosted-guide/security\#client-connections "Direct link to Client connections")

To restrict a client's network access to Temporal Service endpoints you can limit it to clients with certificates issued by a specific Certificate Authority (CA).
Use the `clientCAFiles`/ `clientCAData` and `requireClientAuth` properties in both the `internode` and `frontend` sections of the [mTLS configuration](https://docs.temporal.io/references/configuration#tls).

### Users [​](https://docs.temporal.io/self-hosted-guide/security\#users "Direct link to Users")

To restrict access to specific users, authentication and authorization is performed through extensibility points and plugins as described in the [Authorization](https://docs.temporal.io/self-hosted-guide/security#authorization) section below.

#### Authorization [​](https://docs.temporal.io/self-hosted-guide/security\#authorization "Direct link to Authorization")

info

Information regarding [`Authorizer`](https://docs.temporal.io/self-hosted-guide/security#authorizer-plugin) and [`ClaimMapper`](https://docs.temporal.io/self-hosted-guide/security#claim-mapper) has been moved to another location.

Temporal offers two plugin interfaces for implementing API call authorization:

- [`ClaimMapper`](https://docs.temporal.io/self-hosted-guide/security#claim-mapper)
- [`Authorizer`](https://docs.temporal.io/self-hosted-guide/security#authorizer-plugin)

The authorization and claim mapping logic is customizable, making it available to a variety of use cases and identity schemes.
When these are provided the frontend invokes the implementation of these interfaces before executing the requested operation.

See [https://github.com/temporalio/samples-server/blob/main/extensibility/authorizer](https://github.com/temporalio/samples-server/blob/main/extensibility/authorizer) for a sample implementation.

![Front-end authorization order of operations](https://docs.temporal.io/diagrams/frontend-authorization-order-of-operations.png)

Front-end authorization order of operations

### Single sign-on integration [​](https://docs.temporal.io/self-hosted-guide/security\#single-sign-on-integration "Direct link to Single sign-on integration")

Temporal can be integrated with a single sign-on (SSO) experience by using the `ClaimMapper` and `Authorizer` plugins.
The default JWT `ClaimMapper` implementation can be used as is or as a base for a custom implementation of a similar plugin.

### Temporal UI [​](https://docs.temporal.io/self-hosted-guide/security\#temporal-ui "Direct link to Temporal UI")

To enable SSO authentication in the Temporal UI using environment credentials, you need to configure the UI container with specific environment variables that define your identity provider and OAuth settings.
In your docker-compose.yaml, set `TEMPORAL_AUTH_ENABLED=true` to activate authentication.
Next, specify the required OAuth credentials and endpoints using environment variables such as:

- `TEMPORAL_AUTH_CLIENT_ID`
- `TEMPORAL_AUTH_CLIENT_SECRET`
- `TEMPORAL_AUTH_PROVIDER_URL`
- `TEMPORAL_AUTH_CALLBACK_URL`

These values correspond to the client credentials and endpoints provided by your OAuth identity provider (such as Google, Auth0, Okta).
When properly configured, Temporal UI will redirect users to your SSO login page and enforce authentication on access.
This approach does not require any additional configuration files, making it ideal for containerized environments using secure environment variable injection.

```yaml
temporal-ui:

  container_name: temporal-ui

  depends_on:

    - temporal

  environment:

    - TEMPORAL_GRPC_ENDPOINT=temporal:7233

    - TEMPORAL_ADDRESS=temporal:7233

    - TEMPORAL_AUTH_ENABLED=true

    - TEMPORAL_AUTH_PROVIDER_URL=https://example.com

    - TEMPORAL_AUTH_CLIENT_ID=xxxxxxxxxxxxxx

    - TEMPORAL_AUTH_CLIENT_SECRET=xxxxxxxxxxxxxx

    - TEMPORAL_AUTH_CALLBACK_URL=https://your-domain/auth/sso/callback

    - TEMPORAL_AUTH_SCOPES=openid profile email

  image: temporalio/ui:latest

  networks:

    - temporal-network

  ports:

    - 8080:8080
```

For more general guidance for configuration, refer to the [Temporal UI README](https://github.com/temporalio/ui?tab=readme-ov-file#configuration).
For more details on configuration with Docker, refer to [Temporal UI Config](https://github.com/temporalio/ui/blob/c95265ee6431fd0f6cf78ae06373885d66a8ee0c/server/docker/config-template.yaml).

## Temporal Service plugins [​](https://docs.temporal.io/self-hosted-guide/security\#plugins "Direct link to Temporal Service plugins")

The Temporal Service supports some pluggable components.

### What is a ClaimMapper Plugin? [​](https://docs.temporal.io/self-hosted-guide/security\#claim-mapper "Direct link to What is a ClaimMapper Plugin?")

The Claim Mapper component is a pluggable component that extracts Claims from JSON Web Tokens (JWTs).

This process is achieved with the method `GetClaims`, which translates `AuthInfo` structs from the caller into `Claims` about the caller's roles within Temporal.

A `Role` (within Temporal) is a bit mask that combines one or more of the role constants.
In the following example, the role is assigned constants that allow the caller to read and write information.

```go
role := authorization.RoleReader | authorization.RoleWriter
```

`GetClaims` is customizable and can be modified with the `temporal.WithClaimMapper` server option.
Temporal also offers a default JWT `ClaimMapper` for your use.

A typical approach is for `ClaimMapper` to interpret custom `Claims` from a caller's JWT, such as membership in groups, and map them to Temporal roles for the user.
The subject information from the caller's mTLS certificate can also be a parameter in determining roles.

#### `AuthInfo` [​](https://docs.temporal.io/self-hosted-guide/security\#authinfo "Direct link to authinfo")

`AuthInfo` is a struct that is passed to `GetClaims`. `AuthInfo` contains an authorization token extracted from the `authorization` header of the gRPC request.

`AuthInfo` includes a pointer to the `pkix.Name` struct.
This struct contains an [x.509](https://www.ibm.com/docs/en/ibm-mq/7.5?topic=certificates-distinguished-names) Distinguished Name from the caller's mTLS certificate.

#### `Claims` [​](https://docs.temporal.io/self-hosted-guide/security\#claims "Direct link to claims")

`Claims` is a struct that contains information about permission claims granted to the caller.

`Authorizer` assumes that the caller has been properly authenticated, and trusts the `Claims` when making an authorization decision.

#### Default JWT ClaimMapper [​](https://docs.temporal.io/self-hosted-guide/security\#default-jwt-claimmapper "Direct link to Default JWT ClaimMapper")

Temporal offers a default JWT `ClaimMapper` that extracts the information needed to form Temporal `Claims`.
This plugin requires a public key to validate digital signatures.

To get an instance of the default JWT `ClaimMapper`, call `NewDefaultJWTClaimMapper` and provide it with the following:

- a `TokenKeyProvider` instance
- a `config.Authorization` pointer
- a logger

The code for the default `ClaimMapper` can also be used to build a custom `ClaimMapper`.

#### Token key provider [​](https://docs.temporal.io/self-hosted-guide/security\#token-key-provider "Direct link to Token key provider")

A `TokenKeyProvider` obtains public keys from specified issuers' URIs that adhere to a specific format.
The default JWT `ClaimMapper` uses this component to obtain and refresh public keys over time.

Temporal provides a `defaultTokenKeyProvider`.
This component dynamically obtains public keys that follow the [JWKS format](https://tools.ietf.org/html/rfc7517).
It supports formats such as `RSA` and `ECDSA`.

```go
provider := authorization.NewDefaultTokenKeyProvider(cfg, logger)
```

info

`KeySourceURIs` are the HTTP endpoints that return public keys of token issuers in the [JWKS format](https://tools.ietf.org/html/rfc7517).
`RefreshInterval` defines how frequently keys should be refreshed.
For example, [Auth0](https://auth0.com/) exposes endpoints such as `https://YOUR_DOMAIN/.well-known/jwks.json`.

By default, "permissions" is used to name the `permissionsClaimName` value.

Configure the plugin with `config.Config.Global.Authorization.JWTKeyProvider`.

#### JSON Web Token format [​](https://docs.temporal.io/self-hosted-guide/security\#json-web-token-format "Direct link to JSON Web Token format")

The default JWT `ClaimMapper` expects authorization tokens to be formatted as follows:

```text
Bearer <token>
```

The Permissions Claim in the JWT Token is expected to be a collection of Individual Permission Claims.
Each Individual Permission Claim must be formatted as follows:

```text
<namespace> : <permission>
```

These permissions are then converted into Temporal roles for the caller.
This can be one of Temporal's four values:

- read
- write
- worker
- admin

Multiple permissions for the same Namespace are overridden by the `ClaimMapper`.

##### Example of a payload for the default JWT ClaimMapper [​](https://docs.temporal.io/self-hosted-guide/security\#example-of-a-payload-for-the-default-jwt-claimmapper "Direct link to Example of a payload for the default JWT ClaimMapper")

```text
{

   "permissions":[\
\
      "temporal-system:read",\
\
      "namespace1:write"\
\
   ],

   "aud":[\
\
      "audience"\
\
   ],

   "exp":1630295722,

   "iss":"Issuer"

}
```

### What is an Authorizer Plugin? [​](https://docs.temporal.io/self-hosted-guide/security\#authorizer-plugin "Direct link to What is an Authorizer Plugin?")

The `Authorizer` plugin contains a single `Authorize` method, which is invoked for each incoming API call.
`Authorize` receives information about the API call, along with the role and permission claims of the caller.

`Authorizer` allows for a wide range of authorization logic, including call target, role/permissions claims, and other data available to the system.

#### Configuration [​](https://docs.temporal.io/self-hosted-guide/security\#configuration "Direct link to Configuration")

The following arguments must be passed to `Authorizer`:

- `context.Context`: General context of the call.
- `authorization.Claims`: Claims about the roles assigned to the caller. Its intended use is described in the [`Claims`](https://docs.temporal.io/self-hosted-guide/security#claims) section earlier on this page.
- `authorization.CallTarget`: Target of the API call.

`Authorizer` then returns one of two decisions:

- `DecisionDeny`: the requested API call is not invoked and an error is returned to the caller.
- `DecisionAllow`: the requested API call is invoked.

Security Warning

If you do **not** explicitly configure an `Authorizer`, Temporal uses the default `noopAuthorizer`. This default allows **every** API request,
with no authentication or access control. Anyone who can reach your Temporal Server can invoke any API, including sensitive administrative operations.
This is **not secure** for production or for any environment that is accessible to untrusted clients (such as over the internet).

**To protect your Temporal Server, you must configure an `Authorizer` plugin with a corresponding `ClaimMapper`.** Without this, your deployment is
effectively open to anyone with network access.

Configure your `Authorizer` with the [`temporal.WithAuthorizer`](https://docs.temporal.io/references/server-options#withauthorizer) server option, and your `ClaimMapper` with
the [`temporal.WithClaimMapper`](https://docs.temporal.io/references/server-options#withclaimmapper) server option.

```go
temporalServer, err := temporal.NewServer(

	temporal.WithAuthorizer(newCustomAuthorizer()),

	temporal.WithClaimMapper(func(cfg *config.Config) authorization.ClaimMapper {

		return newCustomClaimMapper(cfg)

	}),

)
```

#### How to authorize SDK API calls [​](https://docs.temporal.io/self-hosted-guide/security\#authorize-api-calls "Direct link to How to authorize SDK API calls")

When authentication is enabled, you can authorize API calls made to the Frontend Service.

The Temporal Server [expects](https://docs.temporal.io/self-hosted-guide/security#authentication) an `authorization` gRPC header with an authorization token to be passed with API calls if [requests authorization](https://docs.temporal.io/self-hosted-guide/security#authorization) is configured.

Authorization Tokens may be provided to the Temporal Java SDK by implementing a `io.temporal.authorization.AuthorizationTokenSupplier` interface.
The implementation should be used to create `io.temporal.authorization.AuthorizationGrpcMetadataProvider` that may be configured on ServiceStub gRPC interceptors list.

The implementation is called for each SDK gRPC request and may supply dynamic tokens.

**JWT**

One of the token types that may be passed this way are JWT tokens.
Temporal Server provides a [default implementation of JWT authentication](https://docs.temporal.io/self-hosted-guide/security#default-jwt-claimmapper).

**Example**

```java
AuthorizationTokenSupplier tokenSupplier =

  //your implementation of token supplier

  () -> "Bearer <Base64 url-encoded value of the token for default JWT ClaimMapper>";

WorkflowServiceStubsOptions serviceStubOptions =

  WorkflowServiceStubsOptions.newBuilder()

    //other service stub options

    .addGrpcMetadataProvider(new AuthorizationGrpcMetadataProvider(tokenSupplier))

    .build();

WorkflowServiceStubs service = WorkflowServiceStubs.newServiceStubs(serviceStubOptions);

WorkflowClient client = WorkflowClient.newInstance(service);
```

Related read:

- [How to secure a Temporal Service](https://docs.temporal.io/security)

## Data Converter [​](https://docs.temporal.io/self-hosted-guide/security\#data-converter "Direct link to Data Converter")

Each Temporal SDK provides a [Data Converter](https://docs.temporal.io/dataconversion) that can be customized with a custom [Payload Codec](https://docs.temporal.io/payload-codec) to encode and secure your data.

For details on what data can be encoded, how to secure it, and what to consider when using encryption, see [Data encryption](https://docs.temporal.io/production-deployment/data-encryption).

#### Codec Server [​](https://docs.temporal.io/self-hosted-guide/security\#codec-server "Direct link to Codec Server")

You can use a [Codec Server](https://docs.temporal.io/codec-server) with your custom Payload Codec to decode the data you see on your Web UI and CLI locally through remote endpoints.
However, ensure that you consider all security implications of [remote data encoding](https://docs.temporal.io/remote-data-encoding) before using a Codec Server.

For details on how to set up a Codec Server, see [Codec Server setup](https://docs.temporal.io/production-deployment/data-encryption#codec-server-setup).

## Configuration Options for Restricting and Securing Access [​](https://docs.temporal.io/self-hosted-guide/security\#configuration-options-for-restricting-and-securing-access "Direct link to Configuration Options for Restricting and Securing Access")

Temporal provides extensive configuration options to limit and control which callers can access your services and how those services behave in different environments. These options help you enforce stricter security boundaries in self-hosted deployments and tune behavior for production use cases. For more details on available settings and how to configure them, see the following references:

- [Cluster & Server configuration](https://docs.temporal.io/references/configuration) — Static configuration settings for servers and services.

- [Dynamic configuration](https://docs.temporal.io/references/dynamic-configuration) — Runtime-updatable settings for tuning and behavior control.

- [Client environment configuration](https://docs.temporal.io/references/client-environment-configuration) — Environment variable settings for configuring Temporal clients.


**Tags:**

- [Temporal Service](https://docs.temporal.io/tags/temporal-service)
- [Self-hosting](https://docs.temporal.io/tags/self-hosting)
- [Security](https://docs.temporal.io/tags/security)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Namespaces](https://docs.temporal.io/self-hosted-guide/namespaces) [Next\\
\\
Monitoring](https://docs.temporal.io/self-hosted-guide/monitoring)

- [Server Samples](https://docs.temporal.io/self-hosted-guide/security#server-samples)
- [Encryption in transit with mTLS](https://docs.temporal.io/self-hosted-guide/security#encryption-in-transit-with-mtls)
- [Authentication](https://docs.temporal.io/self-hosted-guide/security#authentication)
- [Servers](https://docs.temporal.io/self-hosted-guide/security#servers)
- [Client connections](https://docs.temporal.io/self-hosted-guide/security#client-connections)
- [Users](https://docs.temporal.io/self-hosted-guide/security#users)
  - [Authorization](https://docs.temporal.io/self-hosted-guide/security#authorization)
- [Single sign-on integration](https://docs.temporal.io/self-hosted-guide/security#single-sign-on-integration)
- [Temporal UI](https://docs.temporal.io/self-hosted-guide/security#temporal-ui)
- [Temporal Service plugins](https://docs.temporal.io/self-hosted-guide/security#plugins)
  - [What is a ClaimMapper Plugin?](https://docs.temporal.io/self-hosted-guide/security#claim-mapper)
    - [`AuthInfo`](https://docs.temporal.io/self-hosted-guide/security#authinfo)
    - [`Claims`](https://docs.temporal.io/self-hosted-guide/security#claims)
    - [Default JWT ClaimMapper](https://docs.temporal.io/self-hosted-guide/security#default-jwt-claimmapper)
    - [Token key provider](https://docs.temporal.io/self-hosted-guide/security#token-key-provider)
    - [JSON Web Token format](https://docs.temporal.io/self-hosted-guide/security#json-web-token-format)
  - [What is an Authorizer Plugin?](https://docs.temporal.io/self-hosted-guide/security#authorizer-plugin)
    - [Configuration](https://docs.temporal.io/self-hosted-guide/security#configuration)
    - [How to authorize SDK API calls](https://docs.temporal.io/self-hosted-guide/security#authorize-api-calls)
- [Data Converter](https://docs.temporal.io/self-hosted-guide/security#data-converter)
  - [Codec Server](https://docs.temporal.io/self-hosted-guide/security#codec-server)
- [Configuration Options for Restricting and Securing Access](https://docs.temporal.io/self-hosted-guide/security#configuration-options-for-restricting-and-securing-access)

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