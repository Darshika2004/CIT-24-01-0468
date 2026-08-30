# CCS3308 – Virtualization and Containers
## Lab 06: Kubernetes Fundamentals with Minikube

**Name:** G.Darshika Nuwangani (CIT-24-01-0468) 
**Module:** CCS3308 - Virtualization and Containers  
**Week:** Week 7 · Container Orchestration & Kubernetes  

---

## 📌 Overview
This repository contains the setup and deployment scripts for a multi-container application on a single-node Kubernetes cluster using Minikube. It demonstrates core Kubernetes concepts including Pods, Deployments, Services, StatefulSets with Persistent Volumes, Rolling Updates, Self-healing, and Observability.

---
## 🛠️ Environment Setup & Cluster Initialization
- **Environment:** Ubuntu 24.04 LTS running on VMware Virtual Platform
- **Cluster Driver:** Docker driver
- **Installed Tools:** Docker v29.7.2, Minikube v1.38.1, kubectl v1.37.0

---

## 🏗️ Application Architecture
The deployed application follows a 4-tier microservices architecture:
- **Frontend Tier:** `nginx:alpine` (Deployment - 3 Replicas, NodePort Service)
- **API Tier:** `kennethreitz/httpbin` (Deployment - 2 Replicas, ClusterIP Service)
- **Cache Tier:** `redis:7-alpine` (Deployment - 1 Replica, ClusterIP Service)
- **Database Tier:** `postgres:16-alpine` (StatefulSet - 1 Replica with 1Gi PVC, Headless Service)

---

## 📁 Repository Structure
```text
lab6/
├── k8s/
│   ├── pod-frontend.yaml
│   ├── deployment-frontend.yaml
│   ├── service-frontend.yaml
│   ├── api-deployment.yaml
│   ├── api-service.yaml
│   ├── cache-deployment.yaml
│   ├── cache-service.yaml
│   ├── postgres-statefulset.yaml
│   └── postgres-service.yaml
├── screenshots/
│   ├── Task 1.1 Screenshot.png
│   ├── task2.1 Screenshot.png
│   ├── Task 3.1 Before screenshot.png
│   ├── Task 3.1 After screenshot.png
│   ├── Task 4.1 Before screenshot.png
│   ├── Task 4.1 After scale up screenshot.png
│   ├── Task 4.1 After scale down screenshot.png
│   ├── Task 5.1 screenshot.png
│   ├── Task 6.1 Rolling update screenshot.png
│   ├── Task 6.1 Rollback screenshot.png
│   ├── Task 7.1 screenshot.png
│   ├── Task 7.2 screenshot.png
│   ├── Task 8.1 screenshot.png
│   ├── Task 9.1 sceernshot.png
│   └── Task 10.1 screenshot.png
├── answers.md
└── README.md
- **Checkpoint Answers:** Detailed answers and theoretical explanations for Checkpoint Questions Q1 – Q9 are fully documented in [`answers.md`](./answers.md).
- **Execution Screenshots:** Terminal execution screenshots for each task are organized inside the [`screenshots/`](./screenshots/) directory.

---

## 🚀 Part-by-Part Implementation & Results

### Part 1: Explore Cluster Architecture
- Task 1.1: Verified control plane and cluster system pods using "kubectl get pods -n kube-system".
  - System components (coredns, etcd-minikube, kube-apiserver-minikube, kube-controller-manager-minikube, kube-proxy, kube-scheduler, storage-provisioner) were verified running successfully with 1/1 status.

- **Task 1.2 — Pod Mapping:**
  - `kube-apiserver-minikube` — API Server (`kube-apiserver`) | Control Plane Layer
  - `etcd-minikube` — Key-Value Store (`etcd`) | Control Plane Layer
  - `kube-scheduler-minikube` — Scheduler (`kube-scheduler`) | Control Plane Layer
  - `kube-controller-manager-minikube` — Controller Manager (`kube-controller-manager`) | Control Plane Layer
  - `kube-proxy-mqr6w` — Network Proxy (`kube-proxy`) | Worker Node Layer
  - `coredns-7d764666f9-rsn9j` — Cluster DNS (`coredns`) | Cluster Add-on Layer
  - `storage-provisioner` — Dynamic Storage Provisioner | Minikube Add-on Layer



---

### Part 2: Your First Pod
- Created a standalone frontend pod using `k8s/pod-frontend.yaml` (`nginx:alpine`).
- Verified pod status and inspected properties using `kubectl describe pod frontend`.
- Checked container logs using `kubectl logs frontend`.
- Executed local port-forwarding using `kubectl port-forward pod/frontend 8080:80` and verified application access via local browser.

---

### Part 3: From Pod to Deployment: Self-Healing in Action
- Deployed 3 frontend replicas using `k8s/deployment-frontend.yaml`.
- Verified deployment and replica sets using `kubectl get deployments` and `kubectl get rs`.
- Tested Kubernetes self-healing mechanism by manually deleting a running pod (`kubectl delete pod frontend-9d6559d7-9pc4s`).
- Verified that the controller manager immediately detected the state discrepancy and provisioned a replacement pod (`frontend-9d6559d7-rmdrf`) to maintain the desired count of 3 replicas.

---

### Part 4: Scaling the Deployment
Executed dynamic workload scaling using `kubectl scale`:
- **Initial Stage:** Default deployment manifest deployed 3 active pods.
- **Scale Up Stage:** Ran `kubectl scale deployment frontend --replicas=5` — Scaled up to 5 pods successfully.
- **Scale Down Stage:** Ran `kubectl scale deployment frontend --replicas=2` — Scaled down to 2 pods gracefully.


---

### Part 5: Exposing the Deployment with a Service
- Created `NodePort` service via `k8s/service-frontend.yaml` targeting port 80.
- Inspected Service cluster IP and NodePort binding using `kubectl get services`.
- Accessed the frontend application using `minikube service frontend --url` (`http://192.168.49.2:30543`).

