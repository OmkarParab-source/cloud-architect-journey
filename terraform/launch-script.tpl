#!/bin/bash
set -e

dnf update -y
dnf install -y nginx amazon-ssm-agent || true

systemctl enable --now nginx

echo "Hello from $(hostname)" > /usr/share/nginx/html/index.html

systemctl enable --now amazon-ssm-agent
