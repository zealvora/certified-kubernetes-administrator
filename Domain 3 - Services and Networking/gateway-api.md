### Documentation Referenced:

https://gateway-api.sigs.k8s.io/implementations/

### Installing Nginx Gateway Controller

```sh
kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.2" | kubectl apply -f -

kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/crds.yaml

kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/default/deploy.yaml
```

### Verify the Deployment

```sh
kubectl get pods -n nginx-gateway
```

### Verify GatewayClass
```sh
kubectl get gatewayclass

kubectl describe gatewayclass nginx
```

### Create Gateway

```sh
apiVersion: gateway.networking.k8s.io/v1beta1
kind: Gateway
metadata:
  name: nginx-gateway
  namespace: default
spec:
  gatewayClassName: nginx
  listeners:
  - name: http
    protocol: HTTP
    port: 80
```
```sh
kubectl apply -f gateway.yaml
```
### Create Deployment and Service
```sh
kubectl create deployment apache --image=httpd:latest --port=80

kubectl expose deployment apache --name=apache-service --port=80 --target-port=80 --type=ClusterIP
```

### Define HTTPRoute

```sh
apiVersion: gateway.networking.k8s.io/v1beta1
kind: HTTPRoute
metadata:
  name: apache-route
  namespace: default
spec:
  parentRefs:
  - name: nginx-gateway
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: apache-service
      port: 80
```
```sh
kubectl apply -f httproute.yaml
```
### Test the Setup

```sh
kubectl get service --all-namespaces

kubectl run curl --image=alpine/curl -- sleep 36000

kubectl exec -it curl -- sh

curl <CLUSTER-IP-OF-NGINX>
```





