#!/bin/bash
source /home/reo/Workspace/CNAP/reo/elk-installation-process/vars/elk-installation-process-vars.sh

while getopts ":d" opt; do
  case $opt in
    d)
      create="delete"
      apply="delete"
      add_scc_to_user="remove-scc-to-user"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

{
# oc new-project <project-name> (now used and all configured for: eck)
oc get projects -o jsonpath='{.items[*].metadata.name}' | grep -qE "\b$PROJECT_NAME\b" && : || oc new-project $PROJECT_NAME 
# oc create namespace <namespace-name> (now used and all configured for: eck)
oc get namespaces -o jsonpath='{.items[*].metadata.name}' | grep -qE "\b$NAMESPACE_NAME\b" && : || oc create namespace $NAMESPACE_NAME
### Instalation of ECK Operator (it can be done programatically, but you need license secret for it)

oc $create -f $ELK_PATH/eck-dev-energinet-elasticsearch.yaml 
oc $create -f $ELK_PATH/eck-dev-energinet-kibana.yaml

### creation of kibana route
sleep 180 # wait for pods spin up

cert=$(oc get secret kibana-kb-http-ca-internal -o jsonpath='{.data.tls\.crt}' | base64 --decode) # get cert secret for authenthicating to other ELK components
tabs=$(cat $ELK_PATH/eck-dev-energinet-kibana-route.yaml | grep -E -o '^\s*PROVIDE_CERT' | grep -o '^\s*') # get string of spaces for tabulating cert
cat $ELK_PATH/eck-dev-energinet-kibana-route.yaml | awk -v tabbed_cert="$(echo $cert | sed "s/^/$tabs/g")" '{gsub(/^\s*PROVIDE_CERT/, tabbed_cert)}1' | oc $create -f - # take yaml, replace string PROVIDE_CERT in yaml with tabbed cert and create route from stdin

oc adm policy $add_scc_to_user privileged system:serviceaccount:openshift-monitoring:metricbeat
oc adm policy $add_scc_to_user -z metricbeat -n eck privileged # eck=project or namespace?
oc adm policy $add_scc_to_user -z filebeat -n eck privileged # eck=project or namespace?

oc $create -f $BEATS_PATH/metricbeat.yml
oc $apply -f $BEATS_PATH/config-metricbeat.yml
oc $apply -f $BEATS_PATH/filebeat.yml
oc $apply -f $BEATS_PATH/config-filebeat.yml
oc $apply -f $BEATS_PATH/api-key-beat-template.yml

# Roles
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

if [[ $create == "delete" ]]; then
  oc delete project $PROJECT_NAME
  oc delete namespace $NAMESPACE_NAME
fi

} |& tee tmp-elk-installation-log

echo "\n  Do you wish to save the log?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) 
          read -p "Provide name: " log_file
          mv tmp-elk-installation-log $LOG_PATH/install-script/\'$(date +"%d.%m.%Y-%H.%M")\'$log_file
          break;;
        No )  
          rm tmp-elk-installation-log
          break;;
    esac
done 
