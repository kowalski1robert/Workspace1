#!/bin/bash
# Vars that don't change
ELK_PATH="/home/reo/Workspace/CNAP/elk"
BEATS_PATH="/home/reo/Workspace/CNAP/cnap-elk-beats"
ROLES_PATH="/home/reo/Workspace/CNAP/elk/RBAC/roles"
ROLES_API_PATH="api/security/role"
PROJECT_NAME="eck"
NAMESPACE_NAME="eck"
ELASTICSEARCH_NAME="elasticsearch"
KIBANA_NAME="kibana-kb"
KIBANA_ROUTE_NAME="kibana"

LOG_PATH="/home/reo/Workspace/CNAP/reo/elk-installation-process/logs"

# Vars that change with -d flag
create="create"
apply="apply"
add_scc_to_user="add-scc-to-user"