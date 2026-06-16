[![](https://debezium.io/assets/images/color_white_debezium_type_600px.svg)](https://debezium.io/)

[FAQ](https://debezium.io/documentation/faq) [DOCUMENTATION](https://debezium.io/documentation) [RELEASES](https://debezium.io/releases) [COMMUNITY](https://debezium.io/community) [ADOPTERS](https://debezium.io/community/users/) [BLOG](https://debezium.io/blog)

### [Debezium 3.5 Documentation](https://debezium.io/documentation/reference/stable/index.html)

- Getting Started  - [Tutorial](https://debezium.io/documentation/reference/stable/tutorial.html)
  - [Installation](https://debezium.io/documentation/reference/stable/install.html)    - [PostgreSQL Decoding Plugins](https://debezium.io/documentation/reference/stable/postgres-plugins.html)
  - [Architecture](https://debezium.io/documentation/reference/stable/architecture.html)
  - [Features](https://debezium.io/documentation/reference/stable/features.html)
- Configuration  - [Avro Serialization](https://debezium.io/documentation/reference/stable/configuration/avro.html)
  - [Customizing Topic Auto-Creation](https://debezium.io/documentation/reference/stable/configuration/topic-auto-create-config.html)
  - [Sending Signals to Debezium](https://debezium.io/documentation/reference/stable/configuration/signalling.html)
  - [Receive notifications from Debezium](https://debezium.io/documentation/reference/stable/configuration/notification.html)
  - [Store Debezium state](https://debezium.io/documentation/reference/stable/configuration/storage.html)
  - [Exactly-once delivery](https://debezium.io/documentation/reference/stable/configuration/eos.html)
- Source Connectors  - [Overview](https://debezium.io/documentation/reference/stable/connectors/index.html)
  - [MySQL](https://debezium.io/documentation/reference/stable/connectors/mysql.html)
  - [MariaDB](https://debezium.io/documentation/reference/stable/connectors/mariadb.html)
  - [MongoDB](https://debezium.io/documentation/reference/stable/connectors/mongodb.html)
  - [PostgreSQL](https://debezium.io/documentation/reference/stable/connectors/postgresql.html)
  - [Oracle](https://debezium.io/documentation/reference/stable/connectors/oracle.html)
  - [SQL Server](https://debezium.io/documentation/reference/stable/connectors/sqlserver.html)
  - [Db2](https://debezium.io/documentation/reference/stable/connectors/db2.html)
  - [Cassandra](https://debezium.io/documentation/reference/stable/connectors/cassandra.html)
  - [Vitess](https://debezium.io/documentation/reference/stable/connectors/vitess.html)
  - [Spanner](https://debezium.io/documentation/reference/stable/connectors/spanner.html)
  - [Informix](https://debezium.io/documentation/reference/stable/connectors/informix.html)
- Sink Connectors  - [Overview](https://debezium.io/documentation/reference/stable/connectors/index-sink.html)
  - [JDBC](https://debezium.io/documentation/reference/stable/connectors/jdbc.html)
  - [MongoDB Sink](https://debezium.io/documentation/reference/stable/connectors/mongodb-sink.html)
- Transformations  - [Overview](https://debezium.io/documentation/reference/stable/transformations/index.html)
  - [Topic Routing](https://debezium.io/documentation/reference/stable/transformations/topic-routing.html)
  - [New Record State Extraction](https://debezium.io/documentation/reference/stable/transformations/event-flattening.html)
  - [MongoDB New Document State Extraction](https://debezium.io/documentation/reference/stable/transformations/mongodb-event-flattening.html)
  - [Event Changes](https://debezium.io/documentation/reference/stable/transformations/event-changes.html)
  - [Outbox Event Router](https://debezium.io/documentation/reference/stable/transformations/outbox-event-router.html)
  - [MongoDB Outbox Event Router](https://debezium.io/documentation/reference/stable/transformations/mongodb-outbox-event-router.html)
  - [Message Filtering](https://debezium.io/documentation/reference/stable/transformations/filtering.html)
  - [Schema Change Event Filtering](https://debezium.io/documentation/reference/stable/transformations/schema-change-event-filter.html)
  - [Content-Based Routing](https://debezium.io/documentation/reference/stable/transformations/content-based-routing.html)
  - [Using SMT Predicates to Selectively Apply Transformations](https://debezium.io/documentation/reference/stable/transformations/applying-transformations-selectively.html)
  - [Partition Routing](https://debezium.io/documentation/reference/stable/transformations/partition-routing.html)
  - [HeaderToValue](https://debezium.io/documentation/reference/stable/transformations/header-to-value.html)
  - [Timezone Converter](https://debezium.io/documentation/reference/stable/transformations/timezone-converter.html)
  - [Geometry Format Conversion](https://debezium.io/documentation/reference/stable/transformations/geometry-format-transformer.html)
  - [TimescaleDB Integration](https://debezium.io/documentation/reference/stable/transformations/timescaledb.html)
  - [Decode Logical Decoding Message Content](https://debezium.io/documentation/reference/stable/transformations/decode-logical-decoding-message-content.html)
  - [Vector Data Types to JSON Types](https://debezium.io/documentation/reference/stable/transformations/vector-to-json.html)
  - [Swap Geometry Coordinates](https://debezium.io/documentation/reference/stable/transformations/swap-geometry-coordinates.html)
- Post Processors  - [Overview](https://debezium.io/documentation/reference/stable/post-processors/index.html)
  - [Reselect Columns](https://debezium.io/documentation/reference/stable/post-processors/reselect-columns.html)
- API and SPI  - [Debezium Engine](https://debezium.io/documentation/reference/stable/development/engine.html)
  - [Custom Converters](https://debezium.io/documentation/reference/stable/development/converters.html)
- Integrations  - [Change Event SerDes](https://debezium.io/documentation/reference/stable/integrations/serdes.html)
  - [Outbox Quarkus Extension](https://debezium.io/documentation/reference/stable/integrations/outbox.html)
  - [CloudEvents](https://debezium.io/documentation/reference/stable/integrations/cloudevents.html)
  - [OpenLineage](https://debezium.io/documentation/reference/stable/integrations/openlineage.html)
  - [OpenTelemetry](https://debezium.io/documentation/reference/stable/integrations/tracing.html)
  - [Debezium Extensions for Quarkus](https://debezium.io/documentation/reference/stable/integrations/quarkus-debezium-engine-extension.html)
  - [Hibernate Cache Invalidation](https://debezium.io/documentation/reference/stable/integrations/hibernate-cache.html)
  - [Integration Testing with Testcontainers](https://debezium.io/documentation/reference/stable/integrations/testcontainers.html)
- Debezium AI  - [Embeddings Transformation](https://debezium.io/documentation/reference/stable/ai/embeddings.html)
- Standalone Debezium  - [Debezium Server](https://debezium.io/documentation/reference/stable/operations/debezium-server.html)
  - [Debezium Operator](https://debezium.io/documentation/reference/stable/operations/debezium-operator.html)
  - [Debezium Management Platform](https://debezium.io/documentation/reference/stable/operations/debezium-platform.html)
- Operations  - [Logging](https://debezium.io/documentation/reference/stable/operations/logging.html)
  - [Monitoring](https://debezium.io/documentation/reference/stable/operations/monitoring.html)
  - [Running on Kubernetes](https://debezium.io/documentation/reference/stable/operations/kubernetes.html)
  - [Running on Openshift](https://debezium.io/documentation/reference/stable/operations/openshift.html)

Debezium Documentation3.5

- Debezium Documentation  - [nightly](https://debezium.io/documentation/reference/nightly/index.html)
  - [3.5](https://debezium.io/documentation/reference/3.5/index.html)
  - [3.6](https://debezium.io/documentation/reference/3.6/index.html)
  - [3.4](https://debezium.io/documentation/reference/3.4/index.html)
  - [3.3](https://debezium.io/documentation/reference/3.3/index.html)
  - [3.2](https://debezium.io/documentation/reference/3.2/index.html)
  - [3.1](https://debezium.io/documentation/reference/3.1/index.html)
  - [3.0](https://debezium.io/documentation/reference/3.0/index.html)
  - [2.7](https://debezium.io/documentation/reference/2.7/index.html)
  - [1.9](https://debezium.io/documentation/reference/1.9/index.html)

- [Debezium Documentation](https://debezium.io/documentation/reference/stable/index.html)

Version:


3.5

[nightly](https://debezium.io/documentation//reference/index.html) [3.5](https://debezium.io/reference/stable/index.html) [3.6](https://debezium.io/documentation//reference/3.6/index.html) [3.4](https://debezium.io/documentation//reference/3.4/index.html) [3.3](https://debezium.io/documentation//reference/3.3/index.html) [3.2](https://debezium.io/documentation//reference/3.2/index.html) [3.1](https://debezium.io/documentation//reference/3.1/index.html) [3.0](https://debezium.io/documentation//reference/3.0/index.html) [2.7](https://debezium.io/documentation//reference/2.7/index.html) [1.9](https://debezium.io/documentation//reference/1.9/index.html)

\|


[Edit this Page](https://github.com/debezium/debezium/edit/3.5/documentation/modules/ROOT/pages/index.adoc)

# Debezium Documentation

## What is it?

Debezium is a set of distributed services to capture changes in your databases so that your applications can see those changes and respond to them.
Debezium records all row-level changes within each database table in a _change event stream_, and applications simply read these streams to see the change events in the same order in which they occurred.

Use the links at the left to find the documentation for Debezium, including the various Debezium [connectors](https://debezium.io/documentation/reference/stable/connectors/index.html).
If you’re trying to get your head around what Debezium is or how it works, we recommend starting with our [tutorial](https://debezium.io/documentation/reference/stable/tutorial.html) and [this session](https://www.infoq.com/presentations/data-streaming-kafka-debezium/) from QCon San Francisco on CDC use cases with Debezium.

## Feedback

If you have questions about the documentation, or discover any issues that need to be fixed, open an issue [here](https://github.com/debezium/dbz/issues).

Copyright © 2026 Debezium Community (Rev: [eeb4bd8b](https://github.com/debezium/debezium/commit/eeb4bd8baec5e7890beb4c802b8d6a7af0813050))