kubectl create namespace kong

kubectl create secret generic kong-enterprise-license --from-file="'{}'" -n kong

# kubectl apply -f https://raw.githubusercontent.com/Kong/kubernetes-ingress-controller/v2.9.3/deploy/single/all-in-one-dbless-k4k8s-enterprise.yaml

kubectl apply -f https://raw.githubusercontent.com/Kong/kubernetes-ingress-controller/v2.9.3/deploy/single/all-in-one-dbless.yaml