#!/usr/bin/env bash

touch /root/.rnd

mkdir -p /vagrant/ssl
pushd /vagrant/ssl

openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 365 -key ca.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=Acme Root CA" -out ca.crt

openssl req -newkey rsa:2048 -nodes -keyout server.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=192.168.56.33.nip.io" -out server.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:192.168.56.33.nip.io") -days 365 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt

cp server.* /etc/nginx/conf.d/
cat <<-CONF > /etc/nginx/conf.d/ssl.conf
server {
    listen       443  default ssl;
    ssl on;
    ssl_certificate     /etc/nginx/conf.d/server.crt;
    ssl_certificate_key /etc/nginx/conf.d/server.key;

    root /vagrant/terraform_file_mirror;
    index index.html index.htm index.nginx-debian.html;
    server_name _;

    location /vagrant/terraform_file_mirror/registry.terraform.io/ {
    autoindex on;
    }

}
CONF

# restart nginx
systemctl restart nginx
