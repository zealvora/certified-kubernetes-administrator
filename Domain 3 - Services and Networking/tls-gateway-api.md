
### Create TLS Secret
```sh
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt -subj "/CN=example.internal/O=example-org"

kubectl create secret tls example-tls --cert=tls.crt --key=tls.key -n default

kubectl get secret example-tls -n default

```

### Define Simple Backend Service

```sh
kubectl create deployment nginx --image=httpd:latest --port=80

kubectl expose deployment nginx --name=nginx-service --port=80 --target-port=80 --type=ClusterIP
```

### Define a Gateway with TLS Termination
```sh
nano my-tls-gateway.yaml
```

```sh
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: my-tls-gateway
spec:
  gatewayClassName: nginx
  listeners:
  - name: https
    protocol: HTTPS
    port: 443
    tls:
      mode: Terminate
      certificateRefs:
      - kind: Secret
        name: example-tls
```

### Define HTTP Route

```sh
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: tls-route
spec:
  parentRefs:
  - name: my-tls-gateway
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: nginx-service
      port: 80
```
```sh
kubectl apply -f my-tls-gateway.yaml

kubectl get gateways -n default
```
### Test the TLS Termination
```sh
kubectl get service --all-namespaces

kubectl run curl --image=alpine/curl -- sleep 36000

kubectl exec -it curl -- sh

curl <CLUSTER-IP-OF-NGINX>
```