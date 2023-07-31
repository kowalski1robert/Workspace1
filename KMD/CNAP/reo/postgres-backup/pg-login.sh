#!/bin/bash
cluster_name=$1
username=$2
echo $username
if [[ $username == "" ]]; then
  username=$cluster_name
fi
echo $username
PG_CLUSTER_USER_SECRET_NAME=$username-pguser-$username
echo $PG_CLUSTER_USER_SECRET_NAME

PGPASSWORD=$(oc get secrets "${PG_CLUSTER_USER_SECRET_NAME}" -o go-template='{{.data.password | base64decode}}') \
PGUSER=$(oc get secrets "${PG_CLUSTER_USER_SECRET_NAME}" -o go-template='{{.data.user | base64decode}}') \
PGDATABASE=$username \
psql -h localhost 