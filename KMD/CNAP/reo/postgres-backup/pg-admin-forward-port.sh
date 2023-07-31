#!/bin/bash
host_port=5050
destination_port=5050
while getopts ":n:P:p:" opt; do
  case $opt in
    n)
      # cluster name (required)
      cluster_name="$OPTARG"
      ;;
    P)
      # specify host port if needed
      host_port="$OPTARG"
      ;;
    p)
      # specify destination port if needed
      destination_port="$OPTARG"
      ;;
    :)
      create=true
      ;;
  esac
done
if [ -z "cluster_name" ]; then
  echo "ERROR: postgres cluster name required (./pg-admin-forward-port -n <cluster-name>)"
  exit 1
fi

# case "$cluster_name" in
#   "elephant")
#     destination_port="5050"
#     ;;
#   "hippo")
#     destination_port="5051"
#     ;;
# esac

echo "$host_port $destination_port"
# PG_CLUSTER_PRIMARY_POD=$(oc get pod -n postgres-crunchy -o name \
#   -l postgres-operator.crunchydata.com/cluster=$cluster_name,postgres-operator.crunchydata.com/role=master)
# oc -n postgres-crunchy port-forward "${PG_CLUSTER_PRIMARY_POD}" 5432:5432
oc port-forward svc/$cluster_name-pgadmin "$destination_port:$host_port"