---

### Part 6: Rolling Updates and Rollbacks
- Rolling Update: Updated deployment image seamlessly using `kubectl set image deployment/frontend frontend=nginx:1.27-alpine`.
- Inspected rollout status and revision history using `kubectl rollout status deployment/frontend` and `kubectl rollout history deployment/frontend`.
- Rollback: Reverted the update using `kubectl rollout undo deployment/frontend`.

---

### Part 7: Deploying the Full Multi-Container Application
- Deployed the complete microservice architecture stack using `kubectl apply -f k8s/`:
  - `api` (Deployment & ClusterIP Service)
  - `cache` (Deployment & ClusterIP Service)
  - `frontend` (Deployment & NodePort Service)
  - `postgres` (StatefulSet & Headless Service)
- Tested internal cluster DNS connectivity using an ephemeral debug container:
  - Executed debug pod: `kubectl run debugpod --rm -it --image=busybox:1.35 --restart=Never -- sh`
  - Verified API Service endpoint: `wget -qO- http://api-service`
  - Verified Cache Service DNS resolution: `nslookup cache-service`

---

### Part 8: Verifying Persistence
- Connected to database pod shell: `kubectl exec -it postgres-0 -- psql -U postgres`
- Executed SQL commands to create a demo table and insert test data:
  - `CREATE TABLE demo (id serial primary key, note text);`
  - `INSERT INTO demo (note) VALUES ('lab6 test row');`
- Force-deleted the database pod: `kubectl delete pod postgres-0`
- Re-queried the database after pod recreation by StatefulSet: `SELECT * FROM demo;`
- Result: Data successfully persisted (`1 | lab6 test row`), verifying persistent volume binding.

---

### Part 9: Observability and Troubleshooting
- Enabled Metrics Server addon: `minikube addons enable metrics-server`
- Evaluated live resource consumption using `kubectl top pods` and `kubectl top nodes`.
- Deployed misconfigured pod manifest `k8s/broken-pod.yaml` containing an invalid image tag.
- Analyzed failure state using `kubectl describe pod broken-pod` and observed `ErrImagePull` / `ImagePullBackOff` statuses.

---

### Part 10: Cleanup
- Removed all deployed Kubernetes manifests and services: `kubectl delete -f k8s/`
- Verified total resource cleanup: `kubectl get all`
- Gracefully stopped local Minikube cluster: `minikube stop`
