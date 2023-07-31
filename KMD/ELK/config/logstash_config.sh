#!/bin/bash

## Basic configuration script for Logstash
## Author: Antonina Lewicka ejn@kmd.dk, Julia Lewicka jll@kmd.dk
## Ver: 1.0

# parameters
LOGSTASH_YAML=/etc/logstash/logstash.yml
LOGSTASH_CERT_CA=/etc/logstash/elasticsearch-ca.pem
LOGSTASH_USER="username"
LOGSTASH_PASSWORD="password"

# enable xpack monitoring
sed -i  "s|#xpack.monitoring.enabled: .*|xpack.monitoring.enabled: true|" $LOGSTASH_YAML

# user data
sed -i  "s|#xpack.monitoring.elasticsearch.username: .*|xpack.monitoring.elasticsearch.username: \"$LOGSTASH_USER\"|" $LOGSTASH_YAML
sed -i  "s|#xpack.monitoring.elasticsearch.password: .*|xpack.monitoring.elasticsearch.password: \"$LOGSTASH_PASSWORD\"|" $LOGSTASH_YAML

# Elasticsearch hosts
sed -i  "s|#xpack.monitoring.elasticsearch.hosts: .*|xpack.monitoring.elasticsearch.hosts: [\"$ELASTICSEARCH_HOSTS\"]|" $LOGSTASH_YAML

# TLS truststore
sed -i  "s|#xpack.monitoring.elasticsearch.ssl.certificate_authority: .*|xpack.monitoring.elasticsearch.ssl.certificate_authoritiy: [\"$LOGSTASH_CERT_CA\"]|" $LOGSTASH_YAML
