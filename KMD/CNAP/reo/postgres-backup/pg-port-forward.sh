#!/bin/bash
cluster_name=$1
PG_CLUSTER_PRIMARY_POD=$(oc get pod -o name \
  -l postgres-operator.crunchydata.com/cluster=$cluster_name,postgres-operator.crunchydata.com/role=master)
oc port-forward "${PG_CLUSTER_PRIMARY_POD}" 5432:5432