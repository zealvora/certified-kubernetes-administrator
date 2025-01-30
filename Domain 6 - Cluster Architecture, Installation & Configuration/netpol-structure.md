
### Manifest File Used in Video

first-netpol.yaml

```sh
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: demo-network-policy
spec:
  podSelector:
    matchLabels:
      env: production
  policyTypes:
    - Ingress
    - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          env: security
  egress:
  - to:
    - ipBlock:
        cidr: 8.8.8.8/32
```
```sh
kubectl create -f first-netpol.yaml

kubectl describe netpol demo-network-policy
```
### Delete the Resource created
```sh
kubectl delete -f first-netpol.yaml
```