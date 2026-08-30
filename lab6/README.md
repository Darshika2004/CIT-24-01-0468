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

<img width="658" height="297" alt="Image" src="https://github.com/user-attachments/assets/13e875f8-b6f4-4f14-b082-bf1764b2c5c9" />
<img width="1201" height="168" alt="Image" src="https://github.com/user-attachments/assets/df6abdcb-6493-46e7-b4a8-0f6342c815db" />
<img width="1218" height="482" alt="Image" src="https://github.com/user-attachments/assets/e1532309-7356-480b-92d3-3423613f89cb" />
<img width="1209" height="676" alt="Image" src="https://github.com/user-attachments/assets/6b50f288-024d-4412-82ad-0edd0ea2c589" />
<img width="764" height="562" alt="Image" src="https://github.com/user-attachments/assets/b1017bdb-3581-4c22-a96f-98f015d80ab5" />
<img width="1096" height="186" alt="Image" src="https://github.com/user-attachments/assets/09bc8646-0f92-4b4e-90d8-4a31e9475c48" />
<img width="1218" height="130" alt="Image" src="https://github.com/user-attachments/assets/51b523d7-4a8a-40b0-8d52-09ffde978025" />
<img width="670" height="315" alt="Image" src="https://github.com/user-attachments/assets/f88d0970-72f5-460a-b5d9-aa574148f6cd" />
<img width="982" height="96" alt="Image" src="https://github.com/user-attachments/assets/5ebddd05-bc74-4549-bc3a-190718a1c211" />
<img width="739" height="133" alt="Image" src="https://github.com/user-attachments/assets/fbe049fd-d1c4-44b4-a190-9fdc98c31c2b" />
<img width="742" height="76" alt="Image" src="https://github.com/user-attachments/assets/cb9843f8-9306-4511-92f8-e587c9203222" />
<img width="982" height="96" alt="Image" src="https://github.com/user-attachments/assets/cd2fa28c-f8e5-4a39-90d1-d08e50f228e5" />
<img width="982" height="96" alt="Image" src="https://github.com/user-attachments/assets/80ae5718-890e-4c31-a85f-fea96a8fb7cb" />
<img width="1214" height="444" alt="Image" src="https://github.com/user-attachments/assets/a2996c80-805d-4549-ace6-c130d7ad7047" />
<img width="691" height="326" alt="Image" src="https://github.com/user-attachments/assets/0ad523dc-ef0d-46eb-b444-1a2872373351" />
