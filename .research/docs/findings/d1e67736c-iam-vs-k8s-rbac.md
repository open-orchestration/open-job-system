---
id: d1e67736c
topic: gap-fill
title: "Authorization models: AWS IAM action/resource/condition keys vs Kubernetes RBAC"
status: draft
shape: comparison
---

# Authorization models: AWS IAM action/resource/condition keys vs Kubernetes RBAC

AWS IAM and Kubernetes RBAC both decide who may perform which operations, but they
express that decision through different primitives: IAM attaches permission policies
that grant actions on resource types under conditions, while Kubernetes RBAC defines
roles of rules and binds them to subjects.

## AWS IAM fine-grained authorization (AWS Batch, AWS Step Functions)

The Service Authorization Reference documents each service's permissions. AWS Batch
(service prefix: `batch`) provides the following service-specific resources, actions,
and condition context keys for use in IAM permission policies. [c6e762213] AWS Step
Functions (service prefix: `states`) provides the following service-specific resources,
actions, and condition context keys for use in IAM permission policies. [cf0410bb1]
Each service page is organized into the same three topics: Actions defined by the
service, Resource types defined by the service, and Condition keys for the service. [c6e762213]

### Actions

You can specify actions in the `Action` element of an IAM policy statement, and you
use policies to grant permissions to perform an operation in AWS. [c6e762213] When you
use an action in a policy, you usually allow or deny access to the API operation or CLI
command with the same name; however, in some cases a single action controls access to
more than one operation, and alternatively some operations require several different
actions. [cf0410bb1]

The Actions table is described by its columns. The **Access level** column describes how
the action is classified (List, Read, Permissions management, or Tagging), and this
classification can help you understand the level of access that an action grants when you
use it in a policy. [c6e762213] The **Resource types** column indicates whether each action
supports resource-level permissions; if there is no value for the column you must specify
all resources ("*") in the `Resource` element, and required resources are indicated in the
table with an asterisk (*). [c6e762213] The **Condition keys** column includes keys that you
can specify in a policy statement's `Condition` element. [c6e762213] The **Dependent actions**
column shows additional permissions that may be required to successfully call an action. [c6e762213]
The same Actions-table structure and Access level classification apply to AWS Step Functions. [cf0410bb1]

### Resource types

The resource types defined by a service can be used in the `Resource` element of IAM
permission policy statements, and each action in the Actions table identifies the resource
types that can be specified with that action. [c6e762213] A resource type can also define
which condition keys you can include in a policy, and those keys are displayed in the last
column of the Resource types table. [cf0410bb1] AWS Batch's Resource types table lists each
resource type with its ARN and associated Condition keys columns. [c6e762213]

### Condition keys

AWS Batch defines condition keys that can be used in the `Condition` element of an IAM
policy, and you can use these keys to further refine the conditions under which the policy
statement applies. [c6e762213] AWS Step Functions likewise defines condition keys that can
be used in the `Condition` element of an IAM policy to further refine the conditions under
which the policy statement applies. [cf0410bb1] The Condition keys table is structured with
Condition keys, Description, and Type columns. [cf0410bb1]

## Kubernetes RBAC

Role-based access control (RBAC) is a method of regulating access to computer or network
resources based on the roles of individual users within your organization. [c46b7793b] RBAC
authorization uses the `rbac.authorization.k8s.io` API group to drive authorization decisions,
allowing you to dynamically configure policies through the Kubernetes API. [c46b7793b] The RBAC
API declares four kinds of Kubernetes object: Role, ClusterRole, RoleBinding and
ClusterRoleBinding. [c46b7793b]

### Role vs ClusterRole

An RBAC Role or ClusterRole contains rules that represent a set of permissions, and
permissions are purely additive (there are no "deny" rules). [c46b7793b] A Role always sets
permissions within a particular namespace, and when you create a Role you have to specify
the namespace it belongs in. [c46b7793b] ClusterRole, by contrast, is a non-namespaced
resource; the resources have different names (Role and ClusterRole) because a Kubernetes
object always has to be either namespaced or not namespaced, and it can't be both. [c46b7793b]
If you want to define a role within a namespace, use a Role; if you want to define a role
cluster-wide, use a ClusterRole. [c46b7793b] A ClusterRole can be used to define permissions
on namespaced resources and be granted access within individual namespaces, define permissions
on namespaced resources and be granted access across all namespaces, or define permissions on
cluster-scoped resources. [c46b7793b]

A rule is expressed over API groups, resources, and verbs; the documented Role grants read
access to pods with `apiGroups: [""]` (the core API group), `resources: ["pods"]`, and
`verbs: ["get", "watch", "list"]`. [c46b7793b]

### RoleBinding vs ClusterRoleBinding

A role binding grants the permissions defined in a role to a user or set of users, and it
holds a list of subjects (users, groups, or service accounts) plus a reference to the role
being granted. [c46b7793b] A RoleBinding grants permissions within a specific namespace whereas
a ClusterRoleBinding grants that access cluster-wide. [c46b7793b] A RoleBinding may reference
any Role in the same namespace, or alternatively a RoleBinding can reference a ClusterRole and
bind that ClusterRole to the namespace of the RoleBinding. [c46b7793b] If you want to bind a
ClusterRole to all the namespaces in your cluster, you use a ClusterRoleBinding. [c46b7793b]

## Conceptual contrast

The two models scope permissions differently. AWS IAM grants are expressed as actions in a
policy's `Action` element, narrowed to resource types in the `Resource` element and further
refined by keys in the `Condition` element. [c6e762213] Kubernetes RBAC instead separates the
permission set from its assignment: a Role or ClusterRole holds the additive rules over
apiGroups/resources/verbs, and a separate RoleBinding or ClusterRoleBinding attaches those
rules to subjects. [c46b7793b] Scope in IAM is carried by resource ARNs and condition keys per
action, [cf0410bb1] whereas scope in RBAC is carried by the namespaced-vs-cluster-wide
distinction between Role/RoleBinding and ClusterRole/ClusterRoleBinding. [c46b7793b]
