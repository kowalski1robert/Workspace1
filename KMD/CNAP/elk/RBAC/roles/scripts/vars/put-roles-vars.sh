#!/bin/bash
# Vars that don't change
API_PATH="api/security/role"
NAMESPACE_NAME="eck"
ELASTICSEARCH_NAME="elasticsearch"
KIBANA_ROUTE_NAME="kibana"
KIBANA_HOST=$(oc get route -n $NAMESPACE_NAME $KIBANA_ROUTE_NAME -o jsonpath='{.spec.host}')