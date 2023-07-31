#!/bin/bash

## Install Logstash
## Authors: Antonina Lewicka ejn@kmd.dk, Julia Lewicka jll@kmd.dk
## Version: 1.0

# parameters
ELK_VERSION = 7

# add ELK stack repository to RHEL
sudo cat << EOF | sudo tee /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-$ELK_VERSION.x]
name=Elasticsearch repository for $ELK_VERSION.x packages
baseurl=https://artifacts.elastic.co/packages/$ELK_VERSION.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

# import GPG key
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# clean and update yum index
sudo yum clean all
sudo yum makecache

# install elasticsearch
sudo yum -y install elasticsearch

# start kibana
sudo systemctl enable --now elasticsearch.service