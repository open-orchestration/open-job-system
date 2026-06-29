[![](https://nightlies.apache.org/flink/flink-docs-release-2.2//flink-header-logo.svg)](https://nightlies.apache.org/flink/flink-docs-release-2.2/)

v2.2.0

- [ ]
    Try Flink
  ▾  - [First steps](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/try-flink/local_installation/)
  - [Fraud Detection with the DataStream API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/try-flink/datastream/)
  - [Real Time Reporting with the Table API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/try-flink/table_api/)
  - [Flink Operations Playground](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/try-flink/flink-operations-playground/)
- [ ]
    Learn Flink
  ▾  - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/overview/)
  - [Intro to the DataStream API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/datastream_api/)
  - [Data Pipelines & ETL](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/etl/)
  - [Streaming Analytics](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/streaming_analytics/)
  - [Event-driven Applications](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/event_driven/)
  - [Fault Tolerance](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/fault_tolerance/)
- [x]
    Concepts
  ▾  - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/concepts/overview/)
  - [Stateful Stream Processing](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/concepts/stateful-stream-processing/)
  - [Timely Stream Processing](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/concepts/time/)
  - [Flink Architecture](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/concepts/flink-architecture/)
  - [Glossary](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/concepts/glossary/)
- [ ]
    Application Development
  ▾  - [ ] Project Configuration▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/configuration/overview/)
    - [Using Maven](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/configuration/maven/)
    - [Using Gradle](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/configuration/gradle/)
    - [Connectors and Formats](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/configuration/connector/)
    - [Test Dependencies](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/configuration/testing/)
    - [Advanced Configuration](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/configuration/advanced/)
  - [ ] DataStream API▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/overview/)
    - [Execution Mode (Batch/Streaming)](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/execution_mode/)
    - [ ] Event Time▾      - [Generating Watermarks](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/event-time/generating_watermarks/)
      - [Builtin Watermark Generators](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/event-time/built_in/)
    - [ ] State & Fault Tolerance▾      - [State TTL Migration Compatibility](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/state_migration/)
      - [Working with State](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/state/)
      - [Working with State V2](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/state_v2/)
      - [The Broadcast State Pattern](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/broadcast_state/)
      - [Checkpointing](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/checkpointing/)
      - [State Backends](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/state_backends/)
      - [ ] Data Types & Serialization▾        - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/serialization/types_serialization/)
        - [State Schema Evolution](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/serialization/schema_evolution/)
        - [Custom State Serialization](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/serialization/custom_serialization/)
        - [3rd Party Serializers](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/fault-tolerance/serialization/third_party_serializers/)
    - [User-Defined Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/user_defined_functions/)
    - [ ] Operators▾      - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/operators/overview/)
      - [Windows](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/operators/windows/)
      - [Joining](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/operators/joining/)
      - [Process Function](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/operators/process_function/)
      - [Async I/O](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/operators/asyncio/)
      - [Full Window Partition](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/operators/full_window_partition/)
    - [Data Sources](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/sources/)
    - [Data Sinks](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/sinks/)
    - [Side Outputs](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/side_output/)
    - [Handling Application Parameters](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/application_parameters/)
    - [Testing](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/testing/)
    - [Experimental Features](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/experimental/)
    - [Java Lambda Expressions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/java_lambdas/)
    - [ ] Managing Execution▾      - [Execution Configuration](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/execution/execution_configuration/)
      - [Program Packaging](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/execution/packaging/)
      - [Parallel Execution](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/execution/parallel/)
  - [ ] DataStream API (V2)▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream-v2/overview/)
    - [Building Blocks](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream-v2/building_blocks/)
    - [Context and State Processing](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream-v2/context_and_state_processing/)
    - [ ] Time Processing▾      - [Processing Timer Service](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream-v2/time-processing/processing_timer_service/)
      - [Event Timer Service](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream-v2/time-processing/event_timer_service/)
    - [ ] Builtin Functions▾      - [Windows](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream-v2/builtin-funcs/windows/)
      - [Joining](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream-v2/builtin-funcs/joining/)
    - [Watermark](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream-v2/watermark/)
  - [ ] Table API & SQL▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/overview/)
    - [Concepts & Common API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/common/)
    - [DataStream API Integration](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/data_stream_api/)
    - [ ] Streaming Concepts▾      - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/concepts/overview/)
      - [Determinism in Continuous Queries](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/concepts/determinism/)
      - [Dynamic Tables](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/concepts/dynamic_tables/)
      - [Time Attributes](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/concepts/time_attributes/)
      - [Versioned Tables](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/concepts/versioned_tables/)
      - [Temporal Table Function](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/concepts/temporal_table_function/)
    - [Data Types](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/types/)
    - [Time Zone](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/timezone/)
    - [Table API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/tableapi/)
    - [ ] SQL▾      - [SQL](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/overview/)
      - [Getting Started](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/gettingstarted/)
      - [ ] Queries▾        - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/overview/)
        - [Hints](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/hints/)
        - [WITH clause](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/with/)
        - [SELECT & WHERE](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/select/)
        - [SELECT DISTINCT](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/select-distinct/)
        - [Windowing TVF](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/window-tvf/)
        - [Model Inference](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/model-inference/)
        - [Vector Search](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/vector-search/)
        - [Window Aggregation](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/window-agg/)
        - [Group Aggregation](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/group-agg/)
        - [Over Aggregation](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/over-agg/)
        - [Joins](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/joins/)
        - [Window JOIN](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/window-join/)
        - [Set Operations](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/set-ops/)
        - [ORDER BY clause](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/orderby/)
        - [LIMIT clause](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/limit/)
        - [Top-N](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/topn/)
        - [Window Top-N](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/window-topn/)
        - [Deduplication](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/deduplication/)
        - [Window Deduplication](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/window-deduplication/)
        - [Pattern Recognition](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/match_recognize/)
        - [Time Travel](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/queries/time-travel/)
      - [CREATE Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/create/)
      - [DROP Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/drop/)
      - [ALTER Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/alter/)
      - [INSERT Statement](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/insert/)
      - [ANALYZE Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/analyze/)
      - [DESCRIBE Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/describe/)
      - [TRUNCATE Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/truncate/)
      - [EXPLAIN Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/explain/)
      - [USE Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/use/)
      - [SHOW Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/show/)
      - [LOAD Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/load/)
      - [UNLOAD Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/unload/)
      - [SET Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/set/)
      - [RESET Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/reset/)
      - [JAR Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/jar/)
      - [JOB Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/job/)
      - [UPDATE Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/update/)
      - [DELETE Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/delete/)
      - [CALL Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql/call/)
    - [ ] Materialized Table▾      - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/materialized-table/overview/)
      - [Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/materialized-table/statements/)
      - [Deployment](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/materialized-table/deployment/)
      - [Quickstart](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/materialized-table/quickstart/)
    - [ ] Functions▾      - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/functions/overview/)
      - [System (Built-in) Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/functions/systemfunctions/)
      - [User-defined Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/functions/udfs/)
      - [Process Table Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/functions/ptfs/)
    - [Procedures](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/procedures/)
    - [Modules](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/modules/)
    - [Catalogs](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/catalogs/)
    - [Flink JDBC Driver](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/jdbcdriver/)
    - [OLAP Quickstart](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/olap_quickstart/)
    - [SQL Client](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sqlclient/)
    - [ ] SQL Gateway▾      - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql-gateway/overview/)
      - [REST Endpoint](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql-gateway/rest/)
      - [HiveServer2 Endpoint](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sql-gateway/hiveserver2/)
    - [ ] Hive Compatibility▾      - [ ] Hive Dialect▾        - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/overview/)
        - [ ] Queries▾          - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/overview/)
          - [Sort/Cluster/Distributed By](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/sort-cluster-distribute-by/)
          - [Group By](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/group-by/)
          - [Join](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/join/)
          - [Set Operations](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/set-op/)
          - [Lateral View Clause](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/lateral-view/)
          - [Window Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/window-functions/)
          - [Sub-Queries](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/sub-queries/)
          - [CTE](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/cte/)
          - [Transform Clause](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/transform/)
          - [Table Sample](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/queries/table-sample/)
        - [CREATE Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/create/)
        - [DROP Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/drop/)
        - [ALTER Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/alter/)
        - [INSERT Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/insert/)
        - [Load Data Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/load-data/)
        - [SHOW Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/show/)
        - [ADD Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/add/)
        - [SET Statements](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/hive-compatibility/hive-dialect/set/)
    - [Configuration](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/config/)
    - [Performance Tuning](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/tuning/)
    - [User-defined Sources & Sinks](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/sourcessinks/)
  - [ ] Python API▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/overview/)
    - [Installation](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/installation/)
    - [Table API Tutorial](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table_api_tutorial/)
    - [DataStream API Tutorial](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/datastream_tutorial/)
    - [ ] Table API▾      - [Intro to the Python Table API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/intro_to_table_api/)
      - [TableEnvironment](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/table_environment/)
      - [ ] Operations▾        - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/operations/operations/)
        - [Row-based Operations](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/operations/row_based_operations/)
      - [Data Types](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/python_types/)
      - [System (Built-in) Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/system_functions/)
      - [ ] User Defined Functions▾        - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/udfs/overview/)
        - [General User-defined Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/udfs/python_udfs/)
        - [Vectorized User-defined Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/udfs/vectorized_python_udfs/)
      - [Conversions between PyFlink Table and Pandas DataFrame](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/conversion_of_pandas/)
      - [Conversions between Table and DataStream](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/conversion_of_data_stream/)
      - [SQL](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/sql/)
      - [Catalogs](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/catalogs/)
      - [Metrics](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/metrics/)
      - [Connectors](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/table/python_table_api_connectors/)
    - [ ] DataStream API▾      - [Intro to the Python DataStream API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/datastream/intro_to_datastream_api/)
      - [ ] Operators▾        - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/datastream/operators/overview/)
        - [Windows](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/datastream/operators/windows/)
        - [Process Function](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/datastream/operators/process_function/)
      - [Data Types](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/datastream/data_types/)
      - [State](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/datastream/state/)
    - [Dependency Management](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/dependency_management/)
    - [Execution Mode](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/python_execution_mode/)
    - [Configuration](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/python_config/)
    - [Debugging](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/debugging/)
    - [Environment Variables](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/environment_variables/)
    - [FAQ](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/python/faq/)
