### Documentation Referenced:

https://gateway-api.sigs.k8s.io/guides/tls/

### Create TLS Secret
```sh
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt -subj "/CN=example.internal/O=example-org"

kubectl create secret tls example-tls --cert=tls.crt --key=tls.key -n default

kubectl get secret example-tls -n default

```

### Define Simple Backend Service

```sh
kubectl create deployment nginx --image=nginx:latest --port=80

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
```sh
kubectl create -f my-tls-gateway.yaml
```
### Define HTTP Route
```sh
nano httproute.yaml
```
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
kubectl apply -f httproute.yaml
```
### Test the TLS Termination
```sh
kubectl get gateway

nano /etc/hosts
```
```sh
example.internal <IP-ADDRESS>
```
```sh
curl -k https://example.internal
curl http://example.internal
```
If in windows, you can create curl pod and add /etc/host entry there
```sh
kubectl run curl --image=alpine/curl -- sleep 36000

kubectl exec -it curl -- sh
```
