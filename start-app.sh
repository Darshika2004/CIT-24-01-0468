#!/bin/bash
echo "Running app ..."
sudo docker run -d \
  --name postgres-db \
  --network app-network \
  --restart unless-stopped \
  -v db-data:/var/lib/postgresql/data \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=appdb \
  -p 5432:5432 \
  postgres:15-alpine

sudo docker run -d \
  --name web-service \
  --network app-network \
  --restart unless-stopped \
  -e DB_HOST=postgres-db \
  -p 5000:5000 \
  custom-web-app

echo "The app is available at http://localhost:5000"
