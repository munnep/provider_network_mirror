# Manual steps

## SSL Certificates

- Have valid SSL certificates for a FQDN 
- DNS record FQDN pointing to the private IP address 192.168.56.33
```patrick.bg.hashicorp-success.com```


## Configuration

- start vagrant box with a private ip address
- install nginx
```
apt-get update -y
apt-get install -y nginx
systemctl enable nginx 
systemctl start nginx 
```
- create a configuration for nginx with certification keys for SSL and location where the terraform mirror of providers will be placed
```
# Default server configuration
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	# SSL configuration
	#
	listen 443 ssl default_server;
	listen [::]:443 ssl default_server;

	ssl_certificate /vagrant/config_files/fullchain.pem; # managed by Certbot
	ssl_certificate_key /vagrant/config_files/privkey.pem; # managed by Certbot

	root /vagrant/terraform_file_mirror;
	index index.html index.htm index.nginx-debian.html;
	server_name _;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

    location /vagrant/terraform_file_mirror/registry.terraform.io/ {
    autoindex on;
    }
}
```
- have the latest terraform 
- have the terraform download the provider to the vagrant directory which is pointed in the nginx file  
provider.tf
```
provider aws {}
```
```
terraform providers mirror /vagrant/terraform_file_mirror
```
- Now the provider is on disk and the webserver has it available. 
- change the terraform configuration so it will only use the webserver to download the provider  
create file ```$HOME/.terraformrc```
```
provider_installation {
  network_mirror {
    url = "https://patrick.bg.hashicorp-success.com/"
    include = ["*/*"]
  }
  direct {
    exclude = ["*/*"]
  }
}
```
- set TF_LOG=DEBUG to see the actual download location
```
set TF_LOG=DEBUG
```
- run terraform init
```
terraform init
```
output
```
2022-01-06T17:23:02.694Z [DEBUG] GET https://patrick.bg.hashicorp-success.com/registry.terraform.io/hashicorp/aws/3.70.0.json
- Installing hashicorp/aws v3.70.0...
- Installed hashicorp/aws v3.70.0 (verified checksum)
```