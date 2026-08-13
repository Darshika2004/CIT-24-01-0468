#!/bin/bash
echo "Preparing app ..."
sudo docker network create app-network 2>/dev/null || echo "Network already exists."
sudo docker volume create db-data 2>/dev/null || echo "Volume already exists."
sudo docker build -t custom-web-app .
echo "Preparation complete."
