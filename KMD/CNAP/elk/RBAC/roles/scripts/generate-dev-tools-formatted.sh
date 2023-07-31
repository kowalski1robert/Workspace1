#!/bin/bash
read -p "Enter full path to role file (.json): " role_path
cat $role_path | jq 'to_entries | map(select(.value != null and .value != "" and .value != [] and .value != {})) | .[].value' | jq -s 'add'