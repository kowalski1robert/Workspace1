#!/bin/bash
source /home/reo/Workspace/CNAP/reo/elk-installation-process/vars/elk-installation-process-vars.sh

# while getopts ":d" opt; do
#   case $opt in
#     d)
#       create="delete"
#       apply="delete"
#       add_scc_to_user="remove-scc-to-user"
#       ;;
#     \?)
#       echo "Invalid option: -$OPTARG" >&2
#       ;;
#   esac
# done

{
KIBANA_HOST=$(oc get route -n $NAMESPACE_NAME $KIBANA_ROUTE_NAME -o jsonpath='{.spec.host}')

for role_json_file in $ROLES_PATH/*.json
do
  role_name="$(basename $role_json_file .json)"
  compact_json=$(jq -c . $role_json_file | tr -d '\n')
  curl -X PUT -k https://$KIBANA_HOST/$ROLES_API_PATH/$role_name \
  --header 'Content-Type: application/json' \
  --header 'kbn-xsrf: true' \
  --header "Authorization: Basic $(echo -n elastic:$(oc get secret $ELASTICSEARCH_NAME-es-elastic-user -o jsonpath='{.data.elastic}' | base64 -d) | base64)" \
  -d $compact_json
done
} |& tee tmp-elk-installation-log

echo "\n  Do you wish to save the log?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) 
          read -p "Provide name: " log_file
          mv tmp-elk-installation-log $LOG_PATH/roles-upload-script/\'$(date +"%d.%m.%Y-%H.%M")\'$log_file
          break;;
        No )  
          rm tmp-elk-installation-log
          break;;
    esac
done 
