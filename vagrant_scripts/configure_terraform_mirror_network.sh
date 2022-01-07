#!/usr/bin/env bash

# download the latest terraform aws provider and strore it in the following location
pushd /vagrant
terraform providers mirror /vagrant/terraform_file_mirror