- [ ]
    Libraries
  ▾  - [Event Processing (CEP)](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/libs/cep/)
  - [State Processor API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/libs/state_processor_api/)
- [ ]
    Connectors
  ▾  - [ ] DataStream Connectors▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/overview/)
    - [Fault Tolerance Guarantees](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/guarantees/)
    - [ ] Formats▾      - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/formats/overview/)
      - [Avro](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/formats/avro/)
      - [Azure Table storage](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/formats/azure_table_storage/)
      - [CSV](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/formats/csv/)
      - [Hadoop](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/formats/hadoop/)
      - [JSON](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/formats/json/)
      - [Parquet](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/formats/parquet/)
      - [Text files](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/formats/text_files/)
    - [DataGen](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/datagen/)
    - [Dynamic Kafka](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/dynamic-kafka/)
    - [Kafka](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/kafka/)
    - [Cassandra](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/cassandra/)
    - [DynamoDB](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/dynamodb/)
    - [Elasticsearch](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/elasticsearch/)
    - [Firehose](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/firehose/)
    - [Kinesis](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/kinesis/)
    - [MongoDB](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/mongodb/)
    - [Opensearch](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/opensearch/)
    - [Prometheus](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/prometheus/)
    - [SQS](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/sqs/)
    - [FileSystem](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/filesystem/)
    - [RabbitMQ](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/rabbitmq/)
    - [Google Cloud PubSub](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/pubsub/)
    - [Hybrid Source](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/hybridsource/)
    - [Pulsar](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/pulsar/)
    - [JDBC](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/datastream/jdbc/)
  - [ ] Table API Connectors▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/overview/)
    - [ ] Formats▾      - [Formats](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/overview/)
      - [CSV](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/csv/)
      - [JSON](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/json/)
      - [Avro](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/avro/)
      - [Confluent Avro](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/avro-confluent/)
      - [Protobuf](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/protobuf/)
      - [Debezium](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/debezium/)
      - [Canal](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/canal/)
      - [Maxwell](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/maxwell/)
      - [Ogg](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/ogg/)
      - [Parquet](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/parquet/)
      - [Orc](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/orc/)
      - [Raw](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/formats/raw/)
    - [Kafka](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/kafka/)
    - [Upsert Kafka](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/upsert-kafka/)
    - [Dynamic Kafka](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/dynamic-kafka/)
    - [DynamoDB](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/dynamodb/)
    - [Firehose](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/firehose/)
    - [Kinesis](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/kinesis/)
    - [MongoDB](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/mongodb/)
    - [JDBC](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/jdbc/)
    - [Elasticsearch](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/elasticsearch/)
    - [Opensearch](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/opensearch/)
    - [FileSystem](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/filesystem/)
    - [HBase](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/hbase/)
    - [DataGen](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/datagen/)
    - [Print](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/print/)
    - [BlackHole](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/blackhole/)
    - [ ] Hive▾      - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/hive/overview/)
      - [Hive Catalog](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/hive/hive_catalog/)
      - [Hive Read & Write](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/hive/hive_read_write/)
      - [Hive Functions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/hive/hive_functions/)
    - [Download](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/table/downloads/)
  - [ ] Models▾    - [OpenAI](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/models/openai/)
    - [Download](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/connectors/models/downloads/)
