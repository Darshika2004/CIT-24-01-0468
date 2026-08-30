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
![Task 1.1](https://github.com/user-attachments/assets/5bcc7a5c-ca21-48c8-b753-c9c9235122ec)

### Part 2: Pod Deployment
- Created and tested the initial frontend pod using `pod-frontend.yaml`.
![Task 2.1](https://github.com/user-attachments/assets/83454c04-fe3a-4824-bd2e-4ec068a9c33f)

### Part 3: Self-Healing with Deployments
- Observed Kubernetes self-healing behavior before and after deleting a pod.
- **Before Deleting Pod:**
![Task 3.1 Before](https://github.com/user-attachments/assets/bba68943-4ed3-47eb-bb7e-f78317cfc7da)

- **After Deleting Pod (Self-Healed):**
![Task 3.1 After](https://github.com/user-attachments/assets/826985b8-f8ed-4c51-902b-fb8caa64923f)

### Part 4: Scaling
- Scaled frontend replicas up to 5 and down to 2 using `kubectl scale`.
- **Before Scale:**
![Task 4.1 Before](https://github.com/user-attachments/assets/6bca89cd-2c4b-4a99-83d4-696d8943acc1)

- **Scale Up to 5:**
![Task 4.1 Scale Up](https://github.com/user-attachments/assets/6031b8e1-1705-4091-8783-a5d95ae54103)

- **Scale Down to 2:**
![Task 4.1 Scale Down](https://github.com/user-attachments/assets/e02a6caf-74e9-4a4e-b9cd-1eaa6f6e9ba6)

### Part 5: Exposing Services
- Exposed frontend via NodePort service and accessed via browser using `minikube service`.
![Task 5.1](https://github.com/user-attachments/assets/e15c672d-66ab-47f3-8f84-5d3bc4a1d309)

### Part 6: Rolling Updates & Rollbacks
- Performed zero-downtime rolling update and executed a rollback using `kubectl rollout undo`.
- **Rolling Update:**
![Task 6.1 Rolling Update](https://github.com/user-attachments/assets/5d84c67c-cb20-4b76-9444-bf276fef7053)

- **Rollback:**
![Task 6.1 Rollback](https://github.com/user-attachments/assets/7aaa1ad7-9b6f-4ff4-b0b3-43ab22887390)

### Part 7: Full Multi-Container App Deployment
- Deployed Frontend, API, Cache, and Database (StatefulSet) tiers.
![Task 7.1](https://github.com/user-attachments/assets/b0902668-44d1-466e-9b6f-7f888c7e9235)

- Verified internal network connectivity using a debug container.
![Task 7.2](https://github.com/user-attachments/assets/cf7ff5d8-7a21-4e56-8aa4-0878bad00242)

### Part 8: Data Persistence Verification
- Executed SQL query, deleted `postgres-0` pod, and verified data retention after restart.
![Task 8.1](https://github.com/user-attachments/assets/12858f58-ef23-4a3a-85bf-733794e5bc1c)

### Part 9: Observability & Troubleshooting
- Investigated pod failures (`ErrImagePull` / `ImagePullBackOff`) using `kubectl describe`.
![Task 9.1](https://github.com/user-attachments/assets/8a307281-7060-4a7e-aacf-310d90c9eb17)

### Part 10: Cleanup
- Removed all created resources and stopped Minikube cluster.
![Task 10.1](https://github.com/user-attachments/assets/ae342046-fa33-4388-9206-49ed700c9955)

