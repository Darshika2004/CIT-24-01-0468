# CCS3308 – Virtualization and Containers
## Lab 06: Kubernetes Fundamentals with Minikube

**Name:** G.Darshika Nuwangani  
**Module:** CCS3308 - Virtualization and Containers  
**Week:** Week 7 · Container Orchestration & Kubernetes  

---

## 📌 Overview
This repository contains the setup and deployment scripts for a multi-container application on a single-node Kubernetes cluster using Minikube. It demonstrates core Kubernetes concepts including Pods, Deployments, Services, StatefulSets with Persistent Volumes, Rolling Updates, Self-healing, and Observability.

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

## 🚀 Step-by-Step Implementation & Proofs

### Part 1: Cluster Architecture
- Verified cluster components using `kubectl get pods -n kube-system`.
<img width="1214" height="444" alt="Task 1 1 Screenshot" src="https://github.com/user-attachments/assets/91fca621-ae27-4ed9-b5ae-a48c005e3beb" />


### Part 2: Pod Deployment
- Created and tested the initial frontend pod using `pod-frontend.yaml`.
<img width="691" height="326" alt="task2 1 Screenshot" src="https://github.com/user-attachments/assets/5e5efd00-1a8c-4d60-b5a9-9b9e6b8f6126" />


### Part 3: Self-Healing with Deployments
- Observed Kubernetes self-healing behavior before and after deleting a pod.
- **Before Deleting Pod:**
<img width="982" height="96" alt="Task 3 1 Before screenshot" src="https://github.com/user-attachments/assets/44fc71d1-0093-40e7-b29d-d3516556955f" />


- **After Deleting Pod (Self-Healed):**
<img width="982" height="96" alt="Task 3 1 After screenshot" src="https://github.com/user-attachments/assets/8c6ffd9c-3b28-4f6a-8f3e-7e89c17e052f" />


### Part 4: Scaling
- Scaled frontend replicas up to 5 and down to 2 using `kubectl scale`.
- **Before Scale:**
<img width="982" height="96" alt="Task 4 1 Before screenshot" src="https://github.com/user-attachments/assets/ce5a4d57-0255-45ff-8aaf-606b32e5a06c" />


- **Scale Up to 5:**
<img width="739" height="133" alt="Task 4 1 After scale up screenshot" src="https://github.com/user-attachments/assets/26414341-e20e-4ae3-a2df-039469c42fbb" />


- **Scale Down to 2:**
<img width="742" height="76" alt="Task 4 1 After scale down screenshot" src="https://github.com/user-attachments/assets/20237442-31cc-4738-9f56-1de476097f1f" />


### Part 5: Exposing Services
- Exposed frontend via NodePort service and accessed via browser using `minikube service`.
<img width="670" height="315" alt="Task 5 1 screenshot" src="https://github.com/user-attachments/assets/c03e1420-7414-41d7-86a2-55032cc1b74a" />


### Part 6: Rolling Updates & Rollbacks
- Performed zero-downtime rolling update and executed a rollback using `kubectl rollout undo`.
- **Rolling Update:**
<img width="1096" height="186" alt="Task 6 1 Rolling update screenshot" src="https://github.com/user-attachments/assets/b1e07bed-28db-4f1d-910d-d229d1c6892a" />


- **Rollback:**
<img width="1218" height="130" alt="Task 6 1 Rollback screenshot" src="https://github.com/user-attachments/assets/4dd92248-3588-4b7d-8e6d-c4eb734e4c8b" />


### Part 7: Full Multi-Container App Deployment
- Deployed Frontend, API, Cache, and Database (StatefulSet) tiers.
<img width="764" height="562" alt="Task 7 1 screenshot" src="https://github.com/user-attachments/assets/9d3043d7-bd41-4c62-bbbe-be11e9582169" />


- Verified internal network connectivity using a debug container.
<img width="1209" height="676" alt="Task 7 2 screenshot" src="https://github.com/user-attachments/assets/8bce5dfb-d414-4725-83c5-ff4baf5d7b4d" />


### Part 8: Data Persistence Verification
- Executed SQL query, deleted `postgres-0` pod, and verified data retention after restart.
<img width="1218" height="482" alt="Task 8 1 screenshot" src="https://github.com/user-attachments/assets/d7128527-5f4b-49ca-8898-bb1526233af8" />


### Part 9: Observability & Troubleshooting
- Investigated pod failures (`ErrImagePull` / `ImagePullBackOff`) using `kubectl describe`.
<img width="1201" height="168" alt="Task 9 1 sceernshot" src="https://github.com/user-attachments/assets/83bdac5b-d62f-439f-aebb-1daba917ec8e" />

### Part 10: Cleanup
- Removed all created resources and stopped Minikube cluster.
<img width="658" height="297" alt="Task 10 1 screenshot" src="https://github.com/user-attachments/assets/8a6a709a-9cb5-444c-b126-e24a1445324c" />

