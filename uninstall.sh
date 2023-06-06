#!/bin/bash

helm uninstall -n kong quickstart

kubectl delete secrets -n kong kong-enterprise-license
kubectl delete secrets -n kong kong-config-secret

kubectl delete pvc -n kong data-quickstart-postgresql-0
helm repo remove kong

helm uninstall -n cert-manager cert-manager
helm repo remove jetstack