- [ ]
    Deployment
  ▾  - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/overview/)
  - [Java Compatibility](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/java_compatibility/)
  - [ ] Resource Providers▾    - [ ] Standalone▾      - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/resource-providers/standalone/overview/)
      - [Working Directory](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/resource-providers/standalone/working_directory/)
      - [Docker](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/resource-providers/standalone/docker/)
      - [Kubernetes](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/resource-providers/standalone/kubernetes/)
    - [Native Kubernetes](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/resource-providers/native_kubernetes/)
    - [YARN](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/resource-providers/yarn/)
  - [Configuration](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/config/)
  - [ ] Memory Configuration▾    - [Set up Flink's Process Memory](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/memory/mem_setup/)
    - [Set up TaskManager Memory](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/memory/mem_setup_tm/)
    - [Set up JobManager Memory](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/memory/mem_setup_jobmanager/)
    - [Memory Tuning Guide](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/memory/mem_tuning/)
    - [Troubleshooting](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/memory/mem_trouble/)
    - [Migration Guide](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/memory/mem_migration/)
    - [Network Buffer Tuning](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/memory/network_mem_tuning/)
  - [Adaptive Batch](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/adaptive_batch/)
  - [Command-Line Interface](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/cli/)
  - [Elastic Scaling](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/elastic_scaling/)
  - [Fine-Grained Resource Management](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/finegrained_resource/)
  - [Speculative Execution](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/speculative_execution/)
  - [ ] File Systems▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/filesystems/overview/)
    - [Common Configurations](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/filesystems/common/)
    - [Amazon S3](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/filesystems/s3/)
    - [Google Cloud Storage](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/filesystems/gcs/)
    - [Aliyun OSS](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/filesystems/oss/)
    - [Azure Blob Storage](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/filesystems/azure/)
    - [Plugins](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/filesystems/plugins/)
  - [ ] High Availability▾    - [Overview](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/ha/overview/)
    - [ZooKeeper HA Services](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/ha/zookeeper_ha/)
    - [Kubernetes HA Services](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/ha/kubernetes_ha/)
  - [Metric Reporters](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/metric_reporters/)
  - [Trace Reporters](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/trace_reporters/)
  - [Event Reporters](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/event_reporters/)
  - [ ] REPLs▾    - [Python REPL](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/repls/python_shell/)
  - [ ] Security▾    - [SSL Setup](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/security/security-ssl/)
    - [Kerberos](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/security/security-kerberos/)
    - [Delegation tokens](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/security/security-delegation-token/)
  - [ ] Tasks Scheduling▾    - [Balanced Tasks Scheduling](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/tasks-scheduling/balanced_tasks_scheduling/)
  - [ ] Advanced▾    - [External Resources](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/advanced/external_resources/)
    - [History Server](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/advanced/historyserver/)
    - [Logging](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/advanced/logging/)
    - [Failure Enrichers](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/advanced/failure_enrichers/)
    - [Job Status Changed Listener](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/deployment/advanced/job_status_listener/)
