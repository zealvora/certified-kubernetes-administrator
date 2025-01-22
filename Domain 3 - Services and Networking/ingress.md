#### Documentation Referred:

https://kubernetes.io/docs/concepts/services-networking/ingress/#name-based-virtual-hosting

### Ingress Resource - Rule 1
```sh
kubectl create ingress --help

kubectl first  ingress first-ingress --rule="example.internal/*=example-service:80"

kubectl describe ingress first-ingress
```
### Ingress Resource - Rule 2
```sh
kubectl create ingress second-ingress --rule="example.internal/*=example-service:80" --rule="kplabs.internal/*=kplabs-service:80"
```

### Generating Manifest File for Ingress Resource

```sh
kubectl create ingress second-ingress --rule="example.internal/*=example-service:80" --rule="kplabs.internal/*=kplabs-service:80" --dry-run=client -o yaml
```
