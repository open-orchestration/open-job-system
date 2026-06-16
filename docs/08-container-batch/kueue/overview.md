[Kueue](https://kueue.sigs.k8s.io/)

- [Documentation](https://kueue.sigs.k8s.io/docs/)
- [Talks and presentations](https://kueue.sigs.k8s.io/docs/talks_and_presentations/)
- [Adopters](https://kueue.sigs.k8s.io/docs/adopters/)
- [GitHub](https://github.com/kubernetes-sigs/kueue)
- [English](https://kueue.sigs.k8s.io/docs/overview/#)
[简体中文](https://kueue.sigs.k8s.io/zh-cn/docs/overview/)


Search this site…

Clear

[English](https://kueue.sigs.k8s.io/docs/overview/#)

[简体中文](https://kueue.sigs.k8s.io/zh-cn/docs/overview/)

- [Documentation](https://kueue.sigs.k8s.io/docs/)
  - [x] [Overview](https://kueue.sigs.k8s.io/docs/overview/)
  - [ ] [Getting Started](https://kueue.sigs.k8s.io/docs/getting-started/)
    - [ ] [Installation](https://kueue.sigs.k8s.io/docs/getting-started/installation/)
    - [ ] [Quick Start](https://kueue.sigs.k8s.io/docs/getting-started/quick-start/)
  - [ ] [Concepts](https://kueue.sigs.k8s.io/docs/concepts/)
    - [ ] [Resource Flavor](https://kueue.sigs.k8s.io/docs/concepts/resource_flavor/)
    - [ ] [Cluster Queue](https://kueue.sigs.k8s.io/docs/concepts/cluster_queue/)
    - [ ] [Cohort](https://kueue.sigs.k8s.io/docs/concepts/cohort/)
    - [ ] [Elastic Workloads](https://kueue.sigs.k8s.io/docs/concepts/elastic_workload/)
    - [ ] [Local Queue](https://kueue.sigs.k8s.io/docs/concepts/local_queue/)
    - [ ] [Workload](https://kueue.sigs.k8s.io/docs/concepts/workload/)
    - [ ] [Topology](https://kueue.sigs.k8s.io/docs/concepts/topology/)
    - [ ] [Admission Fair Sharing](https://kueue.sigs.k8s.io/docs/concepts/admission_fair_sharing/)
    - [ ] [Fair Sharing](https://kueue.sigs.k8s.io/docs/concepts/fair_sharing/)
    - [ ] [Admission Check](https://kueue.sigs.k8s.io/docs/concepts/admission_check/)
      - [ ] [ProvisioningRequest](https://kueue.sigs.k8s.io/docs/concepts/admission_check/provisioning_request/)
      - [ ] [Multikueue](https://kueue.sigs.k8s.io/docs/concepts/admission_check/multikueue/)
    - [ ] [Topology Aware Scheduling](https://kueue.sigs.k8s.io/docs/concepts/topology_aware_scheduling/)
    - [ ] [Workload Priority Class](https://kueue.sigs.k8s.io/docs/concepts/workload_priority_class/)
    - [ ] [Dynamic Resource Allocation](https://kueue.sigs.k8s.io/docs/concepts/dynamic_resource_allocation/)
    - [ ] [Preemption](https://kueue.sigs.k8s.io/docs/concepts/preemption/)
    - [ ] [Concurrent Admission](https://kueue.sigs.k8s.io/docs/concepts/concurrent_admission/)
    - [ ] [MultiKueue](https://kueue.sigs.k8s.io/docs/concepts/multikueue/)
    - [ ] [Admission](https://kueue.sigs.k8s.io/docs/concepts/admission/)
  - [ ] [Tasks](https://kueue.sigs.k8s.io/docs/tasks/)
    - [ ] [Manage Kueue](https://kueue.sigs.k8s.io/docs/tasks/manage/)
      - [ ] [Productionization of Kueue](https://kueue.sigs.k8s.io/docs/tasks/manage/productization/)
        - [ ] [Configure external cert-manager](https://kueue.sigs.k8s.io/docs/tasks/manage/productization/cert_manager/)
        - [ ] [Configure Prometheus with TLS](https://kueue.sigs.k8s.io/docs/tasks/manage/productization/prometheus/)
      - [ ] [Enforce Kueue Management of Workloads](https://kueue.sigs.k8s.io/docs/tasks/manage/enforce_job_management/)
        - [ ] [Setup default LocalQueue](https://kueue.sigs.k8s.io/docs/tasks/manage/enforce_job_management/setup_default_local_queue/)
        - [ ] [Setup a Job Admission Policy](https://kueue.sigs.k8s.io/docs/tasks/manage/enforce_job_management/setup_job_admission_policy/)
        - [ ] [Setup manageJobsWithoutQueueName](https://kueue.sigs.k8s.io/docs/tasks/manage/enforce_job_management/manage_jobs_without_queue_name/)
        - [ ] [Setup default WorkloadPriorityClass](https://kueue.sigs.k8s.io/docs/tasks/manage/enforce_job_management/setup_default_workload_priority_class/)
        - [ ] [Opt-in Namespace Management](https://kueue.sigs.k8s.io/docs/tasks/manage/enforce_job_management/opt_in_namespace_management/)
      - [ ] [Setup RBAC](https://kueue.sigs.k8s.io/docs/tasks/manage/rbac/)
      - [ ] [Administer Cluster Quotas](https://kueue.sigs.k8s.io/docs/tasks/manage/administer_cluster_quotas/)
      - [ ] [Share Quotas](https://kueue.sigs.k8s.io/docs/tasks/manage/share_quotas_across_flavors/ "Share Quotas Across Resource Flavors")
      - [ ] [Monitor pending Workloads](https://kueue.sigs.k8s.io/docs/tasks/manage/monitor_pending_workloads/)
        - [ ] [Pending Workloads on-demand](https://kueue.sigs.k8s.io/docs/tasks/manage/monitor_pending_workloads/pending_workloads_on_demand/)
        - [ ] [Pending Workloads in Grafana](https://kueue.sigs.k8s.io/docs/tasks/manage/monitor_pending_workloads/pending_workloads_in_grafana/)
      - [ ] [Run job with WorkloadPriority](https://kueue.sigs.k8s.io/docs/tasks/manage/run_job_with_workload_priority/)
      - [ ] [Observability](https://kueue.sigs.k8s.io/docs/tasks/manage/observability/)
        - [ ] [Setup Prometheus](https://kueue.sigs.k8s.io/docs/tasks/manage/observability/setup_prometheus/)
        - [ ] [Common Grafana Queries](https://kueue.sigs.k8s.io/docs/tasks/manage/observability/common_grafana_queries/)
        - [ ] [Monitor actual resource usage](https://kueue.sigs.k8s.io/docs/tasks/manage/observability/monitor_resource_usage/)
        - [ ] [Custom Metric Labels](https://kueue.sigs.k8s.io/docs/tasks/manage/observability/configure_custom_metric_labels/ "Configure Custom Metric Labels")
      - [ ] [Setup All-or-nothing with ready Pods](https://kueue.sigs.k8s.io/docs/tasks/manage/setup_wait_for_pods_ready/)
      - [ ] [Dynamic Resource Allocation](https://kueue.sigs.k8s.io/docs/tasks/manage/setup_dra/ "Set Up Dynamic Resource Allocation")
      - [ ] [Concurrent Admission](https://kueue.sigs.k8s.io/docs/tasks/manage/setup_concurrent_admission/ "Set Up Concurrent Admission")
      - [ ] [Setup a MultiKueue environment](https://kueue.sigs.k8s.io/docs/tasks/manage/setup_multikueue/)
      - [ ] [Setup garbage-collection of workload](https://kueue.sigs.k8s.io/docs/tasks/manage/setup_object_retention_policy/)
      - [ ] [Setup failure recovery](https://kueue.sigs.k8s.io/docs/tasks/manage/setup_failure_recovery/)
      - [ ] [Enable KueueViz](https://kueue.sigs.k8s.io/docs/tasks/manage/enable_kueueviz/)
    - [ ] [Run Workloads](https://kueue.sigs.k8s.io/docs/tasks/run/)
      - [ ] [Kubernetes Jobs](https://kueue.sigs.k8s.io/docs/tasks/run/jobs/ "Run A Kubernetes Job")
      - [ ] [Kubernetes CronJobs](https://kueue.sigs.k8s.io/docs/tasks/run/run_cronjobs/ "Run A CronJob")
      - [ ] [HAMi vGPU](https://kueue.sigs.k8s.io/docs/tasks/run/using_hami/ "Using HAMi")
      - [ ] [LeaderWorkerSet](https://kueue.sigs.k8s.io/docs/tasks/run/leaderworkerset/ "Run LeaderWorkerSet")
      - [ ] [AppWrappers](https://kueue.sigs.k8s.io/docs/tasks/run/appwrappers/ "Run An AppWrapper")
      - [ ] [TrainJobs](https://kueue.sigs.k8s.io/docs/tasks/run/trainjobs/ "Run A TrainJob")
      - [ ] [Deployment](https://kueue.sigs.k8s.io/docs/tasks/run/deployment/ "Run Deployment")
      - [ ] [StatefulSet](https://kueue.sigs.k8s.io/docs/tasks/run/statefulset/ "Run StatefulSet")
      - [ ] [Plain Pods](https://kueue.sigs.k8s.io/docs/tasks/run/plain_pods/ "Run Plain Pods")
      - [ ] [DRA](https://kueue.sigs.k8s.io/docs/tasks/run/dra/ "Run Workloads With DRA Devices")
      - [ ] [Kubeflow Jobs (v1)](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/)
        - [ ] [Run a JAXJob](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/jaxjobs/)
        - [ ] [Run a PaddleJob](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/paddlejobs/)
        - [ ] [Run a XGBoostJob](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/xgboostjobs/)
        - [ ] [Run a TFJob](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/tfjobs/)
        - [ ] [Run a PyTorchJob](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/pytorchjobs/)
        - [ ] [Run a MPIJob](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/mpijobs/)
        - [ ] [Run a SparkApplication](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/sparkapplications/)
      - [ ] [Python](https://kueue.sigs.k8s.io/docs/tasks/run/python_jobs/ "Run Jobs Using Python")
      - [ ] [Jobsets](https://kueue.sigs.k8s.io/docs/tasks/run/jobsets/ "Run A JobSet")
      - [ ] [Topology-Aware Scheduling](https://kueue.sigs.k8s.io/docs/tasks/run/topology_aware_scheduling/ "Run Workloads with Topology-Aware Scheduling")
      - [ ] [Multi-Cluster](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/ "Multi-Cluster Job dispatching")
        - [ ] [Deployment](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/deployment/ "Run Deployment in Multi-Cluster")
        - [ ] [Plain Pod](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/plain_pods/ "Run Plain Pod in Multi-Cluster")
        - [ ] [StatefulSet](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/statefulset/ "Run StatefulSet in Multi-Cluster")
        - [ ] [Kubernetes Job](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/job/ "Run Kubernetes Job in Multi-Cluster")
        - [ ] [TrainJob](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/trainjob/ "Run TrainJobs in Multi-Cluster")
        - [ ] [AppWrappers](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/appwrapper/ "Run AppWrappers in Multi-Cluster")
        - [ ] [Jobsets](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/jobsets/ "Run Jobsets in Multi-Cluster")
        - [ ] [KubeRay](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/kuberay/ "Run KubeRay Jobs in Multi-Cluster")
        - [ ] [Kubeflow (v1)](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/kubeflow/ "Run Kubeflow Jobs (v1) in Multi-Cluster")
        - [ ] [External Framework Jobs](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/external-frameworks/ "Run External Framework Jobs in Multi-Cluster")
        - [ ] [MPIJob](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/mpijob/ "Run MPIJobs in Multi-Cluster")
        - [ ] [LeaderWorkerSet](https://kueue.sigs.k8s.io/docs/tasks/run/multikueue/leaderworkerset/ "Run LeaderWorkerSet in Multi-Cluster")
      - [ ] [External Frameworks](https://kueue.sigs.k8s.io/docs/tasks/run/external_workloads/ "Supporting External Frameworks")
        - [ ] [Custom Workload](https://kueue.sigs.k8s.io/docs/tasks/run/external_workloads/wrapped_custom_workload/ "Run A Wrapped Custom Workload")
        - [ ] [Flux MiniClusters](https://kueue.sigs.k8s.io/docs/tasks/run/external_workloads/flux_miniclusters/ "Run A Flux MiniCluster")
        - [ ] [Argo Workflow](https://kueue.sigs.k8s.io/docs/tasks/run/external_workloads/argo_workflow/ "Run An Argo Workflow")
        - [ ] [Tekton Pipeline](https://kueue.sigs.k8s.io/docs/tasks/run/external_workloads/tektoncd/ "Run A Tekton Pipeline")
        - [ ] [Sandbox](https://kueue.sigs.k8s.io/docs/tasks/run/external_workloads/sandbox/ "Run A Sandbox")
      - [ ] [RayServices](https://kueue.sigs.k8s.io/docs/tasks/run/rayservices/ "Run A RayService")
      - [ ] [RayClusters](https://kueue.sigs.k8s.io/docs/tasks/run/rayclusters/ "Run A RayCluster")
      - [ ] [RayJobs](https://kueue.sigs.k8s.io/docs/tasks/run/rayjobs/ "Run A RayJob")
    - [ ] [Developer Tools](https://kueue.sigs.k8s.io/docs/tasks/dev/)
      - [ ] [Enabling pprof endpoints](https://kueue.sigs.k8s.io/docs/tasks/dev/enabling_pprof_endpoints/)
      - [ ] [Setup Dev Monitoring](https://kueue.sigs.k8s.io/docs/tasks/dev/setup_dev_monitoring/)
      - [ ] [Setup MultiKueue Development Environment](https://kueue.sigs.k8s.io/docs/tasks/dev/setup_multikueue_development_environment/)
      - [ ] [External Frameworks](https://kueue.sigs.k8s.io/docs/tasks/dev/external_frameworks/)
      - [ ] [Integrate a custom Job with Kueue](https://kueue.sigs.k8s.io/docs/tasks/dev/integrate_a_custom_job/)
      - [ ] [Develop an AdmissionCheck Controller](https://kueue.sigs.k8s.io/docs/tasks/dev/develop-acc/)
    - [ ] [Troubleshooting](https://kueue.sigs.k8s.io/docs/tasks/troubleshooting/)
      - [ ] [Troubleshooting Jobs](https://kueue.sigs.k8s.io/docs/tasks/troubleshooting/troubleshooting_jobs/)
      - [ ] [Troubleshooting Queues](https://kueue.sigs.k8s.io/docs/tasks/troubleshooting/troubleshooting_queues/)
      - [ ] [Troubleshooting Provisioning Request in Kueue](https://kueue.sigs.k8s.io/docs/tasks/troubleshooting/troubleshooting_provreq/)
      - [ ] [Troubleshooting Pods](https://kueue.sigs.k8s.io/docs/tasks/troubleshooting/troubleshooting_pods/)
      - [ ] [Troubleshooting delete ClusterQueue](https://kueue.sigs.k8s.io/docs/tasks/troubleshooting/troubleshooting_delete_clusterqueue/)
      - [ ] [Troubleshooting with Agent Skills](https://kueue.sigs.k8s.io/docs/tasks/troubleshooting/troubleshooting_agent_skills/)
  - [ ] [Reference](https://kueue.sigs.k8s.io/docs/reference/)
    - [ ] [Kubectl Kueue Plugin](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/)
      - [ ] [Installation](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/installation/)
      - [ ] [Commands](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/)
        - [ ] [kueuectl](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl/)
        - [ ] [kueuectl create](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_create/)
          - [ ] [kueuectl create clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_create/kueuectl_create_clusterqueue/)
          - [ ] [kueuectl create localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_create/kueuectl_create_localqueue/)
          - [ ] [kueuectl create resourceflavor](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_create/kueuectl_create_resourceflavor/)
        - [ ] [kueuectl delete](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_delete/)
          - [ ] [kueuectl delete clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_delete/kueuectl_delete_clusterqueue/)
          - [ ] [kueuectl delete localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_delete/kueuectl_delete_localqueue/)
          - [ ] [kueuectl delete resourceflavor](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_delete/kueuectl_delete_resourceflavor/)
          - [ ] [kueuectl delete workload](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_delete/kueuectl_delete_workload/)
        - [ ] [kueuectl describe](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_describe/)
          - [ ] [kueuectl describe clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_describe/kueuectl_describe_clusterqueue/)
          - [ ] [kueuectl describe localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_describe/kueuectl_describe_localqueue/)
          - [ ] [kueuectl describe resourceflavor](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_describe/kueuectl_describe_resourceflavor/)
          - [ ] [kueuectl describe workload](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_describe/kueuectl_describe_workload/)
        - [ ] [kueuectl edit](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_edit/)
          - [ ] [kueuectl edit clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_edit/kueuectl_edit_clusterqueue/)
          - [ ] [kueuectl edit localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_edit/kueuectl_edit_localqueue/)
          - [ ] [kueuectl edit resourceflavor](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_edit/kueuectl_edit_resourceflavor/)
          - [ ] [kueuectl edit workload](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_edit/kueuectl_edit_workload/)
        - [ ] [kueuectl get](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_get/)
          - [ ] [kueuectl get clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_get/kueuectl_get_clusterqueue/)
          - [ ] [kueuectl get localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_get/kueuectl_get_localqueue/)
          - [ ] [kueuectl get resourceflavor](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_get/kueuectl_get_resourceflavor/)
          - [ ] [kueuectl get workload](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_get/kueuectl_get_workload/)
        - [ ] [kueuectl list](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_list/)
          - [ ] [kueuectl list clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_list/kueuectl_list_clusterqueue/)
          - [ ] [kueuectl list localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_list/kueuectl_list_localqueue/)
          - [ ] [kueuectl list pods](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_list/kueuectl_list_pods/)
          - [ ] [kueuectl list resourceflavor](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_list/kueuectl_list_resourceflavor/)
          - [ ] [kueuectl list workload](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_list/kueuectl_list_workload/)
        - [ ] [kueuectl patch](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_patch/)
          - [ ] [kueuectl patch clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_patch/kueuectl_patch_clusterqueue/)
          - [ ] [kueuectl patch localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_patch/kueuectl_patch_localqueue/)
          - [ ] [kueuectl patch resourceflavor](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_patch/kueuectl_patch_resourceflavor/)
          - [ ] [kueuectl patch workload](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_patch/kueuectl_patch_workload/)
        - [ ] [kueuectl resume](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_resume/)
          - [ ] [kueuectl resume clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_resume/kueuectl_resume_clusterqueue/)
          - [ ] [kueuectl resume localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_resume/kueuectl_resume_localqueue/)
          - [ ] [kueuectl resume workload](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_resume/kueuectl_resume_workload/)
        - [ ] [kueuectl stop](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_stop/)
          - [ ] [kueuectl stop clusterqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_stop/kueuectl_stop_clusterqueue/)
          - [ ] [kueuectl stop localqueue](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_stop/kueuectl_stop_localqueue/)
          - [ ] [kueuectl stop workload](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_stop/kueuectl_stop_workload/)
        - [ ] [kueuectl version](https://kueue.sigs.k8s.io/docs/reference/kubectl-kueue/commands/kueuectl_version/)
    - [ ] [Component tools](https://kueue.sigs.k8s.io/docs/reference/components-tools/)
      - [ ] [Feature Gates (removed)](https://kueue.sigs.k8s.io/docs/reference/components-tools/feature-gate-removed/)
    - [ ] [Labels and Annotations](https://kueue.sigs.k8s.io/docs/reference/labels-and-annotations/)
    - [ ] [Prometheus Metrics](https://kueue.sigs.k8s.io/docs/reference/metrics/)
    - [ ] [Kueue Configuration v1beta1 API](https://kueue.sigs.k8s.io/docs/reference/kueue-config.v1beta1/)
    - [ ] [Kueue Configuration v1beta2 API](https://kueue.sigs.k8s.io/docs/reference/kueue-config.v1beta2/)
    - [ ] [Kueue v1beta1 API](https://kueue.sigs.k8s.io/docs/reference/kueue.v1beta1/)
    - [ ] [Kueue v1beta2 API](https://kueue.sigs.k8s.io/docs/reference/kueue.v1beta2/)
  - [ ] [Talks and presentations](https://kueue.sigs.k8s.io/docs/talks_and_presentations/)
  - [ ] [Contribution Guidelines](https://kueue.sigs.k8s.io/docs/contribution_guidelines/)
    - [ ] [Development](https://kueue.sigs.k8s.io/docs/contribution_guidelines/development/)
    - [ ] [Running tests](https://kueue.sigs.k8s.io/docs/contribution_guidelines/testing/ "Running and debugging tests")
  - [ ] [Adopters](https://kueue.sigs.k8s.io/docs/adopters/)

[View this page](https://github.com/kubernetes-sigs/kueue/tree/main/site/content/en/docs/overview/_index.md) [Edit this page](https://github.com/kubernetes-sigs/kueue/edit/main/site/content/en/docs/overview/_index.md) [Create child page](https://github.com/kubernetes-sigs/kueue/new/main/site/content/en/docs/overview?filename=change-me.md&value=---%0Atitle%3A+%22Long+Page+Title%22%0AlinkTitle%3A+%22Short+Nav+Title%22%0Aweight%3A+100%0Adescription%3A+%3E-%0A+++++Page+description+for+heading+and+indexes.%0A---%0A%0A%23%23+Heading%0A%0AEdit+this+template+to+create+your+new+page.%0A%0A%2A+Give+it+a+good+name%2C+ending+in+%60.md%60+-+e.g.+%60getting-started.md%60%0A%2A+Edit+the+%22front+matter%22+section+at+the+top+of+the+page+%28weight+controls+how+its+ordered+amongst+other+pages+in+the+same+directory%3B+lowest+number+first%29.%0A%2A+Add+a+good+commit+message+at+the+bottom+of+the+page+%28%3C80+characters%3B+use+the+extended+description+field+for+more+detail%29.%0A%2A+Create+a+new+branch+so+you+can+preview+your+new+file+and+request+a+review+via+Pull+Request.%0A) [Create issue](https://github.com/kubernetes-sigs/kueue/issues/new?title=Overview) [Create project issue](https://github.com/kubernetes-sigs/kueue/issues/new)

- [Why use Kueue](https://kueue.sigs.k8s.io/docs/overview/#why-use-kueue)
- [Features overview](https://kueue.sigs.k8s.io/docs/overview/#features-overview)
- [Job-integrated features](https://kueue.sigs.k8s.io/docs/overview/#job-integrated-features)
- [High-level Kueue operation](https://kueue.sigs.k8s.io/docs/overview/#high-level-kueue-operation)

1. [Documentation](https://kueue.sigs.k8s.io/docs/)
2. Overview

# Overview

Why Kueue?

Kueue is a kubernetes-native system that manages quotas and how jobs consume them. Kueue decides when a job should wait, when a job should be admitted to start (as in pods can be created) and when a job should be preempted (as in active pods should be deleted).

## Why use Kueue

You can install Kueue on top of a vanilla Kubernetes cluster. Kueue does not replace any existing Kubernetes components. Kueue is compatible with cloud environments where:

- Compute resources are elastic and can be scaled up and down.
- Compute resources are heterogeneous (in architecture, availability, price, etc.).

Kueue APIs allow you to express:

- Quotas and policies for Fair Sharing among tenants.
- Resource fungibility: if a resource flavor is fully utilized, Kueue can admit the job using a different flavor.

A core design principle for Kueue is to avoid duplicating mature functionality in Kubernetes components and well-established third-party controllers. Autoscaling, pod-to-node scheduling and job lifecycle management are the responsibility of cluster-autoscaler, kube-scheduler and kube-controller-manager, respectively. Advanced admission control can be delegated to controllers such as gatekeeper.

## Features overview

- **Job management:** Support job queueing based on [priorities](https://kueue.sigs.k8s.io/docs/concepts/workload/#priority) with different [strategies](https://kueue.sigs.k8s.io/docs/concepts/cluster_queue/#queueing-strategy): `StrictFIFO` and `BestEffortFIFO`.
- **Advanced Resource management:** Comprising: [resource flavor fungibility](https://kueue.sigs.k8s.io/docs/concepts/cluster_queue/#flavorfungibility), [Fair Sharing](https://kueue.sigs.k8s.io/docs/concepts/preemption/#fair-sharing), [Cohorts](https://kueue.sigs.k8s.io/docs/concepts/cohort/) and [preemption](https://kueue.sigs.k8s.io/docs/concepts/cluster_queue/#preemption) with a variety of policies between different tenants.
- **Integrations:** Built-in support for popular jobs, e.g. [BatchJob](https://kueue.sigs.k8s.io/docs/tasks/run/jobs/), [Kubeflow training jobs](https://kueue.sigs.k8s.io/docs/tasks/run/kubeflow/), [RayJob](https://kueue.sigs.k8s.io/docs/tasks/run/rayjobs/), [RayCluster](https://kueue.sigs.k8s.io/docs/tasks/run/rayclusters/), [JobSet](https://kueue.sigs.k8s.io/docs/tasks/run/jobsets/), [AppWrappers](https://kueue.sigs.k8s.io/docs/tasks/run/appwrappers/), [plain Pod and Pod Groups](https://kueue.sigs.k8s.io/docs/tasks/run/plain_pods/).
- **System insight:** Build-in [prometheus metrics](https://kueue.sigs.k8s.io/docs/reference/metrics/) to help monitor the state of the system, and on-demand visibility endpoint for [monitoring of pending workloads](https://kueue.sigs.k8s.io/docs/tasks/manage/monitor_pending_workloads/pending_workloads_on_demand/).
- **AdmissionChecks:** A mechanism for internal or external components to influence whether a workload can be [admitted](https://kueue.sigs.k8s.io/docs/concepts/admission_check/).
- **Advanced autoscaling support:** Integration with cluster-autoscaler’s [provisioningRequest](https://kueue.sigs.k8s.io/docs/concepts/admission_check/provisioning_request/#job-using-a-provisioningrequest) via admissionChecks.
- **All-or-nothing with ready Pods:** A timeout-based implementation of [All-or-nothing scheduling](https://kueue.sigs.k8s.io/docs/tasks/manage/setup_wait_for_pods_ready/).
- **Partial admission and dynamic reclaim:** mechanisms to run a job with [reduced parallelism](https://kueue.sigs.k8s.io/docs/tasks/run/jobs/#partial-admission), based on available quota, and to [release](https://kueue.sigs.k8s.io/docs/concepts/workload/#dynamic-reclaim) the quota the pods complete..
- **Mixing training and inference**: Simultaneous management of batch workloads along with serving workloads (such as [Deployments](https://kueue.sigs.k8s.io/docs/tasks/run/deployment/) or [StatefulSets](https://kueue.sigs.k8s.io/docs/tasks/run/statefulset/))
- **Multi-cluster job dispatching:** called [MultiKueue](https://kueue.sigs.k8s.io/docs/concepts/multikueue/), allows to search for capacity and off-load the main cluster.
- **Topology-Aware Scheduling**: Allows to optimize the pod-pod communication throughput by [scheduling aware of the data-center topology](https://kueue.sigs.k8s.io/docs/concepts/topology_aware_scheduling/).

## Job-integrated features

| Feature | Batch Job | JobSet | PaddleJob | PytorchJob | TFJob | TrainJob | XGBoostJob | MPIJob | JAXJob | Pod | RayCluster | RayJob | AppWrapper | Deployment | StatefulSet | LeaderWorkerSet |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [Dynamic Reclaim](https://kueue.sigs.k8s.io/docs/concepts/workload/#dynamic-reclaim) | + | + |  |  |  | + |  |  |  | + |  |  |  |  |  |  |
| [MultiKueue](https://kueue.sigs.k8s.io/docs/concepts/multikueue/) | + | + | + | + | + | + | + | + | + |  | + | + | + |  | + | + |
| [PartialAdmission](https://kueue.sigs.k8s.io/docs/tasks/run/jobs/#partial-admission) | + |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| [Workload Priority Class](https://kueue.sigs.k8s.io/docs/concepts/workload_priority_class/) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |
| [FlavorFungibility](https://kueue.sigs.k8s.io/docs/concepts/cluster_queue/#flavorfungibility) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |
| [ProvisioningACC](https://kueue.sigs.k8s.io/docs/concepts/admission_check/provisioning_request/) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |
| [VisibilityOnDemand](https://kueue.sigs.k8s.io/docs/tasks/manage/monitor_pending_workloads/pending_workloads_on_demand/) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |
| [PrioritySortingWithinCohort](https://kueue.sigs.k8s.io/docs/concepts/cluster_queue/#flavors-and-borrowing-semantics) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |
| [LendingLimit](https://kueue.sigs.k8s.io/docs/concepts/cluster_queue/#lendinglimit) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |
| [All-or-nothing with ready Pods](https://kueue.sigs.k8s.io/docs/concepts/workload/#all-or-nothing-semantics-for-job-resource-assignment) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |
| [Fair Sharing](https://kueue.sigs.k8s.io/docs/concepts/preemption/#fair-sharing) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |
| [Topology Aware Scheduling](https://kueue.sigs.k8s.io/docs/concepts/topology_aware_scheduling/) | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + | + |

## High-level Kueue operation

![High Level Kueue Operation](https://kueue.sigs.k8s.io/images/theory-of-operation.svg)

To learn more about Kueue concepts, see the [concepts](https://kueue.sigs.k8s.io/docs/concepts/) section.

To learn about different Kueue personas and what you can do with Kueue, see the [tasks](https://kueue.sigs.k8s.io/docs/tasks/) section.

## Feedback

Was this page helpful?

YesNo

Glad to hear it! Please [tell us how we can improve](https://github.com/kubernetes-sigs/kueue/issues/new).

Sorry to hear that. Please [tell us how we can improve](https://github.com/kubernetes-sigs/kueue/issues/new).

Last modified February 9, 2026: [promote multikueue batch job to GA (#8877) (31137234b)](https://github.com/kubernetes-sigs/kueue/commit/31137234b4c4eba1e94c4335abaa7c847acd0fb4)

- [User mailing list](https://groups.google.com/a/kubernetes.io/g/wg-batch)
- [Twitter](https://twitter.com/kubernetesio)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/kubernetes)
- [Slack](https://kubernetes.slack.com/messages/wg-batch)

© 2026 The Kubernetes Authors \| Documentation Distributed under CC BY 4.0

© The Linux Foundation has registered trademarks and uses trademarks. For a list of trademarks of The Linux Foundation,
please see our [Trademark Usage page](https://www.linuxfoundation.org/legal/trademark-usage).

Clear