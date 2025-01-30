
### Base Network Policy

base-netpol.yaml

```sh
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: base-network-policy
```

### Example 1
example-1.yaml
```sh
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: example-1
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

Create Pod for Testing

```sh
kubectl run test-pod --image=alpine/curl -- sleep 36000
kubectl get pods
kubectl exec -it test-pod --sh
ping
curl
ping google.com
```
```sh
kubectl create -f example-1.yaml
kubectl get netpol
kubectl describe netpol base-network-policy
```

Testing the setup
```sh
kubectl exec -it test-pod --sh
ping google.com
```

```sh
kubectl delete -f example-1.yaml
```
### Example 2
example-2.yaml
```sh
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: example-2
spec:
  podSelector: {}
  ingress:
  - {}
  policyTypes:
  - Ingress
  - Egress
```
```sh
kubectl create -f example-2.yaml
kubectl describe netpol base-network-policy
```
Testing the Setup
```sh
kubectl run random-pod --image=alpine/curl -- sleep 36000
kubectl get pods -o wide
kubectl exec -it random-pod --sh
ping <IP-OF-TEST-POD>
```
```sh
kubectl create ns testing
kubectl run random-pod -n testing --image=alpine/curl -- sleep 36000
kubectl get pods -n testing
kubectl exec -it random-pod -n testing --sh
ping <IP-OF-TEST-POD>
```

### Example 3
example-3.yaml
```sh
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: example-3
spec:
  podSelector:
    matchLabels:
      role: suspicious
  policyTypes:
  - Ingress
  - Egress
```
```sh
kubectl create -f example-3.yaml
```

Testing the Setup
```sh
kubectl run suspicious-pod --image=alpine/curl -- sleep 36000
kubectl label pod suspicious-pod role=suspicious
kubectl exec -it suspicious-pod --sh
ping google.com
```
### Example 4
example-4.yaml
```sh
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: example-4
spec:
  podSelector: 
    matchLabels:
      role: database
  ingress:
  - from:
    - podSelector:
       matchLabels:
         role: app
  policyTypes:
  - Ingress
```
```sh
kubectl create -f example-4.yaml
```
Testing the Setup
```sh
kubectl run app-pod --image=alpine/curl -- sleep 36000
kubectl run database-pod --image=alpine/curl -- sleep 36000
kubectl get pods -o wide

kubectl exec -it test-pod --sh
ping <DB-POD-IP>

kubectl label pod app-pod role=app
kubectl exec -it app-pod --sh
ping <DB-POD-IP>
```
```sh
kubectl delete -f example-4.yaml
```

### Example 5
example-5.yaml
```sh
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: example-5
  namespace: production
spec:
  podSelector: {}
  ingress:
  - from:
     - namespaceSelector:
         matchLabels:
           kubernetes.io/metadata.name: security
  policyTypes:
  - Ingress
```
```sh
kubectl create -f example-5.yaml
```

```sh
kubectl create ns production
kubectl create ns security

kubectl get ns --show-labels

kubectl run prod-pod -n production --image=alpine/curl -- sleep 36000
kubectl run security-pod -n security --image=alpine/curl -- sleep 36000

kubectl exec -it security-pod -n security --sh
ping <Prod-POD-IP-Of-Production-namespace>
```
```sh
kubectl delete -f example-5.yaml
```
### Example 6
example-6.yaml
```sh
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: example-6
  namespace: production
spec:
  podSelector: {}
  egress:
  - to:
    - ipBlock:
       cidr: 8.8.8.8/32
  policyTypes:
  - Egress
```
```sh
kubectl create -f example-6.yaml
``
```sh
kubectl exec -it prod-pod -n production -- sh
ping 8.8.8.8
```
```sh
kubectl delete -f example-6.yaml
```
### Remove the Created Resources
```sh
kubectl delete pods --all
kubectl delete pod security-pod -n security
kubectl delete pod prod-pod -n production
kubectl delete pods --all -n testing

kubectl delete ns testing
kubectl delete ns production
kubectl delete ns security
```

