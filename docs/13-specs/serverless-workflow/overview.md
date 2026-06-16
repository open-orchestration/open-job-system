[Serverless Workflow](https://serverlessworkflow.io/)

- [Blog](https://serverlessworkflow.io/blog)
- [Community](https://serverlessworkflow.io/community)

![](https://serverlessworkflow.io/img/logos/sw-logo.png)

# Serverless Workflow

Serverless Workflow presents a vendor-neutral, open-source, and entirely community-driven ecosystem tailored for defining and executing DSL-based workflows in the realm of Serverless technology.

The current version is 1.0.3, get the JSON Schema here: [YAML](https://serverlessworkflow.io/schemas/1.0.3/workflow.yaml) or [JSON](https://serverlessworkflow.io/schemas/1.0.3/workflow.json)

[Learn More](https://github.com/serverlessworkflow/specification/blob/main/README.md)

SDK

- [.NET](https://github.com/serverlessworkflow/sdk-net)
- [Go](https://github.com/serverlessworkflow/sdk-go)
- [Java](https://github.com/serverlessworkflow/sdk-java)
- [PHP](https://github.com/serverlessworkflow/sdk-php)
- [Python](https://github.com/serverlessworkflow/sdk-python)
- [Rust](https://github.com/serverlessworkflow/sdk-rust)
- [TypeScript](https://github.com/serverlessworkflow/sdk-typescript)

[Runtime](https://github.com/serverlessworkflow/synapse)

The Serverless Workflow DSL is a high-level language that reshapes the terrain of workflow creation, boasting a design that is ubiquitous, intuitive, imperative, and fluent.

### Usability

Designed with linguistic fluency, implicit default behaviors, and minimal technical jargon, making workflows accessible to developers with diverse skill levels and enhancing collaboration.

### Event driven

Supports event-driven execution and various scheduling options, including CRON expressions and time-based triggers, to respond efficiently to dynamic conditions.

### Interoperability

Seamlessly integrates with multiple protocols (HTTP, gRPC, OpenAPI, AsyncAPI), ensuring easy communication with external systems and services, along with support for custom interactions via scripts, containers, or shell commands.

### Platform-Agnostic

Serverless Workflow enables developers to build workflows that can operate across diverse platforms and environments, eliminating the need for platform-specific adaptations.

### Extensibility

Provides extensible components and supports defining custom functions and extensions, allowing developers to tailor workflows to unique business requirements without compromising compatibility.

### Fault tolerant

Offers comprehensive data transformation, validation, and fault tolerance mechanisms, ensuring workflows are robust, reliable, and capable of handling complex processes and failures gracefully.

## User-Friendly DSL: Workflows Made Simple

### Async API Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: call-asyncapi
  version: '1.0.0'
do:
- findPet:
    call: asyncapi
    with:
      document:
        uri: https://fake.com/docs/asyncapi.json
      operationRef: findPetsByStatus
      server: staging
      message:
        payload:
          petId: ${ .pet.id }
      authentication:
        bearer:
          token: ${ .token }
```

### Container Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: run-container
  version: '1.0.0'
do:
  - runContainer:
      run:
        container:
          image: fake-image
```

### Emit Event Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: emit
  version: '0.1.0'
do:
  - emitEvent:
      emit:
        event:
          with:
            source: https://petstore.com
            type: com.petstore.order.placed.v1
            data:
              client:
                firstName: Cruella
                lastName: de Vil
              items:
                - breed: dalmatian
                  quantity: 101
```

### For Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: for-example
  version: '0.1.0'
do:
  - checkup:
      for:
        each: pet
        in: .pets
        at: index
      while: .vet != null
      do:
        - waitForCheckup:
            listen:
              to:
                one:
                  with:
                    type: com.fake.petclinic.pets.checkup.completed.v2
            output:
              as: '.pets + [{ "id": $pet.id }]'
```

### Fork Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: fork-example
  version: '0.1.0'
do:
  - raiseAlarm:
      fork:
        compete: true
        branches:
          - callNurse:
              call: http
              with:
                method: put
                endpoint: https://fake-hospital.com/api/v3/alert/nurses
                body:
                  patientId: ${ .patient.fullName }
                  room: ${ .room.number }
          - callDoctor:
              call: http
              with:
                method: put
                endpoint: https://fake-hospital.com/api/v3/alert/doctor
                body:
                  patientId: ${ .patient.fullName }
                  room: ${ .room.number }
```

### gRPC Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: call-grpc
  version: '1.0.0'
do:
  - greet:
      call: grpc
      with:
        proto:
          endpoint: file://app/greet.proto
        service:
          name: GreeterApi.Greeter
          host: localhost
          port: 5011
        method: SayHello
        arguments:
          name: '${ .user.preferredDisplayName }'
```

### HTTP Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: call-http
  version: '1.0.0'
do:
- getPet:
    call: http
    with:
      method: get
      endpoint: https://petstore.swagger.io/v2/pet/{petId}
```

### Listen Event Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: listen-to-all
  version: '0.1.0'
do:
  - callDoctor:
      listen:
        to:
          all:
          - with:
              type: com.fake-hospital.vitals.measurements.temperature
              data: ${ .temperature > 38 }
          - with:
              type: com.fake-hospital.vitals.measurements.bpm
              data: ${ .bpm < 60 or .bpm > 100 }
```

### Open API Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: call-openapi
  version: '1.0.0'
do:
  - findPet:
      call: openapi
      with:
        document:
          endpoint: https://petstore.swagger.io/v2/swagger.json
        operationId: findPetsByStatus
        parameters:
          status: available
```

### Raise Error Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: raise-not-implemented
  version: '0.1.0'
do:
  - notImplemented:
      raise:
        error:
          type: https://serverlessworkflow.io/errors/not-implemented
          status: 500
          title: Not Implemented
          detail: ${ "The workflow '\( $workflow.definition.document.name ):\( $workflow.definition.document.version )' is a work in progress and cannot be run yet" }
```

### Script Example

```
document:
  dsl: '1.0.3'
  namespace: samples
  name: run-script-with-arguments
  version: 0.1.0
do:
  - log:
      run:
        script:
          language: javascript
          arguments:
            message: ${ .message }
          code: >
            console.log(message)
```

### Subflow Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: run-subflow
  version: '0.1.0'
do:
  - registerCustomer:
      run:
        workflow:
          namespace: default
          name: register-customer
          version: '0.1.0'
          input:
            customer: .user
```

### Switch Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: switch-example
  version: '0.1.0'
do:
  - processOrder:
      switch:
        - case1:
            when: .orderType == "electronic"
            then: processElectronicOrder
        - case2:
            when: .orderType == "physical"
            then: processPhysicalOrder
        - default:
            then: handleUnknownOrderType
  - processElectronicOrder:
      do:
        - validatePayment:
            call: http
            with:
              method: post
              endpoint: https://fake-payment-service.com/validate
        - fulfillOrder:
            call: http
            with:
              method: post
              endpoint: https://fake-fulfillment-service.com/fulfill
      then: exit
  - processPhysicalOrder:
      do:
        - checkInventory:
            call: http
            with:
              method: get
              endpoint: https://fake-inventory-service.com/inventory
        - packItems:
            call: http
            with:
              method: post
              endpoint: https://fake-packaging-service.com/pack
        - scheduleShipping:
            call: http
            with:
              method: post
              endpoint: https://fake-shipping-service.com/schedule
      then: exit
  - handleUnknownOrderType:
      do:
        - logWarning:
            call: http
            with:
              method: post
              endpoint: https://fake-logging-service.com/warn
        - notifyAdmin:
            call: http
            with:
              method: post
              endpoint: https://fake-notification-service.com/notify
```

### Try-Catch Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: try-catch
  version: '0.1.0'
do:
  - tryGetPet:
      try:
        - getPet:
            call: http
            with:
              method: get
              endpoint: https://petstore.swagger.io/v2/pet/{petId}
      catch:
        errors:
          with:
            type: https://serverlessworkflow.io/spec/1.0.0/errors/communication
            status: 404
        as: error
        do:
          - notifySupport:
              emit:
                event:
                  with:
                    source: https://petstore.swagger.io
                    type: io.swagger.petstore.events.pets.not-found.v1
                    data: ${ $error }
          - setError:
              set:
                error: $error
              export:
                as: '$context + { error: $error }'
  - buyPet:
      if: $context.error == null
      call: http
      with:
        method: put
        endpoint: https://petstore.swagger.io/v2/pet/{petId}
        body: '${ . + { status: "sold" } }'
```

### Wait Example

```
document:
  dsl: '1.0.3'
  namespace: default
  name: wait-duration-inline
  version: '0.1.0'
do:
  - wait30Seconds:
      wait:
        seconds: 30
```

Visit our GitHub repository for [more examples](https://github.com/serverlessworkflow/specification/tree/main/examples) or complete [use cases](https://github.com/serverlessworkflow/specification/tree/main/use-cases).

## Reach out to us!

### Join our Meetings!

Add the schedule to your calendar and become a part of our discussions!

[How To Join](https://github.com/serverlessworkflow/specification/discussions/799)

### Contributions welcome!

We do a [Pull Request](https://github.com/serverlessworkflow/specification/pulls) contributions workflow on **GitHub**. New users are always welcome!

[To Repository](https://github.com/serverlessworkflow/specification/)

### Join us on Slack!

Chat with our community and follow announcements at **#serverless-workflow**

[Open Slack](https://slack.cncf.io/)

## Open Source projects supporting our DSL

![](https://serverlessworkflow.io/img/logos/eventmesh.png)

### Apache EventMesh Workflow

Apache EventMesh Workflow is a cloud vendor-independent, cloud-native-oriented Serverless Workflow Runtime based on Serverless Workflow specification, and provides durability, reliability, scalability, and observability capabilities.

[Get Started](https://github.com/apache/eventmesh-workflow)

![](https://serverlessworkflow.io/img/logos/sonataflowlogo.png)

### Apache KIE SonataFlow

SonataFlow is a powerful tool for building cloud-native workflow applications, enabling seamless orchestration and choreography of services and events.

[Get Started](https://sonataflow.org/)

![](https://serverlessworkflow.io/img/logos/lemlinelogo.png)

### Lemline

Lemline is a highly scalable, native-binary runtime that plugs into any existing message broker (Kafka, RabbitMQ, etc.). Deployed as a message consumer and producer, it orchestrates serverless workflows without requiring any additional infrastructure.

[Get Started](https://github.com/lemline/lemline)

![](https://serverlessworkflow.io/img/logos/synapselogo.png)

### Synapse

Synapse is a vendor-neutral, free, open-source, and community-driven Workflow Management System (WFMS) implementing the Serverless Workflow specification. You can deploy Synapse on Docker, Kubernetes, or natively on Windows, Mac, and Linux.

[Get Started](https://github.com/serverlessworkflow/synapse)

![](https://serverlessworkflow.io/img/logos/zigflowlogo.png)

### Zigflow

Zigflow provides a simple and declarative way to define and manage [Temporal](https://temporal.io/) workflows using the CNCF Serverless Workflow specification. It enables low-code and no-code workflow creation that's easy to visualise, share, and maintain, without sacrificing the power and reliability of Temporal.

[Get Started](https://zigflow.dev/)

## Trusted by top brands in workflow technologies

Already using Serverless Workflow? Join our list of top brands by letting us know here!

![](https://serverlessworkflow.io/img/logos/eventmesh2.png)

### Apache EventMesh

A new generation serverless event middleware for building distributed event-driven applications.

[Learn More](https://github.com/apache/eventmesh)

![](https://serverlessworkflow.io/img/logos/caf.png)

### Caf

Serverless Workflow is the core technology behind every KYC/KYB solution allowing them to customize it for their clients seamlessly.

[Learn More](https://caf.io/)

![](https://serverlessworkflow.io/img/logos/faasnet.png)

### FaasNet

FaasNet makes it easy to deploy functions and API to Kubernetes without repetitive, boiler-plate coding.

[Learn More](https://github.com/simpleidserver/FaasNet)

![](https://serverlessworkflow.io/img/logos/foxflow.svg)

### Foxflow

Foxflow's AI agent development platform accelerates business process automation and software delivery through LLM-integrated declarative workflows

[Learn More](https://foxflow.com/)

![](https://serverlessworkflow.io/img/logos/huawei.png)![](https://serverlessworkflow.io/img/logos/huawei.svg)

### Huawei

Huawei leverages Serverless Workflow with FunctionGraph for scalable, event-driven functions and ROMA Connect for all-domain hybrid integration, connecting applications for seamless digital transformation.

[Learn More](https://www.huaweicloud.com/intl/en-us/product/functiongraph.html)

![](https://serverlessworkflow.io/img/logos/neuroglia.png)

### Neuroglia

Neuroglia is a consultancy and solution design company for the digital transformation of companies and their services.

[Learn More](https://neuroglia.io/)

![](https://serverlessworkflow.io/img/logos/redhat.svg)![](https://serverlessworkflow.io/img/logos/redhat_reverse.svg)

### Red Hat

Red Hat sponsors Apache KIE SonataFlow, a tool for creating cloud-native workflows. SonataFlow supports service and event orchestration, integrating with your architecture using CloudEvents, REST calls, and other standard components.

[Learn More](https://www.redhat.com/en/technologies/cloud-computing/openshift/serverless)

![](https://serverlessworkflow.io/img/logos/warrify.png)

### Warrify

Warrify offers a leading data platform for the retail industry. With "warrify Journeys" (powered by Serverless Workflows) retailers are discovering new ways how to engage their customers in real time.

[Learn More](https://www.warrify.com/)

## Support our Project

Our sponsors, along with our community, help our project grow and stay vendor-neutral through their donations.

[Buy us a coffee!](https://crowdfunding.lfx.linuxfoundation.org/projects/beb979ae-75b5-4589-a2d0-f82949253bb7)

![](https://serverlessworkflow.io/img/logos/neuroglia.png)

### Neuroglia

Neuroglia is a consultancy and solution design company for the digital transformation of companies and their services.

[Learn More](https://neuroglia.io/)

## Innovation in the Open

Serverless Workflow is an open-source project under the governance of the [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/) and a part of the [Linux Foundation](https://www.linuxfoundation.org/).

The project is in the [Application Definition & Image Build](https://landscape.cncf.io/guide#app-definition-and-development--application-definition-image-build) landscape.

![](https://serverlessworkflow.io/img/logos/cncf-color-bg.svg)![](https://serverlessworkflow.io/img/logos/cncf-white-logo.svg)

![](https://serverlessworkflow.io/img/logos/lf-stacked-color.svg)![](https://serverlessworkflow.io/img/logos/lf-stacked-white.svg)

## 💕 Love ServerlessWorkflow? Give us a Star on GitHub! ⭐

Help us grow and show your support! Starring our repository helps more people discover and join our community.

👉 [Star our GitHub Repository](https://github.com/serverlessworkflow/specification/)

© Serverless Workflow Authors \|
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0) \|
[Privacy Policy](https://www.linuxfoundation.org/legal/privacy-policy)

The Linux Foundation has registered trademarks and uses trademarks. For a list of trademarks of The Linux Foundation,
please see our [Trademark Usage page](https://www.linuxfoundation.org/legal/trademark-usage).

[GitHub](https://github.com/serverlessworkflow/specification/)[Slack](https://slack.cncf.io/)[X Social](https://x.com/cncfworkflow)[LinkedIn](https://www.linkedin.com/company/serverless-workflow/posts)[Developer mailing list](mailto:cncf-serverlessws-maintainers@lists.cncf.io)[RSS Feed](https://serverlessworkflow.io/rss.xml)