[Skip to main content](https://volcano.sh/docs/home/introduction/#__docusaurus_skipToContent_fallback)

[![Volcano Logo](https://volcano.sh/img/landing/volcano_logo.png)](https://volcano.sh/)[Documentation](https://volcano.sh/docs/Home/Introduction) [Blog](https://volcano.sh/blog)

[Latest](https://volcano.sh/docs/Home/Introduction)

- [Latest](https://volcano.sh/docs/Home/Introduction)
- [v1.15.0](https://volcano.sh/docs/v1.15.0/Home/Introduction)
- [v1.14.0](https://volcano.sh/docs/v1.14.0/Home/Introduction)
- [v1.13.0](https://volcano.sh/docs/v1.13.0/Home/Introduction)
- [v1.12.0](https://volcano.sh/docs/v1.12.0/Home/Introduction)
- [v1.11.0](https://volcano.sh/docs/v1.11.0/Home/Introduction)
- [v1.10.0](https://volcano.sh/docs/v1.10.0/Home/Introduction)
- [v1.9.0](https://volcano.sh/docs/v1.9.0/Home/Introduction)
- [v1.8.2](https://volcano.sh/docs/v1.8.2/Home/Introduction)
- [v1.7.0](https://volcano.sh/docs/v1.7.0/Home/Introduction)

[English](https://volcano.sh/docs/home/introduction/#)

- [English](https://volcano.sh/docs/Home/Introduction)
- [中文](https://volcano.sh/zh-Hans/docs/Home/Introduction)

`ctrl`  `K`

- [Home](https://volcano.sh/docs/home/introduction/#)

  - [Introduction](https://volcano.sh/docs/Home/Introduction)
  - [Architecture](https://volcano.sh/docs/Home/Architecture)
- [Getting Started](https://volcano.sh/docs/home/introduction/#)

- [Concepts](https://volcano.sh/docs/home/introduction/#)

- [Key Features](https://volcano.sh/docs/home/introduction/#)

- [Ecosystem](https://volcano.sh/docs/home/introduction/#)

- [Scheduler](https://volcano.sh/docs/home/introduction/#)

- [CLI](https://volcano.sh/docs/home/introduction/#)

- [Contribution](https://volcano.sh/docs/home/introduction/#)

- [UserGuide](https://volcano.sh/docs/home/introduction/#)


- [Home page](https://volcano.sh/)
- Home
- Introduction

Version: Latest

On this page

# What is Volcano

Volcano is a cloud native system for high-performance workloads, which has been accepted by [Cloud Native Computing Foundation\\
(CNCF)](https://www.cncf.io/) as its first and only official container batch scheduling project. Volcano supports popular computing
frameworks such as [Spark](https://spark.apache.org/), [TensorFlow](https://www.tensorflow.org/), [PyTorch](https://pytorch.org/),
[Flink](https://flink.apache.org/), [Argo](https://argoproj.github.io/), [MindSpore](https://www.mindspore.cn/en),
[PaddlePaddle](https://www.paddlepaddle.org.cn/) and [Ray](https://www.ray.io/). Volcano also provides various scheduling capabilities including heterogeneous device scheduling, network topology-aware scheduling, multi-cluster scheduling, online-offline workloads colocation and so on.

## Why Volcano [​](https://volcano.sh/docs/home/introduction/\#why-volcano "Direct link to Why Volcano")

Job scheduling and management become increasingly complex and critical for high-performance batch computing. Common requirements are as follows:

- Support for diverse scheduling algorithms
- More efficient scheduling
- Non-intrusive support for mainstream computing frameworks
- Support for multi-architecture computing

Volcano is designed to cater to these requirements. In addition, Volcano inherits the design of Kubernetes APIs, allowing you to easily run applications that require high-performance computing on Kubernetes.

## Features [​](https://volcano.sh/docs/home/introduction/\#features "Direct link to Features")

### [Unified Scheduling](https://volcano.sh/docs/KeyFeatures/UnifiedScheduling) [​](https://volcano.sh/docs/home/introduction/\#unified-scheduling "Direct link to unified-scheduling")

- Support native Kubernetes workload scheduling
- Provide complete support for frameworks like PyTorch, TensorFlow, Spark, Flink, Ray through VolcanoJob
- Unified scheduling for both online microservices and offline batch jobs to improve cluster resource utilization

### Rich Scheduling Policies [​](https://volcano.sh/docs/home/introduction/\#rich-scheduling-policies "Direct link to Rich Scheduling Policies")

- **Gang Scheduling**: Ensure all tasks of a job start simultaneously, suitable for distributed training and big data scenarios
- **Binpack Scheduling**: Optimize resource utilization through compact task allocation
- **Heterogeneous Device Scheduling**: Efficiently share GPU resources, support both CUDA and MIG modes for GPU scheduling, and NPU scheduling
- **Proportion/Capacity Scheduling**: Resource sharing/preemption/reclaim based on queue quotas
- **NodeGroup Scheduling**: Support node group affinity scheduling, implementing binding between queues and node groups
- **DRF Scheduling**: Support fair scheduling of multi-dimensional resources
- **SLA Scheduling**: Scheduling guarantee based on service quality
- **Task-topology Scheduling**: Support task topology-aware scheduling, optimizing performance for communication-intensive applications
- **NUMA Aware Scheduling**: Supports scheduling for NUMA architecture, optimizing resource allocation for tasks on multi-core processors, enhancing memory access efficiency and computational performance.
- ...

Volcano supports custom plugins and actions to implement more scheduling algorithms.

### [Queue Resource Management](https://volcano.sh/docs/KeyFeatures/QueueResourceManagement) [​](https://volcano.sh/docs/home/introduction/\#queue-resource-management "Direct link to queue-resource-management")

- Support multi-dimensional resource quota control (CPU, Memory, GPU, etc.)
- Provide multi-level queue structure and resource inheritance
- Support resource borrowing, reclaiming and preemption between queues
- Implement multi-tenant resource isolation and priority control

### Multi-architecture computing [​](https://volcano.sh/docs/home/introduction/\#multi-architecture-computing "Direct link to Multi-architecture computing")

Volcano can schedule computing resources from multiple architectures:

- x86
- Arm
- Kunpeng
- Ascend
- GPU: Supports multiple [GPU virtualization](https://volcano.sh/docs/KeyFeatures/GPUVirtualization) technologies for flexible resource management
  - **Dynamic MIG Support**: Enables dynamic partitioning of NVIDIA Multi-Instance GPUs (MIG), providing hardware-level isolation to segment a physical GPU into multiple independent instances
  - **vCUDA Virtualization**: Virtualizes physical GPUs into multiple vGPU devices at the software level for resource sharing and isolation
  - **Fine-Grained Resource Control**: Provides dedicated memory and compute allocation for each GPU instance
  - **Multi-Container Sharing**: Enables multiple containers to securely share a single GPU, maximizing utilization
  - **Unified Monitoring**: Delivers unified monitoring and metrics collection for all GPU instances

### Network Topology-aware Scheduling [​](https://volcano.sh/docs/home/introduction/\#network-topology-aware-scheduling "Direct link to Network Topology-aware Scheduling")

- Supports network topology-aware scheduling, fully considering the network bandwidth characteristics between nodes. In AI scenarios, this network topology-aware scheduling effectively optimizes data transmission for communication-intensive distributed training tasks, significantly reducing communication overhead and improving model training speed and overall efficiency.

### Online and Offline Workloads Colocation [​](https://volcano.sh/docs/home/introduction/\#online-and-offline-workloads-colocation "Direct link to Online and Offline Workloads Colocation")

- Supports online and offline workloads colocation, enhancing resource utilization while ensuring online worloads QoS through unified scheduling, dynamic resource overcommitment, CPU burst, and resource isolation.

### Multi-cluster Scheduling [​](https://volcano.sh/docs/home/introduction/\#multi-cluster-scheduling "Direct link to Multi-cluster Scheduling")

- Support cross-cluster job scheduling for larger-scale resource pool management and load balancing

> For more details about multi-cluster scheduling, see: [volcano-global](https://github.com/volcano-sh/volcano-global)

### Descheduling [​](https://volcano.sh/docs/home/introduction/\#descheduling "Direct link to Descheduling")

- Support dynamic descheduling to optimize cluster load distribution and improve system stability

> For more details about descheduling, see: [descheduler](https://github.com/volcano-sh/descheduler)

### Monitoring and Observability [​](https://volcano.sh/docs/home/introduction/\#monitoring-and-observability "Direct link to Monitoring and Observability")

- Complete logging system
- Rich monitoring metrics
- Provides a dashboard, facilitating graphical interface operations for users.

> For more details about dashboard, see: [dashboard](https://github.com/volcano-sh/dashboard)
>
> For more details about volcano metrics, see: [metrics](https://github.com/volcano-sh/volcano/blob/master/docs/design/metrics.md)

## Ecosystem [​](https://volcano.sh/docs/home/introduction/\#ecosystem "Direct link to Ecosystem")

Volcano has become the de facto standard in batch computing scenarios and is widely used in the following high-performance computing frameworks:

- [Spark](https://spark.apache.org/)
- [TensorFlow](https://www.tensorflow.org/)
- [PyTorch](https://pytorch.org/)
- [Flink](https://flink.apache.org/)
- [Argo](https://argoproj.github.io/)
- [Ray](https://www.ray.io/)
- [MindSpore](https://www.mindspore.cn/)
- [PaddlePaddle](https://www.paddlepaddle.org.cn/)
- [OpenMPI](https://www.open-mpi.org/)
- [Horovod](https://horovod.readthedocs.io/)
- [MXNet](https://mxnet.apache.org/)
- [Kubeflow](https://www.kubeflow.org/)
- [KubeGene](https://github.com/volcano-sh/kubegene)
- [Cromwell](https://cromwell.readthedocs.io/)

Additionally, Volcano has been widely adopted by various enterprises and organizations in the fields of AI and big data. With its powerful resource management capabilities, efficient job management mechanisms, and rich scheduling strategies (such as Gang scheduling, heterogeneous device scheduling, and topology-aware scheduling), it effectively meets the complex demands of distributed training and data analysis tasks. At the same time, Volcano enhances scheduling performance while ensuring the flexibility and reliability of task scheduling, providing strong support for enterprises to build an efficient resource utilization system.

## Future Outlook [​](https://volcano.sh/docs/home/introduction/\#future-outlook "Direct link to Future Outlook")

Volcano will continue to expand its functional boundaries through community collaboration and technical innovation, becoming a leader in high-performance computing and cloud-native batch scheduling.

[Edit this page](https://github.com/volcano-sh/website/tree/master/docs/Home/Introduction.md)

Last updated on **May 26, 2026**

[Next\\
\\
Architecture](https://volcano.sh/docs/Home/Architecture)

- [Why Volcano](https://volcano.sh/docs/home/introduction/#why-volcano)
- [Features](https://volcano.sh/docs/home/introduction/#features)
  - [Unified Scheduling](https://volcano.sh/docs/home/introduction/#unified-scheduling)
  - [Rich Scheduling Policies](https://volcano.sh/docs/home/introduction/#rich-scheduling-policies)
  - [Queue Resource Management](https://volcano.sh/docs/home/introduction/#queue-resource-management)
  - [Multi-architecture computing](https://volcano.sh/docs/home/introduction/#multi-architecture-computing)
  - [Network Topology-aware Scheduling](https://volcano.sh/docs/home/introduction/#network-topology-aware-scheduling)
  - [Online and Offline Workloads Colocation](https://volcano.sh/docs/home/introduction/#online-and-offline-workloads-colocation)
  - [Multi-cluster Scheduling](https://volcano.sh/docs/home/introduction/#multi-cluster-scheduling)
  - [Descheduling](https://volcano.sh/docs/home/introduction/#descheduling)
  - [Monitoring and Observability](https://volcano.sh/docs/home/introduction/#monitoring-and-observability)
- [Ecosystem](https://volcano.sh/docs/home/introduction/#ecosystem)
- [Future Outlook](https://volcano.sh/docs/home/introduction/#future-outlook)

Volcano is a [Cloud Native Computing Foundation](https://www.cncf.io/) incubating project.

![Cloud Native Computing Foundation Logo](https://volcano.sh/img/landing/logo_cloudnative.png)

The Linux Foundation has registered trademarks and uses trademarks. For a list of trademarks of The Linux Foundation, please see our [Trademark Usage](https://www.linuxfoundation.org/trademark-usage) page.

2026 @ Volcano Project Authors. All rights reserved.