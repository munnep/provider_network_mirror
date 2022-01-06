# provider_network_mirror

This repo will show you how you have a static web server hosting your terraform providers so you can download them from this website instead of from the internet itself

After the repo is started the following steps will be done
- Nginx webserver will be started
- terraform will download the AWS provider from the internet en store it under ```/vagrant/terraform_file_mirror```
- Terraform will create a file called ```$HOME/.terraformrc``` which from this point on will only look at this webserver by it's FQDN to download any providers
- you will initialize terraform and see the download of the provider happened from the webserver instead of the public internet

# Prerequisites

## Vagrant
Vagrant [See documentation](https://www.vagrantup.com/docs/installation)  
Virtualbox [See documentation](https://www.virtualbox.org/wiki/Downloads)

## SSL certificate
You must configure a FQDN to the internal ip address ```192.168.56.33``` of the Vagrant box this repo uses and valid SSL certificates for the FQDN. 

If you don't have valid SSL certificates you can create one for free using Let's Encrypt. This repository includes an instruction on how to do this. [See documentation](nginx_create_certificate/README.md) This documentation will use Vagrant to create a server that can be used to create the SSL certificates. If you have SSL certificates you can skip this manual.    

Your SSL certificates should be placed in the ```config_files``` folder
as:
```
fullchain.pem 
privkey.pem; 
```

# How to

- Clone the repository to your local machine
```
git clone https://github.com/munnep/provider_network_mirror.git
```
- Go to the directory
```
cd provider_network_mirror
```
- copy your SSL certificates to the directory ```config_files```. Note the filenames you should use. 
```
fullchain.pem
privkey.pem
```
- edit the file ```config_files``` to match your FQDN in the url
- start the Vagrant virtual machine
```
vagrant up
```
- login to the virtual machine
```
vagrant ssh
```
- optional: Set terraform to DEBUG mode so with the initialization you can see where the provider download is coming from
```
export TF_LOG=DEBUG
```
- go to the ```/vagrant/``` directory where the provider file is found
```
cd /vagrant
```
- Terraform initialize
```
terraform init
```

- exit out of the vagrant machine
```
exit
```
- destroy the vagrant machine
```
vagrant destroy
```


# done
- [x] create vagrant machine for nginx webserver to host the aws provider 
    - [x] install nginx
    - [x] install terraform
    - [x] download the provider with terraform from the internet
    - [x] configure certificates
    - [x] install terraform
    - [x] download the provider with terraform from the nginx webserver

# to do


