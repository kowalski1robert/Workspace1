#!/bin/bash
optspec=":-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                api-key)
                    api_key="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 )) 
                    ;;
            esac;;
        # k)
        #     var = ${OPTARG}
        #     ;;
    esac
done

kibana_address="https://kibana-eck.apps.dev.kmdstratus.com"
method="get"
formula="api/data_views/data_view"
object_name="logs-*"

# Kibana_Request() {
#   curl -X ${method^^} -k $kibana_address/$formula/$object_name --header 'Content-Type: application/json;charset=UTF-8' --header 'kbn-xsrf: true' --header "Authorization: ApiKey $api_key" 
# }
Kibana_Request() {
  curl -X ${method^^} -k $kibana_address/$formula/$object_name --header 'Content-Type: application/x-ndjson;charset=UTF-8' --header 'kbn-xsrf: true' --header "Authorization: ApiKey $api_key" $body
}

# Kibana_Request
# method="post"
# formula="_security/user"
# object_name="terminal_test"
# cp user_template.json user.json
# sed -i 's/$PASSWORD/aaaaa123/' user.json
# sed -i 's/$ROLES/viewer/' user.json
# body="-d @user.json"
method="get"; formula="api/spaces"; object_name="space"


Kibana_Request