# CCS3308 – Virtualization and Containers
## Practical Lab Sheet — Kubernetes Fundamentals with Minikube
### Checkpoint Questions & Answers

---

### Checkpoint Q1
**In your own words, explain the difference between the control plane and a worker node.**

- **Control Plane**: Works as the brain of the cluster. Cluster state management, workload scheduling, node failure detection, and Kubernetes API exposure are primary functions of the control plane.
- **Worker Node**: Works as the compute power of the cluster. Application containers are run here, along with node networking and status reporting through `kubelet`.

---

### Checkpoint Q2
**Delete the pod (`kubectl delete pod frontend`), then recreate it from the same manifest and check its IP with `kubectl get pods -o wide`. Has the IP changed? Explain why, using the lecture's description of Pods as "ephemeral."**

- **Answer**: Yes, the IP address has changed.
- **Explanation**: This happens because Kubernetes Pods are **ephemeral** (temporary/disposable). When a Pod is deleted and recreated, Kubernetes creates a fresh container instance and dynamically assigns it a new IP address rather than reusing the old one.

---

### Checkpoint Q3
**Using the lecture's control-loop model — Desired State → Controller watches → Actual State → Gap Detected → Reconcile — describe, step by step, exactly what Kubernetes did when you deleted the pod.**

When the pod was deleted, the Kubernetes Deployment / ReplicaSet Controller reconciled the state using the control-loop model as follows:
1. **Desired State**: The Deployment manifest defines `replicas: 3`, meaning the cluster must continuously maintain exactly 3 running frontend pod instances.
2. **Controller Watches**: The Controller Manager constantly monitors the actual state of the cluster via the API Server.
3. **Actual State & Gap Detected**: Upon deleting a pod, the actual count of healthy frontend pods dropped from 3 to 2. The controller immediately detected a gap between the Desired State (3) and Actual State (2).
4. **Reconcile**: To bridge the gap, the controller instructed the API Server to schedule and spin up a new replacement pod, restoring the cluster back to its desired state of 3 running pods.

---

### Checkpoint Q4
**The lecture's "Applications Are Multiple Containers" slide states that each service can scale independently. Once you deploy the database tier in Part 7, why will you be able to scale the frontend without touching it?**

- Both the frontend and database tiers are microservices that run in separate containers. 
- The frontend is **stateless** and processes user traffic and HTTP requests, making it easy for Kubernetes to increase or reduce the number of frontend Pod replicas to match the traffic load. 
- On the other hand, the database tier is **stateful** and handles its own data persistence. 
- Since their resource lifecycle and workloads are independent of each other, scaling the stateless frontend tier does not affect the database tier.

---

### Checkpoint Q5
**What is the difference between accessing a Pod directly via port-forward (Part 2) and accessing it through a Service (Part 5)? Why do Services matter, given that Pods are ephemeral and get new IPs when replaced?**

- **Port-Forward vs. Service**: `kubectl port-forward` establishes a temporary tunnel that connects directly to a single, specific Pod instance. In comparison, a Service represents a stable entry point that dynamically load-balances and distributes traffic between all active backend Pod instances matching the selector (`app: frontend`).
- **Why We Need Services**: As Pods are temporary and receive dynamic new IP addresses each time they are replaced, restarted, or rescaled, communicating directly via individual Pod IP addresses would result in broken connections. Services provide a persistent IP and DNS name to abstract this away.

---

### Checkpoint Q6
**Referring to the lecture's list of things "Docker Compose Cannot" do, explain why this same update-and-rollback would be much harder to do safely with Docker Compose alone.**

- **No Rolling Updates with Zero Downtime**: Docker Compose stops existing containers before recreating new ones when updating an image. Kubernetes offers automated rolling updates that update Pods incrementally, ensuring uninterrupted application availability.
- **Automated Rollbacks Not Supported**: Docker Compose lacks native functionality for tracking deployment version history and health. If an updated image fails, Docker Compose cannot automatically detect it or perform an instant one-command rollback like `kubectl rollout undo`.

---

### Checkpoint Q7
**Explain why the frontend and API tiers use a Deployment while the database tier uses a StatefulSet. Refer to the lecture's Stateless vs Stateful comparison (pod naming, storage, ordering).**

- **Pod Naming**: Random and interchangeable Pod names (e.g., `frontend-7d9c66-x8z9`) are used by Deployments, while StatefulSets utilize fixed and sticky network identities (e.g., `postgres-0`) required for cluster member discovery.
- **Persistent Storage**: Pods created by Deployments rely on ephemeral container storage that is destroyed upon Pod deletion. StatefulSets provide unique and persistent storage to each Pod via `volumeClaimTemplates`.
- **Ordering of Deployment & Scaling**: Deployments create, update, and scale Pods concurrently without strict order. StatefulSets deploy, update, and scale Pods sequentially (one by one).

---

### Checkpoint Q8
**Would this data have survived if postgres had instead been deployed as a plain Deployment without a PersistentVolumeClaim? Explain your reasoning.**

- **Answer**: No, the data would not have survived.
- **Reasoning**: Plain Deployments use local ephemeral container storage. When a Pod in a plain Deployment is deleted, its entire container filesystem is permanently destroyed. The data survived in this task because PostgreSQL was deployed as a **StatefulSet** backed by a **PersistentVolumeClaim (PVC)**, which decouples the storage volume's lifecycle from the Pod's lifecycle.

---

### Checkpoint Q9
**What status did the broken pod show? Compare it against the lecture's Pod Status table (Running / Pending / CrashLoopBackOff / OOMKilled) — does it match one of these exactly, or is it a related status not explicitly listed? Explain what it means.**

- **Status Shown**: The broken pod showed `ErrImagePull`, which quickly transitioned to `ImagePullBackOff`.
- **Comparison & Meaning**: It does **not** match core runtime statuses like `Running`, `Pending`, `CrashLoopBackOff`, or `OOMKilled` directly; it is an image retrieval failure.
  - **`ErrImagePull`**: Indicates Kubernetes failed to locate or download the specified image (`nginx:definitely-not-a-real-tag`).
  - **`ImagePullBackOff`**: Means Kubernetes is backing off and waiting exponentially before retrying to pull the invalid image again.
