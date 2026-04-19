#!/bin/bash

exec > /var/log/user-data.log 2>&1
set -eux

dnf update -y
dnf install -y nginx amazon-ssm-agent

systemctl enable --now nginx
systemctl enable --now amazon-ssm-agent

echo "Hello from $(hostname)" > /usr/share/nginx/html/index.html
echo "OK" > /usr/share/nginx/html/health
