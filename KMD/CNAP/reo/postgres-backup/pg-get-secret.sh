#!/bin/bash
cluster_name=$1
oc get secrets -n postgres-crunchy "$cluster_name-pguser-reo" -o go-template='{{.data.password}}'