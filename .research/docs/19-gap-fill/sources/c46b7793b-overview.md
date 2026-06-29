[Kubernetes](https://kubernetes.io/)

- [Documentation](https://kubernetes.io/docs/home/)
- [Kubernetes Blog](https://kubernetes.io/blog/)
- [Training](https://kubernetes.io/training/)
- [Careers](https://kubernetes.io/careers/)
- [Partners](https://kubernetes.io/partners/)
- [Community](https://kubernetes.io/community/)
- [Versions](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#)

  - [Release Information](https://kubernetes.io/releases)
  - [v1.36](https://kubernetes.io/)
  - [v1.35](https://v1-35.docs.kubernetes.io/)
  - [v1.34](https://v1-34.docs.kubernetes.io/)
  - [v1.33](https://v1-33.docs.kubernetes.io/)
  - [v1.32](https://v1-32.docs.kubernetes.io/)

- [English](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#)

  - [中文 (Chinese)](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/rbac/)
  - [Français (French)](https://kubernetes.io/fr/docs/reference/access-authn-authz/rbac/)
  - [Bahasa Indonesia (Indonesian)](https://kubernetes.io/id/docs/reference/access-authn-authz/rbac/)
  - [日本語 (Japanese)](https://kubernetes.io/ja/docs/reference/access-authn-authz/rbac/)
  - বাংলা (Bengali)

  - Deutsch (German)

  - हिन्दी (Hindi)

  - Italiano (Italian)

  - 한국어 (Korean)

  - فارسی (Persian)

  - Polski (Polish)

  - Português (Portuguese)

  - Русский (Russian)

  - Español (Spanish)

  - Українська (Ukrainian)

  - Tiếng Việt (Vietnamese)


  - Light
  - Dark
  - Auto

#### ![](https://kubernetes.io/images/announcements/kccnc-india-2026-black.svg)[KubeCon + CloudNativeCon India 2026](https://events.linuxfoundation.org/kubecon-cloudnativecon-india/)

Join us for two days of incredible opportunities to collaborate, learn and share with the cloud native community.

[Buy your ticket now! 18 - 19 June \| Mumbai, India](https://events.linuxfoundation.org/kubecon-cloudnativecon-india/register/?utm_source=kubernetes&utm_medium=homepage&utm_campaign=KubeCon-India-2026&utm_content=hero)

Hide this notice

# Using RBAC Authorization

[English](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#)

- [বাংলা (Bengali)](https://kubernetes.io/bn/docs/concepts/)
- [中文 (Chinese)](https://kubernetes.io/zh-cn/docs/concepts/)
- [Français (French)](https://kubernetes.io/fr/docs/concepts/)
- [Deutsch (German)](https://kubernetes.io/de/docs/concepts/)
- [हिन्दी (Hindi)](https://kubernetes.io/hi/docs/concepts/)
- [Bahasa Indonesia (Indonesian)](https://kubernetes.io/id/docs/concepts/)
- [Italiano (Italian)](https://kubernetes.io/it/docs/concepts/)
- [日本語 (Japanese)](https://kubernetes.io/ja/docs/concepts/)
- [한국어 (Korean)](https://kubernetes.io/ko/docs/concepts/)
- [Polski (Polish)](https://kubernetes.io/pl/docs/concepts/)
- [Português (Portuguese)](https://kubernetes.io/pt-br/docs/concepts/)
- [Русский (Russian)](https://kubernetes.io/ru/docs/concepts/)
- [Español (Spanish)](https://kubernetes.io/es/docs/concepts/)
- [Українська (Ukrainian)](https://kubernetes.io/uk/docs/concepts/)
- [Tiếng Việt (Vietnamese)](https://kubernetes.io/vi/docs/concepts/)
- فارسی (Persian)


- [Kubernetes Documentation](https://kubernetes.io/docs/ "Documentation")
  - [ ] [Documentation](https://kubernetes.io/docs/home/ "Kubernetes Documentation")
    - [ ] [Available Documentation Versions](https://kubernetes.io/docs/home/supported-doc-versions/)
  - [ ] [Getting started](https://kubernetes.io/docs/setup/)
    - [ ] [Learning environment](https://kubernetes.io/docs/setup/learning-environment/)
    - [ ] [Production environment](https://kubernetes.io/docs/setup/production-environment/)
      - [ ] [Container Runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
      - [ ] [Installing Kubernetes with deployment tools](https://kubernetes.io/docs/setup/production-environment/tools/)
        - [ ] [Bootstrapping clusters with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
          - [ ] [Installing kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
          - [ ] [Troubleshooting kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/)
          - [ ] [Creating a cluster with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
          - [ ] [Customizing components with the kubeadm API](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/control-plane-flags/)
          - [ ] [Options for Highly Available Topology](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/)
          - [ ] [Creating Highly Available Clusters with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)
          - [ ] [Set up a High Availability etcd Cluster with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/setup-ha-etcd-with-kubeadm/)
          - [ ] [Configuring each kubelet in your cluster using kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/kubelet-integration/)
          - [ ] [Dual-stack support with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/dual-stack-support/)
      - [ ] [Turnkey Cloud Solutions](https://kubernetes.io/docs/setup/production-environment/turnkey-solutions/)
    - [ ] [Best practices](https://kubernetes.io/docs/setup/best-practices/)
      - [ ] [Considerations for large clusters](https://kubernetes.io/docs/setup/best-practices/cluster-large/)
      - [ ] [Running in multiple zones](https://kubernetes.io/docs/setup/best-practices/multiple-zones/)
      - [ ] [Validate node setup](https://kubernetes.io/docs/setup/best-practices/node-conformance/)
      - [ ] [Enforcing Pod Security Standards](https://kubernetes.io/docs/setup/best-practices/enforcing-pod-security-standards/)
      - [ ] [PKI certificates and requirements](https://kubernetes.io/docs/setup/best-practices/certificates/)
  - [ ] [Concepts](https://kubernetes.io/docs/concepts/)
    - [ ] [Overview](https://kubernetes.io/docs/concepts/overview/)
      - [ ] [Kubernetes Components](https://kubernetes.io/docs/concepts/overview/components/)
      - [ ] [Objects In Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/)
        - [ ] [Kubernetes Object Management](https://kubernetes.io/docs/concepts/overview/working-with-objects/object-management/)
        - [ ] [Object Names and IDs](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/)
        - [ ] [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
        - [ ] [Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
        - [ ] [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)
        - [ ] [Field Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/)
        - [ ] [Finalizers](https://kubernetes.io/docs/concepts/overview/working-with-objects/finalizers/)
        - [ ] [Owners and Dependents](https://kubernetes.io/docs/concepts/overview/working-with-objects/owners-dependents/)
        - [ ] [Recommended Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)
        - [ ] [Storage Versions](https://kubernetes.io/docs/concepts/overview/working-with-objects/storage-version/)
      - [ ] [The Kubernetes API](https://kubernetes.io/docs/concepts/overview/kubernetes-api/)
      - [ ] [The kubectl command-line tool](https://kubernetes.io/docs/concepts/overview/kubectl/)
    - [ ] [Cluster Architecture](https://kubernetes.io/docs/concepts/architecture/)
      - [ ] [Nodes](https://kubernetes.io/docs/concepts/architecture/nodes/)
      - [ ] [Communication between Nodes and the Control Plane](https://kubernetes.io/docs/concepts/architecture/control-plane-node-communication/)
      - [ ] [Controllers](https://kubernetes.io/docs/concepts/architecture/controller/)
      - [ ] [Leases](https://kubernetes.io/docs/concepts/architecture/leases/)
      - [ ] [Cloud Controller Manager](https://kubernetes.io/docs/concepts/architecture/cloud-controller/)
      - [ ] [About cgroup v2](https://kubernetes.io/docs/concepts/architecture/cgroups/)
      - [ ] [Kubernetes Self-Healing](https://kubernetes.io/docs/concepts/architecture/self-healing/)
      - [ ] [Garbage Collection](https://kubernetes.io/docs/concepts/architecture/garbage-collection/)
      - [ ] [Mixed Version Proxy](https://kubernetes.io/docs/concepts/architecture/mixed-version-proxy/)
    - [ ] [Containers](https://kubernetes.io/docs/concepts/containers/)
      - [ ] [Images](https://kubernetes.io/docs/concepts/containers/images/)
      - [ ] [Container Environment](https://kubernetes.io/docs/concepts/containers/container-environment/)
      - [ ] [Runtime Class](https://kubernetes.io/docs/concepts/containers/runtime-class/)
      - [ ] [Container Lifecycle Hooks](https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/)
      - [ ] [Container Runtime Interface (CRI)](https://kubernetes.io/docs/concepts/containers/cri/)
    - [ ] [Workloads](https://kubernetes.io/docs/concepts/workloads/)
      - [ ] [Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
        - [ ] [Pod Lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)
        - [ ] [Pod Conditions](https://kubernetes.io/docs/concepts/workloads/pods/pod-condition/)
        - [ ] [Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
        - [ ] [Sidecar Containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/)
        - [ ] [Ephemeral Containers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/)
        - [ ] [Liveness, Readiness, and Startup Probes](https://kubernetes.io/docs/concepts/workloads/pods/probes/)
        - [ ] [Disruptions](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/)
        - [ ] [Pod Hostname](https://kubernetes.io/docs/concepts/workloads/pods/pod-hostname/)
        - [ ] [Pod Quality of Service Classes](https://kubernetes.io/docs/concepts/workloads/pods/pod-qos/)
        - [ ] [Scheduling Group](https://kubernetes.io/docs/concepts/workloads/pods/scheduling-group/)
        - [ ] [Static Pods](https://kubernetes.io/docs/concepts/workloads/pods/static-pods/)
        - [ ] [User Namespaces](https://kubernetes.io/docs/concepts/workloads/pods/user-namespaces/)
        - [ ] [Downward API](https://kubernetes.io/docs/concepts/workloads/pods/downward-api/)
        - [ ] [Advanced Pod Configuration](https://kubernetes.io/docs/concepts/workloads/pods/advanced-pod-config/)
      - [ ] [Workload API](https://kubernetes.io/docs/concepts/workloads/workload-api/)
        - [ ] [Pod Group Disruption and Priority](https://kubernetes.io/docs/concepts/workloads/workload-api/disruption-and-priority/)
        - [ ] [PodGroup Scheduling Policies](https://kubernetes.io/docs/concepts/workloads/workload-api/policies/)
        - [ ] [Topology-Aware Workload Scheduling](https://kubernetes.io/docs/concepts/workloads/workload-api/topology-aware-scheduling/)
      - [ ] [Workload Management](https://kubernetes.io/docs/concepts/workloads/controllers/)
        - [ ] [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
        - [ ] [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
        - [ ] [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
        - [ ] [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
        - [ ] [Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
        - [ ] [Automatic Cleanup for Finished Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/ttlafterfinished/)
        - [ ] [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
        - [ ] [ReplicationController](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/)
      - [ ] [PodGroup API](https://kubernetes.io/docs/concepts/workloads/podgroup-api/)
        - [ ] [PodGroup Lifecycle](https://kubernetes.io/docs/concepts/workloads/podgroup-api/lifecycle/)
      - [ ] [Managing Workloads](https://kubernetes.io/docs/concepts/workloads/management/)
      - [ ] [Autoscaling Workloads](https://kubernetes.io/docs/concepts/workloads/autoscaling/)
      - [ ] [Horizontal Pod Autoscaling](https://kubernetes.io/docs/concepts/workloads/autoscaling/horizontal-pod-autoscale/)
      - [ ] [Resource managers](https://kubernetes.io/docs/concepts/workloads/resource-managers/)
      - [ ] [Vertical Pod Autoscaling](https://kubernetes.io/docs/concepts/workloads/autoscaling/vertical-pod-autoscale/)
    - [ ] [Services, Load Balancing, and Networking](https://kubernetes.io/docs/concepts/services-networking/)
      - [ ] [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
      - [ ] [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
      - [ ] [Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
      - [ ] [Gateway API](https://kubernetes.io/docs/concepts/services-networking/gateway/)
      - [ ] [EndpointSlices](https://kubernetes.io/docs/concepts/services-networking/endpoint-slices/)
      - [ ] [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
      - [ ] [DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
      - [ ] [IPv4/IPv6 dual-stack](https://kubernetes.io/docs/concepts/services-networking/dual-stack/)
      - [ ] [Topology Aware Routing](https://kubernetes.io/docs/concepts/services-networking/topology-aware-routing/)
      - [ ] [Networking on Windows](https://kubernetes.io/docs/concepts/services-networking/windows-networking/)
      - [ ] [Service ClusterIP allocation](https://kubernetes.io/docs/concepts/services-networking/cluster-ip-allocation/)
      - [ ] [Service Internal Traffic Policy](https://kubernetes.io/docs/concepts/services-networking/service-traffic-policy/)
    - [ ] [Storage](https://kubernetes.io/docs/concepts/storage/)
      - [ ] [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
      - [ ] [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
      - [ ] [Projected Volumes](https://kubernetes.io/docs/concepts/storage/projected-volumes/)
      - [ ] [Ephemeral Volumes](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/)
      - [ ] [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)
      - [ ] [Volume Attributes Classes](https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/)
      - [ ] [Dynamic Volume Provisioning](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/)
      - [ ] [Volume Snapshots](https://kubernetes.io/docs/concepts/storage/volume-snapshots/)
      - [ ] [Volume Snapshot Classes](https://kubernetes.io/docs/concepts/storage/volume-snapshot-classes/)
      - [ ] [CSI Volume Cloning](https://kubernetes.io/docs/concepts/storage/volume-pvc-datasource/)
      - [ ] [Storage Capacity](https://kubernetes.io/docs/concepts/storage/storage-capacity/)
      - [ ] [Node-specific Volume Limits](https://kubernetes.io/docs/concepts/storage/storage-limits/)
      - [ ] [Local ephemeral storage](https://kubernetes.io/docs/concepts/storage/ephemeral-storage/)
      - [ ] [Volume Health Monitoring](https://kubernetes.io/docs/concepts/storage/volume-health-monitoring/)
      - [ ] [Windows Storage](https://kubernetes.io/docs/concepts/storage/windows-storage/)
    - [ ] [Configuration](https://kubernetes.io/docs/concepts/configuration/)
      - [ ] [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)
      - [ ] [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
      - [ ] [Resource Management for Pods and Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
      - [ ] [Organizing Cluster Access Using kubeconfig Files](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/)
      - [ ] [Resource Management for Windows nodes](https://kubernetes.io/docs/concepts/configuration/windows-resource-management/)
    - [ ] [Security](https://kubernetes.io/docs/concepts/security/)
      - [ ] [Cloud Native Security](https://kubernetes.io/docs/concepts/security/cloud-native-security/ "Cloud Native Security and Kubernetes")
      - [ ] [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
      - [ ] [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)
      - [ ] [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
      - [ ] [Pod Security Policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/)
      - [ ] [Security For Linux Nodes](https://kubernetes.io/docs/concepts/security/linux-security/)
      - [ ] [Security For Windows Nodes](https://kubernetes.io/docs/concepts/security/windows-security/)
      - [ ] [Controlling Access to the Kubernetes API](https://kubernetes.io/docs/concepts/security/controlling-access/)
      - [ ] [Role Based Access Control Good Practices](https://kubernetes.io/docs/concepts/security/rbac-good-practices/)
      - [ ] [Good practices for Kubernetes Secrets](https://kubernetes.io/docs/concepts/security/secrets-good-practices/)
      - [ ] [Multi-tenancy](https://kubernetes.io/docs/concepts/security/multi-tenancy/)
      - [ ] [Hardening Guide - Authentication Mechanisms](https://kubernetes.io/docs/concepts/security/hardening-guide/authentication-mechanisms/)
      - [ ] [Hardening Guide - Dynamic Resource Allocation](https://kubernetes.io/docs/concepts/security/hardening-guide/dynamic-resource-allocation/)
      - [ ] [Hardening Guide - Scheduler Configuration](https://kubernetes.io/docs/concepts/security/hardening-guide/scheduler/)
      - [ ] [Kubernetes API Server Bypass Risks](https://kubernetes.io/docs/concepts/security/api-server-bypass-risks/)
      - [ ] [Linux kernel security constraints for Pods and containers](https://kubernetes.io/docs/concepts/security/linux-kernel-security-constraints/)
      - [ ] [Security Checklist](https://kubernetes.io/docs/concepts/security/security-checklist/)
      - [ ] [Application Security Checklist](https://kubernetes.io/docs/concepts/security/application-security-checklist/)
    - [ ] [Policies](https://kubernetes.io/docs/concepts/policy/)
      - [ ] [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/)
      - [ ] [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
      - [ ] [Process ID Limits And Reservations](https://kubernetes.io/docs/concepts/policy/pid-limiting/)
    - [ ] [Scheduling, Preemption and Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/)
      - [ ] [Kubernetes Scheduler](https://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/)
      - [ ] [Topology-Aware Workload Scheduling](https://kubernetes.io/docs/concepts/scheduling-eviction/topology-aware-scheduling/)
      - [ ] [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
      - [ ] [Pod Overhead](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-overhead/)
      - [ ] [Pod Scheduling Readiness](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-scheduling-readiness/)
      - [ ] [Pod Topology Spread Constraints](https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/)
      - [ ] [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
      - [ ] [Scheduling Framework](https://kubernetes.io/docs/concepts/scheduling-eviction/scheduling-framework/)
      - [ ] [Dynamic Resource Allocation](https://kubernetes.io/docs/concepts/scheduling-eviction/dynamic-resource-allocation/)
      - [ ] [Gang Scheduling](https://kubernetes.io/docs/concepts/scheduling-eviction/gang-scheduling/)
      - [ ] [Scheduler Performance Tuning](https://kubernetes.io/docs/concepts/scheduling-eviction/scheduler-perf-tuning/)
      - [ ] [PodGroup Scheduling](https://kubernetes.io/docs/concepts/scheduling-eviction/podgroup-scheduling/)
      - [ ] [Resource Bin Packing](https://kubernetes.io/docs/concepts/scheduling-eviction/resource-bin-packing/)
      - [ ] [Workload-Aware Preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/workload-aware-preemption/)
      - [ ] [Pod Priority and Preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/)
      - [ ] [Node-pressure Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/)
      - [ ] [API-initiated Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/api-eviction/)
      - [ ] [Node Declared Features](https://kubernetes.io/docs/concepts/scheduling-eviction/node-declared-features/)
    - [ ] [Cluster Administration](https://kubernetes.io/docs/concepts/cluster-administration/)
      - [ ] [Node Shutdowns](https://kubernetes.io/docs/concepts/cluster-administration/node-shutdown/)
      - [ ] [Swap memory management](https://kubernetes.io/docs/concepts/cluster-administration/swap-memory-management/)
      - [ ] [Node Autoscaling](https://kubernetes.io/docs/concepts/cluster-administration/node-autoscaling/)
      - [ ] [Certificates](https://kubernetes.io/docs/concepts/cluster-administration/certificates/)
      - [ ] [Cluster Networking](https://kubernetes.io/docs/concepts/cluster-administration/networking/)
      - [ ] [Observability](https://kubernetes.io/docs/concepts/cluster-administration/observability/)
      - [ ] [Admission Webhook Good Practices](https://kubernetes.io/docs/concepts/cluster-administration/admission-webhooks-good-practices/)
      - [ ] [Good practices for Dynamic Resource Allocation as a Cluster Admin](https://kubernetes.io/docs/concepts/cluster-administration/dra/)
      - [ ] [Logging Architecture](https://kubernetes.io/docs/concepts/cluster-administration/logging/)
      - [ ] [Compatibility Version For Kubernetes Control Plane Components](https://kubernetes.io/docs/concepts/cluster-administration/compatibility-version/)
      - [ ] [Metrics For Kubernetes System Components](https://kubernetes.io/docs/concepts/cluster-administration/system-metrics/)
      - [ ] [Metrics for Kubernetes Object States](https://kubernetes.io/docs/concepts/cluster-administration/kube-state-metrics/)
      - [ ] [System Logs](https://kubernetes.io/docs/concepts/cluster-administration/system-logs/)
      - [ ] [Traces For Kubernetes System Components](https://kubernetes.io/docs/concepts/cluster-administration/system-traces/)
      - [ ] [Proxies in Kubernetes](https://kubernetes.io/docs/concepts/cluster-administration/proxies/)
      - [ ] [API Priority and Fairness](https://kubernetes.io/docs/concepts/cluster-administration/flow-control/)
      - [ ] [Installing Addons](https://kubernetes.io/docs/concepts/cluster-administration/addons/)
      - [ ] [Coordinated Leader Election](https://kubernetes.io/docs/concepts/cluster-administration/coordinated-leader-election/)
    - [ ] [Windows in Kubernetes](https://kubernetes.io/docs/concepts/windows/)
      - [ ] [Windows containers in Kubernetes](https://kubernetes.io/docs/concepts/windows/intro/)
      - [ ] [Guide for Running Windows Containers in Kubernetes](https://kubernetes.io/docs/concepts/windows/user-guide/)
    - [ ] [Extending Kubernetes](https://kubernetes.io/docs/concepts/extend-kubernetes/)
      - [ ] [Compute, Storage, and Networking Extensions](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/)
        - [ ] [Network Plugins](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/)
        - [ ] [Device Plugins](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/)
      - [ ] [Extending the Kubernetes API](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/)
        - [ ] [Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)
        - [ ] [Kubernetes API Aggregation Layer](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/apiserver-aggregation/)
      - [ ] [Operator pattern](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)
  - [ ] [Tasks](https://kubernetes.io/docs/tasks/)
    - [ ] [Install Tools](https://kubernetes.io/docs/tasks/tools/)
      - [ ] [Install and Set Up kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
      - [ ] [Install and Set Up kubectl on macOS](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/)
      - [ ] [Install and Set Up kubectl on Windows](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)
    - [ ] [Administer a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/)
      - [ ] [Administration with kubeadm](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/)
        - [ ] [Adding Linux worker nodes](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-linux-nodes/)
        - [ ] [Adding Windows worker nodes](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-windows-nodes/)
        - [ ] [Upgrading kubeadm clusters](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)
        - [ ] [Upgrading Linux nodes](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/)
        - [ ] [Upgrading Windows nodes](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-windows-nodes/)
        - [ ] [Configuring a cgroup driver](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/)
        - [ ] [Certificate Management with kubeadm](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/)
        - [ ] [Reconfiguring a kubeadm cluster](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-reconfigure/)
        - [ ] [Changing The Kubernetes Package Repository](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/change-package-repository/)
      - [ ] [Overprovision Node Capacity For A Cluster](https://kubernetes.io/docs/tasks/administer-cluster/node-overprovisioning/)
      - [ ] [Migrating from dockershim](https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/)
        - [ ] [Changing the Container Runtime on a Node from Docker Engine to containerd](https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/change-runtime-containerd/)
        - [ ] [Find Out What Container Runtime is Used on a Node](https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/find-out-runtime-you-use/)
        - [ ] [Troubleshooting CNI plugin-related errors](https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/troubleshooting-cni-plugin-related-errors/)
        - [ ] [Check whether dockershim removal affects you](https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/check-if-dockershim-removal-affects-you/)
        - [ ] [Migrating telemetry and security agents from dockershim](https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/migrating-telemetry-and-security-agents/)
      - [ ] [Generate Certificates Manually](https://kubernetes.io/docs/tasks/administer-cluster/certificates/)
      - [ ] [Manage Memory, CPU, and API Resources](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/)
        - [ ] [Configure Default Memory Requests and Limits for a Namespace](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/)
        - [ ] [Configure Default CPU Requests and Limits for a Namespace](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/)
        - [ ] [Configure Minimum and Maximum Memory Constraints for a Namespace](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-constraint-namespace/)
        - [ ] [Configure Minimum and Maximum CPU Constraints for a Namespace](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-constraint-namespace/)
        - [ ] [Configure Memory and CPU Quotas for a Namespace](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/quota-memory-cpu-namespace/)
        - [ ] [Configure a Pod Quota for a Namespace](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/quota-pod-namespace/)
      - [ ] [Install a Network Policy Provider](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/)
        - [ ] [Use Antrea for NetworkPolicy](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/antrea-network-policy/)
        - [ ] [Use Calico for NetworkPolicy](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/calico-network-policy/)
        - [ ] [Use Cilium for NetworkPolicy](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/cilium-network-policy/)
        - [ ] [Use Kube-router for NetworkPolicy](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/kube-router-network-policy/)
        - [ ] [Romana for NetworkPolicy](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/romana-network-policy/)
        - [ ] [Weave Net for NetworkPolicy](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/weave-network-policy/)
      - [ ] [Access Clusters Using the Kubernetes API](https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/)
      - [ ] [Enable Or Disable Feature Gates](https://kubernetes.io/docs/tasks/administer-cluster/configure-feature-gates/)
      - [ ] [Advertise Extended Resources for a Node](https://kubernetes.io/docs/tasks/administer-cluster/extended-resource-node/)
      - [ ] [Autoscale the DNS Service in a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)
      - [ ] [Change the Access Mode of a PersistentVolume to ReadWriteOncePod](https://kubernetes.io/docs/tasks/administer-cluster/change-pv-access-mode-readwriteoncepod/)
      - [ ] [Change the default StorageClass](https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/)
      - [ ] [Switching from Polling to CRI Event-based Updates to Container Status](https://kubernetes.io/docs/tasks/administer-cluster/switch-to-evented-pleg/)
      - [ ] [Change the Reclaim Policy of a PersistentVolume](https://kubernetes.io/docs/tasks/administer-cluster/change-pv-reclaim-policy/)
      - [ ] [Cloud Controller Manager Administration](https://kubernetes.io/docs/tasks/administer-cluster/running-cloud-controller/)
      - [ ] [Configure a kubelet image credential provider](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-credential-provider/)
      - [ ] [Configure Quotas for API Objects](https://kubernetes.io/docs/tasks/administer-cluster/quota-api-object/)
      - [ ] [Control CPU Management Policies on the Node](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/)
      - [ ] [Control Memory Management Policies on a Node](https://kubernetes.io/docs/tasks/administer-cluster/memory-manager/)
      - [ ] [Control Topology Management Policies on a node](https://kubernetes.io/docs/tasks/administer-cluster/topology-manager/)
      - [ ] [Customizing DNS Service](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)
      - [ ] [Debugging DNS Resolution](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/)
      - [ ] [Declare Network Policy](https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy/)
      - [ ] [Developing Cloud Controller Manager](https://kubernetes.io/docs/tasks/administer-cluster/developing-cloud-controller-manager/)
      - [ ] [Enable Or Disable A Kubernetes API](https://kubernetes.io/docs/tasks/administer-cluster/enable-disable-api/)
      - [ ] [Encrypting Confidential Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)
      - [ ] [Decrypt Confidential Data that is Already Encrypted at Rest](https://kubernetes.io/docs/tasks/administer-cluster/decrypt-data/)
      - [ ] [Guaranteed Scheduling For Critical Add-On Pods](https://kubernetes.io/docs/tasks/administer-cluster/guaranteed-scheduling-critical-addon-pods/)
      - [ ] [IP Masquerade Agent User Guide](https://kubernetes.io/docs/tasks/administer-cluster/ip-masq-agent/)
      - [ ] [Limit Storage Consumption](https://kubernetes.io/docs/tasks/administer-cluster/limit-storage-consumption/)
      - [ ] [Migrate Replicated Control Plane To Use Cloud Controller Manager](https://kubernetes.io/docs/tasks/administer-cluster/controller-manager-leader-migration/)
      - [ ] [Operating etcd clusters for Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)
      - [ ] [Reserve Compute Resources for System Daemons](https://kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/)
      - [ ] [Running Kubernetes Node Components as a Non-root User](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-in-userns/)
      - [ ] [Safely Drain a Node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/)
      - [ ] [Securing a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/)
      - [ ] [Harden Dynamic Resource Allocation in Your Cluster](https://kubernetes.io/docs/tasks/administer-cluster/hardening-dra/)
      - [ ] [Set Kubelet Parameters Via A Configuration File](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/)
      - [ ] [Share a Cluster with Namespaces](https://kubernetes.io/docs/tasks/administer-cluster/namespaces/)
      - [ ] [Upgrade A Cluster](https://kubernetes.io/docs/tasks/administer-cluster/cluster-upgrade/)
      - [ ] [Use Cascading Deletion in a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/use-cascading-deletion/)
      - [ ] [Using a KMS provider for data encryption](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/)
      - [ ] [Using CoreDNS for Service Discovery](https://kubernetes.io/docs/tasks/administer-cluster/coredns/)
      - [ ] [Using NodeLocal DNSCache in Kubernetes Clusters](https://kubernetes.io/docs/tasks/administer-cluster/nodelocaldns/)
      - [ ] [Using sysctls in a Kubernetes Cluster](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/)
      - [ ] [Verify Signed Kubernetes Artifacts](https://kubernetes.io/docs/tasks/administer-cluster/verify-signed-artifacts/)
    - [ ] [Configure Pods and Containers](https://kubernetes.io/docs/tasks/configure-pod-container/)
      - [ ] [Assign Memory Resources to Containers and Pods](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/)
      - [ ] [Assign CPU Resources to Containers and Pods](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/)
      - [ ] [Assign Devices to Pods and Containers](https://kubernetes.io/docs/tasks/configure-pod-container/assign-resources/)
        - [ ] [Set Up DRA in a Cluster](https://kubernetes.io/docs/tasks/configure-pod-container/assign-resources/set-up-dra-cluster/)
        - [ ] [Allocate Devices to Workloads with DRA](https://kubernetes.io/docs/tasks/configure-pod-container/assign-resources/allocate-devices-dra/)
        - [ ] [Access DRA Device Metadata](https://kubernetes.io/docs/tasks/configure-pod-container/assign-resources/access-dra-device-metadata/)
      - [ ] [Assign Pod-level CPU and memory resources](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pod-level-resources/)
      - [ ] [Configure GMSA for Windows Pods and containers](https://kubernetes.io/docs/tasks/configure-pod-container/configure-gmsa/)
      - [ ] [Resize CPU and Memory Resources assigned to Containers](https://kubernetes.io/docs/tasks/configure-pod-container/resize-container-resources/)
      - [ ] [Resize CPU and Memory Resources assigned to Pods](https://kubernetes.io/docs/tasks/configure-pod-container/resize-pod-resources/)
      - [ ] [Configure RunAsUserName for Windows pods and containers](https://kubernetes.io/docs/tasks/configure-pod-container/configure-runasusername/)
      - [ ] [Create a Windows HostProcess Pod](https://kubernetes.io/docs/tasks/configure-pod-container/create-hostprocess-pod/)
      - [ ] [Configure Quality of Service for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/)
      - [ ] [Assign Extended Resources to a Container](https://kubernetes.io/docs/tasks/configure-pod-container/extended-resource/)
      - [ ] [Configure a Pod to Use a Volume for Storage](https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/)
      - [ ] [Configure a Pod to Use a Projected Volume for Storage](https://kubernetes.io/docs/tasks/configure-pod-container/configure-projected-volume-storage/)
      - [ ] [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
      - [ ] [Configure Service Accounts for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)
      - [ ] [Pull an Image from a Private Registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)
      - [ ] [Configure Liveness, Readiness and Startup Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
      - [ ] [Assign Pods to Nodes](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/)
      - [ ] [Assign Pods to Nodes using Node Affinity](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/)
      - [ ] [Configure Pod Initialization](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-initialization/)
      - [ ] [Attach Handlers to Container Lifecycle Events](https://kubernetes.io/docs/tasks/configure-pod-container/attach-handler-lifecycle-event/)
      - [ ] [Configure a Pod to Use a ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)
      - [ ] [Share Process Namespace between Containers in a Pod](https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/)
      - [ ] [Use a User Namespace With a Pod](https://kubernetes.io/docs/tasks/configure-pod-container/user-namespaces/)
      - [ ] [Use an Image Volume With a Pod](https://kubernetes.io/docs/tasks/configure-pod-container/image-volumes/)
      - [ ] [Create static Pods](https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/)
      - [ ] [Translate a Docker Compose File to Kubernetes Resources](https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/)
      - [ ] [Enforce Pod Security Standards by Configuring the Built-in Admission Controller](https://kubernetes.io/docs/tasks/configure-pod-container/enforce-standards-admission-controller/)
      - [ ] [Enforce Pod Security Standards with Namespace Labels](https://kubernetes.io/docs/tasks/configure-pod-container/enforce-standards-namespace-labels/)
      - [ ] [Migrate from PodSecurityPolicy to the Built-In PodSecurity Admission Controller](https://kubernetes.io/docs/tasks/configure-pod-container/migrate-from-psp/)
    - [ ] [Monitoring, Logging, and Debugging](https://kubernetes.io/docs/tasks/debug/)
      - [ ] [Logging in Kubernetes](https://kubernetes.io/docs/tasks/debug/logging/)
      - [ ] [Monitoring in Kubernetes](https://kubernetes.io/docs/tasks/debug/monitoring/)
      - [ ] [Troubleshooting Applications](https://kubernetes.io/docs/tasks/debug/debug-application/)
        - [ ] [Debug Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/)
        - [ ] [Debug Services](https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/)
        - [ ] [Debug a StatefulSet](https://kubernetes.io/docs/tasks/debug/debug-application/debug-statefulset/)
        - [ ] [Determine the Reason for Pod Failure](https://kubernetes.io/docs/tasks/debug/debug-application/determine-reason-pod-failure/)
        - [ ] [Debug Init Containers](https://kubernetes.io/docs/tasks/debug/debug-application/debug-init-containers/)
        - [ ] [Debug Running Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)
        - [ ] [Get a Shell to a Running Container](https://kubernetes.io/docs/tasks/debug/debug-application/get-shell-running-container/)
      - [ ] [Troubleshooting Clusters](https://kubernetes.io/docs/tasks/debug/debug-cluster/)
        - [ ] [Troubleshooting kubectl](https://kubernetes.io/docs/tasks/debug/debug-cluster/troubleshoot-kubectl/)
        - [ ] [Resource metrics pipeline](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/)
        - [ ] [Tools for Monitoring Resources](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-usage-monitoring/)
        - [ ] [Monitor Node Health](https://kubernetes.io/docs/tasks/debug/debug-cluster/monitor-node-health/)
        - [ ] [Debugging Kubernetes nodes with crictl](https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/)
        - [ ] [Troubleshooting Topology Management](https://kubernetes.io/docs/tasks/debug/debug-cluster/topology/)
        - [ ] [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
        - [ ] [Debugging Kubernetes Nodes With Kubectl](https://kubernetes.io/docs/tasks/debug/debug-cluster/kubectl-node-debug/)
        - [ ] [Developing and debugging services locally using telepresence](https://kubernetes.io/docs/tasks/debug/debug-cluster/local-debugging/)
        - [ ] [Windows debugging tips](https://kubernetes.io/docs/tasks/debug/debug-cluster/windows/)
    - [ ] [Manage Kubernetes Objects](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/)
      - [ ] [Declarative Management of Kubernetes Objects Using Configuration Files](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/)
      - [ ] [Declarative Management of Kubernetes Objects Using Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/)
      - [ ] [Managing Kubernetes Objects Using Imperative Commands](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/imperative-command/)
      - [ ] [Imperative Management of Kubernetes Objects Using Configuration Files](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/imperative-config/)
      - [ ] [Update API Objects in Place Using kubectl patch](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/update-api-object-kubectl-patch/)
      - [ ] [Migrate Kubernetes Objects Using Storage Version Migration](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/storage-version-migration/)
    - [ ] [Managing Secrets](https://kubernetes.io/docs/tasks/configmap-secret/)
      - [ ] [Managing Secrets using kubectl](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/)
      - [ ] [Managing Secrets using Configuration File](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-config-file/)
      - [ ] [Managing Secrets using Kustomize](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kustomize/)
    - [ ] [Inject Data Into Applications](https://kubernetes.io/docs/tasks/inject-data-application/)
      - [ ] [Define a Command and Arguments for a Container](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/)
      - [ ] [Define Dependent Environment Variables](https://kubernetes.io/docs/tasks/inject-data-application/define-interdependent-environment-variables/)
      - [ ] [Define Environment Variables for a Container](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)
      - [ ] [Define Environment Variable Values Using An Init Container](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-via-file/)
      - [ ] [Expose Pod Information to Containers Through Environment Variables](https://kubernetes.io/docs/tasks/inject-data-application/environment-variable-expose-pod-information/)
      - [ ] [Expose Pod Information to Containers Through Files](https://kubernetes.io/docs/tasks/inject-data-application/downward-api-volume-expose-pod-information/)
      - [ ] [Distribute Credentials Securely Using Secrets](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)
    - [ ] [Run Applications](https://kubernetes.io/docs/tasks/run-application/)
      - [ ] [Run a Stateless Application Using a Deployment](https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/)
      - [ ] [Horizontal Manual Scaling for a Deployment](https://kubernetes.io/docs/tasks/run-application/scale-deployment/)
      - [ ] [Update a Deployment Without Downtime](https://kubernetes.io/docs/tasks/run-application/update-deployment-rolling/)
      - [ ] [Run a Single-Instance Stateful Application](https://kubernetes.io/docs/tasks/run-application/run-single-instance-stateful-application/)
      - [ ] [Run a Replicated Stateful Application](https://kubernetes.io/docs/tasks/run-application/run-replicated-stateful-application/)
      - [ ] [Scale a StatefulSet](https://kubernetes.io/docs/tasks/run-application/scale-stateful-set/)
      - [ ] [Delete a StatefulSet](https://kubernetes.io/docs/tasks/run-application/delete-stateful-set/)
      - [ ] [Force Delete StatefulSet Pods](https://kubernetes.io/docs/tasks/run-application/force-delete-stateful-set-pod/)
      - [ ] [HorizontalPodAutoscaler Walkthrough](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
      - [ ] [Specifying a Disruption Budget for your Application](https://kubernetes.io/docs/tasks/run-application/configure-pdb/)
      - [ ] [Accessing the Kubernetes API from a Pod](https://kubernetes.io/docs/tasks/run-application/access-api-from-pod/)
    - [ ] [Run Jobs](https://kubernetes.io/docs/tasks/job/)
      - [ ] [Running Automated Tasks with a CronJob](https://kubernetes.io/docs/tasks/job/automated-tasks-with-cron-jobs/)
      - [ ] [Coarse Parallel Processing Using a Work Queue](https://kubernetes.io/docs/tasks/job/coarse-parallel-processing-work-queue/)
      - [ ] [Fine Parallel Processing Using a Work Queue](https://kubernetes.io/docs/tasks/job/fine-parallel-processing-work-queue/)
      - [ ] [Indexed Job for Parallel Processing with Static Work Assignment](https://kubernetes.io/docs/tasks/job/indexed-parallel-processing-static/)
      - [ ] [Job with Pod-to-Pod Communication](https://kubernetes.io/docs/tasks/job/job-with-pod-to-pod-communication/)
      - [ ] [Parallel Processing using Expansions](https://kubernetes.io/docs/tasks/job/parallel-processing-expansion/)
      - [ ] [Handling retriable and non-retriable pod failures with Pod failure policy](https://kubernetes.io/docs/tasks/job/pod-failure-policy/)
    - [ ] [Access Applications in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/)
      - [ ] [Deploy and Access the Kubernetes Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
      - [ ] [Accessing Clusters](https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/)
      - [ ] [Configure Access to Multiple Clusters](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)
      - [ ] [Use Port Forwarding to Access Applications in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/)
      - [ ] [Use a Service to Access an Application in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/)
      - [ ] [Connect a Frontend to a Backend Using Services](https://kubernetes.io/docs/tasks/access-application-cluster/connecting-frontend-backend/)
      - [ ] [Create an External Load Balancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/)
      - [ ] [List All Container Images Running in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/list-all-running-container-images/)
      - [ ] [Communicate Between Containers in the Same Pod Using a Shared Volume](https://kubernetes.io/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/)
      - [ ] [Configure DNS for a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/configure-dns-cluster/)
      - [ ] [Access Services Running on Clusters](https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster-services/)
    - [ ] [Extend Kubernetes](https://kubernetes.io/docs/tasks/extend-kubernetes/)
      - [ ] [Configure the Aggregation Layer](https://kubernetes.io/docs/tasks/extend-kubernetes/configure-aggregation-layer/)
      - [ ] [Use Custom Resources](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/)
        - [ ] [Extend the Kubernetes API with CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/)
        - [ ] [Versions in CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definition-versioning/)
      - [ ] [Set up an Extension API Server](https://kubernetes.io/docs/tasks/extend-kubernetes/setup-extension-api-server/)
      - [ ] [Configure Multiple Schedulers](https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/)
      - [ ] [Use an HTTP Proxy to Access the Kubernetes API](https://kubernetes.io/docs/tasks/extend-kubernetes/http-proxy-access-api/)
      - [ ] [Use a SOCKS5 Proxy to Access the Kubernetes API](https://kubernetes.io/docs/tasks/extend-kubernetes/socks5-proxy-access-api/)
      - [ ] [Set up Konnectivity service](https://kubernetes.io/docs/tasks/extend-kubernetes/setup-konnectivity/)
    - [ ] [TLS](https://kubernetes.io/docs/tasks/tls/)
      - [ ] [Issue a Certificate for a Kubernetes API Client Using A CertificateSigningRequest](https://kubernetes.io/docs/tasks/tls/certificate-issue-client-csr/)
      - [ ] [Configure Certificate Rotation for the Kubelet](https://kubernetes.io/docs/tasks/tls/certificate-rotation/)
      - [ ] [Manage TLS Certificates in a Cluster](https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/)
      - [ ] [Manual Rotation of CA Certificates](https://kubernetes.io/docs/tasks/tls/manual-rotation-of-ca-certificates/)
    - [ ] [Manage Cluster Daemons](https://kubernetes.io/docs/tasks/manage-daemon/)
      - [ ] [Building a Basic DaemonSet](https://kubernetes.io/docs/tasks/manage-daemon/create-daemon-set/)
      - [ ] [Perform a Rolling Update on a DaemonSet](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/)
      - [ ] [Perform a Rollback on a DaemonSet](https://kubernetes.io/docs/tasks/manage-daemon/rollback-daemon-set/)
      - [ ] [Running Pods on Only Some Nodes](https://kubernetes.io/docs/tasks/manage-daemon/pods-some-nodes/)
    - [ ] [Networking](https://kubernetes.io/docs/tasks/network/)
      - [ ] [Adding entries to Pod /etc/hosts with HostAliases](https://kubernetes.io/docs/tasks/network/customize-hosts-file-for-pods/)
      - [ ] [Extend Service IP Ranges](https://kubernetes.io/docs/tasks/network/extend-service-ip-ranges/)
      - [ ] [Kubernetes Default ServiceCIDR Reconfiguration](https://kubernetes.io/docs/tasks/network/reconfigure-default-service-ip-ranges/)
      - [ ] [Validate IPv4/IPv6 dual-stack](https://kubernetes.io/docs/tasks/network/validate-dual-stack/)
    - [ ] [Extend kubectl with plugins](https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/)
    - [ ] [Manage HugePages](https://kubernetes.io/docs/tasks/manage-hugepages/scheduling-hugepages/)
    - [ ] [Schedule GPUs](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/)
  - [ ] [Tutorials](https://kubernetes.io/docs/tutorials/)
    - [ ] [Hello Minikube](https://kubernetes.io/docs/tutorials/hello-minikube/)
    - [ ] [Learn Kubernetes Basics](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
      - [ ] [Create a Cluster](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/)
        - [ ] [Using Minikube to Create a Cluster](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/)
      - [ ] [Deploy an App](https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/)
        - [ ] [Using kubectl to Create a Deployment](https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/)
      - [ ] [Explore Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/)
        - [ ] [Viewing Pods and Nodes](https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/)
      - [ ] [Expose Your App Publicly](https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/)
        - [ ] [Using a Service to Expose Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/)
      - [ ] [Scale Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/scale/)
        - [ ] [Running Multiple Instances of Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/scale/scale-intro/)
      - [ ] [Update Your App](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/)
        - [ ] [Performing a Rolling Update](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/)
    - [ ] [Configuration](https://kubernetes.io/docs/tutorials/configuration/)
      - [ ] [Updating Configuration via a ConfigMap](https://kubernetes.io/docs/tutorials/configuration/updating-configuration-via-a-configmap/)
      - [ ] [Configuring Redis using a ConfigMap](https://kubernetes.io/docs/tutorials/configuration/configure-redis-using-configmap/)
      - [ ] [Adopting Sidecar Containers](https://kubernetes.io/docs/tutorials/configuration/pod-sidecar-containers/)
      - [ ] [Configure a Pod to Use a PersistentVolume for Storage](https://kubernetes.io/docs/tutorials/configuration/configure-persistent-volume-storage/)
    - [ ] [Security](https://kubernetes.io/docs/tutorials/security/)
      - [ ] [Apply Pod Security Standards at the Cluster Level](https://kubernetes.io/docs/tutorials/security/cluster-level-pss/)
      - [ ] [Apply Pod Security Standards at the Namespace Level](https://kubernetes.io/docs/tutorials/security/ns-level-pss/)
      - [ ] [Restrict a Container's Access to Resources with AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)
      - [ ] [Restrict a Container's Syscalls with seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
    - [ ] [Stateless Applications](https://kubernetes.io/docs/tutorials/stateless-application/)
      - [ ] [Exposing an External IP Address to Access an Application in a Cluster](https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/)
      - [ ] [Example: Deploying PHP Guestbook application with Redis](https://kubernetes.io/docs/tutorials/stateless-application/guestbook/)
    - [ ] [Stateful Applications](https://kubernetes.io/docs/tutorials/stateful-application/)
      - [ ] [StatefulSet Basics](https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/)
      - [ ] [Example: Deploying WordPress and MySQL with Persistent Volumes](https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/)
      - [ ] [Example: Deploying Cassandra with a StatefulSet](https://kubernetes.io/docs/tutorials/stateful-application/cassandra/)
      - [ ] [Running ZooKeeper, A Distributed System Coordinator](https://kubernetes.io/docs/tutorials/stateful-application/zookeeper/)
    - [ ] [Cluster Management](https://kubernetes.io/docs/tutorials/cluster-management/)
      - [ ] [Running Kubelet in Standalone Mode](https://kubernetes.io/docs/tutorials/cluster-management/kubelet-standalone/)
      - [ ] [Configuring swap memory on Kubernetes nodes](https://kubernetes.io/docs/tutorials/cluster-management/provision-swap-memory/)
      - [ ] [Install Drivers and Allocate Devices with DRA](https://kubernetes.io/docs/tutorials/cluster-management/install-use-dra/)
      - [ ] [Namespaces Walkthrough](https://kubernetes.io/docs/tutorials/cluster-management/namespaces-walkthrough/)
    - [ ] [Services](https://kubernetes.io/docs/tutorials/services/)
      - [ ] [Connecting Applications with Services](https://kubernetes.io/docs/tutorials/services/connect-applications-service/)
      - [ ] [Using Source IP](https://kubernetes.io/docs/tutorials/services/source-ip/)
      - [ ] [Explore Termination Behavior for Pods And Their Endpoints](https://kubernetes.io/docs/tutorials/services/pods-and-endpoint-termination-flow/)
  - [ ] [Reference](https://kubernetes.io/docs/reference/)
    - [ ] [Glossary](https://kubernetes.io/docs/reference/glossary/)
    - [ ] [API Overview](https://kubernetes.io/docs/reference/using-api/)
      - [ ] [Declarative API Validation](https://kubernetes.io/docs/reference/using-api/declarative-validation/)
      - [ ] [Kubernetes API Concepts](https://kubernetes.io/docs/reference/using-api/api-concepts/)
      - [ ] [Server-Side Apply](https://kubernetes.io/docs/reference/using-api/server-side-apply/)
      - [ ] [Client Libraries](https://kubernetes.io/docs/reference/using-api/client-libraries/)
      - [ ] [Common Expression Language in Kubernetes](https://kubernetes.io/docs/reference/using-api/cel/)
      - [ ] [Kubernetes Deprecation Policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/)
      - [ ] [Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/)
      - [ ] [Kubernetes API health endpoints](https://kubernetes.io/docs/reference/using-api/health-checks/)
    - [ ] [API Access Control](https://kubernetes.io/docs/reference/access-authn-authz/)
      - [ ] [Authenticating](https://kubernetes.io/docs/reference/access-authn-authz/authentication/)
      - [ ] [Authenticating with Bootstrap Tokens](https://kubernetes.io/docs/reference/access-authn-authz/bootstrap-tokens/)
      - [ ] [Authorization](https://kubernetes.io/docs/reference/access-authn-authz/authorization/)
      - [ ] [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
      - [ ] [Using Node Authorization](https://kubernetes.io/docs/reference/access-authn-authz/node/)
      - [ ] [Webhook Mode](https://kubernetes.io/docs/reference/access-authn-authz/webhook/)
      - [ ] [Using ABAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/abac/)
      - [ ] [Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/ "Admission Control in Kubernetes")
      - [ ] [Dynamic Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/)
      - [ ] [Managing Service Accounts](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)
      - [ ] [User Impersonation](https://kubernetes.io/docs/reference/access-authn-authz/user-impersonation/)
      - [ ] [Certificates and Certificate Signing Requests](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/)
      - [ ] [Mapping PodSecurityPolicies to Pod Security Standards](https://kubernetes.io/docs/reference/access-authn-authz/psp-to-pod-security-standards/)
      - [ ] [Kubelet authentication/authorization](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-authn-authz/)
      - [ ] [TLS bootstrapping](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/)
      - [ ] [Manifest-Based Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/manifest-admission-control/)
      - [ ] [Mutating Admission Policy](https://kubernetes.io/docs/reference/access-authn-authz/mutating-admission-policy/)
      - [ ] [Validating Admission Policy](https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/)
    - [ ] [Well-Known Labels, Annotations and Taints](https://kubernetes.io/docs/reference/labels-annotations-taints/)
      - [ ] [Audit Annotations](https://kubernetes.io/docs/reference/labels-annotations-taints/audit-annotations/)
    - [ ] [Kubernetes API](https://kubernetes.io/docs/reference/kubernetes-api/)
      - [ ] [API Groups](https://kubernetes.io/docs/reference/kubernetes-api/group-versions/)
      - [ ] [Admissionregistration](https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/)
        - [ ] [MutatingAdmissionPolicy](https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/mutating-admission-policy-v1/)
        - [ ] [MutatingAdmissionPolicyBinding](https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/mutating-admission-policy-binding-v1/)
        - [ ] [MutatingWebhookConfiguration](https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/mutating-webhook-configuration-v1/)
        - [ ] [ValidatingAdmissionPolicy](https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/validating-admission-policy-v1/)
        - [ ] [ValidatingAdmissionPolicyBinding](https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/validating-admission-policy-binding-v1/)
        - [ ] [ValidatingWebhookConfiguration](https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/validating-webhook-configuration-v1/)
      - [ ] [Apiextensions](https://kubernetes.io/docs/reference/kubernetes-api/apiextensions/)
        - [ ] [CustomResourceDefinition](https://kubernetes.io/docs/reference/kubernetes-api/apiextensions/custom-resource-definition-v1/)
      - [ ] [Apiregistration](https://kubernetes.io/docs/reference/kubernetes-api/apiregistration/)
        - [ ] [APIService](https://kubernetes.io/docs/reference/kubernetes-api/apiregistration/api-service-v1/)
      - [ ] [Apiserverinternal](https://kubernetes.io/docs/reference/kubernetes-api/apiserverinternal/)
        - [ ] [StorageVersion](https://kubernetes.io/docs/reference/kubernetes-api/apiserverinternal/storage-version-v1alpha1/)
      - [ ] [Apps](https://kubernetes.io/docs/reference/kubernetes-api/apps/)
        - [ ] [ControllerRevision](https://kubernetes.io/docs/reference/kubernetes-api/apps/controller-revision-v1/)
        - [ ] [DaemonSet](https://kubernetes.io/docs/reference/kubernetes-api/apps/daemon-set-v1/)
        - [ ] [Deployment](https://kubernetes.io/docs/reference/kubernetes-api/apps/deployment-v1/)
        - [ ] [ReplicaSet](https://kubernetes.io/docs/reference/kubernetes-api/apps/replica-set-v1/)
        - [ ] [StatefulSet](https://kubernetes.io/docs/reference/kubernetes-api/apps/stateful-set-v1/)
      - [ ] [Autoscaling](https://kubernetes.io/docs/reference/kubernetes-api/autoscaling/)
        - [ ] [HorizontalPodAutoscaler](https://kubernetes.io/docs/reference/kubernetes-api/autoscaling/horizontal-pod-autoscaler-v2/)
      - [ ] [Batch](https://kubernetes.io/docs/reference/kubernetes-api/batch/)
        - [ ] [CronJob](https://kubernetes.io/docs/reference/kubernetes-api/batch/cron-job-v1/)
        - [ ] [Job](https://kubernetes.io/docs/reference/kubernetes-api/batch/job-v1/)
      - [ ] [Certificates](https://kubernetes.io/docs/reference/kubernetes-api/certificates/)
        - [ ] [CertificateSigningRequest](https://kubernetes.io/docs/reference/kubernetes-api/certificates/certificate-signing-request-v1/)
        - [ ] [ClusterTrustBundle](https://kubernetes.io/docs/reference/kubernetes-api/certificates/cluster-trust-bundle-v1beta1/)
        - [ ] [PodCertificateRequest](https://kubernetes.io/docs/reference/kubernetes-api/certificates/pod-certificate-request-v1beta1/)
      - [ ] [Coordination](https://kubernetes.io/docs/reference/kubernetes-api/coordination/)
        - [ ] [Lease](https://kubernetes.io/docs/reference/kubernetes-api/coordination/lease-v1/)
        - [ ] [LeaseCandidate](https://kubernetes.io/docs/reference/kubernetes-api/coordination/lease-candidate-v1beta1/)
      - [ ] [Events](https://kubernetes.io/docs/reference/kubernetes-api/events/)
        - [ ] [Event](https://kubernetes.io/docs/reference/kubernetes-api/events/event-v1/)
      - [ ] [Core](https://kubernetes.io/docs/reference/kubernetes-api/core/)
        - [ ] [ComponentStatus](https://kubernetes.io/docs/reference/kubernetes-api/core/component-status-v1/)
        - [ ] [ConfigMap](https://kubernetes.io/docs/reference/kubernetes-api/core/config-map-v1/)
        - [ ] [Endpoints](https://kubernetes.io/docs/reference/kubernetes-api/core/endpoints-v1/)
        - [ ] [Event](https://kubernetes.io/docs/reference/kubernetes-api/core/event-v1/)
        - [ ] [LimitRange](https://kubernetes.io/docs/reference/kubernetes-api/core/limit-range-v1/)
        - [ ] [Namespace](https://kubernetes.io/docs/reference/kubernetes-api/core/namespace-v1/)
        - [ ] [Node](https://kubernetes.io/docs/reference/kubernetes-api/core/node-v1/)
        - [ ] [PersistentVolume](https://kubernetes.io/docs/reference/kubernetes-api/core/persistent-volume-v1/)
        - [ ] [PersistentVolumeClaim](https://kubernetes.io/docs/reference/kubernetes-api/core/persistent-volume-claim-v1/)
        - [ ] [Pod](https://kubernetes.io/docs/reference/kubernetes-api/core/pod-v1/)
        - [ ] [PodTemplate](https://kubernetes.io/docs/reference/kubernetes-api/core/pod-template-v1/)
        - [ ] [ReplicationController](https://kubernetes.io/docs/reference/kubernetes-api/core/replication-controller-v1/)
        - [ ] [ResourceQuota](https://kubernetes.io/docs/reference/kubernetes-api/core/resource-quota-v1/)
        - [ ] [Secret](https://kubernetes.io/docs/reference/kubernetes-api/core/secret-v1/)
        - [ ] [Service](https://kubernetes.io/docs/reference/kubernetes-api/core/service-v1/)
        - [ ] [ServiceAccount](https://kubernetes.io/docs/reference/kubernetes-api/core/service-account-v1/)
      - [ ] [Discovery](https://kubernetes.io/docs/reference/kubernetes-api/discovery/)
        - [ ] [EndpointSlice](https://kubernetes.io/docs/reference/kubernetes-api/discovery/endpoint-slice-v1/)
      - [ ] [Flowcontrol](https://kubernetes.io/docs/reference/kubernetes-api/flowcontrol/)
        - [ ] [FlowSchema](https://kubernetes.io/docs/reference/kubernetes-api/flowcontrol/flow-schema-v1/)
        - [ ] [PriorityLevelConfiguration](https://kubernetes.io/docs/reference/kubernetes-api/flowcontrol/priority-level-configuration-v1/)
      - [ ] [Networking](https://kubernetes.io/docs/reference/kubernetes-api/networking/)
        - [ ] [IPAddress](https://kubernetes.io/docs/reference/kubernetes-api/networking/ip-address-v1/)
        - [ ] [Ingress](https://kubernetes.io/docs/reference/kubernetes-api/networking/ingress-v1/)
        - [ ] [IngressClass](https://kubernetes.io/docs/reference/kubernetes-api/networking/ingress-class-v1/)
        - [ ] [NetworkPolicy](https://kubernetes.io/docs/reference/kubernetes-api/networking/network-policy-v1/)
        - [ ] [ServiceCIDR](https://kubernetes.io/docs/reference/kubernetes-api/networking/service-cidr-v1/)
      - [ ] [Node](https://kubernetes.io/docs/reference/kubernetes-api/node/)
        - [ ] [RuntimeClass](https://kubernetes.io/docs/reference/kubernetes-api/node/runtime-class-v1/)
      - [ ] [Policy](https://kubernetes.io/docs/reference/kubernetes-api/policy/)
        - [ ] [PodDisruptionBudget](https://kubernetes.io/docs/reference/kubernetes-api/policy/pod-disruption-budget-v1/)
      - [ ] [Rbac](https://kubernetes.io/docs/reference/kubernetes-api/rbac/)
        - [ ] [ClusterRole](https://kubernetes.io/docs/reference/kubernetes-api/rbac/cluster-role-v1/)
        - [ ] [ClusterRoleBinding](https://kubernetes.io/docs/reference/kubernetes-api/rbac/cluster-role-binding-v1/)
        - [ ] [Role](https://kubernetes.io/docs/reference/kubernetes-api/rbac/role-v1/)
        - [ ] [RoleBinding](https://kubernetes.io/docs/reference/kubernetes-api/rbac/role-binding-v1/)
      - [ ] [Resource](https://kubernetes.io/docs/reference/kubernetes-api/resource/)
        - [ ] [DeviceClass](https://kubernetes.io/docs/reference/kubernetes-api/resource/device-class-v1/)
        - [ ] [DeviceTaintRule](https://kubernetes.io/docs/reference/kubernetes-api/resource/device-taint-rule-v1beta2/)
        - [ ] [ResourceClaim](https://kubernetes.io/docs/reference/kubernetes-api/resource/resource-claim-v1/)
        - [ ] [ResourceClaimTemplate](https://kubernetes.io/docs/reference/kubernetes-api/resource/resource-claim-template-v1/)
        - [ ] [ResourcePoolStatusRequest](https://kubernetes.io/docs/reference/kubernetes-api/resource/resource-pool-status-request-v1alpha3/)
        - [ ] [ResourceSlice](https://kubernetes.io/docs/reference/kubernetes-api/resource/resource-slice-v1/)
      - [ ] [Scheduling](https://kubernetes.io/docs/reference/kubernetes-api/scheduling/)
        - [ ] [PodGroup](https://kubernetes.io/docs/reference/kubernetes-api/scheduling/pod-group-v1alpha2/)
        - [ ] [PriorityClass](https://kubernetes.io/docs/reference/kubernetes-api/scheduling/priority-class-v1/)
        - [ ] [Workload](https://kubernetes.io/docs/reference/kubernetes-api/scheduling/workload-v1alpha2/)
      - [ ] [Storage](https://kubernetes.io/docs/reference/kubernetes-api/storage/)
        - [ ] [CSIDriver](https://kubernetes.io/docs/reference/kubernetes-api/storage/csi-driver-v1/)
        - [ ] [CSINode](https://kubernetes.io/docs/reference/kubernetes-api/storage/csi-node-v1/)
        - [ ] [CSIStorageCapacity](https://kubernetes.io/docs/reference/kubernetes-api/storage/csi-storage-capacity-v1/)
        - [ ] [StorageClass](https://kubernetes.io/docs/reference/kubernetes-api/storage/storage-class-v1/)
        - [ ] [VolumeAttachment](https://kubernetes.io/docs/reference/kubernetes-api/storage/volume-attachment-v1/)
        - [ ] [VolumeAttributesClass](https://kubernetes.io/docs/reference/kubernetes-api/storage/volume-attributes-class-v1/)
      - [ ] [Storagemigration](https://kubernetes.io/docs/reference/kubernetes-api/storagemigration/)
        - [ ] [StorageVersionMigration](https://kubernetes.io/docs/reference/kubernetes-api/storagemigration/storage-version-migration-v1beta1/)
    - [ ] [Instrumentation](https://kubernetes.io/docs/reference/instrumentation/)
      - [ ] [Service Level Indicator Metrics](https://kubernetes.io/docs/reference/instrumentation/slis/ "Kubernetes Component SLI Metrics")
      - [ ] [CRI Pod & Container Metrics](https://kubernetes.io/docs/reference/instrumentation/cri-pod-container-metrics/)
      - [ ] [Native Histograms](https://kubernetes.io/docs/reference/instrumentation/native-histograms/ "Native Histogram Support for Kubernetes Metrics")
      - [ ] [Node metrics data](https://kubernetes.io/docs/reference/instrumentation/node-metrics/)
      - [ ] [Understand Pressure Stall Information (PSI) Metrics](https://kubernetes.io/docs/reference/instrumentation/understand-psi-metrics/)
      - [ ] [Kubernetes z-pages](https://kubernetes.io/docs/reference/instrumentation/zpages/)
      - [ ] [Kubernetes Metrics Reference](https://kubernetes.io/docs/reference/instrumentation/metrics/)
    - [ ] [Kubernetes Issues and Security](https://kubernetes.io/docs/reference/issues-security/)
      - [ ] [Kubernetes Issue Tracker](https://kubernetes.io/docs/reference/issues-security/issues/)
      - [ ] [Kubernetes Security and Disclosure Information](https://kubernetes.io/docs/reference/issues-security/security/)
      - [ ] [CVE feed](https://kubernetes.io/docs/reference/issues-security/official-cve-feed/ "Official CVE Feed")
    - [ ] [Node Reference Information](https://kubernetes.io/docs/reference/node/)
      - [ ] [Kubelet Checkpoint API](https://kubernetes.io/docs/reference/node/kubelet-checkpoint-api/)
      - [ ] [Linux Kernel Version Requirements](https://kubernetes.io/docs/reference/node/kernel-version-requirements/)
      - [ ] [Articles on dockershim Removal and on Using CRI-compatible Runtimes](https://kubernetes.io/docs/reference/node/topics-on-dockershim-and-cri-compatible-runtimes/)
      - [ ] [Kubelet Pod Info gRPC API](https://kubernetes.io/docs/reference/node/kubelet-pod-info-grpc-api/)
      - [ ] [Node Labels Populated By The Kubelet](https://kubernetes.io/docs/reference/node/node-labels/)
      - [ ] [Kubelet Sync Loop](https://kubernetes.io/docs/reference/node/kubelet-sync-loop/)
      - [ ] [Local Files And Paths Used By The Kubelet](https://kubernetes.io/docs/reference/node/kubelet-files/)
      - [ ] [Kubelet Configuration Directory Merging](https://kubernetes.io/docs/reference/node/kubelet-config-directory-merging/)
      - [ ] [Kubelet Device Manager API Versions](https://kubernetes.io/docs/reference/node/device-plugin-api-versions/)
      - [ ] [Kubelet Systemd Watchdog](https://kubernetes.io/docs/reference/node/systemd-watchdog/)
      - [ ] [Node Status](https://kubernetes.io/docs/reference/node/node-status/)
      - [ ] [Seccomp and Kubernetes](https://kubernetes.io/docs/reference/node/seccomp/)
      - [ ] [Linux Node Swap Behaviors](https://kubernetes.io/docs/reference/node/swap-behavior/)
    - [ ] [Networking Reference](https://kubernetes.io/docs/reference/networking/)
      - [ ] [Protocols for Services](https://kubernetes.io/docs/reference/networking/service-protocols/)
      - [ ] [Ports and Protocols](https://kubernetes.io/docs/reference/networking/ports-and-protocols/)
      - [ ] [Virtual IPs and Service Proxies](https://kubernetes.io/docs/reference/networking/virtual-ips/)
    - [ ] [Setup tools](https://kubernetes.io/docs/reference/setup-tools/)
      - [ ] [Kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/)
        - [ ] [kubeadm init](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/)
        - [ ] [kubeadm join](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-join/)
        - [ ] [kubeadm upgrade](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/)
        - [ ] [kubeadm upgrade phases](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade-phase/)
        - [ ] [kubeadm config](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-config/)
        - [ ] [kubeadm reset](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-reset/)
        - [ ] [kubeadm token](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-token/)
        - [ ] [kubeadm version](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-version/)
        - [ ] [kubeadm alpha](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-alpha/)
        - [ ] [kubeadm certs](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-certs/)
        - [ ] [kubeadm init phase](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init-phase/)
        - [ ] [kubeadm join phase](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-join-phase/)
        - [ ] [kubeadm kubeconfig](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-kubeconfig/)
        - [ ] [kubeadm reset phase](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-reset-phase/)
        - [ ] [Implementation details](https://kubernetes.io/docs/reference/setup-tools/kubeadm/implementation-details/)
    - [ ] [Command line tool (kubectl)](https://kubernetes.io/docs/reference/kubectl/)
      - [ ] [Introduction to kubectl](https://kubernetes.io/docs/reference/kubectl/introduction/)
      - [ ] [kubectl Quick Reference](https://kubernetes.io/docs/reference/kubectl/quick-reference/)
      - [ ] [kubectl reference](https://kubernetes.io/docs/reference/kubectl/generated/)
        - [ ] [kubectl](https://kubernetes.io/docs/reference/kubectl/generated/kubectl/)
        - [ ] [kubectl annotate](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_annotate/)
        - [ ] [kubectl api-resources](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_api-resources/)
        - [ ] [kubectl api-versions](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_api-versions/)
        - [ ] [kubectl apply](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/)
          - [ ] [kubectl apply edit-last-applied](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/kubectl_apply_edit-last-applied/)
          - [ ] [kubectl apply set-last-applied](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/kubectl_apply_set-last-applied/)
          - [ ] [kubectl apply view-last-applied](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_apply/kubectl_apply_view-last-applied/)
        - [ ] [kubectl attach](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_attach/)
        - [ ] [kubectl auth](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_auth/)
          - [ ] [kubectl auth can-i](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_auth/kubectl_auth_can-i/)
          - [ ] [kubectl auth reconcile](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_auth/kubectl_auth_reconcile/)
          - [ ] [kubectl auth whoami](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_auth/kubectl_auth_whoami/)
        - [ ] [kubectl autoscale](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_autoscale/)
        - [ ] [kubectl certificate](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_certificate/)
          - [ ] [kubectl certificate approve](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_certificate/kubectl_certificate_approve/)
          - [ ] [kubectl certificate deny](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_certificate/kubectl_certificate_deny/)
        - [ ] [kubectl cluster-info](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_cluster-info/)
          - [ ] [kubectl cluster-info dump](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_cluster-info/kubectl_cluster-info_dump/)
        - [ ] [kubectl completion](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion/)
        - [ ] [kubectl config](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/)
          - [ ] [kubectl config current-context](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_current-context/)
          - [ ] [kubectl config delete-cluster](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_delete-cluster/)
          - [ ] [kubectl config delete-context](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_delete-context/)
          - [ ] [kubectl config delete-user](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_delete-user/)
          - [ ] [kubectl config get-clusters](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_get-clusters/)
          - [ ] [kubectl config get-contexts](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_get-contexts/)
          - [ ] [kubectl config get-users](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_get-users/)
          - [ ] [kubectl config rename-context](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_rename-context/)
          - [ ] [kubectl config set](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_set/)
          - [ ] [kubectl config set-cluster](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_set-cluster/)
          - [ ] [kubectl config set-context](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_set-context/)
          - [ ] [kubectl config set-credentials](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_set-credentials/)
          - [ ] [kubectl config unset](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_unset/)
          - [ ] [kubectl config use-context](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_use-context/)
          - [ ] [kubectl config view](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_view/)
        - [ ] [kubectl cordon](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_cordon/)
        - [ ] [kubectl cp](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_cp/)
        - [ ] [kubectl create](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/)
          - [ ] [kubectl create clusterrole](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_clusterrole/)
          - [ ] [kubectl create clusterrolebinding](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_clusterrolebinding/)
          - [ ] [kubectl create configmap](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_configmap/)
          - [ ] [kubectl create cronjob](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_cronjob/)
          - [ ] [kubectl create deployment](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_deployment/)
          - [ ] [kubectl create ingress](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_ingress/)
          - [ ] [kubectl create job](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_job/)
          - [ ] [kubectl create namespace](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_namespace/)
          - [ ] [kubectl create poddisruptionbudget](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_poddisruptionbudget/)
          - [ ] [kubectl create priorityclass](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_priorityclass/)
          - [ ] [kubectl create quota](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_quota/)
          - [ ] [kubectl create role](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_role/)
          - [ ] [kubectl create rolebinding](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_rolebinding/)
          - [ ] [kubectl create secret](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_secret/)
          - [ ] [kubectl create secret docker-registry](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_secret_docker-registry/)
          - [ ] [kubectl create secret generic](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_secret_generic/)
          - [ ] [kubectl create secret tls](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_secret_tls/)
          - [ ] [kubectl create service](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_service/)
          - [ ] [kubectl create service clusterip](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_service_clusterip/)
          - [ ] [kubectl create service externalname](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_service_externalname/)
          - [ ] [kubectl create service loadbalancer](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_service_loadbalancer/)
          - [ ] [kubectl create service nodeport](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_service_nodeport/)
          - [ ] [kubectl create serviceaccount](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_serviceaccount/)
          - [ ] [kubectl create token](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_token/)
        - [ ] [kubectl debug](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_debug/)
        - [ ] [kubectl delete](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_delete/)
        - [ ] [kubectl describe](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_describe/)
        - [ ] [kubectl diff](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_diff/)
        - [ ] [kubectl drain](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_drain/)
        - [ ] [kubectl edit](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_edit/)
        - [ ] [kubectl events](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_events/)
        - [ ] [kubectl exec](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_exec/)
        - [ ] [kubectl explain](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_explain/)
        - [ ] [kubectl expose](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_expose/)
        - [ ] [kubectl get](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_get/)
        - [ ] [kubectl kuberc](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_kuberc/)
          - [ ] [kubectl kuberc set](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_kuberc/kubectl_kuberc_set/)
          - [ ] [kubectl kuberc view](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_kuberc/kubectl_kuberc_view/)
        - [ ] [kubectl kustomize](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_kustomize/)
        - [ ] [kubectl label](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_label/)
        - [ ] [kubectl logs](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_logs/)
        - [ ] [kubectl options](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_options/)
        - [ ] [kubectl patch](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_patch/)
        - [ ] [kubectl plugin](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_plugin/)
          - [ ] [kubectl plugin list](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_plugin/kubectl_plugin_list/)
        - [ ] [kubectl port-forward](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_port-forward/)
        - [ ] [kubectl proxy](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_proxy/)
        - [ ] [kubectl replace](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_replace/)
        - [ ] [kubectl rollout](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/)
          - [ ] [kubectl rollout history](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_history/)
          - [ ] [kubectl rollout pause](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_pause/)
          - [ ] [kubectl rollout restart](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_restart/)
          - [ ] [kubectl rollout resume](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_resume/)
          - [ ] [kubectl rollout status](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_status/)
          - [ ] [kubectl rollout undo](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_undo/)
        - [ ] [kubectl run](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_run/)
        - [ ] [kubectl scale](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_scale/)
        - [ ] [kubectl set](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/)
          - [ ] [kubectl set env](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/kubectl_set_env/)
          - [ ] [kubectl set image](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/kubectl_set_image/)
          - [ ] [kubectl set resources](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/kubectl_set_resources/)
          - [ ] [kubectl set selector](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/kubectl_set_selector/)
          - [ ] [kubectl set serviceaccount](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/kubectl_set_serviceaccount/)
          - [ ] [kubectl set subject](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/kubectl_set_subject/)
        - [ ] [kubectl taint](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_taint/)
        - [ ] [kubectl top](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_top/)
          - [ ] [kubectl top node](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_top/kubectl_top_node/)
          - [ ] [kubectl top pod](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_top/kubectl_top_pod/)
        - [ ] [kubectl uncordon](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_uncordon/)
        - [ ] [kubectl version](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_version/)
        - [ ] [kubectl wait](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_wait/)
      - [ ] [kubectl Commands](https://kubernetes.io/docs/reference/kubectl/kubectl-cmds/)
      - [ ] [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)
      - [ ] [JSONPath Support](https://kubernetes.io/docs/reference/kubectl/jsonpath/)
      - [ ] [kubectl for Docker Users](https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/)
      - [ ] [kubectl Usage Conventions](https://kubernetes.io/docs/reference/kubectl/conventions/)
      - [ ] [Kubectl user preferences (kuberc)](https://kubernetes.io/docs/reference/kubectl/kuberc/)
    - [ ] [Encodings](https://kubernetes.io/docs/reference/encodings/)
      - [ ] [KYAML Reference](https://kubernetes.io/docs/reference/encodings/kyaml/)
    - [ ] [Component tools](https://kubernetes.io/docs/reference/command-line-tools-reference/)
      - [ ] [Feature Gates](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/)
      - [ ] [Feature Gates (removed)](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates-removed/)
      - [ ] [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/)
      - [ ] [kube-controller-manager](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/)
      - [ ] [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)
      - [ ] [kube-scheduler](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/)
      - [ ] [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
    - [ ] [Debug cluster](https://kubernetes.io/docs/reference/debug-cluster/)
      - [ ] [Flow control](https://kubernetes.io/docs/reference/debug-cluster/flow-control/)
    - [ ] [Configuration APIs](https://kubernetes.io/docs/reference/config-api/)
      - [ ] [Client Authentication (v1)](https://kubernetes.io/docs/reference/config-api/client-authentication.v1/)
      - [ ] [Client Authentication (v1beta1)](https://kubernetes.io/docs/reference/config-api/client-authentication.v1beta1/)
      - [ ] [Event Rate Limit Configuration (v1alpha1)](https://kubernetes.io/docs/reference/config-api/apiserver-eventratelimit.v1alpha1/)
      - [ ] [Image Policy API (v1alpha1)](https://kubernetes.io/docs/reference/config-api/imagepolicy.v1alpha1/)
      - [ ] [kube-apiserver Admission (v1)](https://kubernetes.io/docs/reference/config-api/apiserver-admission.v1/)
      - [ ] [kube-apiserver Audit Configuration (v1)](https://kubernetes.io/docs/reference/config-api/apiserver-audit.v1/)
      - [ ] [kube-apiserver Configuration (v1)](https://kubernetes.io/docs/reference/config-api/apiserver-config.v1/)
      - [ ] [kube-apiserver Configuration (v1alpha1)](https://kubernetes.io/docs/reference/config-api/apiserver-config.v1alpha1/)
      - [ ] [kube-apiserver Configuration (v1beta1)](https://kubernetes.io/docs/reference/config-api/apiserver-config.v1beta1/)
      - [ ] [kube-controller-manager Configuration (v1alpha1)](https://kubernetes.io/docs/reference/config-api/kube-controller-manager-config.v1alpha1/)
      - [ ] [kube-proxy Configuration (v1alpha1)](https://kubernetes.io/docs/reference/config-api/kube-proxy-config.v1alpha1/)
      - [ ] [kube-scheduler Configuration (v1)](https://kubernetes.io/docs/reference/config-api/kube-scheduler-config.v1/)
      - [ ] [kubeadm Configuration (v1beta3)](https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta3/)
      - [ ] [kubeadm Configuration (v1beta4)](https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/)
      - [ ] [kubeconfig (v1)](https://kubernetes.io/docs/reference/config-api/kubeconfig.v1/)
      - [ ] [Kubelet Configuration (v1)](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1/)
      - [ ] [Kubelet Configuration (v1alpha1)](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1alpha1/)
      - [ ] [Kubelet Configuration (v1beta1)](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/)
      - [ ] [Kubelet CredentialProvider (v1)](https://kubernetes.io/docs/reference/config-api/kubelet-credentialprovider.v1/)
      - [ ] [kuberc (v1alpha1)](https://kubernetes.io/docs/reference/config-api/kuberc.v1alpha1/)
      - [ ] [kuberc (v1beta1)](https://kubernetes.io/docs/reference/config-api/kuberc.v1beta1/)
      - [ ] [WebhookAdmission Configuration (v1)](https://kubernetes.io/docs/reference/config-api/apiserver-webhookadmission.v1/)
    - [ ] [External APIs](https://kubernetes.io/docs/reference/external-api/)
      - [ ] [Kubernetes Custom Metrics (v1beta2)](https://kubernetes.io/docs/reference/external-api/custom-metrics.v1beta2/)
      - [ ] [Kubernetes External Metrics (v1beta1)](https://kubernetes.io/docs/reference/external-api/external-metrics.v1beta1/)
      - [ ] [Kubernetes Metrics (v1beta1)](https://kubernetes.io/docs/reference/external-api/metrics.v1beta1/)
    - [ ] [Scheduling](https://kubernetes.io/docs/reference/scheduling/)
      - [ ] [Scheduler Configuration](https://kubernetes.io/docs/reference/scheduling/config/)
      - [ ] [Scheduling Policies](https://kubernetes.io/docs/reference/scheduling/policies/)
    - [ ] [Other Tools](https://kubernetes.io/docs/reference/tools/)
  - [ ] [Contribute](https://kubernetes.io/docs/contribute/ "Contribute to Kubernetes")
    - [ ] [Contribute to Kubernetes Documentation](https://kubernetes.io/docs/contribute/docs/)
    - [ ] [Contributing to Kubernetes blogs](https://kubernetes.io/docs/contribute/blog/)
      - [ ] [Submitting articles to Kubernetes blogs](https://kubernetes.io/docs/contribute/blog/article-submission/)
      - [ ] [Blog guidelines](https://kubernetes.io/docs/contribute/blog/guidelines/)
      - [ ] [Blog article mirroring](https://kubernetes.io/docs/contribute/blog/article-mirroring/)
      - [ ] [Post-release communications](https://kubernetes.io/docs/contribute/blog/release-comms/)
      - [ ] [Helping as a blog writing buddy](https://kubernetes.io/docs/contribute/blog/writing-buddy/)
    - [ ] [Suggesting content improvements](https://kubernetes.io/docs/contribute/suggesting-improvements/)
    - [ ] [Contributing new content](https://kubernetes.io/docs/contribute/new-content/)
      - [ ] [Opening a pull request](https://kubernetes.io/docs/contribute/new-content/open-a-pr/)
      - [ ] [Previewing locally](https://kubernetes.io/docs/contribute/new-content/preview-locally/)
      - [ ] [Documenting for a release](https://kubernetes.io/docs/contribute/new-content/new-features/ "Documenting a feature for a release")
      - [ ] [Case studies](https://kubernetes.io/docs/contribute/new-content/case-studies/ "Submitting case studies")
    - [ ] [Reviewing changes](https://kubernetes.io/docs/contribute/review/)
      - [ ] [Reviewing pull requests](https://kubernetes.io/docs/contribute/review/reviewing-prs/)
      - [ ] [For approvers and reviewers](https://kubernetes.io/docs/contribute/review/for-approvers/ "Reviewing for approvers and reviewers")
    - [ ] [Localizing Kubernetes documentation](https://kubernetes.io/docs/contribute/localization/)
    - [ ] [Participating in SIG Docs](https://kubernetes.io/docs/contribute/participate/)
      - [ ] [Roles and responsibilities](https://kubernetes.io/docs/contribute/participate/roles-and-responsibilities/)
      - [ ] [Issue Wranglers](https://kubernetes.io/docs/contribute/participate/issue-wrangler/)
      - [ ] [PR wranglers](https://kubernetes.io/docs/contribute/participate/pr-wranglers/)
    - [ ] [Documentation style overview](https://kubernetes.io/docs/contribute/style/)
      - [ ] [Content guide](https://kubernetes.io/docs/contribute/style/content-guide/ "Documentation Content Guide")
      - [ ] [Style guide](https://kubernetes.io/docs/contribute/style/style-guide/ "Documentation Style Guide")
      - [ ] [Diagram guide](https://kubernetes.io/docs/contribute/style/diagram-guide/ "Diagram Guide")
      - [ ] [Writing a new topic](https://kubernetes.io/docs/contribute/style/write-new-topic/)
      - [ ] [Page content types](https://kubernetes.io/docs/contribute/style/page-content-types/)
      - [ ] [Content organization](https://kubernetes.io/docs/contribute/style/content-organization/)
      - [ ] [Custom Hugo Shortcodes](https://kubernetes.io/docs/contribute/style/hugo-shortcodes/)
    - [ ] [Updating Reference Documentation](https://kubernetes.io/docs/contribute/generate-ref-docs/)
      - [ ] [Quickstart](https://kubernetes.io/docs/contribute/generate-ref-docs/quickstart/ "Reference Documentation Quickstart")
      - [ ] [Contributing to the Upstream Kubernetes Code](https://kubernetes.io/docs/contribute/generate-ref-docs/contribute-upstream/)
      - [ ] [Generating Reference Documentation for the Kubernetes API](https://kubernetes.io/docs/contribute/generate-ref-docs/kubernetes-api/)
      - [ ] [Generating Reference Documentation for kubectl Commands](https://kubernetes.io/docs/contribute/generate-ref-docs/kubectl/)
      - [ ] [Generating Reference Documentation for Metrics](https://kubernetes.io/docs/contribute/generate-ref-docs/metrics-reference/)
      - [ ] [Generating Reference Pages for Kubernetes Components and Tools](https://kubernetes.io/docs/contribute/generate-ref-docs/kubernetes-components/)
      - [ ]
    - [ ] [Advanced contributing](https://kubernetes.io/docs/contribute/advanced/)
    - [ ] [Viewing Site Analytics](https://kubernetes.io/docs/contribute/analytics/)
  - [ ] [Docs smoke test page](https://kubernetes.io/docs/test/)

[Edit this page](https://github.com/kubernetes/website/edit/main/content/en/docs/reference/access-authn-authz/rbac.md) [Create child page](https://github.com/kubernetes/website/new/main/content/en/docs/reference/access-authn-authz/rbac.md?filename=change-me.md&value=---%0Atitle%3A+%22Long+Page+Title%22%0AlinkTitle%3A+%22Short+Nav+Title%22%0Aweight%3A+100%0Adescription%3A+%3E-%0A+++++Page+description+for+heading+and+indexes.%0A---%0A%0A%23%23+Heading%0A%0AEdit+this+template+to+create+your+new+page.%0A%0A%2A+Give+it+a+good+name%2C+ending+in+%60.md%60+-+e.g.+%60getting-started.md%60%0A%2A+Edit+the+%22front+matter%22+section+at+the+top+of+the+page+%28weight+controls+how+its+ordered+amongst+other+pages+in+the+same+directory%3B+lowest+number+first%29.%0A%2A+Add+a+good+commit+message+at+the+bottom+of+the+page+%28%3C80+characters%3B+use+the+extended+description+field+for+more+detail%29.%0A%2A+Create+a+new+branch+so+you+can+preview+your+new+file+and+request+a+review+via+Pull+Request.%0A) [Create an issue](https://github.com/kubernetes/website/issues/new?title=Using%20RBAC%20Authorization) [Print entire section](https://kubernetes.io/docs/reference/access-authn-authz/_print/)

- [API objects](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview)
  - [Role and ClusterRole](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole)
  - [RoleBinding and ClusterRoleBinding](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#rolebinding-and-clusterrolebinding)
  - [Referring to resources](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#referring-to-resources)
  - [Aggregated ClusterRoles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#aggregated-clusterroles)
  - [Referring to subjects](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#referring-to-subjects)
- [Default roles and role bindings](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#default-roles-and-role-bindings)
  - [Auto-reconciliation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#auto-reconciliation)
  - [API discovery roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles)
  - [User-facing roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles)
  - [Core component roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#core-component-roles)
  - [Other component roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#other-component-roles)
  - [Roles for built-in controllers](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#controller-roles)
- [Privilege escalation prevention and bootstrapping](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#privilege-escalation-prevention-and-bootstrapping)
  - [Restrictions on role creation or update](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#restrictions-on-role-creation-or-update)
  - [Restrictions on role binding creation or update](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#restrictions-on-role-binding-creation-or-update)
- [Command-line utilities](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#command-line-utilities)
  - [`kubectl create role`](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-create-role)
  - [`kubectl create clusterrole`](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-create-clusterrole)
  - [`kubectl create rolebinding`](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-create-rolebinding)
  - [`kubectl create clusterrolebinding`](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-create-clusterrolebinding)
  - [`kubectl auth reconcile`](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-auth-reconcile)
- [ServiceAccount permissions](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#service-account-permissions)
- [Write access for EndpointSlices](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#write-access-for-endpoints)
- [Upgrading from ABAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#upgrading-from-abac)
  - [Parallel authorizers](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#parallel-authorizers)
  - [Permissive RBAC permissions](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#permissive-rbac-permissions)

1. [Kubernetes Documentation](https://kubernetes.io/docs/)
2. [Reference](https://kubernetes.io/docs/reference/)
3. [API Access Control](https://kubernetes.io/docs/reference/access-authn-authz/)
4. Using RBAC Authorization

# Using RBAC Authorization

Role-based access control (RBAC) is a method of regulating access to computer or
network resources based on the roles of individual users within your organization.

RBAC authorization uses the `rbac.authorization.k8s.io` [API group](https://kubernetes.io/docs/concepts/overview/kubernetes-api/#api-groups-and-versioning) to drive authorization
decisions, allowing you to dynamically configure policies through the Kubernetes API.

To enable RBAC, start the [API server](https://kubernetes.io/docs/concepts/architecture/#kube-apiserver)
with the `--authorization-config` flag set to a file that includes the `RBAC` authorizer; for example:

```yaml
apiVersion: apiserver.config.k8s.io/v1
kind: AuthorizationConfiguration
authorizers:
  ...
  - type: RBAC
  ...
```

Or, start the [API server](https://kubernetes.io/docs/concepts/architecture/#kube-apiserver) with
the `--authorization-mode` flag set to a comma-separated list that includes `RBAC`;
for example:

```shell
kube-apiserver --authorization-mode=...,RBAC --other-options --more-options
```

## API objects [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#api-overview)

The RBAC API declares four kinds of Kubernetes object: _Role_, _ClusterRole_,
_RoleBinding_ and _ClusterRoleBinding_. You can describe or amend the RBAC
[objects](https://kubernetes.io/docs/concepts/overview/working-with-objects/#kubernetes-objects)
using tools such as `kubectl`, just like any other Kubernetes object.

#### Caution:

These objects, by design, impose access restrictions. If you are making changes
to a cluster as you learn, see
[privilege escalation prevention and bootstrapping](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#privilege-escalation-prevention-and-bootstrapping)
to understand how those restrictions can prevent you making some changes.

### Role and ClusterRole [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#role-and-clusterrole)

An RBAC _Role_ or _ClusterRole_ contains rules that represent a set of permissions.
Permissions are purely additive (there are no "deny" rules).

A Role always sets permissions within a particular [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces);
when you create a Role, you have to specify the namespace it belongs in.

ClusterRole, by contrast, is a non-namespaced resource. The resources have different names (Role
and ClusterRole) because a Kubernetes object always has to be either namespaced or not namespaced;
it can't be both.

ClusterRoles have several uses. You can use a ClusterRole to:

1. define permissions on namespaced resources and be granted access within individual namespace(s)
2. define permissions on namespaced resources and be granted access across all namespaces
3. define permissions on cluster-scoped resources

If you want to define a role within a namespace, use a Role; if you want to define
a role cluster-wide, use a ClusterRole.

#### Role example [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#role-example)

Here's an example Role in the "default" namespace that can be used to grant read access to
[pods](https://kubernetes.io/docs/concepts/workloads/pods/):

[`access/simple-role.yaml`](https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/access/simple-role.yaml)![](https://kubernetes.io/images/copycode.svg)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

#### ClusterRole example [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#clusterrole-example)

A ClusterRole can be used to grant the same permissions as a Role.
Because ClusterRoles are cluster-scoped, you can also use them to grant access to:

- cluster-scoped resources (like [nodes](https://kubernetes.io/docs/concepts/architecture/nodes/))

- non-resource endpoints (like `/healthz`)

- namespaced resources (like Pods), across all namespaces

For example: you can use a ClusterRole to allow a particular user to run
`kubectl get pods --all-namespaces`


Here is an example of a ClusterRole that can be used to grant read access to
[secrets](https://kubernetes.io/docs/concepts/configuration/secret/) in any particular namespace,
or across all namespaces (depending on how it is [bound](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#rolebinding-and-clusterrolebinding)):

[`access/simple-clusterrole.yaml`](https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/access/simple-clusterrole.yaml)![](https://kubernetes.io/images/copycode.svg)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  # "namespace" omitted since ClusterRoles are not namespaced
  name: secret-reader
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing Secret
  # objects is "secrets"
  resources: ["secrets"]
  verbs: ["get", "watch", "list"]
```

The name of a Role or a ClusterRole object must be a valid
[path segment name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#path-segment-names).

### RoleBinding and ClusterRoleBinding [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#rolebinding-and-clusterrolebinding)

A role binding grants the permissions defined in a role to a user or set of users.
It holds a list of _subjects_ (users, groups, or service accounts), and a reference to the
role being granted.
A RoleBinding grants permissions within a specific namespace whereas a ClusterRoleBinding
grants that access cluster-wide.

A RoleBinding may reference any Role in the same namespace. Alternatively, a RoleBinding
can reference a ClusterRole and bind that ClusterRole to the namespace of the RoleBinding.
If you want to bind a ClusterRole to all the namespaces in your cluster, you use a
ClusterRoleBinding.

The name of a RoleBinding or ClusterRoleBinding object must be a valid
[path segment name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#path-segment-names).

#### RoleBinding examples [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#rolebinding-example)

Here is an example of a RoleBinding that grants the "pod-reader" Role to the user "jane"
within the "default" namespace.
This allows "jane" to read pods in the "default" namespace.

[`access/simple-rolebinding-with-role.yaml`](https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/access/simple-rolebinding-with-role.yaml)![](https://kubernetes.io/images/copycode.svg)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
# You need to already have a Role named "pod-reader" in that namespace.
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
# You can specify more than one "subject"
- kind: User
  name: jane # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

A RoleBinding can also reference a ClusterRole to grant the permissions defined in that
ClusterRole to resources inside the RoleBinding's namespace. This kind of reference
lets you define a set of common roles across your cluster, then reuse them within
multiple namespaces.

For instance, even though the following RoleBinding refers to a ClusterRole,
"dave" (the subject, case sensitive) will only be able to read Secrets in the "development"
namespace, because the RoleBinding's namespace (in its metadata) is "development".

[`access/simple-rolebinding-with-clusterrole.yaml`](https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/access/simple-rolebinding-with-clusterrole.yaml)![](https://kubernetes.io/images/copycode.svg)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "dave" to read secrets in the "development" namespace.
# You need to already have a ClusterRole named "secret-reader".
kind: RoleBinding
metadata:
  name: read-secrets
  #
  # The namespace of the RoleBinding determines where the permissions are granted.
  # This only grants permissions within the "development" namespace.
  namespace: development
subjects:
- kind: User
  name: dave # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: secret-reader
  apiGroup: rbac.authorization.k8s.io
```

#### ClusterRoleBinding example [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#clusterrolebinding-example)

To grant permissions across a whole cluster, you can use a ClusterRoleBinding.
The following ClusterRoleBinding allows any user in the group "manager" to read
secrets in any namespace.

[`access/simple-clusterrolebinding.yaml`](https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/access/simple-clusterrolebinding.yaml)![](https://kubernetes.io/images/copycode.svg)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This cluster role binding allows anyone in the "manager" group to read secrets in any namespace.
kind: ClusterRoleBinding
metadata:
  name: read-secrets-global
subjects:
- kind: Group
  name: manager # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: secret-reader
  apiGroup: rbac.authorization.k8s.io
```

After you create a binding, you cannot change the Role or ClusterRole that it refers to.
If you try to change a binding's `roleRef`, you get a validation error. If you do want
to change the `roleRef` for a binding, you need to remove the binding object and create
a replacement.

There are two reasons for this restriction:

1. Making `roleRef` immutable allows granting someone `update` permission on an existing binding
object, so that they can manage the list of subjects, without being able to change
the role that is granted to those subjects.
2. A binding to a different role is a fundamentally different binding.
Requiring a binding to be deleted/recreated in order to change the `roleRef`
ensures the full list of subjects in the binding is intended to be granted
the new role (as opposed to enabling or accidentally modifying only the roleRef
without verifying all of the existing subjects should be given the new role's
permissions).

The `kubectl auth reconcile` command-line utility creates or updates a manifest file containing RBAC objects,
and handles deleting and recreating binding objects if required to change the role they refer to.
See [command usage and examples](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#kubectl-auth-reconcile) for more information.

### Referring to resources [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#referring-to-resources)

In the Kubernetes API, most resources are represented and accessed using a string representation of
their object name, such as `pods` for a Pod. RBAC refers to resources using exactly the same
name that appears in the URL for the relevant API endpoint.
Some Kubernetes APIs involve a
_subresource_, such as the logs for a Pod. A request for a Pod's logs looks like:

```http
GET /api/v1/namespaces/{namespace}/pods/{name}/log
```

In this case, `pods` is the namespaced resource for Pod resources, and `log` is a
subresource of `pods`. To represent this in an RBAC role, use a slash (`/`) to
delimit the resource and subresource. To allow a subject to read `pods` and
also access the `log` subresource for each of those Pods, you write:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-and-pod-logs-reader
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log"]
  verbs: ["get", "list"]
```

You can also refer to resources by name for certain requests through the `resourceNames` list.
When specified, requests can be restricted to individual instances of a resource.
Here is an example that restricts its subject to only `get` or `update` a
[ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) named `my-configmap`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: configmap-updater
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing ConfigMap
  # objects is "configmaps"
  resources: ["configmaps"]
  resourceNames: ["my-configmap"]
  verbs: ["update", "get"]
```

#### Note:

You cannot restrict **deletecollection** or top-level **create** requests by resource name.
For **create**, this limitation is because the name of the new object may not be known at authorization time. However, the **create** limitation applies only to top-level resources, not subresources. For example, you can use the `resourceNames` field with `pods/exec`.
If you restrict **list** or **watch** by `resourceName`, clients must include a `metadata.name` field selector in their **list** or **watch** request (that matches the specified `resourceName`)
in order to be authorized.
For example: `kubectl get configmaps --field-selector=metadata.name=my-configmap`

Rather than referring to individual `resources`, `apiGroups`, and `verbs`,
you can use the wildcard `*` symbol to refer to all such objects.
For `nonResourceURLs`, you can use the wildcard `*` as a suffix glob match.
For `resourceNames`, an empty set means that everything is allowed.
Here is an example that allows access to perform any current and future action on
all current and future resources in the `example.com` API group.
This is similar to the built-in `cluster-admin` role.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: example.com-superuser # DO NOT USE THIS ROLE, IT IS JUST AN EXAMPLE
rules:
- apiGroups: ["example.com"]
  resources: ["*"]
  verbs: ["*"]
```

#### Caution:

Using wildcards in resource and verb entries could result in overly permissive access being granted
to sensitive resources.
For instance, if a new resource type is added, or a new subresource is added,
or a new custom verb is checked, the wildcard entry automatically grants access, which may be undesirable.
The [principle of least privilege](https://kubernetes.io/docs/concepts/security/rbac-good-practices/#least-privilege)
should be employed, using specific resources and verbs to ensure only the permissions required for the
workload to function correctly are applied.

### Aggregated ClusterRoles [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#aggregated-clusterroles)

You can _aggregate_ several ClusterRoles into one combined ClusterRole.
A controller, running as part of the cluster control plane, watches for ClusterRole
objects with an `aggregationRule` set. The `aggregationRule` defines a label
[selector](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) that the controller
uses to match other ClusterRole objects that should be combined into the `rules`
field of this one.

#### Caution:

The control plane overwrites any values that you manually specify in the `rules` field of an
aggregate ClusterRole. If you want to change or add rules, do so in the `ClusterRole` objects
that are selected by the `aggregationRule`.

Here is an example aggregated ClusterRole:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: monitoring
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      rbac.example.com/aggregate-to-monitoring: "true"
rules: [] # The control plane automatically fills in the rules
```

If you create a new ClusterRole that matches the label selector of an existing aggregated ClusterRole,
that change triggers adding the new rules into the aggregated ClusterRole.
Here is an example that adds rules to the "monitoring" ClusterRole, by creating another
ClusterRole labeled `rbac.example.com/aggregate-to-monitoring: true`.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: monitoring-endpointslices
  labels:
    rbac.example.com/aggregate-to-monitoring: "true"
# When you create the "monitoring-endpointslices" ClusterRole,
# the rules below will be added to the "monitoring" ClusterRole.
rules:
- apiGroups: [""]
  resources: ["services", "pods"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["discovery.k8s.io"]
  resources: ["endpointslices"]
  verbs: ["get", "list", "watch"]
```

The [default user-facing roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#default-roles-and-role-bindings) use ClusterRole aggregation. This lets you,
as a cluster administrator, include rules for custom resources, such as those served by
[CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/)
or aggregated API servers, to extend the default roles.

For example: the following ClusterRoles let the "admin" and "edit" default roles manage the custom resource
named CronTab, whereas the "view" role can perform only read actions on CronTab resources.
You can assume that CronTab objects are named `"crontabs"` in URLs as seen by the API server.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: aggregate-cron-tabs-edit
  labels:
    # Add these permissions to the "admin" and "edit" default roles.
    rbac.authorization.k8s.io/aggregate-to-admin: "true"
    rbac.authorization.k8s.io/aggregate-to-edit: "true"
rules:
- apiGroups: ["stable.example.com"]
  resources: ["crontabs"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: aggregate-cron-tabs-view
  labels:
    # Add these permissions to the "view" default role.
    rbac.authorization.k8s.io/aggregate-to-view: "true"
rules:
- apiGroups: ["stable.example.com"]
  resources: ["crontabs"]
  verbs: ["get", "list", "watch"]
```

#### Role examples [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#role-examples)

The following examples are excerpts from Role or ClusterRole objects, showing only
the `rules` section.

Allow reading `"pods"` resources in the core
[API Group](https://kubernetes.io/docs/concepts/overview/kubernetes-api/#api-groups-and-versioning):

```yaml
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing Pod
  # objects is "pods"
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
```

Allow reading/writing Deployments (at the HTTP level: objects with `"deployments"`
in the resource part of their URL) in the `"apps"` API groups:

```yaml
rules:
- apiGroups: ["apps"]
  #
  # at the HTTP level, the name of the resource for accessing Deployment
  # objects is "deployments"
  resources: ["deployments"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```

Allow reading Pods in the core API group, as well as reading or writing Job
resources in the `"batch"` API group:

```yaml
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing Pod
  # objects is "pods"
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["batch"]
  #
  # at the HTTP level, the name of the resource for accessing Job
  # objects is "jobs"
  resources: ["jobs"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```

Allow reading a ConfigMap named "my-config" (must be bound with a
RoleBinding to limit to a single ConfigMap in a single namespace):

```yaml
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing ConfigMap
  # objects is "configmaps"
  resources: ["configmaps"]
  resourceNames: ["my-config"]
  verbs: ["get"]
```

Allow reading the resource `"nodes"` in the core group (because a
Node is cluster-scoped, this must be in a ClusterRole bound with a
ClusterRoleBinding to be effective):

```yaml
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing Node
  # objects is "nodes"
  resources: ["nodes"]
  verbs: ["get", "list", "watch"]
```

Allow GET and POST requests to the non-resource endpoint `/healthz` and
all subpaths (must be in a ClusterRole bound with a ClusterRoleBinding
to be effective):

```yaml
rules:
- nonResourceURLs: ["/healthz", "/healthz/*"] # '*' in a nonResourceURL is a suffix glob match
  verbs: ["get", "post"]
```

### Referring to subjects [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#referring-to-subjects)

A RoleBinding or ClusterRoleBinding binds a role to subjects.
Subjects can be groups, users or
[ServiceAccounts](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/).

Kubernetes represents usernames as strings.
These can be: plain names, such as "alice"; email-style names, like "bob@example.com";
or numeric user IDs represented as a string. It is up to you as a cluster administrator
to configure the [authentication modules](https://kubernetes.io/docs/reference/access-authn-authz/authentication/)
so that authentication produces usernames in the format you want.

#### Caution:

The prefix `system:` is reserved for Kubernetes system use, so you should ensure
that you don't have users or groups with names that start with `system:` by
accident.
Other than this special prefix, the RBAC authorization system does not require any format
for usernames.

In Kubernetes, Authenticator modules provide group information.
Groups, like users, are represented as strings, and that string has no format requirements,
other than that the prefix `system:` is reserved.

[ServiceAccounts](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) have names prefixed
with `system:serviceaccount:`, and belong to groups that have names prefixed with `system:serviceaccounts:`.

#### Note:

- `system:serviceaccount:` (singular) is the prefix for service account usernames.
- `system:serviceaccounts:` (plural) is the prefix for service account groups.

#### RoleBinding examples [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#role-binding-examples)

The following examples are `RoleBinding` excerpts that only
show the `subjects` section.

For a user named `alice@example.com`:

```yaml
subjects:
- kind: User
  name: "alice@example.com"
  apiGroup: rbac.authorization.k8s.io
```

For a group named `frontend-admins`:

```yaml
subjects:
- kind: Group
  name: "frontend-admins"
  apiGroup: rbac.authorization.k8s.io
```

For the default service account in the "kube-system" namespace:

```yaml
subjects:
- kind: ServiceAccount
  name: default
  namespace: kube-system
```

For all service accounts in the "qa" namespace:

```yaml
subjects:
- kind: Group
  name: system:serviceaccounts:qa
  apiGroup: rbac.authorization.k8s.io
```

For all service accounts in any namespace:

```yaml
subjects:
- kind: Group
  name: system:serviceaccounts
  apiGroup: rbac.authorization.k8s.io
```

For all authenticated users:

```yaml
subjects:
- kind: Group
  name: system:authenticated
  apiGroup: rbac.authorization.k8s.io
```

For all unauthenticated users:

```yaml
subjects:
- kind: Group
  name: system:unauthenticated
  apiGroup: rbac.authorization.k8s.io
```

For all users:

```yaml
subjects:
- kind: Group
  name: system:authenticated
  apiGroup: rbac.authorization.k8s.io
- kind: Group
  name: system:unauthenticated
  apiGroup: rbac.authorization.k8s.io
```

## Default roles and role bindings [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#default-roles-and-role-bindings)

API servers create a set of default ClusterRole and ClusterRoleBinding objects.
Many of these are `system:` prefixed, which indicates that the resource is directly
managed by the cluster control plane.
All of the default ClusterRoles and ClusterRoleBindings are labeled with `kubernetes.io/bootstrapping=rbac-defaults`.

#### Caution:

Take care when modifying ClusterRoles and ClusterRoleBindings with names
that have a `system:` prefix.
Modifications to these resources can result in non-functional clusters.

### Auto-reconciliation [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#auto-reconciliation)

At each start-up, the API server updates default cluster roles with any missing permissions,
and updates default cluster role bindings with any missing subjects.
This allows the cluster to repair accidental modifications, and helps to keep roles and role bindings
up-to-date as permissions and subjects change in new Kubernetes releases.

To opt out of this reconciliation, set the `rbac.authorization.kubernetes.io/autoupdate`
annotation on a default cluster role or default cluster RoleBinding to `false`.
Be aware that missing default permissions and subjects can result in non-functional clusters.

Auto-reconciliation is enabled by default if the RBAC authorizer is active.

### API discovery roles [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#discovery-roles)

Default cluster role bindings authorize unauthenticated and authenticated users to read API information
that is deemed safe to be publicly accessible (including CustomResourceDefinitions).
To disable anonymous unauthenticated access, add `--anonymous-auth=false` flag to
the API server configuration.

To view the configuration of these roles via `kubectl` run:

```shell
kubectl get clusterroles system:discovery -o yaml
```

#### Note:

If you edit that ClusterRole, your changes will be overwritten on API server restart
via [auto-reconciliation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#auto-reconciliation). To avoid that overwriting,
either do not manually edit the role, or disable auto-reconciliation.

| Default ClusterRole | Default ClusterRoleBinding | Description |
| --- | --- | --- |
| **system:basic-user** | **system:authenticated** group | Allows a user read-only access to basic information about themselves. Prior to v1.14, this role was also bound to `system:unauthenticated` by default. |
| **system:discovery** | **system:authenticated** group | Allows read-only access to API discovery endpoints needed to discover and negotiate an API level. Prior to v1.14, this role was also bound to `system:unauthenticated` by default. |
| **system:public-info-viewer** | **system:authenticated** and **system:unauthenticated** groups | Allows read-only access to non-sensitive information about the cluster. Introduced in Kubernetes v1.14. |

Kubernetes RBAC API discovery roles

### User-facing roles [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#user-facing-roles)

Some of the default ClusterRoles are not `system:` prefixed. These are intended to be user-facing roles.
They include super-user roles (`cluster-admin`), roles intended to be granted cluster-wide
using ClusterRoleBindings, and roles intended to be granted within particular
namespaces using RoleBindings (`admin`, `edit`, `view`).

User-facing ClusterRoles use [ClusterRole aggregation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#aggregated-clusterroles) to allow admins to include
rules for custom resources on these ClusterRoles. To add rules to the `admin`, `edit`, or `view` roles, create
a ClusterRole with one or more of the following labels:

```yaml
metadata:
  labels:
    rbac.authorization.k8s.io/aggregate-to-admin: "true"
    rbac.authorization.k8s.io/aggregate-to-edit: "true"
    rbac.authorization.k8s.io/aggregate-to-view: "true"
```

| Default ClusterRole | Default ClusterRoleBinding | Description |
| --- | --- | --- |
| **cluster-admin** | **system:masters** group | Allows super-user access to perform any action on any resource.<br>When used in a **ClusterRoleBinding**, it gives full control over every resource in the cluster and in all namespaces.<br>When used in a **RoleBinding**, it gives full control over every resource in the role binding's namespace, including the namespace itself. |
| **admin** | None | Allows admin access, intended to be granted within a namespace using a **RoleBinding**.<br>If used in a **RoleBinding**, allows read/write access to most resources in a namespace,<br>including the ability to create roles and role bindings within the namespace.<br>This role does not allow write access to resource quota or to the namespace itself.<br>This role also does not allow write access to EndpointSlices in clusters created<br>using Kubernetes v1.22+. More information is available in the<br>["Write Access for EndpointSlices" section](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#write-access-for-endpoints). |
| **edit** | None | Allows read/write access to most objects in a namespace.<br>This role does not allow viewing or modifying roles or role bindings.<br>However, this role allows accessing Secrets and running Pods as any ServiceAccount in<br>the namespace, so it can be used to gain the API access levels of any ServiceAccount in<br>the namespace. This role also does not allow write access to EndpointSlices in<br>clusters created using Kubernetes v1.22+. More information is available in the<br>["Write Access for EndpointSlices" section](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#write-access-for-endpoints). |
| **view** | None | Allows read-only access to see most objects in a namespace.<br>It does not allow viewing roles or role bindings.<br>This role does not allow viewing Secrets, since reading<br>the contents of Secrets enables access to ServiceAccount credentials<br>in the namespace, which would allow API access as any ServiceAccount<br>in the namespace (a form of privilege escalation). |

### Core component roles [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#core-component-roles)

| Default ClusterRole | Default ClusterRoleBinding | Description |
| --- | --- | --- |
| **system:kube-scheduler** | **system:kube-scheduler** user | Allows access to the resources required by the [scheduler](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/) component. |
| **system:volume-scheduler** | **system:kube-scheduler** user | Allows access to the volume resources required by the kube-scheduler component. |
| **system:kube-controller-manager** | **system:kube-controller-manager** user | Allows access to the resources required by the [controller manager](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/) component.<br>The permissions required by individual controllers are detailed in the [controller roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#controller-roles). |
| **system:node** | None | Allows access to resources required by the kubelet, **including read access to all secrets, and write access to all pod status objects**.<br>You should use the [Node authorizer](https://kubernetes.io/docs/reference/access-authn-authz/node/) and [NodeRestriction admission plugin](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction) instead of the `system:node` role, and allow granting API access to kubelets based on the Pods scheduled to run on them.<br>The `system:node` role only exists for compatibility with Kubernetes clusters upgraded from versions prior to v1.8. |
| **system:node-proxier** | **system:kube-proxy** user | Allows access to the resources required by the [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) component. |

### Other component roles [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#other-component-roles)

| Default ClusterRole | Default ClusterRoleBinding | Description |
| --- | --- | --- |
| **system:auth-delegator** | None | Allows delegated authentication and authorization checks.<br>This is commonly used by add-on API servers for unified authentication and authorization. |
| **system:heapster** | None | Role for the [Heapster](https://github.com/kubernetes/heapster) component (deprecated). |
| **system:kube-aggregator** | None | Role for the [kube-aggregator](https://github.com/kubernetes/kube-aggregator) component. |
| **system:kube-dns** | **kube-dns** service account in the **kube-system** namespace | Role for the [kube-dns](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/) component. |
| **system:kubelet-api-admin** | None | Allows full access to the kubelet API. |
| **system:node-bootstrapper** | None | Allows access to the resources required to perform<br>[kubelet TLS bootstrapping](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/). |
| **system:node-problem-detector** | None | Role for the [node-problem-detector](https://github.com/kubernetes/node-problem-detector) component. |
| **system:persistent-volume-provisioner** | None | Allows access to the resources required by most [dynamic volume provisioners](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#dynamic). |
| **system:monitoring** | **system:monitoring** group | Allows read access to control-plane monitoring endpoints (i.e. [kube-apiserver](https://kubernetes.io/docs/concepts/architecture/#kube-apiserver) liveness and readiness endpoints ( `/healthz`, `/livez`, `/readyz`), the individual health-check endpoints ( `/healthz/*`, `/livez/*`, `/readyz/*`), `/metrics`), and causes the kube-apiserver to respect the traceparent header provided with requests for tracing. Note that individual health check endpoints and the metric endpoint may expose sensitive information. |

### Roles for built-in controllers [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#controller-roles)

The Kubernetes [controller manager](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/) runs
[controllers](https://kubernetes.io/docs/concepts/architecture/controller/) that are built in to the Kubernetes
control plane.
When invoked with `--use-service-account-credentials`, kube-controller-manager starts each controller
using a separate service account.
Corresponding roles exist for each built-in controller, prefixed with `system:controller:`.
If the controller manager is not started with `--use-service-account-credentials`, it runs all control loops
using its own credential, which must be granted all the relevant roles.
These roles include:

- `system:controller:attachdetach-controller`
- `system:controller:certificate-controller`
- `system:controller:clusterrole-aggregation-controller`
- `system:controller:cronjob-controller`
- `system:controller:daemon-set-controller`
- `system:controller:deployment-controller`
- `system:controller:disruption-controller`
- `system:controller:endpoint-controller`
- `system:controller:expand-controller`
- `system:controller:generic-garbage-collector`
- `system:controller:horizontal-pod-autoscaler`
- `system:controller:job-controller`
- `system:controller:namespace-controller`
- `system:controller:node-controller`
- `system:controller:persistent-volume-binder`
- `system:controller:pod-garbage-collector`
- `system:controller:pv-protection-controller`
- `system:controller:pvc-protection-controller`
- `system:controller:replicaset-controller`
- `system:controller:replication-controller`
- `system:controller:resourcequota-controller`
- `system:controller:root-ca-cert-publisher`
- `system:controller:route-controller`
- `system:controller:service-account-controller`
- `system:controller:service-controller`
- `system:controller:statefulset-controller`
- `system:controller:ttl-controller`

## Privilege escalation prevention and bootstrapping [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#privilege-escalation-prevention-and-bootstrapping)

The RBAC API prevents users from escalating privileges by editing roles or role bindings.
Because this is enforced at the API level, it applies even when the RBAC authorizer is not in use.

### Restrictions on role creation or update [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#restrictions-on-role-creation-or-update)

You can only create/update a role if at least one of the following things is true:

1. You already have all the permissions contained in the role, at the same scope as the object being modified
(cluster-wide for a ClusterRole, within the same namespace or cluster-wide for a Role).
2. You are granted explicit permission to perform the `escalate` verb on the `roles` or
`clusterroles` resource in the `rbac.authorization.k8s.io` API group.

For example, if `user-1` does not have the ability to list Secrets cluster-wide, they cannot create a ClusterRole
containing that permission. To allow a user to create/update roles:

1. Grant them a role that allows them to create/update Role or ClusterRole objects, as desired.
2. Grant them permission to include specific permissions in the roles they create/update:
   - implicitly, by giving them those permissions (if they attempt to create or modify a Role or
     ClusterRole with permissions they themselves have not been granted, the API request will be forbidden)
   - or explicitly allow specifying any permission in a `Role` or `ClusterRole` by giving them
     permission to perform the `escalate` verb on `roles` or `clusterroles` resources in the
     `rbac.authorization.k8s.io` API group

### Restrictions on role binding creation or update [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#restrictions-on-role-binding-creation-or-update)

You can only create/update a role binding if you already have all the permissions contained in the referenced role
(at the same scope as the role binding) _or_ if you have been authorized to perform the `bind` verb on the referenced role.
For example, if `user-1` does not have the ability to list Secrets cluster-wide, they cannot create a ClusterRoleBinding
to a role that grants that permission. To allow a user to create/update role bindings:

1. Grant them a role that allows them to create/update RoleBinding or ClusterRoleBinding objects, as desired.
2. Grant them permissions needed to bind a particular role:
   - implicitly, by giving them the permissions contained in the role.
   - explicitly, by giving them permission to perform the `bind` verb on the particular Role (or ClusterRole).

For example, this ClusterRole and RoleBinding would allow `user-1` to grant other users the `admin`, `edit`, and `view` roles in the namespace `user-1-namespace`:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: role-grantor
rules:
- apiGroups: ["rbac.authorization.k8s.io"]
  resources: ["rolebindings"]
  verbs: ["create"]
- apiGroups: ["rbac.authorization.k8s.io"]
  resources: ["clusterroles"]
  verbs: ["bind"]
  # omit resourceNames to allow binding any ClusterRole
  resourceNames: ["admin","edit","view"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: role-grantor-binding
  namespace: user-1-namespace
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: role-grantor
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: user-1
```

When bootstrapping the first roles and role bindings, it is necessary for the initial user to grant permissions they do not yet have.
To bootstrap initial roles and role bindings:

- Use a credential with the "system:masters" group, which is bound to the "cluster-admin" super-user role by the default bindings.

## Command-line utilities [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#command-line-utilities)

### `kubectl create role` [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#kubectl-create-role)

Creates a Role object defining permissions within a single namespace. Examples:

- Create a Role named "pod-reader" that allows users to perform `get`, `watch` and `list` on pods:



```shell
kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods
```

- Create a Role named "pod-reader" with resourceNames specified:



```shell
kubectl create role pod-reader --verb=get --resource=pods --resource-name=readablepod --resource-name=anotherpod
```

- Create a Role named "foo" with apiGroups specified:



```shell
kubectl create role foo --verb=get,list,watch --resource=replicasets.apps
```

- Create a Role named "foo" with subresource permissions:



```shell
kubectl create role foo --verb=get,list,watch --resource=pods,pods/status
```

- Create a Role named "my-component-lease-holder" with permissions to get/update a resource with a specific name:



```shell
kubectl create role my-component-lease-holder --verb=get,list,watch,update --resource=lease --resource-name=my-component
```


### `kubectl create clusterrole` [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#kubectl-create-clusterrole)

Creates a ClusterRole. Examples:

- Create a ClusterRole named "pod-reader" that allows user to perform `get`, `watch` and `list` on pods:



```shell
kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods
```

- Create a ClusterRole named "pod-reader" with resourceNames specified:



```shell
kubectl create clusterrole pod-reader --verb=get --resource=pods --resource-name=readablepod --resource-name=anotherpod
```

- Create a ClusterRole named "foo" with apiGroups specified:



```shell
kubectl create clusterrole foo --verb=get,list,watch --resource=replicasets.apps
```

- Create a ClusterRole named "foo" with subresource permissions:



```shell
kubectl create clusterrole foo --verb=get,list,watch --resource=pods,pods/status
```

- Create a ClusterRole named "foo" with nonResourceURL specified:



```shell
kubectl create clusterrole "foo" --verb=get --non-resource-url=/logs/*
```

- Create a ClusterRole named "monitoring" with an aggregationRule specified:



```shell
kubectl create clusterrole monitoring --aggregation-rule="rbac.example.com/aggregate-to-monitoring=true"
```


### `kubectl create rolebinding` [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#kubectl-create-rolebinding)

Grants a Role or ClusterRole within a specific namespace. Examples:

- Within the namespace "acme", grant the permissions in the "admin" ClusterRole to a user named "bob":



```shell
kubectl create rolebinding bob-admin-binding --clusterrole=admin --user=bob --namespace=acme
```

- Within the namespace "acme", grant the permissions in the "view" ClusterRole to the service account in the namespace "acme" named "myapp":



```shell
kubectl create rolebinding myapp-view-binding --clusterrole=view --serviceaccount=acme:myapp --namespace=acme
```

- Within the namespace "acme", grant the permissions in the "view" ClusterRole to a service account in the namespace "myappnamespace" named "myapp":



```shell
kubectl create rolebinding myappnamespace-myapp-view-binding --clusterrole=view --serviceaccount=myappnamespace:myapp --namespace=acme
```


### `kubectl create clusterrolebinding` [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#kubectl-create-clusterrolebinding)

Grants a ClusterRole across the entire cluster (all namespaces). Examples:

- Across the entire cluster, grant the permissions in the "cluster-admin" ClusterRole to a user named "root":



```shell
kubectl create clusterrolebinding root-cluster-admin-binding --clusterrole=cluster-admin --user=root
```

- Across the entire cluster, grant the permissions in the "system:node-proxier" ClusterRole to a user named "system:kube-proxy":



```shell
kubectl create clusterrolebinding kube-proxy-binding --clusterrole=system:node-proxier --user=system:kube-proxy
```

- Across the entire cluster, grant the permissions in the "view" ClusterRole to a service account named "myapp" in the namespace "acme":



```shell
kubectl create clusterrolebinding myapp-view-binding --clusterrole=view --serviceaccount=acme:myapp
```


### `kubectl auth reconcile` [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#kubectl-auth-reconcile)

Creates or updates `rbac.authorization.k8s.io/v1` API objects from a manifest file.

Missing objects are created, and the containing namespace is created for namespaced objects, if required.

Existing roles are updated to include the permissions in the input objects,
and remove extra permissions if `--remove-extra-permissions` is specified.

Existing bindings are updated to include the subjects in the input objects,
and remove extra subjects if `--remove-extra-subjects` is specified.

Examples:

- Test applying a manifest file of RBAC objects, displaying changes that would be made:



```shell
kubectl auth reconcile -f my-rbac-rules.yaml --dry-run=client
```

- Apply a manifest file of RBAC objects, preserving any extra permissions (in roles) and any extra subjects (in bindings):



```shell
kubectl auth reconcile -f my-rbac-rules.yaml
```

- Apply a manifest file of RBAC objects, removing any extra permissions (in roles) and any extra subjects (in bindings):



```shell
kubectl auth reconcile -f my-rbac-rules.yaml --remove-extra-subjects --remove-extra-permissions
```


## ServiceAccount permissions [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#service-account-permissions)

Default RBAC policies grant scoped permissions to control-plane components, nodes,
and controllers, but grant _no permissions_ to service accounts outside the `kube-system` namespace
(beyond the permissions given by [API discovery roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles)).

This allows you to grant particular roles to particular ServiceAccounts as needed.
Fine-grained role bindings provide greater security, but require more effort to administrate.
Broader grants can give unnecessary (and potentially escalating) API access to
ServiceAccounts, but are easier to administrate.

In order from most secure to least secure, the approaches are:

1. Grant a role to an application-specific service account (best practice)

This requires the application to specify a `serviceAccountName` in its pod spec,
and for the service account to be created (via the API, application manifest, `kubectl create serviceaccount`, etc.).

For example, grant read-only permission within "my-namespace" to the "my-sa" service account:



```shell
kubectl create rolebinding my-sa-view \
     --clusterrole=view \
     --serviceaccount=my-namespace:my-sa \
     --namespace=my-namespace
```

2. Grant a role to the "default" service account in a namespace

If an application does not specify a `serviceAccountName`, it uses the "default" service account.



#### Note:

Permissions given to the "default" service account are available to any pod
in the namespace that does not specify a `serviceAccountName`.

For example, grant read-only permission within "my-namespace" to the "default" service account:



```shell
kubectl create rolebinding default-view \
     --clusterrole=view \
     --serviceaccount=my-namespace:default \
     --namespace=my-namespace
```



Many [add-ons](https://kubernetes.io/docs/concepts/cluster-administration/addons/) run as the
"default" service account in the `kube-system` namespace.
To allow those add-ons to run with super-user access, grant cluster-admin
permissions to the "default" service account in the `kube-system` namespace.



#### Caution:

Enabling this means the `kube-system` namespace contains Secrets
that grant super-user access to your cluster's API.



```shell
kubectl create clusterrolebinding add-on-cluster-admin \
     --clusterrole=cluster-admin \
     --serviceaccount=kube-system:default
```

3. Grant a role to all service accounts in a namespace

If you want all applications in a namespace to have a role, no matter what service account they use,
you can grant a role to the service account group for that namespace.

For example, grant read-only permission within "my-namespace" to all service accounts in that namespace:



```shell
kubectl create rolebinding serviceaccounts-view \
     --clusterrole=view \
     --group=system:serviceaccounts:my-namespace \
     --namespace=my-namespace
```

4. Grant a limited role to all service accounts cluster-wide (discouraged)

If you don't want to manage permissions per-namespace, you can grant a cluster-wide role to all service accounts.

For example, grant read-only permission across all namespaces to all service accounts in the cluster:



```shell
kubectl create clusterrolebinding serviceaccounts-view \
     --clusterrole=view \
    --group=system:serviceaccounts
```

5. Grant super-user access to all service accounts cluster-wide (strongly discouraged)

If you don't care about partitioning permissions at all, you can grant super-user access to all service accounts.



#### Warning:

This allows any application full access to your cluster, and also grants
any user with read access to Secrets (or the ability to create any pod)
full access to your cluster.



```shell
kubectl create clusterrolebinding serviceaccounts-cluster-admin \
     --clusterrole=cluster-admin \
     --group=system:serviceaccounts
```


## Write access for EndpointSlices [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#write-access-for-endpoints)

Kubernetes clusters created before Kubernetes v1.22 include write access to
EndpointSlices (and the now-deprecated Endpoints API) in the aggregated "edit" and "admin" roles.
As a mitigation for [CVE-2021-25740](https://github.com/kubernetes/kubernetes/issues/103675),
this access is not part of the aggregated roles in clusters that you create using
Kubernetes v1.22 or later.

Existing clusters that have been upgraded to Kubernetes v1.22 will not be
subject to this change. The [CVE\\
announcement](https://github.com/kubernetes/kubernetes/issues/103675) includes
guidance for restricting this access in existing clusters.

If you want new clusters to retain this level of access in the aggregated roles,
you can create the following ClusterRole:

[`access/endpoints-aggregated.yaml`](https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/access/endpoints-aggregated.yaml)![](https://kubernetes.io/images/copycode.svg)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    kubernetes.io/description: |-
      Add endpoints write permissions to the edit and admin roles. This was
      removed by default in 1.22 because of CVE-2021-25740. See
      https://issue.k8s.io/103675. This can allow writers to direct LoadBalancer
      or Ingress implementations to expose backend IPs that would not otherwise
      be accessible, and can circumvent network policies or security controls
      intended to prevent/isolate access to those backends.
      EndpointSlices were never included in the edit or admin roles, so there
      is nothing to restore for the EndpointSlice API.
  labels:
    rbac.authorization.k8s.io/aggregate-to-edit: "true"
  name: custom:aggregate-to-edit:endpoints # you can change this if you wish
rules:
  - apiGroups: [""]
    resources: ["endpoints"]
    verbs: ["create", "delete", "deletecollection", "patch", "update"]
```

## Upgrading from ABAC [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#upgrading-from-abac)

Clusters that originally ran older Kubernetes versions often used
permissive ABAC policies, including granting full API access to all
service accounts.

Default RBAC policies grant scoped permissions to control-plane components, nodes,
and controllers, but grant _no permissions_ to service accounts outside the `kube-system` namespace
(beyond the permissions given by [API discovery roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles)).

While far more secure, this can be disruptive to existing workloads expecting to automatically receive API permissions.
Here are two approaches for managing this transition:

### Parallel authorizers [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#parallel-authorizers)

Run both the RBAC and ABAC authorizers, and specify a policy file that contains
the [legacy ABAC policy](https://kubernetes.io/docs/reference/access-authn-authz/abac/#policy-file-format):

```shell
--authorization-mode=...,RBAC,ABAC --authorization-policy-file=mypolicy.json
```

To explain that first command line option in detail: if earlier authorizers, such as Node,
deny a request, then the RBAC authorizer attempts to authorize the API request. If RBAC
also denies that API request, the ABAC authorizer is then run. This means that any request
allowed by _either_ the RBAC or ABAC policies is allowed.

When the kube-apiserver is run with a log level of 5 or higher for the RBAC component
(`--vmodule=rbac*=5` or `--v=5`), you can see RBAC denials in the API server log
(prefixed with `RBAC`).
You can use that information to determine which roles need to be granted to which users, groups, or service accounts.

Once you have [granted roles to service accounts](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#service-account-permissions) and workloads
are running with no RBAC denial messages in the server logs, you can remove the ABAC authorizer.

### Permissive RBAC permissions [Heading self-link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/\#permissive-rbac-permissions)

You can replicate a permissive ABAC policy using RBAC role bindings.

#### Warning:

The following policy allows **ALL** service accounts to act as cluster administrators.
Any application running in a container receives service account credentials automatically,
and could perform any action against the API, including viewing secrets and modifying permissions.
This is not a recommended policy.

```shell
kubectl create clusterrolebinding permissive-binding \
  --clusterrole=cluster-admin \
  --user=admin \
  --user=kubelet \
  --group=system:serviceaccounts
```

After you have transitioned to use RBAC, you should adjust the access controls
for your cluster to ensure that these meet your information security needs.

## Feedback

Was this page helpful?

YesNo

Thanks for the feedback. If you have a specific, answerable question about how to use Kubernetes, ask it on
[Stack Overflow](https://stackoverflow.com/questions/tagged/kubernetes).
Open an issue in the [GitHub Repository](https://www.github.com/kubernetes/website/) if you want to
[report a problem](https://github.com/kubernetes/website/issues/new?title=Issue%20with%20k8s.io/docs/reference/access-authn-authz/rbac/)
or
[suggest an improvement](https://github.com/kubernetes/website/issues/new?title=Improvement%20for%20k8s.io/docs/reference/access-authn-authz/rbac/).

Last modified January 16, 2026 at 12:49 AM PST: [Clarified RBAC doc about resourceNames field and create verb (#50455) (a14451f9ad)](https://github.com/kubernetes/website/commit/a14451f9ad5cf2b3117321114d00c1fb23c3b0b7)

- [YouTube](https://youtube.com/kubernetescommunity)
- [Forum](https://discuss.kubernetes.io/)
- [Server Fault](https://serverfault.com/questions/tagged/kubernetes)
- [LinkedIn](https://www.linkedin.com/company/kubernetes/)
- [Bluesky](https://bsky.app/profile/kubernetes.io)
- [X (formerly Twitter)](https://x.com/kubernetesio)

© 2026 The Kubernetes Authors \| Documentation Distributed under [CC BY 4.0](https://git.k8s.io/website/LICENSE)

© 2026 The Linux Foundation ®. All rights reserved. The Linux Foundation has registered trademarks and uses trademarks. For a list of trademarks of The Linux Foundation, please see our [Trademark Usage page](https://www.linuxfoundation.org/trademark-usage)

ICP license: 京ICP备17074266号-3

- [Contributor website](https://k8s.dev/)
- [GitHub](https://github.com/kubernetes/kubernetes)
- [Slack](https://slack.k8s.io/)
- [Events Calendar](https://calendar.google.com/calendar/embed?src=calendar%40kubernetes.io)

- [Kubernetes](https://kubernetes.io/)
- [Documentation](https://kubernetes.io/docs/home/)
- [Kubernetes Blog](https://kubernetes.io/blog/)
- [Training](https://kubernetes.io/training/)
- [Careers](https://kubernetes.io/careers/)
- [Partners](https://kubernetes.io/partners/)
- [Community](https://kubernetes.io/community/)
- [Versions](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#)
- [Release Information](https://kubernetes.io/releases)
- [v1.36](https://kubernetes.io/)
- [v1.35](https://v1-35.docs.kubernetes.io/)
- [v1.34](https://v1-34.docs.kubernetes.io/)
- [v1.33](https://v1-33.docs.kubernetes.io/)
- [v1.32](https://v1-32.docs.kubernetes.io/)
- [English](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#)
- [中文 (Chinese)](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/rbac/)
- [Français (French)](https://kubernetes.io/fr/docs/reference/access-authn-authz/rbac/)
- [Bahasa Indonesia (Indonesian)](https://kubernetes.io/id/docs/reference/access-authn-authz/rbac/)
- [日本語 (Japanese)](https://kubernetes.io/ja/docs/reference/access-authn-authz/rbac/)
- [Light](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Dark](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Auto](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)