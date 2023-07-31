#!/bin/bash
echo "From what do you want to take logs?"
select elk in "Elastic" "Kibana"; do
    case $elk in
        Elastic ) 
          echo "" > elastic_logs
          for pod in $(oc get pods -o json | jq -r '.items[] | select(.metadata.name | test("^elastic")) | .metadata.name')
          do
            oc logs $pod >> elastic_logs
          done
          break;;
        Kibana )
          oc logs $(oc get pods -o json | jq -r '.items[] | select(.metadata.name | test("^kibana-kb")) | .metadata.name') > kibana_log
          break;;
    esac
done

# oc logs $(oc get pods -o json | jq -r ".items[] | select(.metadata.name | test("^kibana-kb")) | .metadata.name") > kibana_log

# oc logs $(oc get pods -o json | jq -r '.items[] | select(.metadata.name | test("^elastic")) | .metadata.name')