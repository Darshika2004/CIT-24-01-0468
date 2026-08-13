#!/bin/bash
echo "Stopping app ..."
sudo docker stop web-service postgres-db 2>/dev/null
sudo docker rm web-service postgres-db 2>/dev/null
echo "App stopped. Persistent data preserved."
