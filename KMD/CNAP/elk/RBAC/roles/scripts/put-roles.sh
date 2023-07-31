#!/bin/bash
source vars/put-roles-vars.sh

for role_json_file in ../*.json
do
  role_name=$(basename $role_json_file .json)
  compact_json=$(jq -c . $role_json_file | tr -d '\n')
  curl -X PUT -k https://$KIBANA_HOST/$API_PATH/$role_name \
  --header 'Content-Type: application/json' \
  --header 'kbn-xsrf: true' \
  --header "Authorization: Basic $(echo -n elastic:$(oc get secret $ELASTICSEARCH_NAME-es-elastic-user -o jsonpath='{.data.elastic}' | base64 -d) | base64)" \
  -d $compact_json
done
