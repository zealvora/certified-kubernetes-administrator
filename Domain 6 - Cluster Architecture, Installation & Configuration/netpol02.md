### Rule 5 - Ingress From:
```sh
kubectl label pod pod-1 role=secure
```
```sh
nano netpol.yaml
```
```sh
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-from-ips
spec:
  podSelector:
    matchLabels:
      role: secure
  ingress:
  - from:
     - ipBlock:
        cidr: 192.168.0.0/16
        except:
        - 192.168.137.70/32
  policyTypes:
  - Ingress
```
```sh
kubectl apply -f netpol.yaml
```
```sh
kubectl exec -n external -it pod-3 -- ping [pod-1]
kubectl exec -it pod-2 -- ping [pod-1]
```
```sh
kubectl label pod pod-1 role-
kubectl delete -f netpol.yaml
```

### Rule 6 - Egress To:
```sh
kubectl label pod pod-1 role=secure
```
```sh
nano netpol.yaml
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: egress-to-ips
spec:
  podSelector:
    matchLabels:
      role: secure
  egress:
  - to:
     - ipBlock:
        cidr: 192.168.137.70/32
  policyTypes:
  - Egress
```
```sh
kubectl apply -f netpol.yaml
```
```sh
kubectl exec -it pod-1 -- ping [pod-2]
kubectl exec -it pod-1 -- ping google.com
```
```sh
kubectl delete -f netpol.yaml
```
### Rule 7 - Namespace Selector:
```sh
nano netpol.yaml
```
```sh
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: namespace-selector
spec:
  podSelector:
    matchLabels:
      role: secure
  ingress:
  - from:
     - namespaceSelector:
        matchLabels:
          role: app
       podSelector:
         matchLabels:
           role: reconcile
  policyTypes:
  - Ingress
```
```sh
kubectl apply -f netpol.yaml
```
```sh
kubectl exec -it pod-2 -- ping [pod-1]
kubectl exec -n external -it pod-3 -- ping [pod-1]

kubectl label pod -n external pod-3 role=reconcile

kubectl label ns external role=app

kubectl exec -n external -it pod-3 -- ping [pod-1]
```
```sh
kubectl delete -f netpol.yaml
```
