#!/bin/bash
curl -fsSL https://get.docker.com | sh ## download and install docker
id ssm-user &>/dev/null || useradd -m ssm-user ## create ssm-user if it doesn't exist 
usermod -aG docker ssm-user ## no need sudo
docker run -d -p 80:80 nginx
docker run -d --network host cloudflare/cloudflared:latest \
  tunnel --no-autoupdate run --token ${tunnel_token}