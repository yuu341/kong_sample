#!/bin/bash

kubectl create namespace kong
	 
kubectl create secret generic kong-config-secret -n kong \
    --from-literal=portal_session_conf='{"storage":"kong","secret":"super_secret_salt_string","cookie_name":"portal_session","cookie_same_site":"Lax","cookie_secure":false}' \
    --from-literal=admin_gui_session_conf='{"storage":"kong","secret":"super_secret_salt_string","cookie_name":"admin_session","cookie_same_site":"Lax","cookie_secure":false}' \
    --from-literal=pg_host="enterprise-postgresql.kong.svc.cluster.local" \
    --from-literal=kong_admin_password=kong \
    --from-literal=password=kong

kubectl create secret generic kong-enterprise-license --from-literal=license="'{}'" -n kong --dry-run=client -o yaml | kubectl apply -f -

helm repo add jetstack https://charts.jetstack.io ; helm repo update
helm upgrade --install cert-manager jetstack/cert-manager \
    --set installCRDs=true --namespace cert-manager --create-namespace

kubectl apply -n kong -f manifest/cert-manifests.yaml


helm repo add kong https://charts.konghq.com ; helm repo update
helm install quickstart kong/kong --namespace kong --values https://bit.ly/KongGatewayHelmValuesAIO
echo "https://$(kubectl get ingress --namespace kong quickstart-kong-manager -o jsonpath='{.spec.tls[0].hosts[0]}')"
