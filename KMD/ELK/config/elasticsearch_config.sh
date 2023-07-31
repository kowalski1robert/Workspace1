#!/bin/bash

## Script to customize vanila elasticsearch config file
## Author: Bartlomiej Szwajkowski bsa@kmd.dk
## Date: 2022-02-14
## Ver: 1.0

##############################
#EDIT below for new deployment
##############################
ELK_YAML=/etc/elasticsearch/elasticsearch.yml
ELK_CLUSTER_NAME="new-elk-cluster"
ELK_PATH_DATA=/kmd/elasticsearch #location for storing index data
ELK_PATH_LOGS=/kmd/elasticsearch/var/log #elk self logs
ELK_NET_PORT=9200 #http port
ELK_TRAN_HOST=localhost
ELK_TRAN_PORT=9300 #transport port
ELK_SEED_HOSTS="127.0.0.1" #list of hosts to perform discovery
ELK_HTTP_KEYSTORE_PATH="http.p12" #path to https certificate
ELK_TRAN_CERT_CA="/etc/elasticsearch/elasticsearch-ca.pem" #CA trust store
##############################


#enter name of ELK cluster
sed -i  "s/#cluster.name: .*/cluster.name: $ELK_CLUSTER_NAME/" $ELK_YAML


############
#ELK PATHS
############

#set path to ELK data & ELK self logs
sed -i  "s|#path.data: .*|path.data: $ELK_PATH_DATA|" $ELK_YAML
sed -i  "s|#path.logs: .*|path.logs: $ELK_PATH_LOGS|" $ELK_YAML

############
#ELK NETWORK
############

#expose ELK on network interfaces
sed -i  "s|#network.host:.*|network.host: [_local_, _site_]|" $ELK_YAML

#configure http port
sed -i  "s|#http.port: .*|http.port: $ELK_NET_PORT|" $ELK_YAML

#configure transport port
sed -i  "/^.*http.port: .*/ {
a\transport.host: $ELK_TRAN_HOST
a\transport.tcp.port: $ELK_TRAN_PORT
}" $ELK_YAML

##############
#ELK DISCOVERY
##############

#configure list of hosts to perform discovery
sed -i  "s|#discovery.seed_hosts: .*|discovery.seed_hosts: [\"$ELK_SEED_HOSTS\"]|" $ELK_YAML

############
#ELK Various
############
sed -i  "/^.*- Various -.*/ {
a\http.compression: true
a\http.compression_level: 9
a\transport.compress: true
}" $ELK_YAML

#############
#ELK SECURITY
#############
sed -i  "/^.*- Security -.*/ {
a\xpack.security.enabled: true
a\xpack.security.transport.ssl.enabled: true
a\xpack.security.transport.ssl.verification_mode: certificate
a\xpack.security.http.ssl.enabled: true
a\xpack.security.http.ssl.keystore.path: $ELK_HTTP_KEYSTORE_PATH
a\xpack.security.transport.ssl.certificate_authorities: [\"$ELK_TRAN_CERT_CA\"]
a\xpack.security.http.ssl.certificate_authorities: [\"$ELK_TRAN_CERT_CA\"]
a\xpack.security.audit.enabled: true
}" $ELK_YAML