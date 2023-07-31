#!/bin/bash

## Script to customize vanila kibana config file
## Author: Bartlomiej Szwajkowski bsa@kmd.dk
## Date: 2022-02-15
## Ver: 1.0

##############################
#EDIT below for new deployment
##############################
KIB_YAML=/etc/kibana/kibana.yml
KIB_NET_PORT=5601 #http port
KIB_HOST=0.0.0.0
KIB_NAME="new-kibana-server"
KIB_HOSTS="https://localhost:9200"
KIB_USER="kibana_system"
KIB_PASS="changeme"
KIB_CERT=/etc/kibana/kibana-server.crt #path to tls certificate
KIB_KEY=/etc/kibana/kibana-server.key #path to tls certificate
KIB_CERT_CA=/etc/kibana/elasticsearch-ca.pem #tls truststore
##############################

#configure http port
sed -i  "s|#server.port: .*|server.port: $KIB_NET_PORT|" $KIB_YAML
sed -i  "s|#server.host: .*|server.host: \"$KIB_HOST\"|" $KIB_YAML
sed -i  "s|#server.name: .*|server.name: $KIB_NAME|" $KIB_YAML

#Addresses of elasticsearch servers
sed -i  "s|#elasticsearch.hosts: .*|elasticsearch.hosts: [\"$KIB_HOSTS\"]|" $KIB_YAML


#Account to access elasticsearch
sed -i  "s|#elasticsearch.username: .*|elasticsearch.username: \"$KIB_USER\"|" $KIB_YAML
sed -i  "s|#elasticsearch.password: .*|elasticsearch.password: \"$KIB_PASS\"|" $KIB_YAML

#Enable HTTPS for browser traffic
sed -i  "s|#server.ssl.enabled: .*|server.ssl.enabled: true|" $KIB_YAML
sed -i  "s|#server.ssl.certificate: .*|server.ssl.certificate: $KIB_CERT|" $KIB_YAML
sed -i  "s|#server.ssl.key: .*|server.ssl.key: $KIB_KEY|" $KIB_YAML

#Mutual TLS with elasticsearch
sed -i  "s|#elasticsearch.ssl.certificate: .*|elasticsearch.ssl.certificate: $KIB_CERT|" $KIB_YAML
sed -i  "s|#elasticsearch.ssl.key: .*|elasticsearch.ssl.key: $KIB_KEY|" $KIB_YAML

#TLS Truststore
sed -i  "s|#elasticsearch.ssl.certificateAuthorities: .*|elasticsearch.ssl.certificateAuthorities: [\"$KIB_CERT_CA\"]|" $KIB_YAML

# enable audit logging
echo "xpack.security.audit.enabled: true" >> $KIB_YAML