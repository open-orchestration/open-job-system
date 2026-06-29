---
id: d63f65f39
topic: container-batch
title: "Compute substrate: Kubernetes batch primitives, queueing, and the HPC lineage"
status: draft
shape: survey
---

# Compute substrate: Kubernetes batch primitives, queueing, and the HPC lineage

**Scope.** The compute substrate that runs job workloads, from the catalog's
container/batch sources. Covers Kubernetes Jobs and CronJobs, KEDA, Kueue, Slurm, and Dask;
the corpus also holds HTCondor, Nomad, and Ray (not synthesized here).

## Key claims (cited)

- **K8s Job (run-to-completion).** A Job **creates one or more Pods and retries execution
  until a specified number successfully terminate** — the native run-to-completion batch
  primitive [cf56364e3].
- **K8s CronJob (scheduled).** A CronJob performs **regular scheduled actions such as backups
  and report generation** — Jobs on a cron schedule [c635be951].
- **KEDA (event autoscaling).** KEDA is the **Kubernetes Event-driven Autoscaler**, scaling
  workloads from event sources [c41324cb5].
- **Kueue (batch queueing).** Kueue is a **Kubernetes-native system that manages quotas and
  how jobs consume them** — deciding when a job should **wait**, be **admitted** to start, or
  be **preempted** — installed on vanilla Kubernetes without replacing existing components
  [c2747faca].
- **Slurm (HPC scheduler).** Slurm is a fault-tolerant, highly scalable **cluster management
  and job scheduling system** for large and small **Linux clusters**, requiring no kernel
  modifications [c28f50fc4].
- **Dask (language-native parallelism).** Dask is a **Python library for parallel and
  distributed computing** [cf8e4385f].

## Convergent vs contested

- **Convergent:** All provide the substrate that *executes* jobs — accept work, place it on
  compute, run to completion, retry on failure — beneath any queue or orchestrator.
- **Contested / two lineages.** **Cloud-native**: Kubernetes supplies the primitives (Job,
  CronJob) and the ecosystem layers scheduling on top — Kueue for quota/admission/preemption,
  KEDA for event-driven (and scale-to-zero) autoscaling. **HPC**: Slurm (and HTCondor) carry
  decades of mature batch-queue scheduling for Linux clusters. **Language-native**: Dask (and
  Ray) embed parallelism directly in the application runtime. The same "run many tasks on a
  pool" need is solved at three different layers.

## Implications for the system

- For containerized workers, K8s **Job/CronJob** are the run/schedule primitives; add **Kueue**
  when multi-tenant quota/fair-share matters and **KEDA** when workers should scale on queue
  depth (including to zero).
- Don't reinvent batch scheduling: for HPC-shaped parallel workloads, Slurm/HTCondor already
  solve placement and fairness; for in-process parallelism, Dask/Ray. The job core should
  treat the compute substrate as a pluggable execution backend.

## Gaps found → re-scan
- K8s Job completion modes (Indexed jobs, work-queue pattern, pod-failure-policy) — in-corpus, not synthesized.
- HTCondor, Nomad, Ray — not synthesized.
- KEDA scaler catalog + scale-to-zero mechanics; Kueue cohort/borrowing quota model.
