#!/bin/bash
sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "Hello from Terraform ASG" > /usr/share/nginx/html/index.html
