#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
# install extra software to add the hashicorp repository
pushd /vagrant/config_files
cp terraformrc_example $HOME/.terraformrc
