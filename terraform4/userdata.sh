#!/bin/bash
set -euxo pipefail

# Install Docker (includes the docker compose plugin)
curl -fsSL https://get.docker.com | sh
systemctl enable --now docker

# Create ssm-user so Session Manager lands in a shell that can use Docker
id ssm-user &>/dev/null || useradd -m ssm-user
usermod -aG docker ssm-user

# Deploy Rackula using the official persistence compose file (port 8080)
mkdir -p /opt/rackula
cd /opt/rackula
curl -fsSL https://raw.githubusercontent.com/RackulaLives/Rackula/main/deploy/docker-compose.persist.yml -o docker-compose.yml

# API container runs as UID 1001 and needs write access to the data directory
mkdir -p data
chown 1001:1001 data

docker compose up -d
