#!/usr/bin/env bash

# copy the nginx configuration to the correct location
cp /vagrant/config_files/default /etc/nginx/sites-enabled/

# restart nginx
systemctl restart nginx