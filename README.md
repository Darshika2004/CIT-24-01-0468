# CCS3308 Assignment - Virtualization and Containers

## Deployment Requirements
* Docker Engine
* Bash terminal

## Application Description
A multi-container web application consisting of:
1. **Frontend Service:** Flask Python web server listening on port `5000`.
2. **Database Service:** PostgreSQL database server listening on port `5432`.

## Network and Volume Details
* **Network:** `app-network` (User-defined bridge network for inter-container communication).
* **Volume:** `db-data` (Named volume for database persistence).

## Container List
| Container Name | Image | Port | Role |
| :--- | :--- | :--- | :--- |
| `web-service` | `custom-web-app` | `5000` | Web Application |
| `postgres-db` | `postgres:15-alpine` | `5432` | Relational Database |

## Instructions
1. Prepare: `./prepare-app.sh`
2. Run: `./start-app.sh` (Access: `http://localhost:5000`)
3. Stop: `./stop-app.sh`
4. Delete: `./remove-app.sh`