- [ ]
    Operations
  ▾  - [ ] State & Fault Tolerance▾    - [Checkpoints](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/checkpoints/)
    - [Checkpointing under backpressure](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/checkpointing_under_backpressure/)
    - [Savepoints](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/savepoints/)
    - [Checkpoints vs. Savepoints](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/checkpoints_vs_savepoints/)
    - [State Backends](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/state_backends/)
    - [Tuning Checkpoints and Large State](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/large_state_tuning/)
    - [Disaggregated State Management](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/disaggregated_state/)
    - [Task Failure Recovery](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/state/task_failure_recovery/)
  - [Metrics](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/metrics/)
  - [Traces](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/traces/)
  - [Events](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/events/)
  - [ ] Batch▾    - [Batch Shuffle](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/batch/batch_shuffle/)
    - [Recovery job progress from job master failures](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/batch/recovery_from_job_master_failure/)
  - [ ] Debugging▾    - [Debugging Windows & Event Time](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/debugging/debugging_event_time/)
    - [Debugging Classloading](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/debugging/debugging_classloading/)
    - [Flame Graphs](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/debugging/flame_graphs/)
    - [Profiler](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/debugging/profiler/)
    - [Application Profiling & Debugging](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/debugging/application_profiling/)
  - [REST API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/rest_api/)
  - [ ] Monitoring▾    - [Monitoring Checkpointing](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/monitoring/checkpoint_monitoring/)
    - [Monitoring Back Pressure](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/monitoring/back_pressure/)
  - [Upgrading Applications and Flink Versions](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/upgrading/)
  - [Production Readiness Checklist](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/ops/production_ready/)
