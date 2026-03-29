#!/bin/bash
set -e

sudo dnf update -y
sudo dnf install nginx -y

sudo systemctl start nginx
sudo systemctl enable nginx

echo "Hello from $(hostname)" > /usr/share/nginx/html/index.html
