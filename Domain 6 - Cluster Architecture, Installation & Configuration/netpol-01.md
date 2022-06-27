#### Create base setup:
```sh
kubectl create ns external
```
```sh
kubectl run pod-1 --image=praqma/network-multitool
kubectl run pod-2 --image=praqma/network-multitool
kubectl run pod-3 --image=praqma/network-multitool -n external
```
```sh
kubectl get pods -o wide
kubectl get pods -o wide -n external
```
Check connectivity from POD-1 to POD2 and POD-3 and Internet:
```sh
kubectl exec -it pod-1 -- ping [pod-2-ip]
kubectl exec -it pod-1 -- ping [pod-3-ip]
kubectl exec -it pod-1 -- ping google.com
```
###  Rule 1: Deny Ingress
```sh
nano netpol.yaml
```
```sh
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  ingress:
  - {}
  policyTypes:
  - Ingress
```
```sh
kubectl apply -f netpol.yaml
```
```sh
kubectl get netpol
```
```sh
kubectl exec -it pod-1 -- ping [pod2-ip]
kubectl exec -it pod-1 -- ping [pod3-ip]
kubectl exec -it pod-1 -- ping google.com

kubectl exec -it pod-3 -- ping [pod1-ip]
kubectl exec -it pod-3 -- ping [pod2-ip]
```
```sh
kubectl delete -f netpol.yaml
```
[Remove the contents of netpol.yaml file]

### Rule 2: Allow Ingress
```sh
nano netpol.yaml
```
```sh
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  ingress:
  - {}
  policyTypes:
  - Ingress
```
```sh
kubectl apply -f netpol.yaml
```
```sh
kubectl exec -it pod-3 -- ping [pod1-ip]
kubectl exec -it pod-3 -- ping [pod2-ip]
```
```sh
kubectl delete -f netpol.yaml
```
[Remove the contents of netpol.yaml file]

### Rule 3: Deny All Egress:

```sh
nano netpol.yaml
```
```sh
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
spec:
  podSelector: {}
  policyTypes:
  - Egress
```
```sh
kubectl apply -f netpol.yaml
```
```sh
kubectl exec -it pod-2 -- ping google.com
kubectl exec -n external -it pod-3 -- ping [pod1]
kubectl exec -n external -it pod-3 -- ping [pod2]
```
```sh
kubectl delete -f netpol.yaml
```
### Rule 4 - PodSelector:

```sh
nano netpol.yaml
```
```sh
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: podselector-suspicous
spec:
  podSelector:
    matchLabels:
      role: suspicious
  policyTypes:
  - Ingress
  - Egress
```
```sh
kubectl apply -f netpol.yaml
```
```sh
kubectl label pod pod-1 role=suspicious
kubectl get pods --show-labels
kubectl exec -it pod-2 -- ping [pod-1]
kubectl exec -it pod-1 -- ping google.com
```
Remove the label and verify:

```sh
kubectl label pod pod-1 role-
kubectl exec -it pod-1 -- ping google.com
```
```sh
kubectl delete -f netpol.yaml
```
