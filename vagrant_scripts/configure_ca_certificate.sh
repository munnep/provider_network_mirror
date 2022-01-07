#!/usr/bin/env bash

cp /vagrant/ssl/ca.crt /etc/ssl/certs/
cp /vagrant/ssl/server.crt /etc/ssl/certs/
update-ca-certificates --fresh
