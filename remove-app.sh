#!/bin/bash
echo "Removing app resources ..."
sudo docker stop web-service postgres-db 2>/dev/null
sudo docker rm web-service postgres-db 2>/dev/null
sudo docker network rm app-network 2>/dev/null
sudo docker volume rm db-data 2>/dev/null
sudo docker rmi custom-web-app 2>/dev/null
echo "Removed app completely."
