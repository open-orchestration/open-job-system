[Skip to main content](https://docs.dask.org/en/stable/#main-content)

- [![](https://docs.dask.org/en/stable/_static/images/dask-horizontal-white.svg)](https://docs.dask.org/)
- [Dask](https://docs.dask.org/)
- [Distributed](https://distributed.dask.org/)
- [Dask ML](https://ml.dask.org/)
- [Examples](https://examples.dask.org/)
- [Ecosystem](https://docs.dask.org/en/latest/ecosystem.html)
- [Community](https://docs.dask.org/en/latest/support.html)

Back to top`Ctrl` + `K`

[Dask documentation](https://docs.dask.org/en/stable/_static/images/dask-horizontal-white.svg)

Search`Ctrl` + `K`

Getting Started

- [Install Dask](https://docs.dask.org/en/stable/install.html)
- [10 Minutes to Dask](https://docs.dask.org/en/stable/10-minutes-to-dask.html)
- [Deploy Dask Clusters](https://docs.dask.org/en/stable/deploying.html)

  - [Python API](https://docs.dask.org/en/stable/deploying-python.html)
  - [Cloud](https://docs.dask.org/en/stable/deploying-cloud.html)
  - [High Performance Computers](https://docs.dask.org/en/stable/deploying-hpc.html)
  - [Kubernetes](https://docs.dask.org/en/stable/deploying-kubernetes.html)
  - [Command Line](https://docs.dask.org/en/stable/deploying-cli.html)
  - [SSH](https://docs.dask.org/en/stable/deploying-ssh.html)
  - [Additional Information](https://docs.dask.org/en/stable/deploying-extra.html)

    - [Adaptive deployments](https://docs.dask.org/en/stable/adaptive.html)
    - [Docker Images](https://docs.dask.org/en/stable/deploying-docker.html)
    - [Python API (advanced)](https://docs.dask.org/en/stable/deploying-python-advanced.html)
    - [Manage Environments](https://docs.dask.org/en/stable/software-environments.html)
    - [Prometheus](https://docs.dask.org/en/stable/prometheus.html)
    - [Customize Initialization](https://docs.dask.org/en/stable/customize-initialization.html)
    - [Deployment Considerations](https://docs.dask.org/en/stable/deployment-considerations.html)

- [Best Practices](https://docs.dask.org/en/stable/best-practices.html)
- [FAQ](https://docs.dask.org/en/stable/faq.html)

How to Use

- [Array](https://docs.dask.org/en/stable/array.html)

  - [Best Practices](https://docs.dask.org/en/stable/array-best-practices.html)
  - [Chunks](https://docs.dask.org/en/stable/array-chunks.html)
  - [Create Dask Arrays](https://docs.dask.org/en/stable/array-creation.html)
  - [Overlapping Computations](https://docs.dask.org/en/stable/array-overlap.html)
  - [Internal Design](https://docs.dask.org/en/stable/array-design.html)
  - [Sparse Arrays](https://docs.dask.org/en/stable/array-sparse.html)
  - [Stats](https://docs.dask.org/en/stable/array-stats.html)
  - [Slicing](https://docs.dask.org/en/stable/array-slicing.html)
  - [Assignment](https://docs.dask.org/en/stable/array-assignment.html)
  - [Stack, Concatenate, and Block](https://docs.dask.org/en/stable/array-stack.html)
  - [Generalized Ufuncs](https://docs.dask.org/en/stable/array-gufunc.html)
  - [Random Number Generation](https://docs.dask.org/en/stable/array-random.html)
  - [API](https://docs.dask.org/en/stable/array-api.html)
  - [Compatibility with numpy functions](https://docs.dask.org/en/stable/array-numpy-compatibility.html)

- [Bag](https://docs.dask.org/en/stable/bag.html)

  - [Create Dask Bags](https://docs.dask.org/en/stable/bag-creation.html)
  - [API](https://docs.dask.org/en/stable/bag-api.html)

    - [dask.dataframe.DataFrame.to\_bag](https://docs.dask.org/en/stable/generated/dask.dataframe.DataFrame.to_bag.html)
    - [dask.dataframe.Series.to\_bag](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.to_bag.html)

- [DataFrame](https://docs.dask.org/en/stable/dataframe.html)

  - [Load and Save Data](https://docs.dask.org/en/stable/dataframe-create.html)
  - [Internal Design](https://docs.dask.org/en/stable/dataframe-design.html)
  - [Optimizer](https://docs.dask.org/en/stable/dataframe-optimizer.html)
  - [Best Practices](https://docs.dask.org/en/stable/dataframe-best-practices.html)
  - [API](https://docs.dask.org/en/stable/dataframe-api.html)

    - [dask.dataframe.Series.dt.date](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.date.html)
    - [dask.dataframe.Series.dt.day](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.day.html)
    - [dask.dataframe.Series.dt.dayofweek](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.dayofweek.html)
    - [dask.dataframe.Series.dt.dayofyear](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.dayofyear.html)
    - [dask.dataframe.Series.dt.daysinmonth](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.daysinmonth.html)
    - [dask.dataframe.Series.dt.freq](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.freq.html)
    - [dask.dataframe.Series.dt.hour](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.hour.html)
    - [dask.dataframe.Series.dt.microsecond](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.microsecond.html)
    - [dask.dataframe.Series.dt.minute](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.minute.html)
    - [dask.dataframe.Series.dt.month](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.month.html)
    - [dask.dataframe.Series.dt.nanosecond](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.nanosecond.html)
    - [dask.dataframe.Series.dt.quarter](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.quarter.html)
    - [dask.dataframe.Series.dt.second](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.second.html)
    - [dask.dataframe.Series.dt.time](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.time.html)
    - [dask.dataframe.Series.dt.timetz](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.timetz.html)
    - [dask.dataframe.Series.dt.tz](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.tz.html)
    - [dask.dataframe.Series.dt.week](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.week.html)
    - [dask.dataframe.Series.dt.weekday](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.weekday.html)
    - [dask.dataframe.Series.dt.weekofyear](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.weekofyear.html)
    - [dask.dataframe.Series.dt.year](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.year.html)
    - [dask.dataframe.Series.cat.categories](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.cat.categories.html)
    - [dask.dataframe.Series.cat.codes](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.cat.codes.html)
    - [dask.dataframe.Series.cat.known](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.cat.known.html)
    - [dask.dataframe.Series.cat.ordered](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.cat.ordered.html)
    - [dask.dataframe.api.Rolling.apply](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.apply.html)
    - [dask.dataframe.api.Rolling.count](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.count.html)
    - [dask.dataframe.api.Rolling.kurt](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.kurt.html)
    - [dask.dataframe.api.Rolling.max](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.max.html)
    - [dask.dataframe.api.Rolling.mean](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.mean.html)
    - [dask.dataframe.api.Rolling.median](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.median.html)
    - [dask.dataframe.api.Rolling.min](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.min.html)
    - [dask.dataframe.api.Rolling.quantile](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.quantile.html)
    - [dask.dataframe.api.Rolling.skew](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.skew.html)
    - [dask.dataframe.api.Rolling.std](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.std.html)
    - [dask.dataframe.api.Rolling.sum](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.sum.html)
    - [dask.dataframe.api.Rolling.var](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.var.html)

  - [Additional Information](https://docs.dask.org/en/stable/dataframe-extra.html)

    - [Parquet](https://docs.dask.org/en/stable/dataframe-parquet.html)
    - [Indexing](https://docs.dask.org/en/stable/dataframe-indexing.html)
    - [SQL](https://docs.dask.org/en/stable/dataframe-sql.html)
    - [Join Performance](https://docs.dask.org/en/stable/dataframe-joins.html)
    - [Shuffling Performance](https://docs.dask.org/en/stable/dataframe-groupby.html)
    - [Categoricals](https://docs.dask.org/en/stable/dataframe-categoricals.html)
    - [Extend](https://docs.dask.org/en/stable/dataframe-extend.html)
    - [Hive Partitioning](https://docs.dask.org/en/stable/dataframe-hive.html)

- [Delayed](https://docs.dask.org/en/stable/delayed.html)

  - [Working with Collections](https://docs.dask.org/en/stable/delayed-collections.html)
  - [Best Practices](https://docs.dask.org/en/stable/delayed-best-practices.html)

- [Futures](https://docs.dask.org/en/stable/futures.html)
- [Machine Learning](https://docs.dask.org/en/stable/ml.html)

Internals

- [Understanding Performance](https://docs.dask.org/en/stable/understanding-performance.html)
- [Scheduling](https://docs.dask.org/en/stable/scheduling.html)
- [Task Graphs](https://docs.dask.org/en/stable/graphs.html)

  - [Specification](https://docs.dask.org/en/stable/spec.html)
  - [Custom Graphs](https://docs.dask.org/en/stable/custom-graphs.html)
  - [Optimization](https://docs.dask.org/en/stable/optimize.html)
  - [Advanced graph manipulation](https://docs.dask.org/en/stable/graph_manipulation.html)
  - [Custom Collections](https://docs.dask.org/en/stable/custom-collections.html)
  - [High Level Graphs](https://docs.dask.org/en/stable/high-level-graphs.html)

- [Debugging and Performance](https://docs.dask.org/en/stable/debugging-performance.html)

  - [Debug](https://docs.dask.org/en/stable/how-to/debug.html)
  - [Visualize task graphs](https://docs.dask.org/en/stable/graphviz.html)
  - [Dashboard](https://docs.dask.org/en/stable/dashboard.html)
  - [Diagnostics (local)](https://docs.dask.org/en/stable/diagnostics-local.html)
  - [Diagnostics (distributed)](https://docs.dask.org/en/stable/diagnostics-distributed.html)
  - [Phases of computation](https://docs.dask.org/en/stable/phases-of-computation.html)

- [Dask Internals](https://docs.dask.org/en/stable/internals.html)

  - [User Interfaces](https://docs.dask.org/en/stable/user-interfaces.html)
  - [Understanding Performance](https://docs.dask.org/en/stable/understanding-performance.html)
  - [Stages of Computation](https://docs.dask.org/en/stable/phases-of-computation.html)
  - [Ordering](https://docs.dask.org/en/stable/order.html)
  - [Opportunistic Caching](https://docs.dask.org/en/stable/caching.html)
  - [Shared Memory](https://docs.dask.org/en/stable/shared.html)
  - [Scheduling in Depth](https://docs.dask.org/en/stable/scheduling-policy.html)
  - [Query planning with Expression system](https://docs.dask.org/en/stable/expr-system-internals.html)

Reference

- [API Reference](https://docs.dask.org/en/stable/api.html)

  - [Array](https://docs.dask.org/en/stable/array-api.html)
  - [DataFrame](https://docs.dask.org/en/stable/dataframe-api.html)

    - [dask.dataframe.Series.dt.date](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.date.html)
    - [dask.dataframe.Series.dt.day](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.day.html)
    - [dask.dataframe.Series.dt.dayofweek](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.dayofweek.html)
    - [dask.dataframe.Series.dt.dayofyear](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.dayofyear.html)
    - [dask.dataframe.Series.dt.daysinmonth](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.daysinmonth.html)
    - [dask.dataframe.Series.dt.freq](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.freq.html)
    - [dask.dataframe.Series.dt.hour](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.hour.html)
    - [dask.dataframe.Series.dt.microsecond](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.microsecond.html)
    - [dask.dataframe.Series.dt.minute](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.minute.html)
    - [dask.dataframe.Series.dt.month](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.month.html)
    - [dask.dataframe.Series.dt.nanosecond](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.nanosecond.html)
    - [dask.dataframe.Series.dt.quarter](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.quarter.html)
    - [dask.dataframe.Series.dt.second](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.second.html)
    - [dask.dataframe.Series.dt.time](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.time.html)
    - [dask.dataframe.Series.dt.timetz](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.timetz.html)
    - [dask.dataframe.Series.dt.tz](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.tz.html)
    - [dask.dataframe.Series.dt.week](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.week.html)
    - [dask.dataframe.Series.dt.weekday](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.weekday.html)
    - [dask.dataframe.Series.dt.weekofyear](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.weekofyear.html)
    - [dask.dataframe.Series.dt.year](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.dt.year.html)
    - [dask.dataframe.Series.cat.categories](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.cat.categories.html)
    - [dask.dataframe.Series.cat.codes](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.cat.codes.html)
    - [dask.dataframe.Series.cat.known](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.cat.known.html)
    - [dask.dataframe.Series.cat.ordered](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.cat.ordered.html)
    - [dask.dataframe.api.Rolling.apply](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.apply.html)
    - [dask.dataframe.api.Rolling.count](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.count.html)
    - [dask.dataframe.api.Rolling.kurt](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.kurt.html)
    - [dask.dataframe.api.Rolling.max](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.max.html)
    - [dask.dataframe.api.Rolling.mean](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.mean.html)
    - [dask.dataframe.api.Rolling.median](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.median.html)
    - [dask.dataframe.api.Rolling.min](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.min.html)
    - [dask.dataframe.api.Rolling.quantile](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.quantile.html)
    - [dask.dataframe.api.Rolling.skew](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.skew.html)
    - [dask.dataframe.api.Rolling.std](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.std.html)
    - [dask.dataframe.api.Rolling.sum](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.sum.html)
    - [dask.dataframe.api.Rolling.var](https://docs.dask.org/en/stable/generated/dask.dataframe.api.Rolling.var.html)

  - [Bag](https://docs.dask.org/en/stable/bag-api.html)

    - [dask.dataframe.DataFrame.to\_bag](https://docs.dask.org/en/stable/generated/dask.dataframe.DataFrame.to_bag.html)
    - [dask.dataframe.Series.to\_bag](https://docs.dask.org/en/stable/generated/dask.dataframe.Series.to_bag.html)

  - [Delayed](https://docs.dask.org/en/stable/delayed-api.html)
  - [Futures](https://docs.dask.org/en/stable/futures.html)

- [Command Line Interface](https://docs.dask.org/en/stable/cli.html)
- [Development Guidelines](https://docs.dask.org/en/stable/develop.html)
- [Changelog](https://docs.dask.org/en/stable/changelog.html)
- [Configuration](https://docs.dask.org/en/stable/configuration.html)
- [How To…](https://docs.dask.org/en/stable/how-to/index.html)

  - [Connect to remote data](https://docs.dask.org/en/stable/how-to/connect-to-remote-data.html)
  - [Debug](https://docs.dask.org/en/stable/how-to/debug.html)
  - [Extend sizeof](https://docs.dask.org/en/stable/how-to/extend-sizeof.html)
  - [Selecting the collection backend](https://docs.dask.org/en/stable/how-to/selecting-the-collection-backend.html)
  - [Use GPUs](https://docs.dask.org/en/stable/gpu.html)

- [Talks & Tutorials](https://docs.dask.org/en/stable/presentations.html)
- [Maintainer Guidelines](https://docs.dask.org/en/stable/maintainers.html)

- [.rst](https://docs.dask.org/en/stable/_sources/index.rst)
- .pdf

LightDarkSystem Settings

# Dask

## Contents

- [How to Use Dask](https://docs.dask.org/en/stable/#how-to-use-dask)
- [How to Install Dask](https://docs.dask.org/en/stable/#how-to-install-dask)
- [How to Deploy Dask](https://docs.dask.org/en/stable/#how-to-deploy-dask)
- [Learn with Examples](https://docs.dask.org/en/stable/#learn-with-examples)

# Dask [\#](https://docs.dask.org/en/stable/\#dask "Link to this heading")

_Dask is a Python library for parallel and distributed computing._ Dask is:

- **Easy** to use and set up (it’s just a Python library)

- **Powerful** at providing scale, and unlocking complex algorithms

- and **Fun** 🎉


![Dask dashboard animation showing the task stream, memory stored on each worker, CPU utilization, and task progress.](https://embed-ssl.wistia.com/deliveries/05b64c688adc81ca92c61df752a1ab83427d2d99.webp?image_crop_resized=1456x1092)

Click for sound

## How to Use Dask [\#](https://docs.dask.org/en/stable/\#how-to-use-dask "Link to this heading")

Dask provides several APIs. Choose one that works best for you:

Tasks

Dask Futures parallelize arbitrary for-loop style Python code,
providing:

- **Flexible** tooling allowing you to construct custom
pipelines and workflows

- **Powerful** scaling techniques, processing several thousand
tasks per second

- **Responsive** feedback allowing for intuitive execution,
and helpful dashboards


Dask futures form the foundation for other Dask work

Learn more at [Futures Documentation](https://docs.dask.org/en/stable/futures.html)
or see an example at [Futures Example](https://examples.dask.org/futures.html)

```
from dask.distributed import LocalCluster
client = LocalCluster().get_client()

# Submit work to happen in parallel
results = []
for filename in filenames:
    data = client.submit(load, filename)
    result = client.submit(process, data)
    results.append(result)

# Gather results back to local computer
results = client.gather(results)
```

Copy to clipboard

![_images/futures-graph.png](https://docs.dask.org/en/stable/_images/futures-graph.png)

DataFrames

Dask Dataframes parallelize the popular pandas library, providing:

- **Larger-than-memory** execution for single machines, allowing you
to process data that is larger than your available RAM

- **Parallel** execution for faster processing

- **Distributed** computation for terabyte-sized datasets


Dask Dataframes are similar in this regard to Apache Spark, but use the
familiar pandas API and memory model. One Dask dataframe is simply a
collection of pandas dataframes on different computers.

Learn more at [DataFrame Documentation](https://docs.dask.org/en/stable/dataframe.html)
or see an example at [DataFrame Example](https://examples.dask.org/dataframe.html)

```
import dask.dataframe as dd

# Read large datasets in parallel
df = dd.read_parquet("s3://mybucket/data.*.parquet")
df = df[df.value < 0]
result = df.groupby(df.name).amount.mean()

result = result.compute()  # Compute to get pandas result
result.plot()
```

Copy to clipboard

![_images/dask-dataframe.svg](https://docs.dask.org/en/stable/_images/dask-dataframe.svg)

Arrays

Dask Arrays parallelize the popular NumPy library, providing:

- **Larger-than-memory** execution for single machines, allowing you
to process data that is larger than your available RAM

- **Parallel** execution for faster processing

- **Distributed** computation for terabyte-sized datasets


Dask Arrays allow scientists and researchers to perform intuitive and
sophisticated operations on large datasets but use the
familiar NumPy API and memory model. One Dask array is simply a
collection of NumPy arrays on different computers.

Learn more at [Array Documentation](https://docs.dask.org/en/stable/array.html)
or see an example at [Array Example](https://examples.dask.org/array.html)

```
import dask.array as da

x = da.random.random((10000, 10000))
y = (x + x.T) - x.mean(axis=1)

z = y.var(axis=0).compute()
```

Copy to clipboard

![_images/dask-array.svg](https://docs.dask.org/en/stable/_images/dask-array.svg)

Xarray wraps Dask array and is a popular downstream project, providing
labeled axes and simultaneously tracking many Dask arrays together,
resulting in more intuitive analyses. Xarray is popular and accounts
for the majority of Dask array use today especially within geospatial
and imaging communities.

Learn more at [Xarray Documentation](https://docs.xarray.dev/en/stable/)
or see an example at [Xarray Example](https://examples.dask.org/xarray.html)

```
import xarray as xr

ds = xr.open_mfdataset("data/*.nc")
da.groupby('time.month').mean('time').compute()
```

Copy to clipboard

![https://docs.xarray.dev/en/stable/_static/logos/Xarray_Logo_RGB_Final.png](https://docs.xarray.dev/en/stable/_static/logos/Xarray_Logo_RGB_Final.png)

Bags

Dask Bags are simple parallel Python lists, commonly used to process
text or raw Python objects. They are …

- **Simple** offering easy map and reduce functionality

- **Low-memory** processing data in a streaming way that minimizes memory use

- **Good for preprocessing** especially for text or JSON data prior
ingestion into dataframes


Dask bags are similar in this regard to Spark RDDs or vanilla
Python data structures and iterators. One Dask bag is simply a
collection of Python iterators processing in parallel on different computers.

Learn more at [Bag Documentation](https://docs.dask.org/en/stable/bag.html)
or see an example at [Bag Example](https://examples.dask.org/bag.html)

```
import dask.bag as db

# Read large datasets in parallel
lines = db.read_text("s3://mybucket/data.*.json")
records = (lines
    .map(json.loads)
    .filter(lambda d: d["value"] > 0)
)
df = records.to_dask_dataframe()
```

Copy to clipboard

## How to Install Dask [\#](https://docs.dask.org/en/stable/\#how-to-install-dask "Link to this heading")

Installing Dask is easy with `pip` or `conda`.

Learn more at [Install Documentation](https://docs.dask.org/en/stable/install.html)

pip

```
pip install "dask[complete]"
```

Copy to clipboard

conda

```
conda install dask
```

Copy to clipboard

## How to Deploy Dask [\#](https://docs.dask.org/en/stable/\#how-to-deploy-dask "Link to this heading")

You can use Dask on a single machine, or deploy it on distributed hardware.

Learn more at [Deploy Documentation](https://docs.dask.org/en/stable/deploying.html)

Local

Dask can set itself up easily in your Python session if you create a
`LocalCluster` object, which sets everything up for you.

```
from dask.distributed import LocalCluster
cluster = LocalCluster()
client = cluster.get_client()

# Normal Dask work ...
```

Copy to clipboard

Alternatively, you can skip this part, and Dask will operate within a
thread pool contained entirely with your local process.

Cloud

[Coiled](https://docs.coiled.io/user_guide/index.html?utm_source=dask-docs&utm_medium=homepage)
is a commercial SaaS product that deploys Dask clusters on cloud platforms like AWS, GCP, and Azure.

```
import coiled
cluster = coiled.Cluster(
   n_workers=100,
   region="us-east-2",
   worker_memory="16 GiB",
   spot_policy="spot_with_fallback",
)
client = cluster.get_client()
```

Copy to clipboard

Learn more at [Coiled Documentation](https://docs.coiled.io/user_guide/index.html?utm_source=dask-docs&utm_medium=homepage)

HPC

The [Dask-Jobqueue project](https://jobqueue.dask.org/) deploys
Dask clusters on popular HPC job submission systems like SLURM, PBS, SGE, LSF,
Torque, Condor, and others.

```
from dask_jobqueue import PBSCluster
cluster = PBSCluster(
   cores=24,
   memory="100GB",
   queue="regular",
   account="my-account",
)
cluster.scale(jobs=100)
client = cluster.get_client()
```

Copy to clipboard

Learn more at [Dask-Jobqueue Documentation](https://jobqueue.dask.org/)

Kubernetes

The [Dask Kubernetes project](https://kubernetes.dask.org/) provides
a Dask Kubernetes Operator for deploying Dask on Kubernetes clusters.

```
from dask_kubernetes.operator import KubeCluster
cluster = KubeCluster(
   name="my-dask-cluster",
   image="ghcr.io/dask/dask:latest",
   resources={"requests": {"memory": "2Gi"}, "limits": {"memory": "64Gi"}},
)
cluster.scale(10)
client = cluster.get_client()
```

Copy to clipboard

Learn more at [Dask Kubernetes Documentation](https://kubernetes.dask.org/)

## Learn with Examples [\#](https://docs.dask.org/en/stable/\#learn-with-examples "Link to this heading")

Dask use is widespread, across all industries and scales. Dask is used
anywhere Python is used and people experience pain due to large scale data, or
intense computing.

You can learn more about Dask applications at the following sources:

- [Dask Examples](https://examples.dask.org/)

- [Dask YouTube Channel](https://youtube.com/@dask-dev)


Additionally, we encourage you to look through the reference documentation on
this website related to the API that most closely matches your application.

Dask was designed to be **easy to use** and **powerful**. We hope that it’s
able to help you have fun with your work.

[next\\
\\
Dask Installation](https://docs.dask.org/en/stable/install.html "next page")

Contents


- [How to Use Dask](https://docs.dask.org/en/stable/#how-to-use-dask)
- [How to Install Dask](https://docs.dask.org/en/stable/#how-to-install-dask)
- [How to Deploy Dask](https://docs.dask.org/en/stable/#how-to-deploy-dask)
- [Learn with Examples](https://docs.dask.org/en/stable/#learn-with-examples)

By Dask Developers


© Copyright 2026.


![Read the Docs](<Base64-Image-Removed>)stable
Versions[latest](https://docs.dask.org/en/latest/)**[stable](https://docs.dask.org/en/stable/)**On Read the Docs[Project Home](https://app.readthedocs.org/projects/dask/?utm_source=dask&utm_content=flyout)[Builds](https://app.readthedocs.org/projects/dask/builds/?utm_source=dask&utm_content=flyout)Search

* * *

[Addons documentation](https://docs.readthedocs.io/page/addons.html?utm_source=dask&utm_content=flyout) ― Hosted by
[Read the Docs](https://about.readthedocs.com/?utm_source=dask&utm_content=flyout)

![brand logo](https://docs.dask.org/en/stable/_images/dask_icon.svg)Ask DaskBot