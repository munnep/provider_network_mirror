#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# install nginx
apt-get update -y
apt-get install -y nginx
systemctl enable nginx 
systemctl start nginx 