- [ ]
    Flink Development
  ▾  - [Importing Flink into an IDE](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/flinkdev/ide_setup/)
  - [Building Flink from Source](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/flinkdev/building/)
- [ ]
    Internals
  ▾  - [Jobs and Scheduling](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/internals/job_scheduling/)
  - [Task Lifecycle](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/internals/task_lifecycle/)
  - [File Systems](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/internals/filesystems/)

* * *

[Project Homepage](https://flink.apache.org/)

[JavaDocs](https://nightlies.apache.org/flink/flink-docs-release-2.2/api/java/)

[PyDocs](https://nightlies.apache.org/flink/flink-docs-release-2.2/api/python/)

* * *

[ ]
Pick Docs Version
▾[2.2 (✓)](https://nightlies.apache.org/flink/flink-docs-release-2.2/)

* * *

- [v2.2](http://nightlies.apache.org/flink/flink-docs-release-2.2)
- [v2.1](http://nightlies.apache.org/flink/flink-docs-release-2.1)

* * *

- [All Versions](https://nightlies.apache.org/flink/flink-docs-release-2.2//versions)
[中文版](https://nightlies.apache.org/flink/flink-docs-release-2.2/zh/docs/concepts/overview/)

![Menu](https://nightlies.apache.org/flink/flink-docs-release-2.2/svg/menu.svg)**Overview**

# Concepts  [\#](https://nightlies.apache.org/flink/flink-docs-stable/docs/concepts/overview/\#concepts)

The [Hands-on Training](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/overview/) explains the basic concepts
of stateful and timely stream processing that underlie Flink’s APIs, and provides examples of how these mechanisms are used in applications. Stateful stream processing is introduced in the context of [Data Pipelines & ETL](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/etl/#stateful-transformations)
and is further developed in the section on [Fault Tolerance](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/fault_tolerance/).
Timely stream processing is introduced in the section on [Streaming Analytics](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/learn-flink/streaming_analytics/).

This _Concepts in Depth_ section provides a deeper understanding of how Flink’s architecture and runtime implement these concepts.

## Flink’s APIs  [\#](https://nightlies.apache.org/flink/flink-docs-stable/docs/concepts/overview/\#flinks-apis)

Flink offers different levels of abstraction for developing streaming/batch applications.

![Programming levels of abstraction](https://nightlies.apache.org/flink/flink-docs-release-2.2//fig/concepts/levels_of_abstraction.svg)

- The lowest level abstraction simply offers **stateful and timely stream processing**. It is
embedded into the [DataStream API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/overview/) via the [Process\\
Function](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/operators/process_function/). It allows
users to freely process events from one or more streams, and provides consistent, fault tolerant
_state_. In addition, users can register event time and processing time callbacks, allowing
programs to realize sophisticated computations.

- In practice, many applications do not need the low-level
abstractions described above, and can instead program against the **Core APIs**: the
[DataStream API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/overview/)
(bounded/unbounded streams). These fluent APIs offer the
common building blocks for data processing, like various forms of
user-specified transformations, joins, aggregations, windows, state, etc.
Data types processed in these APIs are represented as classes in the
respective programming languages.

The low level _Process Function_ integrates with the _DataStream API_,
making it possible to use the lower-level abstraction on an as-needed basis.

- The **Table API** is a declarative DSL centered around _tables_, which may
be dynamically changing tables (when representing streams). The [Table\\
API](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/overview/) follows the
(extended) relational model: Tables have a schema attached (similar to
tables in relational databases) and the API offers comparable operations,
such as select, project, join, group-by, aggregate, etc. Table API
programs declaratively define _what logical operation should be done_
rather than specifying exactly _how the code for the operation looks_.
Though the Table API is extensible by various types of user-defined
functions, it is less expressive than the _Core APIs_, and more concise to
use (less code to write). In addition, Table API programs also go through
an optimizer that applies optimization rules before execution.

One can seamlessly convert between tables and _DataStream_,
allowing programs to mix the _Table API_ with the _DataStream API_.

- The highest level abstraction offered by Flink is **SQL**. This abstraction
is similar to the _Table API_ both in semantics and expressiveness, but
represents programs as SQL query expressions. The [SQL](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/table/overview/#sql) abstraction closely interacts with the
Table API, and SQL queries can be executed over tables defined in the
_Table API_.


[Want to contribute translation?](https://cwiki.apache.org/confluence/display/FLINK/Flink+Translation+Specifications)

[Edit This Page](https://github.com/apache/flink/edit/release-2.2/docs/content/docs/concepts/overview.md)