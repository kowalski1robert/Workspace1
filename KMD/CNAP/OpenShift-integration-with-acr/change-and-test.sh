#! /bin/bash
for schema in trigger.yml triggerBinding.yml triggerTemplate.yml tektonPipeline.yml
do
oc replace -f $schema
done && \
az acr helm push /home/reo/kubernetes-ingress/deployments/helm-chart/acrtest-nginx-1.0.2.tgz -n kmdcnap --force && sleep 1 && \
oc logs el-acr-eventlistener-69459cd6cd-gbpk6 | tail -n 7 | jq > log && code log